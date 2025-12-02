obj/SkillCards/Clan/Hyuuga/Jyuken
	icon_state="card_Jyuken"
	cmdstring="Jyuken"
	Range=1
	CCost=80
	Cooldown=40
	CooldownCur=40
	UpgradeChoices = list("Lower Cost")

	Description = list(
		"about"="X."
		,"title"="Jyuken"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='Jyuken.png'
		)

	Activate(mob/U)
		if(U.wielding && U.wielding != "Gauntlet") {U<<"This technique can only be used with bare fists or gauntlets"; return}
		if(!U.InByakugan) {U<<"You cannot see what points to hit unless you use Byakugan."; return}
		var
			c=CCost; mx=c
		if(ChakraUseCheck()) c *= 4
		if(U.Chakra < c) {U<<"Not enough Chakra."; return}
		if(prob(U.ChakraControl))
			var/mob/M = locate() in get_step(U,U.dir)
			if(M)//TESTIT
				if(M.TreeStump) {U<<"It does not have any tenketsu for you to hit."; return}
				if(TAICHECKBOTH(U,M)) return
				U.JutsuUseChakra(c)
				var/dmg=round((U.Taijutsu*1.4)-(M.Taijutsu*0.20))
				if(dmg<1) dmg=1
				if(U.HitCheck(M))
					dmg+=U.Weapons() + (U.H2HSkill * 4)
					U.attacking=1; spawn(8)U.attacking=0
					flick("punch",U);
					if(U.PracticeMode || ControlCheck(U)) return ..()
					U.MoveUses[name]++
					if(M.Chakra)
						M.Chakra-=(M.ChakraMax*0.25)
						if(M.Chakra < 0)
							M.Chakra = 0
					M.DamageMe(U,dmg,"palm")
					U.ApplyEXP(10,"Stamina")
				else
					U.attacking=1; spawn(10)U.attacking=null
					U<<"[M] dodged the attack"; M<<"You dodged [U]'s attack"
		else {c-=rand(1,mx/2); U.CCGain(c); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
		..()