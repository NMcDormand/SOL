obj/SkillCards/Clan/Inuzuka/Garouga
	icon_state="card_Garouga"
	cmdstring="Garouga"
	CCost=450
	Cooldown = 850
	CooldownCur = 350
	Seals=2
	Duration = 60

	UpgradeChoices = list("Increase Duration","Lower Cooldown")

	Description = list(
		"about"="After combining with your K9 Companion and begin spinning extremely rapidly towards their target."
		,"title"="Garouga"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='Garouga.png'
		)

	Activate(mob/U)
		if(GAROUGAATkCHK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Garouga",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(!U.InSoutourou)
			U<<"You must be in 2-headed beast form to use this."
			var/obj/SkillCards/Clan/Inuzuka/Soutourou/JB = locate() in U
			if(JB)
				JB.Activate(U)
				sleep(10)
				if(!U.InSoutourou)
					return
			else
				return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			if(prob(U.ChakraControl))
				U.JutsuSeals(s); U.JutsuTai(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c)
				U.JutsuMessage(Description["title"])
				if(U.PracticeMode || ControlCheck(U)) return ..()
				U.InGarouga=1; U.firing=1; U.movespeed=1; U.icon_state="Garouga"
				spawn(Duration)
					U.InGarouga=0; U.firing=0; U.movespeed=1; U.icon_state=null
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()