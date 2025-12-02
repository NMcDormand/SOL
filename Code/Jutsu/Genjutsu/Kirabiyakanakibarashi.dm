//Kirabiyakanakibarashi - Glittering Distraction
#if DEBUGGING
mob/verb
	SelfLearnKirabiyakanaKibarashi()
		var/obj/SkillCards/Genjutsu/KirabiyakanaKibarashi/J=locate(/obj/SkillCards/Genjutsu/KirabiyakanaKibarashi) in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Kirabiyakana Kibarashi no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Genjutsu/KirabiyakanaKibarashi(src)
#endif

obj/SkillCards/Genjutsu/KirabiyakanaKibarashi
	icon_state="card_Blank"
	cmdstring="KirabiyakanaKibarashi"
	CCost=16000
	Seals=12
	Cooldown = 2400
	Duration = 70
	Description = list(
		"about"="Creates illusionary clones in an area. Any attacks to the clones will cause damage to the attacker"
		,"title"="Kirabiyakana Kibarashi"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="A"
//		,"pic"='Dispel.png'
	)

	UpgradeChoices = list("Lower Cost","Increase Duration")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("KirabiyakanaKibarashi",(CooldownCur*U.cooldownmultiplier)+s,1)) return
		if(ChakraUseCheck()) c *= 4
		if(U.GenjutsuTrue > 100000)
			s = 0
		else
			U.icon_state="seals"
			spawn(s+10)
				U.icon_state=null
				U.JutsuSeals(s)
		U.firing=1
		spawn(s)
			spawn(2)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuSeals(s); U.JutsuGen(c*0.2);
				U.MoveUses[name]++
				U.JutsuUseChakra(c,0.1);
				if(U.GenjutsuTrue < 50000)
					U.JutsuMessage(Description["title"])
				if(U.PracticeMode || ControlCheck(U))
					return ..()
				U.Kirabiyakana()
			else
				c-=rand(1,mx/2); U.Chakra-=c
				U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"
				return
mob
	proc
		Kirabiyakana(DUR)
			var/list/Turfs = list()
			for(var/turf/T in view(4))
				if(T.density)
					continue
				else
					Turfs += T
			for(var/mob/M in MasterPlayerList)
				if(M.Targeting == src)
					M.Targeting = null
					for(var/image/x in M.client.images) // first, check to see if your have a target.
						if(x.icon=='target.dmi') // if so.
							del(x) // delete it.
			for(var/i=1 to 30)
				if(!Turfs.len)
					break
				var/turf/CT = pick(Turfs)
				Turfs -= CT

				var/mob/Hittable/Command/Genjutsu/KirabiClone/I = new(CT)
				KiraClones += I
				I.Creator = src
				I.movespeed = movespeed
				I.setspeed = setspeed
				I.equippedweight = equippedweight
				I.name = name
				I.Taijutsu = Taijutsu
				I.Village = Village
				I.NinjaRank = NinjaRank
				I.ChakraControl = 100
				I.Chakra = 10000000000000
				I.Stamina = 10000000000000
				I.WW = 1
				I.appearance = appearance
				walk_rand(I)
				spawn(DUR)
					del I
			invisibility++
			alpha = 153
			spawn(120)
				alpha = 255
				invisibility--
