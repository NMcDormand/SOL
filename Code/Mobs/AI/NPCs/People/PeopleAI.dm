mob/Hittable/Responsive/NPC
	AI()
		set waitfor = 0
		while(!dead)
			if(RinneBlown)
				sleep(1)
				continue
			if(sleepy&&prob(80))
				sleepy=0
				DispelProc()
			if(InIllusion || InIzanami)
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
			if(RESTRAINEDCHECK(src))
				sleep(10)
				continue
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
		while(AttackTime>0)
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