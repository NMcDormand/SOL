mob/proc
	TreeStump(mob/T, var/dmg)
		..()
	Tree(mob/T, var/dmg)
		..()
	Cactus(mob/T, var/dmg)
		..()

mob/player
	Tree(mob/T, var/dmg, var/doubleHit)
		if(!dmg)
			return
		T.DamageMe(src,dmg,AttackMethod)

		if(StaminaTrue<500) Stamina-=rand(1,9)
		else if(StaminaTrue>=500&&StaminaTrue<1000) Stamina-=rand(5,20)
		else if(StaminaTrue>=1000&&StaminaTrue<5000) Stamina-=rand(10,100)
		else if(StaminaTrue>=5000&&StaminaTrue<10000) Stamina-=rand(50,500)
		else if(StaminaTrue>=10000) Stamina-=rand(100,1000)
		if(Stamina<1) Stamina=1
		var/XP=10
		if(doubleHit) XP+=5
		if(weights) XP+=(extraweight*3)
		ApplyEXP(XP,"taijutsu")
		ApplyEXP(30,"Stamina")
		RefreshStamina()

	Cactus(mob/T, var/dmg, var/doubleHit)
		for(var/mob/L in DMGMSGlist)
			if(L.z != T.z)
				continue
			if(get_dist(L,T)<4)
				if(doubleHit)
					var/dmgNum=(dmg/1.8); dmgNum=dmg%dmgNum;
					var/total=(round(dmg)+dmgNum)
					TextOverlay(T, total, "stump");
					L<<"[src] [AttackMethod] the cactus twice causing [round(dmg)] +([dmgNum]) damage!"
				else
					TextOverlay(T, dmg, "stump");
					L<<"[src] [AttackMethod] the cactus causing [round(dmg)] damage!"

		if(StaminaTrue<500) Stamina-=rand(1,6)
		else if(StaminaTrue>=500&&StaminaTrue<1000) Stamina -= rand(5,20)
		else if(StaminaTrue>=1000&&StaminaTrue<5000) Stamina -= rand(40,300)
		else if(StaminaTrue>=5000&&StaminaTrue<20000) Stamina -= rand(150,600)
		else if(StaminaTrue>=20000) Stamina -= rand(500,4000)
		if(Stamina<1) Stamina=1

		var/XP=10
		if(doubleHit) XP+=5
		if(weights) XP += extraweight
		ApplyEXP(XP*1.4,"taijutsu")
		ApplyEXP(XP*2,"Stamina")
		RefreshStamina()

	TreeStump(mob/T, var/dmg, var/doubleHit)
		for(var/mob/L in DMGMSGlist)
			if(L.z != T.z)
				continue
			if(get_dist(L,T)<4)
				if(doubleHit)
					var/dmgNum=(dmg/1.8); dmgNum=dmg%dmgNum;
					var/total=(round(dmg)+dmgNum)
					TextOverlay(T, total, "stump");
					L<<"[src] [AttackMethod] the stump twice causing [round(dmg)] +([dmgNum]) damage!"
				else
					TextOverlay(T, dmg, "stump");
					L<<"[src] [AttackMethod] the stump causing [round(dmg)] damage!"

		if(StaminaTrue<500) Stamina-=rand(1,9)
		else if(StaminaTrue>=500&&StaminaTrue<1000) Stamina-=rand(5,20)
		else if(StaminaTrue>=1000&&StaminaTrue<5000) Stamina-=rand(10,100)
		else if(StaminaTrue>=5000&&StaminaTrue<10000) Stamina-=rand(50,500)
		else if(StaminaTrue>=10000) Stamina-=rand(100,1000)
		if(Stamina<1) Stamina=1
		var/XP=10
		if(doubleHit) XP+=5
		if(weights) XP += extraweight
		ApplyEXP(XP*2,"taijutsu")
		ApplyEXP(XP*1.4,"Stamina")
		RefreshStamina()

