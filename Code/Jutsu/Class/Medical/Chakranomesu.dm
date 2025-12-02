obj/SkillCards/Class/Medical/ChakranoMesu
	icon_state="card_ChakranoMesu"
	cmdstring="ChakranoMesu"
	JutsuType = "Class"
	Cooldown = 1200
	DM = 8
	CCost = 200
	Seals = 4

	Description=list(
		"about" = "Create scalpels out of chakra that can damage internally.",
		,"title" = "Chakra no Mesu",
		,"type" ="Ninjutsu",
		,"strong"="N/A",
		,"weak"="N/A",
		,"rank"="A",
		//,"pic"='Bunshin.png',
	)

	UpgradeChoices = list("Lower Cost","Lower Cooldown")

	Activate(mob/U)
		if(U.InMesu)
			U.InMesu=0;
			U<<"Your scalpels disappear.";
			U.firing=0;
			U.Cooldowns["ChakraNoMesu"]=world.time+(CooldownCur*U.cooldownmultiplier)
			return
		else
			if(!U.Class["Medical-Nin"])
				U << "This technique is disabled as you are not currently an Medic-Nin"
				return
			if(GENERICATTACKCHECK(U)) return
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("ChakraNoMesu",(CooldownCur*U.cooldownmultiplier)+s)) return
			if(ChakraUseCheck()) c *= 4
			U.icon_state="seals"
			U.firing=1; spawn(30) U.firing=0
			spawn(s)
				spawn(1)U.icon_state=null
				if(prob(U.ChakraControl))
					U.JutsuUseChakra(c)
					U.JutsuMessage(Description["title"])
					U.JutsuSeals(s)
					U.JutsuNin(c)
					U.MoveUses[name]++
					if(U.PracticeMode || ControlCheck(U)) return ..()
					U.InMesu=1; U<<"Chakra Scalpels emerge in your hands."
					U.ScalpelDrain(c,src);
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
				..()

mob
	proc
		ScalpelDrain(C =10, obj/SkillCards/CM)
			while(InMesu)
				if(Chakra < C)
					if(Chakra<=0)
						Chakra=0;
					src<<"You are out of chakra."
					InMesu=0
					break
				else
					Chakra-=C
				RefreshChakra()
			Cooldowns["ChakraNoMesu"] = world.time + (CM.CooldownCur*cooldownmultiplier)