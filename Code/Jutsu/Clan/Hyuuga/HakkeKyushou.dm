obj/SkillCards/Clan/Hyuuga/HakkeKyushou
	icon_state="card_HakkeKyushou"
	cmdstring="HakkeKyushou"
	Range=1
	CCost=500
	Seals=2
	Cooldown=40
	CooldownCur=40
	UpgradeChoices = list("Lower Cost", "Lower Cooldown")
	Description = list(
		"about"="high-speed palm thrust using the Gentle Fist, a burst of compressed is formed to attack the opponent's vitals from a distance,"
		,"title"="Hakke Kyushou"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='HakkeKyushou.png'
		)
	Activate(mob/U)
		if(!U.InByakugan) {U<<"You must activate Byakuagan first"; return}
		if(GENERICATTACKCHECK(U)) return
		var/mob/M = locate() in get_step(U,U.dir)
		if(M)//TESTIT
			if(TAICHECKBOTH(U,M)) return
			var
				c=CCost; mx=c; dmg
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("Kyushou",CooldownCur*U.cooldownmultiplier,1)) return
			if(ChakraUseCheck()) c *= 4
			if(U.HitCheck(M))
				U.JutsuMessage(Description["title"])
				if(prob(U.ChakraControl))
					if(usr.ChakraControl<100) {c+=rand(0,mx/2); usr.CCGain(c)}
					U.MoveUses[name]++; U.JutsuUseChakra(c)
					if(U.PracticeMode || ControlCheck(U)) return ..()
					dmg = round(U.Taijutsu*1.3-(M.Taijutsu*0.06))
					if(dmg<=round(U.Taijutsu*0.20)) dmg=round(U.Taijutsu*0.20)
					if(M.NinjaRank != "Academy Student" && IDCHECK(M,src))
						M.KnockBack(U,dmg,4)
				else
					c-=rand(1,mx/2); U.CCGain(c)
					U.Chakra-=c; U<< "<i>Only [c]/[mx] converted, you did not perform the jutsu correctly</i>"
					if(U.PracticeMode) return ..()
					dmg = round(U.Taijutsu*1-(M.Taijutsu*0.1))
					if(dmg<=round(U.Taijutsu*0.20)) dmg=round(U.Taijutsu*0.20)
				U.attacking=1; spawn(6)U.attacking=0
				flick("punch",U)
				M.DamageMe(U,dmg,"palms")
			else {U<<"[M] dodged the attack"; M<<"You dodged [U]'s attack"}
			..()

mob/proc/KnockBack(mob/ATTACKER,DAMAGE,Max_Dist)
	var/Distance
	KnockedBack=ATTACKER.name
	if(DAMAGE>StaminaMax*0.10) Distance=Max_Dist
	else if(DAMAGE>StaminaMax*0.05) Distance=(Max_Dist-1)
	else Distance=(Max_Dist-2)

	if(Distance<1)
		Distance=1
	spawn(Distance) KnockedBack=null
	spawn()
		while(KnockedBack==ATTACKER.name)
			dir=get_dir(src,ATTACKER); step_away(src,ATTACKER); dir=get_dir(src,ATTACKER)
			sleep(pick(1,2))