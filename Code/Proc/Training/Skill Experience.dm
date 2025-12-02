mob/proc
	ApplyEXP(e,STAT)
		if(cheater) e*= 0.1
		var/boost=BoostModifier(STAT)
		e*=(1+(boost))
		if(InCombat)
			e *= 3
		else if(DamagedRecently)
			e *= 1.5
		if(STAT == "ninjutsu") {e=getReduce(Cap_Ninjutsu, NinjutsuTrue, e);}
		if(STAT == "genjutsu")  {e=getReduce(Cap_Genjutsu, GenjutsuTrue, e);}
		if(STAT == "taijutsu") {e=getReduce(Cap_Taijutsu, TaijutsuTrue, e);}
		if(STAT == "Stamina") {e=getReduce(Cap_Stamina, StaminaTrue, e);}
		if(STAT == "chakra") e*=1.2
		//world<< "[STAT] went up by [e]"
//		world<<"[STAT]'s XPerince is training @ [((1+(boost))*100)]%"
		switch(STAT)
			if("Stamina") {StaminaXP+=((e*EXPGains_Stamina)*EXP_BASE); if(StaminaXP>=StaminaMXP) StamUp()}
			if("chakra") {ChakraXP+=((e*EXPGains_Chakra)*EXP_BASE); if(ChakraXP>=ChakraMXP) ChakraUp()}
			if("ninjutsu") {NinjutsuXP+=((e*EXPGains_Ninjutsu)*EXP_BASE); if(NinjutsuXP>=NinjutsuMXP) Ninup()}
			if("taijutsu") {TaijutsuXP+=((e*EXPGains_Taijutsu)*EXP_BASE); if(TaijutsuXP>=TaijutsuMXP) Taiup()}
			if("genjutsu") {GenjutsuXP+=((e*EXPGains_Genjutsu)*EXP_BASE); if(GenjutsuXP>=GenjutsuMXP) Genup()}
			if("reflex") {ReflexExp+=e; if(ReflexExp>=ReflexMXP) ReflexUp()}

			if("sword") {SwordSkillXP+=e; if(SwordSkillXP>=SwordSkillMXP) Swordup()}
			if("knife") {KnifeSkillXP+=e; if(KnifeSkillXP>=KnifeSkillMXP) Knifeup()}
			if("fan") {FanSkillXP+=e; if(FanSkillXP>=FanSkillMXP) Fanup()}
			if("axe") {AxeSkillXP+=e; if(AxeSkillXP>=AxeSkillMXP) Axeup()}
			if("scythe") {ScytheSkillXP+=e; if(ScytheSkillXP>=ScytheSkillMXP) Scytheup()}
			if("staff") {StaffSkillXP+=e; if(StaffSkillXP>=StaffSkillMXP) Staffup()}
			if("unarmed") {H2HSkillXP+=e; if(H2HSkillXP>=H2HSkillMXP) H2Hup()}
			if("throwing") {ThrowingSkillXP+=e; if(ThrowingSkillXP>=ThrowingSkillMXP) Throwingup()}

			if("taijutsuStatic") {TaijutsuXP+=e; if(TaijutsuXP>=TaijutsuMXP) TaiupStatic()}
//			if("fishing")
//				ChakraControlXP+=e; if(ChakraControlXP>=ChakraControlMXP) CCup()
//			if("crafting")
//				ChakraControlXP+=e; if(ChakraControlXP>=ChakraControlMXP) CCup()
//			if("repair")
//				ChakraControlXP+=e; if(ChakraControlXP>=ChakraControlMXP) CCup()
//			if("firstaid")
//				ChakraControlXP+=e; if(ChakraControlXP>=ChakraControlMXP) CCup()

	ApplyDogEXP(e,STAT)
		if(cheater) e*= 0.1
		switch(STAT)
			if("stam") {StaminaXP+=((e*EXPGains_Stamina)*EXP_BASE); if(StaminaXP>=StaminaMXP) StamUp()}
			if("tai") {TaijutsuXP+=((e*EXPGains_Taijutsu)*EXP_BASE); if(TaijutsuXP>=TaijutsuMXP) TaiupDog()}


proc/getReduce(CapNumber, CurrNumber, e)
	var/x = CurrNumber - CapNumber;
	if(x<=0) return e
	x = x / 30000 //We need a small number ie 10k over = 0.33 = 33%
	x = e-(e*x)
	if(x<0.2) x=0.2 //Always give something.
	return x
/*
Elemental skill boosts to be handled in the gain method (as is) and not the XP method.
*/