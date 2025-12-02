mob/proc
	SpecialtyBoost(X,STAT)
		if(Speciality==STAT) return X*1.3
		else if(Speciality=="GenNin")
			if(STAT == "Genjutsu"||STAT=="Ninjutsu")
				return X*1.15
		else if(Speciality=="GenTai")
			if(STAT == "Genjutsu"||STAT=="Taijutsu")
				return X*1.15
		else if(Speciality=="NinTai")
			if(STAT == "Taijutsu"||STAT=="Ninjutsu")
				return X*1.15
		else if(Speciality=="All Round") return X*1
		return X

	BoostModifier(STAT) // The village boost % increase
		if(!KageCurrent[Village])
			return 0

		var/modifier=5 //innate 5% boost

		var/mob/player/K = KageMob[Village]
		if(K)
			modifier += 2
			if(K.InVillage == Village)
				modifier += 3

		switch(STAT)
			if("taijutsu")
				modifier+=TaiBoost[Village]
			if("ninjutsu")
				modifier+=NinBoost[Village]
			if("genjutsu")
				modifier+=GenBoost[Village]
			if("Stamina")
				modifier+=StamBoost[Village]
			if("chakra")
				modifier+=ChakBoost[Village]
			if("knife","sword","unarmed","throwing","fan","axe","scythe","staff")
				modifier+=SkillBoost[Village]
			if("primary")
				modifier+=PEBoost[Village]
			if("secondary")
				modifier+=SEBoost[Village]
			if("reflex")
				modifier+=RFXBoost[Village]

		if(InVillage!=Village)
			modifier*=0.5

		return (modifier*0.01)