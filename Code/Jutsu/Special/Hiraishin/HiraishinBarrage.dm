#if DEBUGGING
mob/verb
	SelfLearnHiraishinDanmaku()
		var/obj/SkillCards/Ninjutsu/Special/HiraishinDanmaku/J=locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Hiraishin Danmaku</i>!</font></b>"
			new/obj/SkillCards/Ninjutsu/Special/HiraishinDanmaku(src)

#endif

obj/SkillCards/Ninjutsu/Special/HiraishinDanmaku
	icon_state="card_HiraishinDanmaku"
	JutsuType = "S-Rank"
	cmdstring="HiraishinDanmaku"
	Range=4
	CCost=20000
	Seals=1
	DM=5
	Cooldown = 7000
	XPLGain = 200

	Description = list(
		"about"="Create clones to trap the target and throw a barrage of inscribed kunai to actiate your Hiraishin Technique"
		,"title"="Hiraishin Danmaku"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
		//,"pic"='Chidori.png'
		)

	UpgradeChoices = list("Increase Damage","Lower Cost")

	Activate(mob/U)
		if(U.choosingHoming) return
		var/mob/M
		if(ismob(U.Targeting)&&get_dist(U.Targeting,U)<= Range)
			M = U.Targeting
		else
			M = U.TargetSelect(Range)
		if(M)
			if(!M.trueName)
				M.trueName = name
			if(!U.MarkedTargets[M.trueName])
				U << "You do not have this Target marked with your seal"
				return
			spawn(10)if(U)U.choosingHoming=0
			if(GENERICATTACKCHECK(U)) return
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("HiraishinDanmaku",(CooldownCur*U.cooldownmultiplier)+s,0)) return
			if(U.CooldownCheck("Homing",(100*U.cooldownmultiplier)+s,1)) return
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				spawn(2)U.firing=0
				U.icon_state=null
				if(prob(U.ChakraControl))
					U.JutsuSeals(s); U.JutsuNin(c*0.1);
					U.MoveUses[name]++
					U.JutsuUseChakra(c,0.01)
					U.JutsuMessage(Description["title"])
					if(U.PracticeMode || ControlCheck(U)) return ..()
					U.HiraiBarrage(M,DM)
					U.HiraishinToggled = 0
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

mob
	proc
		HiraiBarrage(mob/M,DM)
			var/turf/C = M.loc
			var/list/Clones = list()
			for(var/turf/T in view(4,C))
				if(get_dist(T,C) == 4)
					var/mob/Hittable/Command/Clones/KageBunshin/B=new(T)
					Clones += B
					BunshinCreate(B,DM*0.01,2000)
					B.InHiraiBarrage = 1
			InHiraiBarrage = 1
			spawn(30)
				if(src)
					InHiraiBarrage = 0
			while(InHiraiBarrage && Clones.len && M)
				var/mob/CL = pick(Clones)
				if(CL && CL.loc)
					var/obj/Weapon/Wield/InscribedKunai/K = new(CL.loc)
					K.Taijutsu=Taijutsu; K.ThrowingSkill=ThrowingSkill*DM
					K.dir=get_dir(K,M); K.Owner=src; K.Marker = src; walk_towards(K,M);
					sleep(1)
				else
					break
			if(Clones.len)
				for(var/mob/A in Clones)
					del A
			if(src)
				InHiraiBarrage = 0