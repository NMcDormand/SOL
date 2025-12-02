obj/SkillCards/Starter/Spar
	icon_state="card_Spar"
	JutsuType = "Taijutsu"
	cmdstring="Spar"

	Description = list(
		"about"="Spar with an opponent to increase your Taijutsu and Reflexes.  Must be in a Spar Arena to use."
		,"title"="Spar"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="E"
//		,"pic"='Spar.png'
	)

	Activate(mob/U)
		U<<"If you and your sparring partner both enable 'Practice' mode, you can spar anywhere but just punching! Also works with your clones!";
		return;
		if(!U.InSparArea) {U<<"You cannot use this outside of the spar arena!"; return}
		if(U.Stamina<=100) {U<<"You are too low on Stamina to continue sparring"; return}
		if(U.NinjaRank=="Academy Student") {U<<"You must be Genin or above to spar"; return}
		for(var/mob/Hittable/Command/Clones/C in get_step(U,U.dir))
			if(U == C.Creator) // Check to see if it's our clone
				if(TAICHECKBOTH(U,C)) return
				C.dir=turn(U.dir,180)
				U.attacking=1; spawn(6)U.attacking=0
				if(!U.firing){U.firing=1; spawn(6)U.firing=0}
				var/stamLoss=(U.StaminaTrue-U.TaijutsuTrue)*0.1
				if(stamLoss >= (U.StaminaTrue * 0.04)) {stamLoss = (U.StaminaTrue *0.05)}
				U.Stamina-=stamLoss
				var/SparEXP=6
				if(U.weights) SparEXP+=(U.extraweight/1.5)
				U.ApplyEXP(SparEXP,"reflex")
				U.icon_state="punch"; spawn(4) U.icon_state=""
				C.icon_state="punch"; spawn(4) C.icon_state=""
				//flick("punch",C); flick("punch",U.client.mob)
				U.RefreshStats()
		for(var/mob/player/P in get_step(U,U.dir))
			if(TAICHECKBOTH(U,P)||P.resting||!P.InSparArea) return
			U.attacking=1; spawn(5)U.attacking=0
			if(!U.firing)
				U.firing=1; spawn(5)U.firing=0
			var/difference=round(P.TaijutsuTrue/U.TaijutsuTrue)*100
			var/SparTai
			if(difference == 100)
				SparTai=200
			else if(difference in 98 to 102)
				SparTai=rand(50,120)
			else if(difference<98)
				if(difference in 80 to 97) SparTai=rand(18,42)
				else if(difference in 70 to 79) SparTai=35
				else SparTai=rand(8,18)
			else if(difference>102)
				if(difference in 103 to 115) SparTai=rand(15,35)
				else if(difference in 116 to 121) SparTai=30
				else SparTai=rand(5,15)
			var/dmg=round(U.TaijutsuTrue*0.33)
			if(dmg<(P.StaminaMax*0.01)) dmg = P.StaminaMax*0.01
			if(U.weights) SparTai+=(U.extraweight/1.5)
			if(!U.SparPunch) {U.SparPunch=1; spawn(15)U.SparPunch=0}
			U.SparringWith=P; U.HitCount++
			if(U.SparPunch&&P.SparPunch&&P.SparringWith==U)
				if(U.ReflexTrue<RFXMax)
					if(U.Clan=="Kaguya")  U.ApplyEXP(5,"reflex")
					U.ApplyEXP(10,"reflex")
				if(difference == 100) {U.ApplyEXP(SparTai+P.taitraining,"taijutsuStatic")}
				else {U.ApplyEXP(SparTai+P.taitraining,"taijutsu")}
				if(U.HitCount>=40)
					U<<"You feel nimbler and more agile."
					if(U.ReflexTrue<RFXMax) U.ApplyEXP(400,"reflex")
					if(difference == 100) {U.ApplyEXP((SparTai*40)+P.taitraining,"taijutsuStatic")}
					else {U.ApplyEXP((SparTai*40)+P.taitraining,"taijutsu")}
					U.HitCount=0
			flick("punch",U.client.mob)

			P.Stamina-=round(dmg)
			if(P.Stamina<1) P.Stamina=1
			U.RefreshStats()

mob/var
	tmp
		SparHit
		SparPunch
		SparringWith
		HitCount
		BumpCount