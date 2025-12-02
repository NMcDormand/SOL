mob/var/tmp
	Paralysed

mob/Hittable/Command/Clones/
	KageBunshin
		Del()
			dead=1; frozen=1
			for(var/mob/player/P in hearers(src)) P.PlaySound("poof")
			var/mob/P=Creator
			if(P)
				if(P.KageBunshinList)
					P.KageBunshinList-=src
			flick('Smoke.dmi',src)
			sleep(5)
			..()

mob/Hittable/Command/Clones/
	Status="stay"
	Cross(A)
		if(A == Creator)
			return 1
		else
			.=..()
	New()

		/*vis_contents = null
		if(!CMarker)
			CMarker = new/Overlay_Obj(icon('BunshinMarker.dmi'),MOB_LAYER+8)
			CMarker.name = "Marker"
			CMarker.invisibility = 8
		vis_contents += CMarker*/
		spawn()
			StaminaMax=Stamina; TaijutsuMax=Taijutsu


	Bunshin
		drain=60
		drain2=0.0012
		Del()
			if(dead&&Explosive) {Explosive=0; ExplosiveBunshin()}
			else dead=1
			frozen=1
			for(var/mob/player/P in hearers(src)) P.PlaySound("poof")
			flick('Smoke.dmi',src)
			var/mob/P = Creator
			if(P&&src in P.BunshinList) P.BunshinList-=src
			if(P&&src in P.MasterBunshinList) P.MasterBunshinList-=src
			sleep(5)
			..()

	KageBunshin
		drain=120
		drain2=180
		Del()
			if(dead&&Explosive) {Explosive=0; ExplosiveBunshin()}
			else dead=1
			frozen=1
			for(var/mob/player/P in hearers(src)) P.PlaySound("poof")
			var/mob/P=Creator
			if(P)
				Stamina=max(Stamina,0)
				P.Stamina-= ((StaminaMax-Stamina)*0.35)
				if(P.Stamina <=0)
					P.Stamina =0
				if(Chakra>0) P.Chakra+=(Chakra*0.8)
				P.Chakra=min(P.Chakra,P.ChakraMax)
				P.RefreshStamina(); P.RefreshChakra()
				if(P.KageBunshinList && islist(P.KageBunshinList))
					if(src in P.KageBunshinList)
						P.KageBunshinList-=src
						P.ApplyBunshinTraining(src)
				if(src in P.MasterBunshinList)
					P.MasterBunshinList-=src
			flick('Smoke.dmi',src)
			sleep(5)
			..()

	RaiBunshin
		drain=200
		drain2=250
		Del()
			var/mob/P=Creator
			for(var/mob/m in range(1,src))
				if(m!=P && !(P.FriendlyFireCheck(m)) && src!=m && m.Creator!=Creator && P) m.RaiBunshinShock(src,P)
			if(dead&&Explosive) {Explosive=0; ExplosiveBunshin()}
			else dead=1
			frozen=1
			for(var/mob/player/p in hearers(src)) p.PlaySound("poof")
			if(P)
				Stamina=max(Stamina,0)
				P.Stamina-= ((StaminaMax-Stamina)*0.35)
				if(P.Stamina <=0) P.Stamina =0
				if(Chakra>0) P.Chakra+=(Chakra*0.5)
				P.Chakra=min(P.Chakra,P.ChakraMax)
				P.RefreshStamina(); P.RefreshChakra()
				if(src in P.KageBunshinList)
					P.KageBunshinList-=src
					P.ApplyBunshinTraining(src)
				if(src in P.MasterBunshinList) P.MasterBunshinList-=src
			flick('Smoke.dmi',src)
			sleep(5)
			..()

	MizuBunshin
		drain=140
		drain2=220
		Del()
			if(dead&&Explosive) {Explosive=0; ExplosiveBunshin()}
			else dead=1
			frozen=1
			for(var/mob/player/P in hearers(src)) P.PlaySound("poof")
			var/mob/P=Creator
			if(P)
				Stamina=max(Stamina,0)
				P.Stamina-= ((StaminaMax-Stamina)*0.35)
				if(P.Stamina <=0) P.Stamina =0
				if(Chakra>0) P.Chakra+=(Chakra*0.5)
				P.Chakra=min(P.Chakra,P.ChakraMax)
				P.RefreshStamina(); P.RefreshChakra()
				if(src in P.KageBunshinList)
					P.KageBunshinList-=src
					P.ApplyBunshinTraining(src)
				if(src in P.MasterBunshinList) P.MasterBunshinList-=src
			flick('Smoke.dmi',src)
			sleep(5)
			..()

	SunaBunshin
		drain=110
		drain2=80
		Del()
			if(dead&&Explosive) {Explosive=0; ExplosiveBunshin()}
			else dead=1
			frozen=1
			for(var/mob/player/P in hearers(src)) P.PlaySound("poof")
			var/mob/P=Creator
			if(P)
				Stamina=max(Stamina,0)
				P.Stamina-= ((StaminaMax-Stamina)*0.35)
				if(P.Stamina <=0) P.Stamina =0
				if(Chakra>0) P.Chakra+=(Chakra*0.4)
				P.Chakra=min(P.Chakra,P.ChakraMax)
				P.RefreshStamina(); P.RefreshChakra()
				if(src in P.KageBunshinList)
					P.KageBunshinList-=src
					P.ApplyBunshinTraining(src)
				if(src in P.MasterBunshinList) P.MasterBunshinList-=src
			flick("Suna Death",src)
			sleep(4)
			..()

	MushiBunshin
		drain=100
		drain2=50
		Del()
			if(dead&&Explosive) {Explosive=0; ExplosiveBunshin()}
			else dead=1
			for(var/mob/player/P in hearers(src)) P.PlaySound("poof")
			var/mob/P=Creator
			if(P)
				Stamina=max(Stamina,0)
				P.Stamina-= ((StaminaMax-Stamina)*0.35)
				if(P.Stamina <=0) P.Stamina =0
				if(Chakra>0) P.Chakra+=(Chakra*0.5)
				P.Chakra=min(P.Chakra,P.ChakraMax)
				P.RefreshStamina(); P.RefreshChakra()
				if(src in P.KageBunshinList)
					P.KageBunshinList-=src
					P.ApplyBunshinTraining(src)
				if(src in P.MasterBunshinList) P.MasterBunshinList-=src
			flick("Death",src)
			sleep(12)
			..()

	ExperienceCheck(D,mob/v)
		set waitfor = 0
		var/mob/OWNER=Creator
		if(src!=v  && !(src in v.MasterBunshinList))//src is the attacker.  v is the victim.
			if(OWNER.Level>=OWNER.MaxGain()) return
			if((OWNER.FriendlyFireCheck(v))||(OWNER.KI_InMission&&(OWNER in KI_Participants))) return
			var/k=(OWNER.TaijutsuMax+OWNER.NinjutsuMax+OWNER.GenjutsuMax)*0.20	//25% of the Average score of Tai+Nin+Gen
			var/a=(v.TaijutsuMax+v.NinjutsuMax+v.GenjutsuMax)*0.20	//25% of the Average score of Tai+Nin+Gen (for the other guy)
			var/P=(k/a)*100// What Killers avg stats are Compared to Victims's. as a percent
			if(istype(v,/mob/Hittable/Responsive/VillageNinjas)) P*=1.1
			else if(istype(v,/mob/NPC)) P*=1.3
			else if(istype(v,/mob/player)) P*=1.6
			if(D>100) D=100
			if(a<10) a=10
			var/XP_perHit=0
			var/EL = OWNER.KageBunshinList.len
			if(!EL)
				EL = 1
			var/XPlimit=(Exp+(OWNER.MXP*0.03))/EL
			switch(P)
				if(180 to 200) XP_perHit=a*0.0025
				if(150 to 179) XP_perHit=a*0.005
				if(125 to 149) XP_perHit=((a*0.01)+(D*1))
				if(110 to 124) XP_perHit=((a*0.018)+(D*2))
				if(91 to 109) XP_perHit=((a*0.025)+(D*3))
				if(75 to 90) XP_perHit=((a*0.023)+(D*3))
				if(50 to 74) XP_perHit=((a*0.012)+(D*2.5))
				if(20 to 49) XP_perHit=((a*0.09)+(D*2))
				else XP_perHit=a*0.001
			if(XP_perHit>XPlimit) XP_perHit=XPlimit

var/BunshinTRate = 1.3
mob/proc
	RaiBunshinShock(mob/bunshin,mob/O)
		DamageMe(O,bunshin.LightningElemental,"shock")
		Paralysed=1; spawn(20) Paralysed=0

	ApplyBunshinTraining(mob/C)
		var/BT = BunshinTRate
		ApplyEXP(C.H2HSkillXP * BT,"unarmed")
		ApplyEXP(C.ThrowingSkillXP * BT,"throwing")

		ApplyEXP(C.KnifeSkillXP * BT,"knife")
		ApplyEXP(C.SwordSkillXP * BT,"sword")
		ApplyEXP(C.AxeSkillXP * BT,"axe")
		ApplyEXP(C.StaffSkillXP * BT,"staff")
		ApplyEXP(C.ScytheSkillXP * BT,"scythe")
		ApplyEXP(C.FanSkillXP * BT,"fan")

		ApplyEXP(C.TaijutsuXP * BT,"taijutsu")
		ApplyEXP(C.NinjutsuXP * BT,"ninjutsu")

		ApplyEXP(C.StaminaXP,"Stamina")
		ApplyEXP(C.ChakraXP,"chakra")

		if(Level<MaxGain()) {Exp+=C.Exp*0.8; LevelUpCheck()}