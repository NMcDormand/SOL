mob
	var
		GaveSpecialScroll = 0
		KilledMinato = 0
		tmp/KOChase = 0
		tmp/list/Spectators = list()

mob/Hittable/Responsive/Boss/
	var/DTimer = 0

	New()
		Stamina = (Stamina * EXPGains_Stamina) * EXP_BASE
		StaminaMax = Stamina
		StaminaTrue = Stamina
		Chakra = (Chakra * EXPGains_Chakra) * EXP_BASE
		ChakraMax = Chakra
		ChakraTrue = Chakra
		Taijutsu = (Taijutsu * EXPGains_Taijutsu) * EXP_BASE
		TaijutsuMax = Taijutsu
		TaijutsuTrue = Taijutsu
		Ninjutsu = (Ninjutsu * EXPGains_Ninjutsu) * EXP_BASE
		NinjutsuMax = Ninjutsu
		NinjutsuTrue = Ninjutsu
		Genjutsu = (Genjutsu * EXPGains_Genjutsu) * EXP_BASE
		GenjutsuMax = Genjutsu
		GenjutsuTrue = Genjutsu

	KillMe(mob/M)
		if(M)
			if(M.client)
				M.TotalKills++
				M.CurrentKills++
		..()
	proc
		RestoreMe()
		DamageTimer(A)
			set waitfor = 0
			DTimer = 1
			while(DamWait>0)
				if(src)
					DamWait-=600
					sleep(60)
				else
					return
			DTimer = 0
			if(src)
				if(!dead && !KO)
					if(!DamagedRecently && Stamina < StaminaMax)\
						RestoreMe()