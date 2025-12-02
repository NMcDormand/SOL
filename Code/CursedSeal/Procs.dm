mob/proc
	CSLevel()
		if(CSLevel==1&&NinjaRank!="Chuunin")
			if(HasSeal=="Earth"&&TaijutsuTrue>=15000&&NinjaRank!="Chuunin"&&NinjaRank!="Special Jounin")
				CSLevel=2; src<<"You've unlocked a deeper power from your Cursed Seal!"
			if(HasSeal=="Heaven"&&GenjutsuTrue>=12000&&NinjutsuTrue>=12000&&NinjaRank!="Chuunin"&&NinjaRank!="Special Jounin")
				CSLevel=2; src<<"You've unlocked a deeper power from your Cursed Seal!"
	Revert()
		StaminaMax=StaminaTrue; ChakraMax=ChakraTrue
		Taijutsu=TaijutsuTrue; Ninjutsu=NinjutsuTrue; Genjutsu=GenjutsuTrue
		Chakra-=(ChakraTrue*0.8)
		if(Chakra>ChakraMax) Chakra=ChakraMax
		if(Chakra<0) Chakra=1
		Stamina-=(StaminaTrue*0.8)
		if(Stamina>StaminaMax) Stamina=StaminaMax
		if(Stamina<0) Stamina=1
		StatUpdate_SelfImage()
		StatUpdate_ninjutsu(); StatUpdate_genjutsu(); RefreshChakra()
		StatUpdate_taijutsu(); RefreshStamina()
//-------------------------------------------------------------------------------------------------------------
	CS_1_Heaven()
		var/C=round(ChakraTrue*1.2)
		var/d=ChakraTrue*0.2
		ChakraMax=C; Chakra+=d
		CS1Nin(); CS1Gen()
		if(Chakra>ChakraMax) Chakra=ChakraMax
		StatUpdate_SelfImage()
		StatUpdate_ninjutsu(); StatUpdate_genjutsu(); RefreshChakra()

	CS1Tai() usr.Taijutsu=round(usr.TaijutsuTrue*1.2)
	CS1Nin() usr.Ninjutsu=round(usr.NinjutsuTrue*1.2)
	CS1Gen() usr.Genjutsu=round(usr.GenjutsuTrue*1.2)


//-------------------------------------------------------------------------------------------------------------

	CS_2_Heaven()
		var/C=round(ChakraTrue*1.4)
		var/d=ChakraTrue*0.4
		ChakraMax=C; Chakra+=d
		CS2Nin(); CS2Gen()
		if(Chakra>ChakraMax) Chakra=ChakraMax
		StatUpdate_SelfImage()
		StatUpdate_ninjutsu(); StatUpdate_genjutsu(); RefreshChakra()

	CS2Tai() usr.Taijutsu=round(usr.TaijutsuTrue*1.4)
	CS2Nin() usr.Ninjutsu=round(usr.NinjutsuTrue*1.4)
	CS2Gen() usr.Genjutsu=round(usr.GenjutsuTrue*1.4)

//-------------------------------------------------------------------------------------------------------------
	CS_1_Earth()
		var/S=round(StaminaTrue*1.2)
		var/d=StaminaTrue*0.2
		StaminaMax=S; Stamina+=d; CS1Tai()
		if(Stamina>StaminaMax) Stamina=StaminaMax
		StatUpdate_SelfImage()
		StatUpdate_taijutsu(); RefreshStamina()


//-------------------------------------------------------------------------------------------------------------

	CS_2_Earth()
		var/S=round(StaminaTrue*1.4)
		var/d=StaminaTrue*0.4
		StaminaMax=S; Stamina+=d; CS2Tai()
		if(Stamina>=StaminaMax) Stamina=StaminaMax
		StatUpdate_SelfImage()
		StatUpdate_taijutsu(); RefreshStamina()