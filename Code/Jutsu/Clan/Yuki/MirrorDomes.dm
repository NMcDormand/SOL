obj/SkillCards/Clan/Yuki/MakyouHyoushou
	icon_state="card_MakyouHyoushou"
	cmdstring="MakyouHyoushou"
	Range=6
	CCost=4500
	Seals=12
	Cooldown=3000
	Duration = 300

	Description = list(
		"about"="Trap your opponent in ice mirrors"
		,"title"="Hyouton: Makyou Hyoushou"
		,"type"="Ninjutsu"
		,"Element"="Ice"
		,"weak"="Fire"
		,"rank"="C"
//		,"pic"='MakyouHyoushou.png'
		)

	UpgradeChoices = list("Lower Cooldown","Lower Cost","Increase Duration")

	Activate(mob/U)
		if(U.choosingHoming)
			return
		if(GENERICATTACKCHECK(U)||U.Gokusamaisou||U.mirroring||U.InMirrors)
			return
		var/mob/M
		if(ismob(U.Targeting)&&get_dist(U.Targeting,U)<= Range)
			M = U.Targeting
		else
			M = U.TargetSelect(Range)
		if(M)
			if(GENERICATTACKCHECK(U)||U.Gokusamaisou||U.mirroring||M.mirroring||U.InMirrors||InvisibilityCheck(U,M))
				return
			var
				c=CCost; mx=c; s=U.SS*Seals
			//var/originalSpot=U.loc
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck(cmdstring,(CooldownCur*U.cooldownmultiplier)+s)) return
			if(ChakraUseCheck()) c *= 4
			U.firing=1
			U.icon_state="seals"
			spawn(s)
				spawn(12) U.firing=0
				U.icon_state=null
				if(prob(U.ChakraControl))
					U.JutsuMessage(Description["title"])
					U.JutsuSeals(s); U.JutsuNin(c); U.ElementalUp("Ice",3);
					U.MoveUses[name]++
					U.JutsuUseChakra(c);
					if(U.PracticeMode || ControlCheck(U)) return ..()
					U.Mirrors(M,Duration)
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

obj/SkillCards/Clan/Yuki/Sukuinomado
	icon_state="card_MakyouHyoushou"
	cmdstring="Sukuinomado"
	Range=1
	CCost=4000
	Seals=12
	Cooldown=3000
	Duration = 300

	Description = list(
		"about"="Surround yourself in ice mirrors to defend against opponents techniques"
		,"title"="Hyouton: Sukui no mado"
		,"type"="Ninjutsu"
		,"Element"="Ice"
		,"weak"="Fire"
		,"rank"="C"
//		,"pic"='MakyouHyoushou.png'
		)

	UpgradeChoices = list("Lower Cooldown","Lower Cost","Increase Duration")

	Activate(mob/U)
		if(U.InMado)
			for(var/mob/Hittable/Unresponsive/Inanimate/Break/DemonMirror/DM in range())
				if(DM.InDome == 3)
					del DM
		else
			if(GENERICATTACKCHECK(U)||U.Gokusamaisou||U.mirroring||U.InMirrors)
				return
			var
				c=CCost; mx=c; s=U.SS*Seals
			//var/originalSpot=U.loc
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck(cmdstring,(CooldownCur*U.cooldownmultiplier)+s)) return
			if(ChakraUseCheck()) c *= 4
			U.firing=1
			U.icon_state="seals"
			spawn(s)
				spawn(12) U.firing=0
				U.icon_state=null
				if(prob(U.ChakraControl))
					U.JutsuMessage(Description["title"])
					U.JutsuSeals(s); U.JutsuNin(c); U.ElementalUp("Ice",3);
					U.MoveUses[name]++
					U.JutsuUseChakra(c);
					if(U.PracticeMode || ControlCheck(U)) return ..()
					U.InMado = 1
					for(var/turf/T in oview(1))
						if(T==loc)
							continue
						var/mob/Hittable/Unresponsive/Inanimate/Break/DemonMirror/DM = new(T,U,get_dir(T,src))
						DM.InDome = 3
						spawn(Duration)
							del DM
					spawn(Duration + 100)
						U.InMado = 0
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()