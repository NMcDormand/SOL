obj/SkillCards/Clan/Sand/SunaShuriken
	icon_state="card_SunaShuriken"
	cmdstring="SunaShuriken"
	CCost=10
	Seals=2
	Cooldown = 300
	DM = 1
	ECost = 8

	Description = list(
		"about"="Throw Shuriken created using sand infuse with chakra"
		,"title"="Suna Shuriken"
		,"type"="Ninjutsu"
		,"Element"="Sand"
		,"weak"="N/A"
		,"rank"="C"
		//,"pic"='Chidori.png'
	)

	UpgradeChoices = list("Increase Damage","Lower Cost")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		if(!U.onsand)
			if(U.SandCollected<ECost)
				U<<"You do not have enough sand in your gourd."
				return
		var
			c=CCost; mx=c
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("SunaShuriken",(CooldownCur*U.cooldownmultiplier))) return
		if(ChakraUseCheck()) c *= 4
		U.throwing=1; spawn(9) U.throwing=0
		if(prob(U.ChakraControl))
			if(!U.onsand) U.SandCollected-=ECost
			U.JutsuMessage(Description["title"])
			U.JutsuNin(c);
			U.MoveUses[name]++
			U.JutsuUseChakra(c);
			//U.ElementalUp("Sand")
			if(U.PracticeMode || ControlCheck(U)) return ..()
			U.ApplyEXP(2,"throwing")
			var/obj/SandNin/SunaShuriken/S = new(U.loc)
			S.Taijutsu=(U.Taijutsu*0.25)*DM;
			S.ThrowingSkill=U.ThrowingSkill*DM;
			S.dir=U.dir; S.movespeed=1; S.Owner=U
			walk(S,U.dir)
			spawn(10)
				del(S)
		else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
		..()