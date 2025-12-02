mob/Hittable/Responsive/NPC/Mission/Bounty
	SRate = 1200
	AI()
		set waitfor = 0
		while(!dead)
			if(RinneBlown)
				sleep(movespeed)
				continue
			if(RESTRAINEDCHECK(src) || InIzanami)
				sleep(10)
				continue
			if(sleepy&&prob(80))
				sleepy=0
				DispelProc()
			if(InIllusion)
				if(InFirudo)
					step_rand(src)
					sleep(5)
					continue
				else if((Clan == "Uchiha"||Clan=="Hyuuga") && prob(40)||prob(10))
					DispelProc()
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
			if(waterprisoned || Kanashibari || Coffin || InKageArashi || IceBlasted || ShadowCaptured || JubakuBound)
				FreeMe()
			var/mob/t
			var/list/ppl=list()
			var/list/Clones=list()
			for(var/mob/A in HitList)
				for(var/mob/c in A.MasterBunshinList)
					Clones+=c
				for(var/mob/c in A.EdoCloneList)
					Clones+=c
				if(A.Familiar)
					Clones+=A.Familiar
				if(A == src)
					continue
				if(A.dead)
					continue
				if(A.protect)
					continue
				if(A.invisibility > see_invisible)
					continue
				if(get_dist(A,src) > 14 || z != A.z)
					continue
				if(A.Yield && YieldCheck(A))
					HitList-=A
					continue
				if(A.KO)
					if(PursuitMSG)
						hearers(4,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b>  [PursuitMSG]", "Chat")
					t = A
					break
				if(istype(A,/mob/Hittable/Command/Clones))
					Clones+=A
				else if(istype(A,/mob/Hittable/Command/EdoClone))
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
				switch(pick(1,2))
					if(1)
						Attack1(t)
					if(2)
						Attack2(t)
			sleep(5)
			CHECK_TICK

	AI_Attack(mob/M, var/AttackTime)
		while(AttackTime)
			if(KO||dead)
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
				if(KO||dead)
					break
				if(get_dist(src,M)<2)
					dir = get_dir(src,M)
					AI_Punch(M)
					sleep(atkspeed)
		AttackTime = 0

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
						Housenka(M)
					if(get_dist(src,M)>=2 && !M.UsedArashi && !M.InFujinHeki)
						sleep(ATKWAit)
						if(KO || dead)
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
							if(M&&!throwing&&prob(5)) {step_towards(src,M); spawn(2) NinjaShuriken()}
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

	Attack2(mob/M)
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
						Housenka(M)
					if(get_dist(src,M)>=2 && !M.UsedArashi && !M.InFujinHeki)
						sleep(ATKWAit)
						if(KO || dead)
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
							else if(M&&!throwing&&prob(5))
								step_towards(src,M)
								NinjaShuriken()
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
		var/atom/DLOC = loc
		if(M && get_dist(M,src) < 2 && M.client)
			DLOC = M
		if(prob(DropMissing+M.Luck))
			var/obj/Item/Material/Mission/BingoCard/Missing/O = locate()  in DLOC
			if(O)
				O.amount++
				O.Checkamount()
			else
				O = new(DLOC)
			if(DLOC == M)
				M << "You pick up a [O.trueName]"
		if(istype(src,/mob/Hittable/Responsive/NPC/Mission/Bounty/ItachiClone) && prob(1+M.Luck))
			M.GiveRareItem()
		else if(prob(18))
			DropItem()
		SpawnMe(SRate,type,respawn)
		del src
		//loc = locate(0,0,0)