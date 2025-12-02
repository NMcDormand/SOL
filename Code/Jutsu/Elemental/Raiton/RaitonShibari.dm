#if DEBUGGING
mob/verb
	SelfLearnShibari()
		var/obj/SkillCards/Ninjutsu/Raiton/Shibari/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Raiton Shichu Shibari no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Raiton/Shibari(src)
#endif

obj/SkillCards/Ninjutsu/Raiton/Shibari
	icon_state="card_Shibari"
	cmdstring="ShichuShibari"
	CCost=6000
	Seals=6
	Range=8
	Cooldown = 1200
	Duration = 100

	Description= list(
		"about"="Creates 4 Pillars around target and shocks the user while inside of it and making the target unable to move"
		,"title"="Raiton Shichu Shibari"
		,"type"="Ninjutsu"
		,"Element"="Lightning"
		,"weak"="Earth"
		,"rank"="B"
		,"pic"='Bunshin.png'
		)

	UpgradeChoices = list("Increase Duration","Lower Cost")

	Activate(mob/U)
		if(U.choosingHoming)
			return
		var/mob/M
		if(ismob(U.Targeting)&&get_dist(U.Targeting,U)<= Range)
			M = U.Targeting
		else
			M = U.TargetSelect(Range)
		if(M)
			if(GENERICATTACKCHECK(U))
				return
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("ShichuShibari",(CooldownCur*U.cooldownmultiplier)+s,1)) return
			if(U.CooldownCheck("Homing",(100*U.cooldownmultiplier)+s,1)) return
			if(ChakraUseCheck()) c *= 4
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				spawn(1)U.icon_state=null
				spawn(3)U.firing=0
				if(prob(U.ChakraControl))
					U.JutsuMessage(Description["title"])
					U.JutsuSeals(s); U.JutsuNin(c);
					U.MoveUses[name]++
					U.JutsuUseChakra(c);
					U.ElementalUp("Lightning")
					if(U.PracticeMode || ControlCheck(U)) return ..()
					U.ShichuShibari(M)
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

mob
	var/tmp
		ShibariHit = 0
	proc
		ShibariDMG(mob/M)
			ShibariHit++
			CantWalk++
			RaitonCurrent++
			var/D = M.LightningElemental + round(M.Ninjutsu*0.2)
			DamageMe(M, D, "Shibari")
			spawn(30)
				ShibariHit--
				CantWalk--
				RaitonCurrent--

		ShichuShibari(mob/M,DUR)
			set waitfor = 0
			var/turf/R = M.loc
			var/turf/P1 = locate(M.x-2,M.y+2,M.z)
			var/turf/P2 = locate(M.x+2,M.y+2,M.z)
			var/turf/P3 = locate(M.x-2,M.y-2,M.z)
			var/turf/P4 = locate(M.x+2,M.y-2,M.z)
			if(!R)
				return
			sleep(1)
			if(P1)
				var/obj/LightningPillar/Left/F = new/obj/LightningPillar/Left(P1,DUR)
				F.Owner=src
				F.dir=dir
			if(P3)
				var/obj/LightningPillar/Left/F2 = new/obj/LightningPillar/Left(P3,DUR)
				F2.Owner=src
				F2.dir=dir
			if(P2)
				var/obj/LightningPillar/Right/F3 = new/obj/LightningPillar/Left(P2,DUR)
				F3.Owner=src
				F3.dir=dir
			if(P4)
				var/obj/LightningPillar/Right/F4 = new/obj/LightningPillar/Left(P4,DUR)
				F4.Owner=src
				F4.dir=dir
			for(var/turf/I in range(R,2))
				var/obj/ShibariElec/Y = new/obj/ShibariElec(I,DUR)
				Y.Owner=src
				Y.dir=dir
				continue

obj
	LightningPillar
		icon='LightningPillar.dmi'
		layer=MOB_LAYER+1
		density=1
		New(LOC,DUR)
			..()
			loc = LOC
			spawn(DUR)
				if(src)
					del(src)
		Del()
			Owner = null
			loc = null
		Left
			icon_state="idlel"
			New()
				..()
				flick("left",src)
		Right
			icon_state="idler"
			New()
				..()
				flick("right",src)

	ShibariElec
		icon='electricity.dmi'
		icon_state=""
		layer=MOB_LAYER+1
		New(LOC,DUR)
			..()
			loc = LOC
			spawn()
				spin()
			spawn(DUR)
				if(src)
					del(src)
		proc
			spin()
				set waitfor = 0
				var/mob/O = Owner
				while(src)
					if(O)
						for(var/mob/I in loc)
							if(IDCHECK(O,I)||I.dead)
								continue
							else
								O<<"You hit [I] with Raiton Shichu Shibari!"
								I.ShibariDMG(O)
						sleep(30)
					else
						del src