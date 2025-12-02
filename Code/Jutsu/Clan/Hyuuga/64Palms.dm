obj/SkillCards/Clan/Hyuuga/HakkeRokujyuyonShou
	icon_state="card_HakkeRokujyuyonShou"
	cmdstring="HakkeRokujyuyonShou"
	Range=1
	CCost=1000
	SCost=1000
	Cooldown=2000
	CooldownCur=2000
	DM = 6

	UpgradeChoices = list("Lower Cost", "Lower Cooldown")

	Description = list(
		"about"="Unleash a barrage of 64 Jyuken palms on your opponents, damage will be divided between those that surround you."
		,"title"="Hakke Rokujyuyon Shou"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='HakkeRokujyuyonShou.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; S=SCost
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.Stamina<=S) {U<<"Not enough Stamina."; return}
		if(U.wielding && U.wielding != "Gauntlet") {U<<"This technique can only be used with bare fists or gauntlets"; return}
		if(!U.InByakugan) {U<<"You must activate Byakuagan first"; return}
		if(U.CooldownCheck("64Palms",CooldownCur*U.cooldownmultiplier)) return
		if(ChakraUseCheck()) c *= 4
		if(prob(U.ChakraControl))
			U.MoveUses[name]++;
			U.JutsuUseChakra(c)
			U.JutsuUseStamina(S)
			U.JutsuMessage(Description["title"])
			if(U.PracticeMode || ControlCheck(U)) return ..()
			var/B = new/Effect/Visual/Trigrams/Small(U.loc)
			U.Palms(6,Range)//6 = 6 waves (2,4,8,16,32,64 = 6)
			spawn(10)
				del B
		else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
		..()