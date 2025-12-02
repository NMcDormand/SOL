obj/SkillCards/Ninjutsu/Suiton/Suikoudan
	icon_state="card_suikoudan"
	cmdstring="Suikoudan"
	Range=8
	CCost=2000
	Seals=10
	Cooldown = 1200
	DM = 15
	Speed = 3

	Description = list(
		"about"="Send a powerful water projectile at opponents."
		,"title"="Suiton: Suikoudan"
		,"type"="Ninjutsu"
		,"Element"="Fire"
		,"weak"="Lightning"
		,"rank"="B"
//		,"pic"='Suikoudan.png'
	)

	UpgradeChoices = list("Increase Damage","Increase Speed")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		if(!U.onwater && U.WaterElemental<SuitonOnEarthCheck && U.Clan!="Yuki") {U<<"You must be on water to use this."; return}
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Suikoudan",(CooldownCur*U.cooldownmultiplier)+s,1)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(2)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.ElementalUp("Water")
				if(U.PracticeMode || ControlCheck(U)) return ..()
				var/obj/Jutsu/Suiton/Suikoudan/S=new/obj/Jutsu/Suiton/Suikoudan
				NewProjectile(U,S,src,1.9,DM)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()