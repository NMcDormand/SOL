//His Spawn is in meditate

mob/VerbHolder/Admin/MGM
	verb
		ThornTest()
			ThornActivate()
		ShinsuCircleTest(a as num)
			ShinsuCircle(a)
		ShinsuForcetest()
			ShinsuForce()
		ReverseFlowTest(mob/M in view())
			ReverseFlow(M)
		ReverseFieldTest()
			ReverseFlowField()
mob
	var/tmp/HitViole=0
	proc
		Shinwonryu_AI()
			set waitfor = 0
			var/icon/Shi = 'Shinwonryu.dmi'

			switch(usr.InShinwon)
				if(2)
					usr << "You threw the Black Hole Sphere!"
					usr.overlays-=Shi
					usr.ShinwonThrow()
					usr.InShinwon = 0
				else
					usr.InShinwon = 1
					usr.overlays+= Shi
					usr<< "You begin to form the black hole sphere"
					sleep(50)
					if(usr.InShinwon)
						usr.overlays+='AirBurst32.dmi'
						spawn(4)
							usr.overlays-='AirBurst32.dmi'
						usr<< "You can feel the Sphere is ready"
						usr.InShinwon = 2

		ReverseFlow(mob/M)
			if(M)
				M << "[src] reversed your flow"
				if(client)
					src << "[M] has been stopped!"
				M.ReverseFlow = 1
				spawn(30)
					if(M)
						M.ReverseFlow = 0

		ReverseFlowField()
			if(client)
				src << "Everyone in range has been stopped!"
			for(var/mob/M in range())
				if(M == src|| M.Creator == src)
					continue
				if(M.client)
					M << "[src] stopped flow of chakra in the area"
				M.ReverseFlow = 1
				spawn(40)
					if(M)
						M.ReverseFlow = 0

