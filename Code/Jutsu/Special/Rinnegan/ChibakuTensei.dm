obj/SkillCards/Clan/Rinnegan/ChibakuTensei
	icon_state="card_ChibakuTensei"
	cmdstring="ChibakuTensei"
	CCost=10000
	Seals=0
	Range = 3
	Duration = 20
	Cooldown=1500
	CooldownCur=1500

	UpgradeChoices = list("Increase Range","Increase Duration")

	Description = list(
		"about"="Pull any targets in range with an insurmountable force to a designated location"
		,"title"="Chibaku Tensei"
		,"type"="Kinjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
	)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		if(!U.HasRinnegan)
			U << "You do not have the power of the Rinnegan to use this technique"
			return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("ChibakuTensei",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 4
		U.firing=1
		if(prob(U.ChakraControl))
			U.JutsuSeals(s); U.JutsuTai(c*0.1); U.JutsuNin(c*0.14); U.MoveUses[name]++
			U.JutsuUseChakra(c);
			U.JutsuMessage("Chibaku Tensei")
			U.firing = 0
			if(U.PracticeMode || ControlCheck(U)) return ..()
			U.ChabakuTensei(Duration,Range)
		else {c-=rand(1,mx/2); U.Chakra-=c; U.icon_state=""; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
		..()

mob
	proc
		ChabakuTensei(DUR=30,RNG=2)
			new/Effect/Visual/ChibakuTensei(loc,src,DUR,RNG)