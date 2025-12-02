#if DEBUGGING
mob/verb
	SelfLearnHien()
		var/obj/SkillCards/Clan/Sarutobi/Hien/J=locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Hien no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Sarutobi/Hien(src)
#endif

obj/SkillCards/Clan/Sarutobi/Hien
	icon_state="card_Hien"
	cmdstring="Hien"
	CCost=1000
	Seals=0
	Duration = 5
	Cooldown = 1500
	DM = 1.5

	Description = list(
		"about"="Infuses any physial attack with your elemental nature chakra"
		,"title"="Hien"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
//		,"pic"='Dispel.png'
	)

	UpgradeChoices = list("Increase Damage","Lower Cost")

	Activate(mob/U)
		if(U.InHien)
			U.InHien = 0
			U << "You disabled your Hien"
		else
			if(GENERICATTACKCHECK(U))
				return
			var
				c=CCost; mx=c;
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("Hien",(CooldownCur*U.cooldownmultiplier))) return
			if(ChakraUseCheck()) c *= 3
			U.firing=1
			spawn(2)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);

				U.ElementalUp("Fire")
				U.ElementalUp("Water")
				U.ElementalUp("Earth")
				U.ElementalUp("Lightning")
				U.ElementalUp("Wind")

				if(U.PracticeMode || ControlCheck(U))
					return ..()
				U.InHien = ((U.FireElemental+U.WaterElemental+U.EarthElemental+U.LightningElemental+U.WindElemental) * 1.5) * DM
				src << "You begin using your Hien technique"
				U.Hien(CCost,Duration)
			else {c-=rand(1,mx/2); usr.Chakra-=c; usr<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()


mob
	proc
		Hien(COST)
			set waitfor = 0
			while(InHien)
				if(Chakra >= COST)
					Chakra -= COST
					JutsuChakra(30);
					sleep(10)
				else
					InHien = 0
					if(Chakra<0)
						Chakra = 0
					src << "Your Hien has ended"
				StatUpdate_chakra()