mob/Hittable/Responsive/Boss/Viole
	name="Jue Viole grace"
	trueName="Jue Viole grace"
	icon='Base_Pale.dmi'
	Village="Event"
	NinjaRank="Irregular"
	WW = 1
	Level = 8000
	Taijutsu=205000
	Ninjutsu=905000
	Genjutsu=605000
	TaijutsuMax=205000
	NinjutsuMax=905000
	GenjutsuMax=6050000
	Stamina=195000000
	StaminaMax=195000000
	Chakra = 8000000
	ChakraMax=8000000
	WindElemental=10000
	FireElemental=100000
	LightningElemental=10000
	WaterElemental=10000
	EarthElemental=10000
	Reflex=160
	ReflexTrue=160
	see_invisible = 10
	SS=1
	gender="male"
	movespeed=1
	atkspeed=4
	protect=0
	EvadeChance = 10
	BunshinLimit = 16
	MaxBangs = 4
	DamWait = 6000
	var/ResetMe = 0
	var/ShinwonCool = 0
	FinishMSG = "Thank you for your efforts"
	NotFinishMSG = "Please stay down next time"
	PursuitMSG = "This is my chance"

	New()
		//del src
		//return
		var/icon/A = icon('Eyes_Base.dmi')
		A += rgb(200,120,0)
		overlays += A
		A = icon('LShirt.dmi')
		A += rgb(160,160,160)
		overlays += A
		A = icon('Pants.dmi')
		A += rgb(160,160,160)
		overlays += icon('Viole-Robe.dmi')
		A = icon('Hair_Viole.dmi')
		A += rgb(56,28,0)
		overlays += A
		overlays += icon('Shoes.dmi')

		if(!SpecialMobs["Viole"])
			SpecialMobs["Viole"] = src
		respawn=loc
		spawn(5) AI()
		DamageTimer()

	Del()
		walk(src,0)
		if(loc)
			for(var/obj/Jutsu/A in range(30))
				if(A.Owner == src)
					del A

			for(var/Map/Darkness/D in range(50))
				D.invisibility = 50
				D.Checking=0

			for(var/mob/KM in KageBunshinList)
				del KM

			loc=null
		..()

	Bump(A)
		if(istype(A,/mob/Hittable/Unresponsive/Inanimate))
			var/mob/M = A
			AI_Punch(M)

	FreeMe()
		if(waterprisoned)
			if(LightningElemental)
				Inazuma() //Lightning Field
				waterprisoned = 0
				overlays -= 'WPrison.dmi'
		if(Kanashibari)
			KawaEvade()
			Kanashibari--
			if(Kanashibari < 0)
				Kanashibari = 0
		if(Coffin)
			if(WindElemental)
				Coffin--
				if(Coffin < 0)
					Coffin = 0
				overlays-='Coffin.dmi'
				KuchuNejire()//Aerial Twist
		if(InKageArashi)
			if(HasHiraishin)
				HiraishinEvade()
				InKageArashi = 0
		/*if(InDoumu)
			if(HasHiraishin)
				HiraishinEvade()*/
		if(IceBlasted)
			if(FireElemental)
				overlays-='iceblastcover.dmi'
				KazanFunka()//Volcanic erruption
				IceBlasted--
				if(IceBlasted < 0)
					IceBlasted = 0
		if(ShadowCaptured)
			if(HasHiraishin)
				HiraishinEvade()
			else
				KawaEvade()
			if(ShadowCaptured)
				ShadowCaptured.ShadowList -= src
				ShadowCaptured = 0
		if(JubakuBound)
			if(HasHiraishin)
				HiraishinEvade()
			else
				KawaEvade()
			JubakuBound = 0
		..()

	GetSerious()
		if(!Serious)
			Serious = 1
			hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[name]</font> says:</b> I'll just scratch it's surface", "Chat")
			atkspeed = 3
			EvadeChance = 40
			ATKWAit = 5
			Stamina+=40000000
			Wounds = 0
			MaxBangs += 3
			KO = 0
			DamWait = 6000
			see_invisible +=2
			ThornActivate()
		else if(Serious == 1)
			Serious = 2
			hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[name]</font> says:</b> I just need a little more", "Chat")
			atkspeed = 2
			EvadeChance = 60
			ATKWAit = 4
			Stamina += 40000000
			Wounds  = 0
			MaxBangs += 3
			KO = 0
			DamWait = 6000
			see_invisible +=2
			ThornActivate()

	AI()
		set waitfor = 0
		while(!dead)
			if(Serious<2)
				if((Stamina < StaminaMax * 0.5) && !KO)
					GetSerious()
			if(sleepy&&prob(90))
				sleepy=0
				DispelProc()
			if(waterprisoned || Kanashibari || Coffin || InKageArashi || IceBlasted || ShadowCaptured || JubakuBound)
				FreeMe()
			if(RESTRAINEDCHECK(src) || InIzanami)
				sleep(10)
				continue
			if(ClayInfection)
				ClayInfection = 0
			var/mob/t
			var/list/ppl=list()
			var/list/Clones = list()
			for(var/H in HitList)
				if(!H)
					HitList -= H
					continue
				var/mob/A = HitList[H]
				if(!A)
					InactiveList[H] = 1
					HitList -= H
					continue
				for(var/mob/c in A.MasterBunshinList)
					Clones+=c
				for(var/mob/c in A.EdoCloneList)
					Clones+=c
				if(A.Familiar)
					Clones+=A.Familiar
				if(A == src)
					HitList -= H
					continue
				if(A.dead)
					HitList -= H
					continue
				if(A.protect)
					continue
				if(A.invisibility > see_invisible)
					continue
				if(get_dist(A,src) > 50 || z != A.z)
					continue
				if(A.Yield && YieldCheck(A))
					HitList -= H
					continue
				if(A.KO)
					if(PursuitMSG)
						hearers(4,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b>  [PursuitMSG]", "Chat")
					t = A
					break
				if(istype(A,/mob/Hittable/Command/Clones)||istype(A,/mob/Hittable/Command/EdoClone))
					Clones+=A
				else
					ppl+=A
			if(!t)
				var/P,C
				if(ppl.len)
					P = 1
				if(Clones.len)
					C = 1
					for(var/mob/Cl in Clones)
						if(KageBunshinList.len < BunshinLimit)
							spawn()
								ShadowClone(Cl,1)
								ReverseFlow(Cl)
				if(P&&C)
					if(prob(80))
						t = pick(ppl)
					else
						t = pick(Clones)
				else if(P)
					t = pick(ppl)
				else if(C)
					t = pick(Clones)
			if(t)
				Attack1(t)
			sleep(5)
			CHECK_TICK

	Attack1(mob/M)
		if(sleepy&&prob(98))
			sleepy=0;
			DispelProc()
		if(M)
			if(Serious<2)
				if((Stamina < StaminaMax * 0.5) && !KO)
					GetSerious()
			if(KO)
				return
			else if(M.KO)
				AI_KO(M)
			else if(M.dead)
				HitList -= M
			else
				if(ShinsuCircles < MaxBangs)
					//while(ShinsuCircles < MaxBangs)
					ShinsuCircle(pick(1,2,3,4))
				if(Thorn == 2)
					if(!InShinwon && !ShinwonCool)
						ShinwonCool = 1
						spawn(1200)
							ShinwonCool = 0
						Shinwonryu_AI()
						hearers(4,src) << "[src] begins preparing a shining light"
				/*if(waterprisoned||Kanashibari||Coffin||InKageArashi||IceBlasted||ShadowCaptured||JubakuBound)
					FreeMe()*/
				if(Stamina>0&&!Lotus&&!fallen&&!frozen&&!GMfrozen&&!CantWalk)
					if(M.InFujinHeki && FireElemental)
						Housenka(M)
					while(get_dist(src,M) > 6)
						if(KO||M.dead)
							return
						if(M.KO)
							AI_KO(M)
							break
						if(!firing)
							ShinsuStream(M)
						if(!step_to(src,M))
							StepFailed++
						else
							StepFailed = 0
						sleep(movespeed)
						if(!src || !M)
							return
						CHECK_TICK
					var/GD = get_dist(src,M)
					if(GD>=2)
						sleep(ATKWAit)
						if(KO || dead)
							return
						if(M)
							if(M.protect)
								return
							if(M.icon_state=="seals"&&prob(90))
								Evade1(M)
							else if(!M.kaiten&&!M.MushiKabe)
								AI_Attack(M,11)
							else if(!firing)
								ShinsuStream(M)
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
		if(prob(20))
			if(Thorn == 1)
				ReverseFlow(M)
			else if(Thorn == 2)
				ReverseFlowField()
		while(AttackTime)
			if(Serious<2)
				if((Stamina < StaminaMax * 0.5) && !KO)
					GetSerious()
			if(KO||dead)
				break
			AttackTime--
			if(!M || M.protect || M.dead)
				break
			else
				if(KO||dead)
					break
				if(M.KO)
					AI_KO(M)
					break
				else
					while(get_dist(src,M) < 4)
						if(KO)
							break
						if(!firing)
							dir = get_dir(src,M)
							switch(pick(1,2,3,4,5))
								if(1)
									Suiryuudan(M)
								if(2)
									Housenka(M)
								if(3)
									DoryuuDango()
								if(4)
									Rairyuu(M)
								if(5)
									Mugen()
							ShinsuStream(M)
							firing = 0
						if(StepFailed >= 10)
							ShinsuForce()
							StepFailed = 0
							break
						if(!step_away(src,M))
							StepFailed++
						else
							StepFailed = 0
						//spawn()
						var/turf/T = get_step(src,dir)
						for(var/mob/F in T)
							AI_Punch(F)
						sleep(movespeed)
						if(!src || !M)
							return
						CHECK_TICK
					while(get_dist(src,M) > 6)
						if(KO)
							break
						if(!firing)
							ShinsuStream(M)
							dir = get_dir(src,M)
							switch(pick(1,2,3,4,5))
								if(1)
									Suiryuudan(M)
								if(2)
									Housenka(M)
								if(3)
									DoryuuDango()
								if(4)
									Rairyuu(M)
								if(5)
									Mugen()
						if(StepFailed >= 10)
							ShinsuForce()
							StepFailed = 0
							break
						if(!step_to(src,M))
							StepFailed++
						else
							StepFailed = 0
						//spawn()
						var/turf/T = get_step(src,dir)
						for(var/mob/F in T)
							AI_Punch(F)
						sleep(movespeed)
						if(!src || !M)
							return
						CHECK_TICK
					if(InShinwon == 2)
						hearers(4,src) << "[src] seems ready to throw that ball of light"
						for(var/i=1 to 5)
							if(KO)
								break
							if(get_dist(src,M) > 4)
								if(!step_to(src,M))
									StepFailed++
								else
									StepFailed = 0
							if(get_dist(src,M) < 3)
								if(!step_away(src,M))
									StepFailed++
								else
									StepFailed = 0
							if(!firing)
								dir = get_dir(src,M)
								switch(pick(1,2,3,4,5))
									if(1)
										Suiryuudan(M)
									if(2)
										Housenka(M)
									if(3)
										DoryuuDango()
									if(4)
										Rairyuu(M)
									if(5)
										Mugen()
							sleep(movespeed)
						dir = get_dir(src,M)
						Shinwonryu_AI()
					else if(get_dist(src,M)<2)
						dir = get_dir(src,M)
						AI_Punch(M)
						sleep(atkspeed)
					else
						dir = get_dir(src,M)
						switch(pick(1,2,3,4,5))
							if(1)
								Suiryuudan(M)
							if(2)
								Housenka(M)
							if(3)
								DoryuuDango()
							if(4)
								Rairyuu(M)
							if(5)
								Mugen()
						firing = 0
						sleep(atkspeed)
		AttackTime = 0

	AI_KO(mob/M)
		if(KO || M.dead || KOChase)
			return
		if(M)
			KOChase = 1
			while(get_dist(src,M) > 1)
				if(KO)
					KOChase = 0
					return
				step_to(src,M)
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
						if(FinishMSG)
							hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b>  [FinishMSG]", "Chat")
						attacking=1
						spawn(atkspeed+3)
							if(src)
								attacking=0
						flick("punch",src)
						M.Wounds+=150
						M.KillMe(src)
						HitList -= M
				KOChase = 0

	DamageMe(mob/M, var/D,METHOD,hidemessage)
		if(!M)
			return
		if(dead || M == src || M.protect)
			return

		if(M.Creator)
			var/mob/CR = M.Creator
			if(!HitList[CR.trueName])
				HitList[CR.trueName] = CR

		if(get_dist(M,src) < 2)
			if(!istype(M,/mob/Hittable/Responsive) && ismob(M))
				if(!M.trueName)
					M.trueName = M.name
				if(!HitList[M.trueName])
					HitList[M.trueName] = M

		switch(METHOD)
			if("strikes","attacks","punch","kick", "slices","hacks at","whips","sweeps","slashes","swings at","slaps")
				D*=0.3
			if("BunshinExplode","palm","palms")
				D*=0.5
			if("Jashin")
				D*=0.05
			else
				D*=1.2

		if(Thorn)
			D*=1-(0.2*Thorn)
		if(M.client)
			if(!HitList[M.trueName])
				HitList[M.trueName] = M
			if(!KO)
				if(!DamagedMe[M.trueName])
					DamagedMe[M.trueName] = D
				else
					DamagedMe[M.trueName] += D
		var
			w
		if(D<1)
			D=1
		D=round(D); w=(D/StaminaMax)*65
		Stamina-=D;
		if(M)
			DamWait = 6000
			M.Damaged()
			Damaged()
			if(!hidemessage)
				DamageReport(src,M,D,METHOD)

			M.ExperienceCheck(w,src)
			M.RefreshStats()
			if(Stamina<=0)
				if(!KO)
					KO=1
					icon_state="KO"
					range(src)<<"<b><i>[src] has fallen with exhaustion!</i></b>"
					spawn(50)
						if(!dead)
							KO=0
							icon_state=""
							Stamina=10000000
				else
					if(Wounds<100)
						Wounds+=5
					else
						KillMe(M)

	KillMe(mob/M)
		..()
		if(istype(M,/mob/Hittable/Command/Clones/)) M=M.Creator
		if(istype(M,/mob/Hittable/Responsive/Animal/Pet/)) M=M.Master
		if(dead) return
		dead=1
		if(M)
			var/mob/Hittable/Responsive/Boss/Viole/Mi = src
			for(var/H in HitList)
				var/mob/P = HitList[H]
				if(!P)
					continue
				if(Mi.DamagedMe[P.trueName] > 5000000)
					P.StatPoints += 30
					P.StatUpdate_statpoints()
					var/obj/Item/Icon_Scroll/I = locate() in P
					if(!I)
						new/obj/Item/Icon_Scroll(P)
					else
						I.amount++
					P.UpdateInventory()
					if(prob(1))
						new/obj/Clothing/Over/VioleRobe(src)
						src<<"<b><i>You obtain something special...</i></b>"
						UpdateInventory();
					P << "<b><b>Headon says: You are now ready to climb the tower</b><br>+30 Stat Points<br>+1 Icon Scroll"
					var/obj/SkillCards/Ninjutsu/Special/Tower/ShinsuStream/J=locate() in P.contents
					if(!J)
						P<<"<b><font size=2>You've just learned <i>Shinsu Stream</i>!</b></font>"
						J = new(P)

		SpecialMobs["Viole"] = 1
		spawn(3000)
			SpecialMobs["Viole"] = 0
		del src

	RestoreMe()
		del(src)