mob/Hittable/Command/Clones
	TreeStump(mob/T, var/dmg)
		for(var/mob/L in DMGMSGlist)
			if(L.z != T.z)
				continue
			if(get_dist(L,T)<4)
				L<<"[src] [AttackMethod] the stump causing [round(dmg)] damage!"
		if(StaminaTrue<500) Stamina-=rand(1,9)
		else if(StaminaTrue>=500&&StaminaTrue<1000) Stamina-=rand(5,20)
		else if(StaminaTrue>=1000&&StaminaTrue<5000) Stamina-=rand(10,100)
		else if(StaminaTrue>=5000&&StaminaTrue<10000) Stamina-=rand(50,500)
		else if(StaminaTrue>=10000) Stamina-=rand(100,1000)
		if(Stamina<1) Stamina=1
		var/XP=5
		if(weights) XP += extraweight
		ApplyEXP(XP,"taijutsu")
		ApplyEXP(XP*0.7,"Stamina")
		RefreshStamina()

	Cactus(mob/T, var/dmg)
		for(var/mob/L in DMGMSGlist)
			if(L.z != T.z)
				continue
			if(get_dist(L,T)<4)
				L<<"[src] [AttackMethod] the cactus causing [round(dmg)] damage!"
		if(StaminaTrue<500) Stamina-=rand(5,12)
		else if(StaminaTrue>=500&&StaminaTrue<1000) Stamina-=rand(10,25)
		else if(StaminaTrue>=1000&&StaminaTrue<5000) Stamina-=rand(25,200)
		else if(StaminaTrue>=5000&&StaminaTrue<20000) Stamina-=rand(100,400)
		else if(StaminaTrue>=20000) Stamina-=rand(300,2000)
		if(Stamina<1) Stamina=1
		var/XP=6
		if(weights) XP+=(extraweight)
		ApplyEXP(XP*0.7,"taijutsu")
		ApplyEXP(XP,"Stamina")

mob/Hittable/Responsive/Animal/Pet
	TreeStump(mob/T, var/dmg)
		for(var/mob/L in DMGMSGlist)
			if(L.z != T.z)
				continue
			if(get_dist(L,T)<4)
				L<<"[src] [AttackMethod] the stump causing [round(dmg)] damage!"
		if(StaminaTrue<500) Stamina-=rand(1,5)
		else if(StaminaTrue>=500&&StaminaTrue<1000) Stamina-=rand(5,20)
		else if(StaminaTrue>=1000&&StaminaTrue<5000) Stamina-=rand(10,100)
		else if(StaminaTrue>=5000&&StaminaTrue<10000) Stamina-=rand(50,500)
		else if(StaminaTrue>=10000) Stamina-=rand(100,1000)
		Stamina-=(StaminaMax*0.005)
		if(Stamina<1) Stamina=1
		var/taiup=rand(1,60)
		var/stamup=rand(5,30)
		ApplyDogEXP(stamup,"stam")
		ApplyDogEXP(taiup,"tai")
		TheoreticalTaijutsuXP+=(taiup+T.taitraining)
		TheoreticalstaminaXP+=rand(5, 7)

	Cactus(mob/T, var/dmg)
		for(var/mob/L in DMGMSGlist)
			if(L.z != T.z)
				continue
			if(get_dist(L,T)<4)
				L<<"[src] [AttackMethod] the cactus causing [round(dmg)] damage!"
		if(StaminaTrue<500) Stamina-=rand(5,12)
		else if(StaminaTrue>=500&&StaminaTrue<1000) Stamina-=rand(10,25)
		else if(StaminaTrue>=1000&&StaminaTrue<5000) Stamina-=rand(25,200)
		else if(StaminaTrue>=5000&&StaminaTrue<20000) Stamina-=rand(100,400)
		else if(StaminaTrue>=20000) Stamina-=rand(300,2000)
		Stamina-=(StaminaMax*0.005)
		if(Stamina<1) Stamina=1
		var/taiup=rand(2,30)
		var/stamup=rand(9,60)
		ApplyDogEXP(stamup,"stam")
		ApplyDogEXP(taiup,"tai")
		//TheoreticalTaijutsuXP+=(taiup+T.taitraining)
		//TheoreticalstaminaXP+=rand(9,25)