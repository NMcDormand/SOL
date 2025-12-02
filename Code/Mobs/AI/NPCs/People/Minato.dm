mob/verb/SpyMinato()
	set name = "Spectate Minato"
	if(InSPS)
		return
	if(SpyStatus)
		client.perspective = MOB_PERSPECTIVE|EDGE_PERSPECTIVE; usr.client.eye = usr
		SpyStatus=0
	else
		if(SpecialMobs["Minato"])
			usr.client.perspective = EYE_PERSPECTIVE;
			usr.client.eye = SpecialMobs["Minato"]
			usr.SpyStatus=1

mob/Hittable/Responsive/Boss/Minato
	name="Minato"
	icon='Base_Pale.dmi'
	Village="Event"
	NinjaRank="Former Hokage"
	WW = 1
	Level = 8000
	Taijutsu=905000
	Ninjutsu=405000
	Genjutsu=605000
	TaijutsuMax=905000
	NinjutsuMax=405000
	GenjutsuMax=605000
	Stamina=95000000
	StaminaMax=95000000
	ChakraMax=800000
	WindElemental=100000
	FireElemental=100000
	LightningElemental=100000
	WaterElemental=100000
	EarthElemental=100000
	VillageColour = "#e92106"
	Reflex=550
	ReflexTrue=180
	gender="male"
	movespeed=1
	atkspeed=4
	protect=0
	HasHiraishin = 1
	EvadeChance = 10
	BunshinLimit = 16
	var/FEvade = 30
	var/IKunai = 18
	var/list/GKunai = list()
	var/list/Touched = list()
	PursuitMSG = "This is my chance"

	Action(mob/user)
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

	New()
		//del src
		//return
		var/icon/A = icon('Hair_Minato.dmi')
		A += rgb(204,204,102)
		overlays += A
		A = icon('Eyes_Base.dmi')
		A += rgb(102,102,255)
		overlays += A
		overlays += icon('Shoes.dmi')
		overlays += icon('Pants.dmi')
		overlays += icon('LShirt.dmi')
		overlays += icon('Jounin_Leaf.dmi')
		if(prob(50))
			overlays += icon('Yondaime-Cloak.dmi')
		overlays += icon('Headband-Minato.dmi')
		for(var/obj/Weapon/Wield/MKunai/B in world)
			B.Owner = src
			GKunai += B
		respawn=loc
		if(!SpecialMobs["Minato"])
			SpecialMobs["Minato"] = src
		spawn(10) AI()

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
		if(InDoumu)
			Daitoppa()
			Mugen()
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
		Serious = 1
		atkspeed = 3
		EvadeChance = 40
		FEvade +=32
		ATKWAit = 5
		Stamina += 100000000
		Wounds = 0
		hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">Minato Namikaze</font> says:</b> I'll show you what it means to be Hokage", "Chat")
		SageMode()
		spawn(pick(60,120,180))
			if(src && !KO && !dead)
				HiraishinBarrage()

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
			for(var/H in HitList)
				var/mob/M = HitList[H]
				if(!M)
					InactiveList[H] = 1
					HitList -= H
					continue
				if(M == src)
					HitList -= H
					continue
				if(M.dead)
					HitList -= H
					continue
				if(M.protect)
					continue
				if(get_dist(M,src) > 50 || z != M.z)
					continue
				if(invisibility > see_invisible && !Serious && !Touched[M.trueName])
					continue
				else// if(M in YieldList)
					if(M.KO)
						t = M
						if(PursuitMSG)
							hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b>  [PursuitMSG]", "Chat")
						break
					else
						if(istype(M,/mob/Hittable/Command/Clones))
							Clones += M
						else if(istype(M,/mob/Hittable/Command/EdoClone))
							Clones += M
							for(var/mob/Hittable/Command/Clones/C in M.KageBunshinList)
								Clones += C
						else
							ppl+=M
							for(var/mob/Hittable/Command/Clones/C in M.KageBunshinList)
								Clones += C
							for(var/mob/Hittable/Command/EdoClone/C in M.EdoCloneList)
								Clones += C
							if(M.Familiar)
								Clones+=M.Familiar
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
			if(M.KO)
				AI_KO(M)
			else if(M.dead)
				HitList -= M.trueName
			else
				if(waterprisoned||Kanashibari||Coffin||InKageArashi||IceBlasted||ShadowCaptured||JubakuBound)
					FreeMe()
				if(Stamina>0&&!dead&&!DeathSee&&!Lotus&&!KO&&!MushiKabe&&!fallen&&!Underground&&!frozen&&!GMfrozen&&!resting&&!CantWalk&&!length(AcquiringList))
					if(M.InFujinHeki)
						Housenka(M)
					if(get_dist(src,M)>=2 && !M.UsedArashi && !M.InFujinHeki)
						sleep(ATKWAit)
						if(KO)
							return
						if(M)
							if(M.protect)
								return
							if(prob(50) && (Touched[M.trueName]) && !(M.PortBlockCheck()))
								var/turf/TU = get_step(M,turn(M.dir,pick(-180,-90,90)))
								if(TU)
									var/turf/HL = loc
									HL.overlays += 'Hiraishin.dmi'
									spawn(4)
										HL.overlays -= 'Hiraishin.dmi'
									loc.loc.Exited(src)
									loc = TU
									if(loc.loc)
										loc.loc.Entered(src)
							if(!KageBunshinList.len && prob(45))
								ShadowClone(M,1)
								ShadowClone(M,1)
							else if(M.icon_state=="seals"&&prob(90))
								Evade1(M)
							else if(firing&&!M.kaiten&&!M.MushiKabe)
								AI_Attack(M,11)
							else if(!firing)
								Move_In(M);
								spawn(5)
									Ryuuka()
									sleep(4)
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
		while(AttackTime>0)
			if(KO)
				break
			if(!Serious)
				if((Stamina < StaminaMax * 0.5) && !KO)
					GetSerious()
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
						if(Touched[M.trueName] && !(M.PortBlockCheck()))
							var/turf/TU = get_step(M,turn(M.dir,pick(-180,-90,90)))
							if(TU)
								var/turf/HL = loc
								HL.overlays += 'Hiraishin.dmi'
								spawn(4)
									HL.overlays -= 'Hiraishin.dmi'
								loc.loc.Exited(src)
								loc = TU
								if(loc.loc)
									loc.loc.Entered(src)
						else
							step_to(src,M)
							sleep(movespeed)
							if(!src || !M)
								return
				if(KO)
					break
				if(get_dist(src,M)<2)
					if(!M.trueName)
						M.trueName = name
					if(!Touched[M.trueName])
						Touched[M.trueName] = M
					dir = get_dir(src,M)
					AI_Punch(M)
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
				if(Touched[M.trueName] && !(M.PortBlockCheck()))
					var/turf/TU = get_step(M,turn(M.dir,pick(-180,-90,90)))
					if(TU)
						var/turf/HL = loc
						HL.overlays += 'Hiraishin.dmi'
						spawn(4)
							HL.overlays -= 'Hiraishin.dmi'
						loc.loc.Exited(src)
						loc = TU
						if(loc.loc)
							loc.loc.Entered(src)
				else
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
					if(TAICHECKBOTH(src,M))
						KOChase = 0
						return
					if(!M.KO && !M.dead)
						if(Serious)
							hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">Minato Namikaze</font> says:</b> You're forcing this on me", "Chat")
						else
							if(M.Village == "Leaf")
								hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">Minato Namikaze</font> says:</b> The will of fire burns strong in you", "Chat")
							else
								hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">Minato Namikaze</font> says:</b> I may need to take you more seriously", "Chat")
					else
						if(!M.dead)
							hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">Minato Namikaze</font> says:</b>  If a person hasn't discovered something that they will die for, they arent fit to live.", "Chat")
							attacking=1
							spawn(atkspeed+3)
								if(src)
									attacking=0
							flick("punch",src)
							M.Wounds+=150
							M.KillMe(src)
							HitList -= M.trueName
				KOChase = 0

	AI_Punch(mob/TARGET)
		if(TARGET)
			if(TAICHECKBOTH(src,TARGET)) return
			if(inchidori) {ChidoriPunch(TARGET); return}
			if(inrasengan) {RasenganPunch(TARGET); return}
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
				if(TARGET.KO)
					AI_KO(TARGET)
			else
				attacking=1
				spawn(atkspeed*4)attacking=null
				TARGET<<"You dodged [src]'s attack"

	DamageMe(mob/M, var/D,METHOD,hidemessage)
		if(dead || M == src || M && M.protect)
			return
		if(get_dist(M,src) < 2)
			if(!istype(M,/mob/NPC) && ismob(M))
				if(!M.trueName)
					M.trueName = M.name
				if(!HitList[M.trueName])
					HitList[M.trueName] = M
		var/mob/Hitter = Touched[M.trueName]
		if(FEvade && METHOD != "ClayDeteriorate")
			var/DC = 20
			if(Serious)
				DC = 100
			if(prob(DC))
				if(Hitter && !(Hitter.PortBlockCheck()))
					var/turf/HL = loc
					HL.overlays += 'Hiraishin.dmi'
					spawn(4)
						HL.overlays -= 'Hiraishin.dmi'
					loc.loc.Exited(src)
					loc = get_step(Hitter,turn(Hitter.dir,pick(180,-90,90)))
					loc.loc.Entered(src)

					if(Serious)
						if(prob(80))
							FEvade--
					else
						FEvade--
					return
				else if(length(GKunai))
					var/turf/OL = loc
					OL.overlays += 'Hiraishin.dmi'
					spawn(4)
						OL.overlays -= 'Hiraishin.dmi'
					var/obj/Weapon/Wield/MKunai/NL = pick(GKunai)
					//loc.loc.Exited(src)
					if(NL)
						loc = NL.loc
						NL.Used++
						if(NL.Used >= 4)
							GKunai -= NL
							del NL
						//loc.loc.Entered(src)
						if(Serious)
							if(prob(80))
								FEvade--
						else
							FEvade--

					sleep(3)
					var/turf/HL = loc
					HL.overlays += 'Hiraishin.dmi'
					spawn(4)
						HL.overlays -= 'Hiraishin.dmi'
					loc=OL
					return
		if(SageMode)
			D*=0.8
		var
			w
		if(METHOD == "Jashin")
			D*=0.05
		if(D<1)
			D=1
		D=round(D); w=(D/StaminaMax)*65
		Stamina-=D;
		if(D>100000000)
			hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">Minato Namikaze</font> says:</b> Not bad... I actually felt that one", "Chat")
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

	KillMe(mob/M)
		..()
		if(istype(M,/mob/Hittable/Command/Clones/)) M=M.Creator
		if(istype(M,/mob/Hittable/Responsive/Animal/Pet/)) M=M.Master
		if(dead) return
		dead=1
		if(M)
			var/mob/Hittable/Responsive/Boss/Minato/Mi = src
			for(var/H in HitList)
				var/mob/P = HitList[H]
				if(!P)
					continue
				if(Mi.DamagedMe[P.trueName] > 3000000)
					P.StatPoints += 30

					P.StatUpdate_statpoints()
					var/obj/Item/Icon_Scroll/I = locate() in P
					if(!I)
						new/obj/Item/Icon_Scroll(P)
					else
						I.amount++
					P.UpdateInventory()
					if(prob(5))
						new/obj/Clothing/Over/YondaimeCloak(src)
						src<<"<b><i>You obtain something special...</i></b>"
						UpdateInventory();
					P << "<b><b>[src] says:</b> I acknowledge your power, You are now ready to obtain a greater skill and your village will hear of your bravery<br>+30 Stat Points<br>+1 Icon Scroll"
			del src

	Del()
		for(var/mob/KM in KageBunshinList)
			del KM
		for(var/mob/M in MasterPlayerList)
			if(M.client.eye == src)
				M.client.perspective = MOB_PERSPECTIVE|EDGE_PERSPECTIVE
				M.client.eye = M
				M.SpyStatus=0
		if(!MinatoDisabled)
			SpawnMe(30000,type,respawn)
		flick('Smoke.dmi',src)
		loc=locate(0,0,0)
		..()
