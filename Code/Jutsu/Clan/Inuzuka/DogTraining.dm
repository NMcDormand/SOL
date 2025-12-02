mob/proc
	TheoreticalUp()
		TaijutsuXP+=TheoreticalTaijutsuXP; TheoreticalTaijutsuXP=0; DogTaiup(0)
		StaminaXP+=TheoreticalstaminaXP; TheoreticalstaminaXP=0; DogStamUpTree(0)

	DogStamUpTree(var/x)
		var/mob/O=Master
		if(StaminaXP>=StaminaMXP)
			StaminaXP-=StaminaMXP
			var/stamgain=rand(5,12)
			StaminaMax+=stamgain; x+=stamgain
			Stamina+=0.3
			if(O) {O.DogStaminaMax=StaminaMax; O.DogStaminaExp=StaminaXP; O.DogStaminaMXP=StaminaMXP}
			spawn(1) DogStamUpTree(x)
			StatUpdate_dogStuff()
		else if(x) O<<"[src] has gained [x] Stamina!"

	DogTaiup(var/x)
		var/mob/O=Master
		while(TaijutsuXP>=TaijutsuMXP)
			TaijutsuXP-=TaijutsuMXP
			TaijutsuMXP += 10
			var/taigain=rand(2,10)+2
			Taijutsu+=taigain; x+=taigain
			if(O) {O.DogTaijutsu=Taijutsu; O.DogTaijutsuXP=TaijutsuXP; O.DogTaijutsuMXP=TaijutsuMXP}
			else if(x) O<<"[src] has gained [x] Taijutsu!"
		StatUpdate_dogStuff()

	TaiupDog()
		while(TaijutsuXP>=TaijutsuMXP)
			var/mob/O=Master
			var
				ExpGain=1
				Gain=rand(1,40)
				boost=0

			switch(O.NinjaRank)
				if("Academy Student") boost=0
				if("Genin") boost=0
				if("Chuunin") boost=1
				if("Special Jounin") boost=1.5
				else boost=2
			Gain=O.SpecialtyBoost(Gain,"Taijutsu")
			Gain*=(1+(boost))
			if(Taijutsu>=Cap_Taijutsu) {Gain*=0.30; ExpGain*=0.10}
			TaijutsuMax+=Gain; Taijutsu+=Gain; TaijutsuTrue+=Gain
			TaijutsuXP-=TaijutsuMXP; TaijutsuMXP+=ExpGain
			if(O) {O.DogTaijutsu=Taijutsu; O.DogTaijutsuXP=TaijutsuXP; O.DogTaijutsuMXP=TaijutsuMXP; }
			else {src<<"Your Taijutsu increases.";}

		StatUpdate_dogStuff()
		StatUpdate_taijutsu()