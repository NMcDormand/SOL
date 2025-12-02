mob/Hittable/Command/EdoClone
	CantHenge = 1
	var
		Cost = 0

	New()
		..()
		/*vis_contents = null
		CMarker = new/Overlay_Obj(icon('BunshinMarker.dmi'),MOB_LAYER+9)
		CMarker.name = "Marker"
		CMarker.invisibility = 9
		CPaths = new/Overlay_Obj(icon('PlayerMarker.dmi'),MOB_LAYER+10)
		CPaths.name = "Chakra Paths"
		CPaths.invisibility = 10
		vis_contents += CMarker
		vis_contents += CPaths
		*/
		spawn(10)
			AI()

	Del()
		var/DNA/D = Creator.EdoList[trueName]
		D.Destroyed = 1
		D.Summoned = 0
		Creator.ChakraMax += Cost
		..()

	AI()
		set waitfor = 0
		while(!dead)
			if(KO || Status == STATUS_RESTRAINED || InIzanami)
				sleep(10)
				continue
			if(sleepy)
				sleepy=0
				DispelProc()

			if(InIllusion)
				if(prob(40))
					DispelProc()
				else
					if(InFakeEnemyView)
						Attack1(Projection)
						sleep(2)
						continue
					else if(InSenKaze)
						step_rand(src)
						sleep(10)
						continue
					else if(InFakeView)
						sleep(10)
						continue
			if(Status == STATUS_FOLLOW)
				sleep(10)
				continue
			if(Status == STATUS_ATTACK && !Targeting)
				Status = STATUS_STAY
				sleep(10)
				continue
			var/mob
				M; t
			HuntList=new/list
			if(Status == STATUS_REVOLT)
				Targeting = Creator
			if(Targeting)
				t = Targeting
			else
				for(M in HitList)
					if(M == src)
						HitList -= M
						continue
					if(M.dead)
						HitList -= M
						continue
					if(M.protect)
						continue
					if(get_dist(M,src)>24)
						HitList -= M
						continue
					if(M.NinjaRank == "Academy Student")
						HitList -= M
						continue
					else// if(M in YieldList)
						if(M.KO)
							t = M
							break
						else
							HuntList+=M
							for(var/mob/Hittable/Command/Clones/C in M.KageBunshinList)
								if(!(C in HitList))
									HuntList+=C
			if(!t && length(HuntList))
				t=pick(HuntList)
			if(t)
				Attack1(t)
			sleep(5)

	Attack1(mob/M)
		if(sleepy&&prob(98))
			sleepy=0;
			DispelProc()
		if(M)
			if(M.KO)
				AI_KO(M)
			else if(M.dead)
				HitList -= M
			else
				/*if(waterprisoned||Kanashibari||Coffin||InKageArashi||IceBlasted||ShadowCaptured||JubakuBound)
					FreeMe()*/
				if(Stamina>0&&!dead&&!DeathSee&&!Lotus&&!KO&&!MushiKabe&&!fallen&&!Underground&&!frozen&&!GMfrozen&&!resting&&!CantWalk&&!length(AcquiringList))
					if(M.InFujinHeki && FireElemental)
						Ryuuka()
					if(get_dist(src,M)>=2 && !M.UsedArashi && !M.InFujinHeki)
						sleep(ATKWAit)
						if(KO || Status == STATUS_RESTRAINED || Status == STATUS_STAY || Status == STATUS_FOLLOW)
							return
						if(M)
							if(M.protect)
								return
							if(!KageBunshinList.len && prob(23))
								ShadowClone(M)
								ShadowClone(M)
								ShadowClone(M)
							else if(M.icon_state=="seals"&&prob(90))
								Evade1(M)
							else if(firing&&!M.kaiten&&!M.MushiKabe)
								AI_Attack(M,11)
							else if(!firing)
								Move_In(M);
								switch(pick(
									prob(WaterElemental)
									1,
									prob(FireElemental)
									2,
									prob(EarthElemental)
									3,
									prob(LightningElemental)
									4,
									prob(WindElemental)
									5
								))
									if(1)
										Suiryuudan(M)
									if(2)
										Ryuuka(M)
									if(3)
										DoryuuDango()
									if(4)
										Rairyuu(M)
									if(5)
										Mugen()
							else
								ReCheck
								if(M.kaiten||M.MushiKabe)
									sleep(10)
									goto ReCheck
								else
									AI_Attack(M,10)
					else
						sleep(ATKWAit)
						if(KO)
							return
						if(M)
							ReCheck
							if(!M.kaiten&&!M.MushiKabe)
								AI_Attack(M,12)
							else
								sleep(10)
								goto ReCheck

	AI_Attack(mob/M, var/AttackTime)
		while(AttackTime)
			if(KO || Status == STATUS_RESTRAINED || Status == STATUS_STAY || Status == STATUS_FOLLOW)
				break
			AttackTime--
			if(!M || M.protect || M.dead)
				break
			else
				var/A = get_dist(src,M)
				if(A>=20)
					break
				if(A>1)
					while(get_dist(src,M) > 1)
						if(KO)
							break
						if(get_dist(M,src) > 12)
							break
						step_to(src,M)
						sleep(movespeed)
						if(!src || !M)
							return
				if(KO || Status == STATUS_RESTRAINED || Status == STATUS_STAY || Status == STATUS_FOLLOW)
					break
				if(get_dist(src,M)<2)
					dir = get_dir(src,M)
					AI_Punch(M)
					sleep(atkspeed)
		AttackTime = 0

	AI_KO(mob/M)
		if(KO || M.dead || KOChase || Status == STATUS_RESTRAINED || Status == STATUS_STAY || Status == STATUS_FOLLOW)
			return
		if(M)
			KOChase = 1
			while(get_dist(src,M) > 1)
				if(KO)
					KOChase = 0
					return
				if(!step_to(src,M))
					StepFailed++
				else
					StepFailed = 0
				sleep(movespeed)
				if(!src || !M)
					KOChase = 0
					return
			sleep(5)
			if(KO)
				KOChase = 0
				return
			if(src)
				if(M)
					dir=get_dir(src,M)
					if(M.KO && !M.dead && !(TAICHECKBOTH(src,M)))
						attacking=1
						spawn(atkspeed+3)
							if(src)
								attacking=0
						flick("punch",src)
						M.Wounds+=150
						M.KillMe(src)
						HitList -= M
				KOChase = 0

	AI_Punch(mob/TARGET)
		if(TARGET)
			if(TAICHECKBOTH(src,TARGET)) return
			if(inchidori) {ChidoriPunch(TARGET); return}
			if(inrasengan) {RasenganPunch(TARGET); return}
			var/dmg=round(Taijutsu*0.9-(TARGET.Taijutsu*0.09))
			dmg+=NPCWeapons(TARGET)
			if(dmg<round(Taijutsu*0.1)) dmg=round(Taijutsu*0.1)
			flick("punch",src)
			if(HitCheck(TARGET))
				attacking=1; spawn(atkspeed)attacking=0
				TARGET.DamageMe(src,dmg,AttackMethod)
				if(TARGET.KO)
					AI_KO(TARGET)
			else
				attacking=1
				spawn(atkspeed*4)attacking=null
				TARGET<<"You dodged [src]'s attack"

	DamageMe(mob/M, var/D,METHOD,hidemessage)
		if(dead || M == src || M.protect)
			return
		if(get_dist(M,src) < 2)
			if(M != Creator && M.Creator != Creator)
				if(!istype(M,/mob/Hittable/Responsive) && ismob(M))
					if(!(M in HitList))
						HitList+=M
		var
			w
		if(D<1)
			D=1
		D=round(D); w=(D/StaminaMax)*65
		Stamina-=D;
		if(M)
			Damaged()
			if(!hidemessage)
				DamageReport(src,M,D,METHOD)

			if(M != Creator && M.Creator != Creator)
				M.ExperienceCheck(w,src)
			M.RefreshStats()

			if(Stamina<=0&&Wounds<100)
				if(!KO)
					KO=1
					var/R=50000
					for(var/mob/b in KageBunshinList)
						del(b)
					icon_state="KO"; range(src)<<"<b><i>[src] has fallen with exhaustion!</i></b>"
					spawn(50)
						if(Wounds<100)
							KO=0
							icon_state=""
							Stamina=R
						else
							KillMe(M)
				else Wounds+=5
			else if((Wounds>=150)||(Stamina<=0&&Wounds>=100))
				if(!KO)
					KO=1; icon_state="KO"; range(src)<<"<b><i>[src] has fallen gravely unconcious!</i></b>"
					spawn(50)if(M&&!M.dead)KillMe(M)

	KillMe(mob/M)
		if(istype(M,/mob/Hittable/Command/Clones/)) M=M.Creator
		if(istype(M,/mob/Hittable/Responsive/Animal/Pet/)) M=M.Master
		if(dead) return
		dead=1
		for(var/mob/KM in KageBunshinList)
			del KM

		flick('Smoke.dmi',src)
		loc=locate(0,0,0)
		del src