//--------------------------------------------------------

	RestoreMe()
		Stamina = StaminaMax
		Wounds = 0
		SageModeDispel()
		Serious = 0
		movespeed=1
		atkspeed=4
		IKunai = 18
		ATKWAit = 5
		hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">Minato Namikaze</font> says:</b> with this chance ill bandage my wounds", "Chat")
		if(loc.loc)
			loc.loc.Exited(src)
		loc=respawn
		dir=SOUTH
		FEvade = initial(FEvade)
		HasKonchuu = list()
		DamagedMe = list()
		var/NOLOC = 0
		for(var/H in HitList)
			var/mob/MO = HitList[H]
			if(MO)
				if(MO == src)
					HitList -= H
					continue
				if(MO.z == z && get_dist(MO, src) <= 50)
					NOLOC = 1
		if(!NOLOC)
			HitList = list()
			HuntList = list()
			loc = respawn

	proc
		HiraishinBarrage()
			hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">Minato Namikaze</font> says:</b> This will be over in an...", "Chat")
			var/list/PList = list()
			var/turf/FStep = loc
			for(var/turf/A in range(10))
				PList += A
			for(var/H in HitList)
				var/mob/A = HitList[H]
				if(!A)
					continue
				if(A == src)
					HitList -= H
					continue
				if(Touched[A.trueName])
					spawn()
						var/s
						for(var/turf/B in orange(A,1))
							s = pick(0,1,2,3,4,5)
							spawn(s)
								var/turf/OL = loc
								OL.overlays += 'Hiraishin.dmi'
								B.overlays += 'Hiraishin.dmi'
								spawn(4)
									OL.overlays -= 'Hiraishin.dmi'
									B.overlays -= 'Hiraishin.dmi'
								loc = pick(PList)
						A.DamageMe(src,(Taijutsu*18)*0.2,"HiraishinBarrage")
			loc = FStep
			sleep(2)
			hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">Minato Namikaze</font> says:</b> ...Instant", "Chat")

obj/Weapon/Wield/MKunai
	name="Inscribed Kunai"
	icon='KunaiM.dmi'
	var/turf/Respawn
	var/Used
	Get()
		usr << "You cant seem to keep your grip on the kunai"
		return
	New()
		..()
		Respawn = loc
	Del()
		if(!Used)
			loc = locate(0,0,0)
			redo
			spawn(1000)
				if(Owner)
					if(Respawn)
						loc=Respawn
						Used = 0
						return
				else
					goto redo
		..()
