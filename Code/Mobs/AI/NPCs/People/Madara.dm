mob/Hittable/Responsive/Boss/Madara
	name="Madara"
	icon='Base_Pale.dmi'
	Village="Event"
	NinjaRank="Ancestor"
	WW = 1
	Level = 8000
	Taijutsu=905000
	Ninjutsu=2005000
	Genjutsu=605000
	TaijutsuMax=905000
	NinjutsuMax=2005000
	GenjutsuMax=605000
	Stamina=35000000
	StaminaMax=35000000
	ChakraMax=800000
	WindElemental=10000
	FireElemental=10000
	LightningElemental=10000
	WaterElemental=10000
	EarthElemental=10000
	VillageColour = "#990000"
	Reflex=520
	ReflexTrue=400
	gender="male"
	movespeed=1.4
	atkspeed=3
	SS = 0
	protect=0
	Cooldowns = list()

	EvadeChance = 10
	BunshinLimit = 16
	see_invisible = 12
	PursuitMSG = "Your fate is now within my grasp"

/*	Action(mob/user)
		if(get_dist(user,src)>2) return
		if(user.GMfrozen||user.choosing)
			return
		else
			if(!user.GaveSpecialScroll)
				var/obj/Item/Scroll/Special_Scroll/OB = locate() in user.contents
				if(OB)
					if(user.TaijutsuTrue > 120000 && user.NinjutsuTrue > 80000)
						user << "I see Jiraiya has given you his blessing, I cant teach you everything but this will go a long way"
						del OB
						user.GaveSpecialScroll = 1
					else
						user << "I see you have the blessing but you lack the skill for this technique"
*/
	New()
		//del src
		//return
		overlays += icon('SharinganEyes.dmi')
		overlays += icon('Shoes.dmi')
		overlays += icon('Pants.dmi')
		overlays += icon('UchiShirt.dmi')
		overlays += icon('Madara-Chest.dmi')
		overlays += icon('Hair_Madara.dmi')
		var/obj/Weapon/Wield/Gunbai/GN = new(src)
		EquipRemove_Weapon(GN,GN.icon)
		//respawn=loc
		SpecialMobs["Madara"] = src

	FreeMe()
		sleep(10)
		if(waterprisoned)
			Inazuma() //Lightning Field
			waterprisoned = 0
			overlays -= 'WPrison.dmi'
		if(Kanashibari)
			KawaEvade()
			Kanashibari--
			if(Kanashibari < 0)
				Kanashibari = 0
		else if(Coffin)
			Coffin--
			if(Coffin < 0)
				Coffin = 0
			overlays-='Coffin.dmi'
			KuchuNejire()//Aerial Twist
		else if(InDoumu)
			Daitoppa()
			Mugen()
		else if(IceBlasted)
			overlays-='iceblastcover.dmi'
			KazanFunka()//Volcanic erruption
			IceBlasted--
			if(IceBlasted < 0)
				IceBlasted = 0
		else if(ShadowCaptured)
			KawaEvade()
			if(ShadowCaptured)
				ShadowCaptured.ShadowList -= src
				ShadowCaptured = 0
		else if(JubakuBound)
			KawaEvade()
			JubakuBound = 0
		..()

	GetSerious()
		switch(Serious)
			if(0)
				Serious = 1
				atkspeed = 2
				movespeed = 1
				Stamina += 50000000
				Wounds = 0
				hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> you're but a flea in the face of these eyes", "Chat")

				new/obj/SharEye(src,"EMS1",50)
				FlashSteps =1
				DouEyes = new/Overlay_Obj('SharinganEyes.dmi',EYE_LAYER)
				overlays+=DouEyes
				InSharingan=4;
				overlays -= icon('Madara-Chest.dmi')
				//var/obj/Weapon/Wield/Gunbai/GN = locate() in src
				Reflex+=50
				if(!Projection)
					see_invisible += InSharingan

			if(1)
				Serious = 2
				overlays -= icon('SharinganEyes.dmi')
				overlays -= icon('Shoes.dmi')
				overlays -= icon('UchiShirt.dmi')
				//var/obj/Weapon/Wield/Gunbai/GN = locate() in src
				//EquipRemove_Weapon(GN,GN.icon)
				atkspeed = 1
				movespeed = 0.3
				Stamina += 380000000
				Wounds = 0
				hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> Witness the true might of the Uchiha", "Chat")

				ShinraTensei()

				overlays -= icon('Hair_Madara.dmi')
				var/icon/I = icon('Hair_Madara.dmi')
				I += rgb(170,170,170)
				overlays += I

				new/obj/SharEye(src,"R1",50)
				HasRinnegan=1;

	AI()
		set waitfor = 0
		while(!dead)
			if(RinneBlown)
				sleep(1)
				continue
			if(KO || InIzanami)
				sleep(10)
				continue
			if(sleepy)
				sleepy=0
				DispelProc()
			if(InIllusion)
				if(prob(70))
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
					else if(InIzanami)
						sleep(10)
						continue

			if(waterprisoned||Kanashibari||Coffin||InKageArashi||IceBlasted||ShadowCaptured||JubakuBound)
				FreeMe()

			var/mob/t
			var/list/ppl = list()
			var/list/Clones = list()

			for(var/mob/A in oview(src,20))
				if(A == src)
					continue
				if(A.dead)
					continue
				if(A.protect)
					continue
				if(IDCHECK(A,src))
					continue
				if(istype(A,/mob/Hittable)||A.client)
					if(istype(A,/mob/Hittable/Unresponsive/NPC)||istype(A,/mob/Hittable/Unresponsive/Training)||istype(A,/mob/Hittable/Responsive/Boss)||istype(A,/mob/Hittable/Responsive/NPC)||istype(A,/mob/Hittable/Command/Genjutsu))
						continue
					if(istype(A,/mob/Hittable/Command/EdoClone))
						Clones+=A
					else if(A.Familiar)
						Clones+=A.Familiar
					else if(istype(A,/mob/Hittable/Command/Clones))
						if(Serious==2)
							del A
						else
							Clones += A
					else
						if(A.kaiten || A.MushiKabe || A.Tsukuyomi)
							continue
						if(A.KO)
							t = A
							break
						ppl+=A

			if(!t)
				if(RESTRAINEDCHECK(src))
					sleep(10)
					continue
				var/P,C
				if(ppl.len)
					P = 1
				if(Clones.len)
					C = 1
					for(var/mob/Cl in Clones)
						if(KageBunshinList.len < BunshinLimit)
							ShadowClone(Cl,1)
				if(P&&C)
					if(prob(90))
						t = pick(ppl)
					else
						t = pick(Clones)
				else if(P)
					t = pick(ppl)
				else if(C)
					t = pick(Clones)
			if(t)
				switch(Serious)
					if(2)
						Attack3(t)
					if(1)
						Attack2(t)
					else
						Attack1(t)

			sleep(5)
			CHECK_TICK

	proc
		Attack3(mob/M)
			if(Stamina<1)
				return
			if(sleepy&&prob(98))
				sleepy=0;
				DispelProc()
			if(!ReverseGenjutsu && prob(30))
				//new/obj/SharEye(src,"EMS1",10)
				JutsuMessage("Kyouten Chiten")
				ReverseGenjutsu = 1
				spawn(40)
					ReverseGenjutsu = 0
			if(M)
				if(waterprisoned||Kanashibari||Coffin||InKageArashi||IceBlasted||ShadowCaptured||JubakuBound)
					sleep(10)
					FreeMe()

				if(M.protect)
					return

				if(!dead && !DeathSee && !Lotus && !KO && !MushiKabe && !fallen && !Underground && !frozen && !GMfrozen && !resting && !CantWalk && !length(AcquiringList))
					if(M.KO)
						AI_KO(M)
					else if(M.dead)
						HitList -= M.trueName
					else if(M.UsedArashi)
						Move_Away(M)
						if(Move_Aim(M))
							Housenka(M)
					else if(M.InFujinHeki)
						Housenka(M)

					else if(get_dist(src,M)>=2)
						if(KageBunshinList.len < 4)
							for(var/i = KageBunshinList.len to 4)
								LimboClone(M)
						if(prob(70))
							if(!Cooldowns["Izanagi"] && !InIzanagi)
								new/obj/SharEye(src,"EMS1",10)
								JutsuMessage("Izanagi")
								InIzanagi = 1
								spawn(50)
									InIzanagi = 0
									Cooldowns["Izanagi"] = 1
									spawn(200)
										Cooldowns["Izanagi"] = 0
							else if(!Cooldowns["Kamui"] && !InKamui)
								new/obj/SharEye(src,"EMS1",10)
								JutsuMessage("Kamui")
								InKamui = 1
								spawn(30)
									InKamui = 0
									Cooldowns["Kamui"] = 1
									spawn(100)
										Cooldowns["Kamui"] = 0
						if(M.icon_state=="seals")
							Evade1(M)
						else if(!firing)
							if(KageBunshinList.len < 4)
								JutsuMessage("Limbo")
								for(var/i = KageBunshinList.len to 4)
									LimboClone(M)
							switch(rand(1,100))
								if(1 to 30)
									if(!Cooldowns["TengaShinsei"])
										new/obj/SharEye(src,"R1",10)
										JutsuMessage("Tenga Shinsei")
										Cooldowns["TengaShinsei"] = 1
										spawn(800)
											Cooldowns["TengaShinsei"]--
										new/Effect/Visual/TengaiShinsei(M.loc,src)
									else if(!Cooldowns["Chibaku"])
										new/obj/SharEye(src,"R1",10)
										JutsuMessage("Chibaku Tensei")
										Cooldowns["Chibaku"] = 1
										spawn(400)
											Cooldowns["Chibaku"]--
										new/Effect/Visual/ChibakuTensei(loc,src,50,6)
										sleep(6)
										Cooldowns["AmatShield"] = 1
										spawn(200)
											Cooldowns["AmatShield"] = 0
										sleep(20)
										if(M.client && loc==get_step(M,M.dir) && !M.Tsukuyomi && Cooldowns["Tsuku"]<4)
											dir=get_dir(src,M)
											AI_Tsukuyomi(M)
											Move_Away(M)
											if(Cooldowns["Tsuku"]<2)
												Cooldowns["Tsuku"] = 1
											else
												Cooldowns["Tsuku"]++
											spawn(600)
												Cooldowns["Tsuku"]--
										else
											AI_Attack(M,5,0)
									else if(!Cooldowns["ShinraTenseiPull"])
										new/obj/SharEye(src,"R1",10)
										JutsuMessage("Shinra Tensei")
										ShinraTenseiPull()
										if(!Cooldowns["ShinraTenseiPull"])
											Cooldowns["ShinraTenseiPull"] = 1
										else
											Cooldowns["ShinraTenseiPull"]++
										spawn(100)
											Cooldowns["ShinraTenseiPull"]--
										for(var/turf/T in oview(2,src))
											spawn()
												var/TL = T.loc
												if(TL && (istype(TL,/area/Water)||istype(TL,/area/Waterfall)))
													return
												new/obj/Jutsu/Uchiha/AmaterasuBurn(T,src)
										Cooldowns["AmatShield"] = 1
										spawn(200)
											Cooldowns["AmatShield"] = 0
										sleep(20)
										if(M.client && loc==get_step(M,M.dir) && !M.Tsukuyomi && Cooldowns["Tsuku"]<4)
											dir=get_dir(src,M)
											AI_Tsukuyomi(M)
											Move_Away(M)
											if(Cooldowns["Tsuku"]<2)
												Cooldowns["Tsuku"] = 1
											else
												Cooldowns["Tsuku"]++
											spawn(600)
												Cooldowns["Tsuku"]--
										else
											AI_Attack(M,5,0)
									else
										AI_Attack(M,5)
								if(31 to 80)
									if(Cooldowns["Amaterasu"]<6)
										Move_Aim(M)
										new/obj/SharEye(src,"EMS1",10)
										JutsuMessage("Amaterasu")
										if(!Cooldowns["Amaterasu"])
											Cooldowns["Amaterasu"] = 1
										else
											Cooldowns["Amaterasu"]++
										spawn(70)
											Cooldowns["Amaterasu"]--
										var/obj/Jutsu/Uchiha/Amaterasu/AM=new(src,80,1)
										spawn(12)
											if(AM)
												del(AM)
										spawn(1)
											Daitoppa()
									else
										Move_Aim(M)
										Goukakyuu()
										sleep(4)
										Renkoudan()

								if(81 to 100)
									if(M.client && !M.InIllusion && Cooldowns["Izanami"]<2)
										JutsuMessage("Izanami")
										new/obj/SharEye(src,"EMS1",10)
										IzanamiActivate(M,50,0)
										if(!Cooldowns["Izanami"])
											Cooldowns["Izanami"] = 1
										else
											Cooldowns["Izanami"]++
										spawn(460)
											Cooldowns["Izanami"]--
									else
										Move_Aim(M)
										Goukakyuu()
										sleep(4)
										Renkoudan(3)
						else
							if(KageBunshinList.len < 4)
								JutsuMessage("Limbo")
								for(var/i = KageBunshinList.len to 4)
									LimboClone(M)
							AI_Attack(M,5)
					else
						if(KageBunshinList.len < 4)
							for(var/i = KageBunshinList.len to 4)
								LimboClone(M)
						AI_Attack(M,5)

	Attack2(mob/M)
		if(Stamina<1)
			return
		if(sleepy&&prob(98))
			sleepy=0;
			DispelProc()
		if(!ReverseGenjutsu && prob(30))
			//new/obj/SharEye(src,"EMS1",10)
			JutsuMessage("Kyouten Chiten")
			ReverseGenjutsu = 1
			spawn(40)
				ReverseGenjutsu = 0
		if(M)
			if(waterprisoned||Kanashibari||Coffin||InKageArashi||IceBlasted||ShadowCaptured||JubakuBound)
				sleep(20)
				FreeMe()

			if(M.protect)
				return

			if(!dead && !DeathSee && !Lotus && !KO && !MushiKabe && !fallen && !Underground && !frozen && !GMfrozen && !resting && !CantWalk && !length(AcquiringList))
				if(M.KO)
					AI_KO(M)
				else if(M.dead)
					HitList -= M.trueName
				else if(M.UsedArashi)
					Move_Away(M)
					if(Move_Aim(M))
						Housenka(M)
				else if(M.InFujinHeki)
					Housenka(M)
				else if(get_dist(src,M)>=2)
					if(M.icon_state=="seals" && prob(90))
						if(!Cooldowns["Izanagi"] && !InIzanagi)
							new/obj/SharEye(src,"EMS1",10)
							JutsuMessage("Izanagi")
							InIzanagi = 1
							spawn(50)
								InIzanagi = 0
								Cooldowns["Izanagi"] = 1
								spawn(100)
									Cooldowns["Izanagi"] = 0
						else if(!Cooldowns["Kamui"] && !InKamui)
							new/obj/SharEye(src,"EMS1",10)
							JutsuMessage("Kamui")
							InKamui = 1
							spawn(30)
								InKamui = 0
								Cooldowns["Kamui"] = 1
								spawn(100)
									Cooldowns["Kamui"] = 0
						else
							Evade1(M)
					else if(!firing)
						if(prob(60) && Move_Aim(M))
							if(Cooldowns["Amaterasu"]<6)
								new/obj/SharEye(src,"EMS1",10)
								JutsuMessage("Amaterasu")
								if(!Cooldowns["Amaterasu"])
									Cooldowns["Amaterasu"] = 1
								else
									Cooldowns["Amaterasu"]++
								spawn(70)
									Cooldowns["Amaterasu"]--
								var/obj/Jutsu/Uchiha/Amaterasu/AM=new(src,80,1)
								spawn(12)
									if(AM)
										del(AM)
								spawn(1)
									Daitoppa()
							else
								Ryuuka()
								Daitoppa()
						else
							if(M.InIllusion && !Cooldowns["Izanami"]<3)
								JutsuMessage("Izanami")
								new/obj/SharEye(src,"EMS1",10)
								IzanamiActivate(M,50,0)
								if(!Cooldowns["Izanami"])
									Cooldowns["Izanami"] = 1
								else
									Cooldowns["Izanami"]++
								spawn(120)
									Cooldowns["Izanami"]--
							else
								Move_Aim(M)
								Renkoudan(3)
					else
						AI_Attack(M,1)
				else
					if(loc==get_step(M,M.dir) && !M.Tsukuyomi && Cooldowns["Tsuku"]<2)
						dir=get_dir(src,M)
						AI_Tsukuyomi(M)
						Move_Away(M)
						if(!Cooldowns["Tsuku"])
							Cooldowns["Tsuku"] = 1
						else
							Cooldowns["Tsuku"]++
						spawn(1220)
							Cooldowns["Tsuku"]--
					else
						AI_Attack(M,1)


	Attack1(mob/M)
		if(Stamina<1)
			return
		if(sleepy&&prob(98))
			sleepy=0;
			DispelProc()

		if(M)
			if(waterprisoned||Kanashibari||Coffin||InKageArashi||IceBlasted||ShadowCaptured||JubakuBound)
				FreeMe()

			if(M.protect)
				return

			if(!dead && !DeathSee && !Lotus && !KO && !MushiKabe && !fallen && !Underground && !frozen && !GMfrozen && !resting && !CantWalk && !length(AcquiringList))
				if(M.KO)
					AI_KO(M)
				else if(M.dead)
					HitList -= M.trueName
				else if(M.UsedArashi)
					Move_Away(M)
					if(Move_Aim(M))
						Housenka(M)
				else if(M.InFujinHeki)
					Housenka(M)
				else if(get_dist(src,M)>=2)
					if(M.icon_state=="seals" && prob(90))
						Evade1(M)
					else if(!firing)
						if(Move_Aim(M))
							Ryuuka()
					else
						AI_Attack(M,1)
				else
					AI_Attack(M,1)

	AI_Attack(mob/M, var/AttackTime, Push=1)
		while(AttackTime>0 && !KO)
			if(!M || M.protect || M.dead)
				break
			else
				var/A = get_dist(src,M)
				if(A>=20)
					break
				if(A>1)
					if(Serious == 2)
						while(M && get_dist(src,M) > 1 && !KO)
							step_to(src,M)
							var/turf/T = Get_Rand_DirStep(M)
							if(T)
								loc.loc.Exited(src)
								loc = T
								loc.loc.Entered(src)
							sleep(movespeed)
					else
						while(get_dist(src,M) > 1 && !KO)
							step_to(src,M)
							sleep(movespeed)
					if(!src || !M)
						return
				if(!KO && get_dist(src,M)<2)
					dir = get_dir(src,M)
					AI_Punch(M,Push)
					sleep(atkspeed)
			AttackTime--
		AttackTime = 0

	AI_KO(mob/M)
		if(KO || M.dead || KOChase)
			return
		if(M)
			KOChase = 1
			if(Serious == 2)
				while(get_dist(src,M) > 1 && !KO)
					step_to(src,M)
					var/turf/T = Get_Rand_DirStep(M)
					if(T)
						loc.loc.Exited(src)
						loc = T
						loc.loc.Entered(src)
			else
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
			if(KO)
				KOChase = 0
				return
			if(src && M)
				dir=get_dir(src,M)
				//if(TAICHECKBOTH(src,M))
				//	KOChase = 0
				//	return
				if(!M.KO && !M.dead)
					if(Serious)
						hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> Power is the only true necessity", "Chat")
					else
						hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> It seems that you still want to dance", "Chat")
				else
					if(M && !M.dead)
						hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> Wake up to reality! Nothing ever goes as planned in this world.", "Chat")
						attacking=1
						spawn(atkspeed+3)
							if(src)
								attacking=0
						flick("punch",src)
						M.Wounds+=150
						M.KillMe(src)
						if(M)
							HitList -= M.trueName
			KOChase = 0

	AI_Punch(mob/TARGET,Push=1)
		if(TARGET)
			if(TAICHECKBOTH(src,TARGET)) return
			if(inchidori) {ChidoriPunch(TARGET); return}
			if(inrasengan) {RasenganPunch(TARGET); return}
			if(wielding == "Gunbai" && Push)
				if(!firing)
					firing = 1
					spawn(atkspeed*3)
						firing = 0
					var/obj/Jutsu/Class/Fan/Ookamaitachi/F=new(loc, src, WindElemental*0.5, Ninjutsu * 0.05)
					F.movespeed=0.2
					walk(F,dir)
			if(InKamui)
				InKamui = 0
			var/dmg=round(Taijutsu*0.9-(TARGET.Taijutsu*0.09))
			dmg+=NPCWeapons(TARGET)
			if(dmg<round(Taijutsu*0.1)) dmg=round(Taijutsu*0.1)
			//flick("punch",src)
			icon_state = "punch"
			spawn(4)
				if(icon_state == "punch")
					icon_state = null
			if(HitCheck(TARGET))
				attacking=1; spawn(atkspeed)attacking=0
				TARGET.DamageMe(src,dmg,AttackMethod)
				if(TARGET)
					if(TARGET.KO)
						AI_KO(TARGET)
			else
				attacking=1
				spawn(atkspeed*4)attacking=null
				if(TARGET)
					TARGET<<"You dodged [src]'s attack"

	DamageMe(mob/M, var/D,METHOD,hidemessage)
		if(dead || M == src || M && M.protect || InKamui)
			return
		var
			w
		if(METHOD == "Jashin")
			D*=0.05
		if(D<1)
			D=1
		if(Serious)
			if(!Cooldowns["AmatShield"] && get_dist(src,M) < 2)
				for(var/turf/T in oview(1,src))
					spawn()
						var/TL = T.loc
						if(TL && (istype(TL,/area/Water)||istype(TL,/area/Waterfall)))
							return
						new/obj/Jutsu/Uchiha/AmaterasuBurn(T,src)
				Cooldowns["AmatShield"] = 1
				spawn(200)
					Cooldowns["AmatShield"] = 0
				return

			else if(!Cooldowns["Izanagi"] && !InIzanagi)
				new/obj/SharEye(src,"EMS1",10)
				JutsuMessage("Izanagi")
				InIzanagi = 1
				Cooldowns["Izanagi"] = 1
				spawn(50)
					InIzanagi = 0
					spawn(100)
						Cooldowns["Izanagi"] = 0

			else if(!Cooldowns["Kamui"] && !InKamui)
				new/obj/SharEye(src,"EMS1",10)
				JutsuMessage("Kamui")
				InKamui = 1
				spawn(30)
					InKamui = 0
					Cooldowns["Kamui"] = 1
					spawn(100)
						Cooldowns["Kamui"] = 0

		if(InIzanagi)
			IzanagiClone(M)
			return
		D=round(D); w=(D/StaminaMax)*65
		Stamina-=D;
		if(D>100000000)
			hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> I acknowledge your Power!", "Chat")
		if(M)
			M.Damaged()
			if(!istype(M,/mob/NPC) && ismob(M))
				if(!M.trueName)
					M.trueName = M.name
				if(!HitList[M.trueName])
					HitList[M.trueName] = M
				if(!KO)
					if(!DamagedMe[M.trueName])
						DamagedMe[M.trueName] = D
					else
						DamagedMe[M.trueName] += D
			if(!DTimer)
				DamWait = 1800
				DamageTimer(DamWait)
			else
				DamWait = 1800
			Damaged()
			if(!hidemessage)
				DamageReport(src,M,D,METHOD)

			M.ExperienceCheck(w,src)
			M.RefreshStats()
			if(Serious>1)
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
					else
						if(Wounds<100)
							Wounds+=5
						else
							KillMe(M)
				else if((Wounds>=150)||(Stamina<=0&&Wounds>=100))
					if(!KO)
						KO=1; icon_state="KO"; range(src)<<"<b><i>[src] has fallen gravely unconcious!</i></b>"
						spawn(50)if(M&&!M.dead)KillMe(M)
			else
				if(Stamina<=0)
					GetSerious()

	KillMe(mob/M)
		..()
		if(istype(M,/mob/Hittable/Command/Clones/)) M=M.Creator
		if(istype(M,/mob/Hittable/Responsive/Animal/Pet/)) M=M.Master
		if(dead) return
		dead=1
		if(M)
			var/mob/Hittable/Responsive/Boss/Minato/Mi = src
			var/list/PrizeChance = list()
			for(var/H in HitList)
				var/mob/P = HitList[H]
				if(!P)
					continue
				if(Mi.DamagedMe[P.trueName] > 3000000)
					P.StatPoints += 30
					P.StatUpdate_statpoints()

					PrizeChance += P

					var/obj/Item/Icon_Scroll/I = locate() in P
					if(!I)
						new/obj/Item/Icon_Scroll(P)
					else
						I.amount++
					if(prob(20))
						new/obj/Clothing/Armour/UchihaArmour(src)
						src<<"<b><i>You obtained something special...</i></b>"
					if(prob(1))
						new/obj/Weapon/Wield/Gunbai(src)
						src<<"<b><i>You obtained something exceedingly rare...</i></b>"
					P << "<br>+30 Stat Points<br>+1 Icon Scroll"
					P.UpdateInventory()

			if(prob(10) && PrizeChance.len)
				var/mob/P = pick(PrizeChance)
				P << "<b><i>You feel a new power awaken within you</i></b>"
				P.HasRinnegan = 1
			del src

	Del()
		for(var/mob/KM in KageBunshinList)
			del KM
		flick('Smoke.dmi',src)
		loc=locate(0,0,0)
		..()
//--------------------------------------------------------
	RestoreMe()
		Stamina = StaminaMax
		Wounds = 0

		hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> your destiny wasnt here it seems", "Chat")

		dir=SOUTH
		HasKonchuu = list()
		DamagedMe = list()
