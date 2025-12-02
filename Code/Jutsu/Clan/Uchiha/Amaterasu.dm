obj/SkillCards/Clan/Uchiha/MS/Amaterasu
	icon_state="card_Amaterasu"
	cmdstring="Amaterasu"
	Range=12
	CCost=4000
	Seals=3
	Cooldown = 1200
	Duration = 80
	Speed = 2

	UpgradeChoices = list("Lower Cost","Increase Fire Duration","Increase Speed")

	Description = list(
		"about"="Send out a black flame as hot as the sun to obliterate opponents."
		,"title"="Amaterasu"
		,"type"="Ninjutsu"
		,"Element"="Fire"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='Amaterasu.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		if(!U.InMangekyou) {U<<"You must activate Mangekyou Sharingan first"; return}
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Amaterasu",(Cooldown*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(15)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuUseChakra(c)
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s)
				U.JutsuNin(c)
				U.ElementalUp("Fire")
				U.MoveUses[name]++
				var/Dam
				switch(pick(1,2,3))
					if(1)
						Dam = pick(1,2,3,4,5)
						U << "You've strained your eyes causing [Dam] wounds"
					if(2)
						Dam = pick(7,9,11,13,15)
						U << "A blood vesel in your eye has ruptured causing [Dam] wounds"
					if(3)
						Dam = pick(30,40,50)
						U << "You severed an artery in your eye causing [Dam] wounds"
				if(!U.EternalSharingan && prob(105-Level))
					U.BlindMe("Amaterasu")
				U.Wounds += Dam
				U.RefreshStats()
				if(U.PracticeMode || ControlCheck(U)) return ..()
				var/obj/Jutsu/Uchiha/Amaterasu/A=new(U,Duration,Speed)
				spawn(Range)
					if(A)
						del(A)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()