mob/Hittable/Responsive/NPC/Criminal
	icon = 'Base_Pale.dmi'
	Aggressive = 1
	WW = 1
	NinjaRank = null
	New()
		..()
		trueName = name
		NinStat()
		DressNin()
		step_rand(src)
		spawn(12)
			AI()
		respawn = loc

	Del()
		if(SRate)
			SpawnMe(SRate,type,respawn)
		..()

	Ravager
		Aggressive = 0
		New()
			NinjaRank = pick("Academy Student", "Genin", "Chuunin")
			Reflex = rand(1,10)
			ReflexTrue = Reflex
			..()

	Prisoner
		New()
			NinjaRank = pick("Genin", "Chuunin")
			Reflex = rand(1,10)
			ReflexTrue = Reflex
			..()

	Thief
		New()
			NinjaRank = pick("Special Jounin", "Chuunin")
			Reflex = rand(5,20)
			ReflexTrue = Reflex
			..()

	Murderer
		NinjaRank = "Jounin"
		New()
			Reflex = rand(20,50)
			ReflexTrue = Reflex
			..()

	Villain
		NinjaRank = "Villain"
		New()
			Reflex = rand(50,100)
			ReflexTrue = Reflex
			..()

	AI()
		set waitfor = 0, background = 1
		while(!dead)
			CHECK_TICK
			if(RinneBlown)
				sleep(movespeed)
				continue
			var/WT = 5
			if(KO || InIzanami)
				sleep(10)
				continue
			//if(waterprisoned || Kanashibari || Coffin || InKageArashi || IceBlasted || ShadowCaptured || JubakuBound)
			//	FreeMe()
			var/mob/t
			var/list/ppl=list()
			var/list/Clones=list()
			var/moveit = 0
			if(!Aggressive)
				if(HitList.len)
					if(RESTRAINEDCHECK(src))
						sleep(10)
						continue
					for(var/mob/A in HitList)
						if(A == src)
							continue

						for(var/mob/c in A.MasterBunshinList)
							Clones+=c
						for(var/mob/c in A.EdoCloneList)
							Clones+=c
						if(A.Familiar)
							Clones+=A.Familiar
						if(A.dead)
							continue
						if(A.protect)
							continue
						if(A.invisibility > see_invisible)
							continue
						var/GD = get_dist(A,src)
						if(GD > 20 || z != A.z)
							if(GD > 50 && z == A.z)
								HitList -= A
							continue
						if(A.KO)
							t = A
							break
						if(istype(A,/mob/Hittable/Command/Clones)||istype(A,/mob/Hittable/Command/EdoClone))
							Clones+=A
						else
							if(A.client)
								moveit = 1
							ppl+=A

					if(moveit)
						if(InIllusion)
							if(InFirudo)
								step_rand(src)
								sleep(5)
								continue
							else
								if(InFakeEnemyView)
									Attack1(Projection)
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

					if(!t)
						var/P,C
						if(ppl.len)
							P = 1
						if(Clones.len)
							C = 1
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
					else
						if(moveit)
							var/d = pick(WEST, EAST, NORTH, SOUTH, NORTHWEST, NORTHEAST, SOUTHWEST, SOUTHEAST)
							walk(src,d,3)
							spawn(6)
								walk(src,0)
						sleep(15)
						continue
				else
					for(var/mob/player/M in MasterPlayerList)
						if(get_dist(M,src) < 20)
							moveit = 1
							break

					if(moveit)
						var/d = pick(WEST, EAST, NORTH, SOUTH, NORTHWEST, NORTHEAST, SOUTHWEST, SOUTHEAST)
						walk(src,d,3)
						spawn(6)
							walk(src,0)
					sleep(15)
					continue

			else
				if(RESTRAINEDCHECK(src))
					sleep(10)
					continue

				for(var/mob/A in oview(src,10))
					if(A == src)
						continue
					if(A.dead)
						continue
					if(A.protect)
						continue
					if(A.TeamID == TeamID)
						continue
					if(istype(A,/mob/Hittable)||A.client)
						if(istype(A,/mob/Hittable/Unresponsive/NPC)||istype(A,/mob/Hittable/Unresponsive/Training)||istype(A,/mob/Hittable/Responsive/Boss)||istype(A,/mob/Hittable/Responsive/NPC))
							continue
						if(istype(A,/mob/Hittable/Command/EdoClone))
							Clones+=A
						else if(A.Familiar)
							Clones+=A.Familiar
						else if(istype(A,/mob/Hittable/Command/Clones))
							Clones += A
						else
							if(A.client)
								moveit = 1
							ppl+=A

				if(moveit)
					if(InIllusion)
						if(InFirudo)
							step_rand(src)
							sleep(5)
							continue
						else
							if(InFakeEnemyView)
								Attack1(Projection)
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

				if(!t)
					var/P,C
					if(ppl.len)
						P = 1
					if(Clones.len)
						C = 1
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
				else
					if(moveit)
						var/d = pick(WEST, EAST, NORTH, SOUTH, NORTHWEST, NORTHEAST, SOUTHWEST, SOUTHEAST)
						walk(src,d,3)
						spawn(6)
							walk(src,0)
					sleep(10)
					continue
			sleep(WT)

	AI_Attack(mob/M, var/AttackTime)
		while(AttackTime)
			if(KO||dead)
				break
			if(!M || M.protect || M.dead)
				break
			else
				var/A = get_dist(src,M)
				if(A>= 20)
					break
				if(A>1)
					while(get_dist(src,M) > 1)
						if(KO||dead)
							break
						if(get_dist(M,src) > 20)
							break
						step_to(src,M)
						sleep(movespeed)
						if(!src || !M)
							break
				if(KO||dead)
					break
				if(get_dist(src,M)<2)
					dir = get_dir(src,M)
					AI_Punch(M)
					sleep(atkspeed)
			AttackTime--
		AttackTime = 0

	Attack1(mob/M)
		if(sleepy&&prob(98))
			sleepy = 0;
			DispelProc()
		if(M)
			if(M.KO)
				AI_KO(M)
			else if(M.dead)
				HitList -= M
			else
				if(Stamina>0&&!dead&&!DeathSee&&!Lotus&&!KO&&!MushiKabe&&!fallen&&!Underground&&!frozen&&!GMfrozen&&!resting&&!CantWalk&&!length(AcquiringList))
					if(M.InFujinHeki && FireElemental)
						Housenka(M)
					if(get_dist(src,M)>= 2 && !M.UsedArashi && !M.InFujinHeki)
						sleep(ATKWAit)
						if(KO || dead)
							return
						if(M)
							if(M.protect)
								return
							if(Rank2Num(NinjaRank) > 4 && !KageBunshinList.len && prob(100))
								ShadowClone(M)
							else if(M.icon_state == "seals"&&prob(90))
								Evade1(M)
							else if(firing&&!M.kaiten&&!M.MushiKabe)
								AI_Attack(M,11)
							if(M&&!throwing&&prob(5))
								step_towards(src,M)
								spawn(2) NinjaShuriken()
							else if(!firing)
								Move_In(M);
								if(!M)
									return
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
								if(!M)
									return
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
							if(!M)
								return
							if(!M.kaiten&&!M.MushiKabe)
								AI_Attack(M,12)
							else
								sleep(10)
								goto ReCheck

	AI_KO(mob/M)
		if(KO || M.dead || KOChase)
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
					dir = get_dir(src,M)
					if(M.KO && !M.dead && !(TAICHECKBOTH(src,M)))
						if(FinishMSG)
							hearers(8,src)<<output("<b><font face = verdana color = \"[VillageColour]\">[src]</font> says:</b>  [FinishMSG]", "Chat")
						attacking = 1
						spawn(atkspeed+3)
							if(src)
								attacking = 0
						flick("punch",src)
						M.Wounds += 150
						M.KillMe(src)
						HitList -= M
				KOChase = 0
	DamageMe(mob/M, var/D,METHOD,hidemessage)
		set waitfor = 0
		if(M.protect||dead) return
		if(!istype(M,/mob/NPC))
			if(!(M in HitList)) HitList += M
		var
			d = D; w
		if(BugArmour) D -= (d*0.12)
		if(SandArmour) D -= (d*0.20)
		if(MushiKabe) D -= (d*0.80)
		if(Blocking && METHOD != "ClayDeteriorate") D -= (d*0.45)
		if(InKaramatsu)
			D -= (d*0.20)
			var/recoil = (Taijutsu*0.1)
			M.Stamina -= recoil; M.Wounds += (recoil/StaminaMax)*90
		if(D<1)D = 1
		D = round(D); w = (D/StaminaMax)*65
		Stamina -= D; Wounds += w
		if(!hidemessage) DamageReport(src,M,D,METHOD)
		if(M)
			M.ExperienceCheck(w,src)
			M.RefreshStats()
			for(var/mob/Fry in range())
				if(Fry.Creator && Fry.Creator == Creator)
					if(!(M in Fry.HitList))
						Fry.HitList += M
		if(Wounds>= 200)
			KillMe(M)

		spawn(1800)
			if(!dead && !KO && src)
				if(!DamagedRecently && Stamina < StaminaMax)
					Stamina = StaminaMax
					Wounds = 0
					HasKonchuu = list()
					var/NOLOC = 0
					for(var/mob/MO in HitList)
						if(get_dist(MO, src) <= 8)
							NOLOC = 1
					if(!NOLOC)
						loc = respawn

		if(Stamina<= 0&&Wounds<100)
			if(!KO)
				KO = 1
				var/R = 500
				for(var/mob/b in KageBunshinList) del(b)
				icon_state = "KO"; viewers(src)<<"<b><i>[src] has fallen unconcious with exhaustion!</i></b>"
				spawn(50)
					if(Wounds<100) {KO = 0; icon_state = ""; Stamina = R}
					else KillMe(M)
			else Wounds += 5
		else if((Wounds>= 150)||(Stamina<= 0&&Wounds>= 100))
			if(!KO)
				KO = 1; icon_state = "KO"; viewers(src)<<"<b><i>[src] has fallen gravely unconcious!</i></b>"
				spawn(50)if(M&&!M.dead)KillMe(M)

	KillMe(mob/M)
		if(istype(M,/mob/Hittable/Command/Clones/))
			M = M.Creator
		if(istype(M,/mob/Hittable/Responsive/Animal/Pet/))
			M = M.Master
		if(dead) return
		dead = 1
		if(M)
			if(M.client)
				M.CriminalKills++
				M.CurCrimKills++
				var/NM = M.CurCrimKills/5
				if(NM == round(NM))
					M << "You now have [NM] B Rank missions to turn in from Criminal Kills"
				M.TotalKills++
			if(Creator)
				if(istype(Creator,/obj/Spawner))
					var/obj/Spawner/Spn = Creator
					if(Spn)
						//world<<"this belonged to a spawner located at [Spn.x],[Spn.z],[Spn.z]"
						for(var/mob/Fry in range())
							if(Fry.Creator && Fry.Creator == Spn)
								if(!(M in Fry.HitList))
									Fry.HitList += M
						Spn.SpCur--
						Spn.SpLim--
						Spn.SpnDthCheck()
		for(var/mob/KM in KageBunshinList)
			del KM
		if(prob(18+M.Luck)) DropItem()
		var/atom/DLOC = loc
		if(M && get_dist(M,src) < 2 && M.client)
			DLOC = M
		if(istype(src,/mob/Hittable/Responsive/NPC/Criminal/Prisoner))
			if(prob(DropPrisoner+M.Luck))
				var/obj/Item/Material/Mission/BingoCard/Prisoner/O = locate() in DLOC
				if(O)
					O.amount++
					O.Checkamount()
				else
					O = new(DLOC)
				if(DLOC == M)
					M << "You pick up a [O.trueName]"
		else if(istype(src,/mob/Hittable/Responsive/NPC/Criminal/Ravager))
			if(prob(DropRavager+M.Luck))
				var/obj/Item/Material/Mission/BingoCard/Ravager/O = locate()  in DLOC
				if(O)
					O.amount++
					O.Checkamount()
				else
					O = new(DLOC)
				if(DLOC == M)
					M << "You pick up a [O.trueName]"
		else if(istype(src,/mob/Hittable/Responsive/NPC/Criminal/Thief))
			if(prob(DropThief+M.Luck))
				var/obj/Item/Material/Mission/BingoCard/Thief/O = locate() in DLOC
				if(O)
					O.amount++
					O.Checkamount()
				else
					O = new(DLOC)
				if(DLOC == M)
					M << "You pick up a [O.trueName]"
		else if(istype(src,/mob/Hittable/Responsive/NPC/Criminal/Murderer))
			if(prob(DropMurderer+M.Luck))
				var/obj/Item/Material/Mission/BingoCard/Murderer/O = locate() in DLOC
				if(O)
					O.amount++
					O.Checkamount()
				else
					O = new(DLOC)
				if(DLOC == M)
					M << "You pick up a [O.trueName]"
		else if(istype(src,/mob/Hittable/Responsive/NPC/Criminal/Villain))
			if(prob(DropVillain+M.Luck))
				var/obj/Item/Material/Mission/BingoCard/Villain/O = locate() in DLOC
				if(O)
					O.amount++
					O.Checkamount()
				else
					O = new(DLOC)
				if(DLOC == M)
					M << "You pick up a [O.trueName]"
		del src
		//loc = locate(0,0,0)