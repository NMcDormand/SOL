obj/SkillCards/Class/Sensory/SenseArea
	icon_state="card_SenseArea"
	cmdstring="SenseArea"
	CCost=40
	Seals=2
	Cooldown = 400
	Range = 10

	Description = list(
		"about"="Scan an area for Chakra signatures to locate people or living things"
		,"title"="Sense Area"
		,"type"="Genjutsu"
		,"weak"="N/A"
		,"rank"="C"
		//,"pic"='Chidori.png'
	)

	UpgradeChoices = list("Increase Range","Lower Cooldown")

	Activate(mob/U)
		if(!U.Class["Sensory-Nin"])
			U << "This technique is disabled as you are not currently a Sensory-Nin"
			return
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("SenseArea",(CooldownCur*U.cooldownmultiplier))) return
		if(ChakraUseCheck()) c *= 4
		U.firing=1
		U.icon_state="seals"
		spawn(10)
			spawn(10)U.firing=0
			U.icon_state=null
			if(prob(U.ChakraControl))
				//U.JutsuMessage(Description["title"])
				U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);

				U<<"You <i>([U.x],[U.y])</i>"

				if(U.z==2)
					for(var/mob/m in range(Range))
						if(m.Chakra > 10)
							if(m.z != U.z)
								continue
							if(m.ZCoord != U.ZCoord)
								continue
							if(m.Class["Sensory-Nin"])
								continue
							U<<"[m] - [get_dir(U,m)] <i>([m.x],[m.y])</i>"
				else
					for(var/mob/m in range(Range))
						if(m.Chakra > 10)
							if(m.z != U.z)
								continue
							if(m.Class["Sensory-Nin"])
								continue
							U<<"[m] - [get_dir(U,m)] <i>([m.x],[m.y])</i>"
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
			..()