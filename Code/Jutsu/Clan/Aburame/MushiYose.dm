obj/SkillCards/Clan/Aburame/MushiYose
	icon_state="card_MushiYose"
	cmdstring="MushiYose"

	UpgradeChoices = list("Lower Cooldown")

	CCost=10
	Seals=2
	Cooldown = 300
	CooldownCur = 100
	var/SummonLevel = 0
	var/SummonBonus = 0

	Description = list(
		"about"="Utilise secret Aburame techniques to attract bugs in nature, and collect them for use in jutsu later."
		,"title"="Mushi Yose no Jutsu"
		,"type"="Clan-Jutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="D"
		,"Tutorial" = "Use his move store more insects to use the all your Aburame skills, you will obtain more insects as you raise your mastery of the technique"
//		,"pic"='MushiYose.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		if(U.Konchuuamount>=U.KonchuuLimit) {U<<"You have already collected as many as you can hold!"; return}
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.CooldownCheck("Bug Gathering",(CooldownCur*U.cooldownmultiplier)+s,1)) return
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(3)U.firing=0
			U.icon_state=null
			if(prob(U.ChakraControl))
				U.JutsuUseChakra(CCost)
				U.JutsuSeals(s); U.JutsuNin(c); U.MoveUses[name]++
				if(SummonLevel < 10)
					if(U.MoveUses[name] > 100 * (SummonLevel+1))
						SummonLevel++
						SummonBonus += 3 * SummonLevel
						U << "<b><font size=2>You can now collect more bugs at a time, up to a maximum of [SummonBonus + 5] each time!</b></font>"
						U.KonchuuLimit+=100
				U.JutsuMessage(Description["title"])
				if(ControlCheck(U)) return ..()
				var/k=5 + SummonBonus
				if(k+U.Konchuuamount>U.KonchuuLimit) k=(U.KonchuuLimit-U.Konchuuamount)
				U.Konchuuamount+=k;
				U<<"You found [k] bugs!"
				if(U.Konchuuamount>U.KonchuuLimit) U.Konchuuamount=U.KonchuuLimit
				U.StatUpdate_bugs()
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
			..()