obj/SkillCards/Clan/Inuzuka/Tsuuga
	icon_state="card_Tsuuga"
	cmdstring="Tsuuga"
	CCost=100
	Seals=2
	Cooldown = 900
	CooldownCur = 400
	Duration = 40

	UpgradeChoices = list("Increase Duration","Lower Cooldown")

	Description = list(
		"about"="the user begins spinning rapidly towards their target"
		,"title"="Tsuuga"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='Tsuuga.png'
	)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)||U.InTsuuga||MoveCheck(U)) return
		var {c=CCost; mx=c; s=U.SS*Seals}
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Tsuuga",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			U.icon_state=""
			if(prob(U.ChakraControl))
				U.JutsuSeals(s); U.JutsuTai(c); U.MoveUses[name]++
				U.JutsuMessage(Description["title"])

				if(U.PracticeMode || ControlCheck(U))
					U.firing=0;
					return ..()

				U.overlays=list(); U.icon_state="tsuuga"
				U.InTsuuga=1
				spawn(Duration)
					U.firing=0; U.InTsuuga=0
					U.CreationSkin(1)
					U.icon_state=null
			else {U.firing=0;c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
			..()