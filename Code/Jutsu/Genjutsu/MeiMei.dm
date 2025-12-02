obj/SkillCards/Genjutsu/MeiMei
	icon_state="card_Meimei"
	cmdstring="MeiMei"
	CCost=800
	Seals=3
	Cooldown = 1200
	Duration = 40

	Description = list(
		"about"="Turn invisible for a short time"
		,"title"="Mei Mei no Jutsu"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="D"
//		,"pic"='Meimei.png'
	)

	UpgradeChoices = list("Increase Duration","Lower Cooldown")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("MeiMei",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			U.icon_state=null
			spawn(45)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuSeals(s); U.JutsuGen(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				if(U.PracticeMode || ControlCheck(U))
					U.JutsuMessage(Description["title"])
					return ..()
				U << "You are now under the effect Mei Mei"
				U.invisibility++
				U.alpha = 153
				spawn(Duration)
					U.invisibility--
					U.alpha = 255
					U << "The effect Mei Mei no jutsu has ended"
			else {c=rand(8,19); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()