var
	Sound5KillCount=0
	SoundList = list()
mob/var
	tmp
		Sound5Kills

mob/Hittable/Responsive/NPC/Mission/Sound5
	New()
		..()
		NinStat()
		spawn(10) AI()
		SoundList += src

	Bump(A)
		if(ismob(A))
			var/mob/M=A
			if(!(istype(M,/mob/NPC)))
				if(HitCheck(M)) AI_Punch(M)
				else M<<"You dodged [src]'s attack"

	LocateTarget(mob/T)
		if(T in HitList)
			return
		if(Darkness&&T)
			if(prob(8)) HitList+=T
		else if(T&&!T.icon)
			if(T.InKawarimi) {if(prob(90)&&T) HitList+=T}
			else if(T.InCamo) {if(prob(85)&&T) HitList+=T}
			else if(T.InCloak) {if(prob(38)&&T) HitList+=T}
			else if(T.InMeiMei) {if(prob(50)&&T) HitList+=T}
		else if(T) HitList+=T

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
				if(prob(80))
					sleepy=0
					DispelProc()
				else
					sleep(10)
					continue
			if(InIllusion)
				if(InFirudo)
					step_rand(src)
					sleep(5)
					continue
				else if(prob(10))
					DispelProc(src)
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
			var/list/Clones = list()
			for(var/mob/A in SoundMissionaries)
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
				ppl+=A
			if(!t)
				var/P,C
				if(ppl.len)
					P = 1
				if(Clones.len)
					C = 1
					for(var/mob/Cl in Clones)
						if(KageBunshinList.len < BunshinLimit)
							spawn(1)
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
						if(!step_to(src,M))
							StepFailed++
						else
							StepFailed = 0
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
					else if(!M.KO)
						if(NotFinishMSG)hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> [NotFinishMSG]", "Chat")
					else
				KOChase = 0

mob/Hittable/Summon
	AI()
		set waitfor = 0
		while(!dead)
			if(RinneBlown)
				sleep(1)
				continue
			if(KO || InIzanami)
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
			for(var/mob/A in SoundMissionaries)
				for(var/mob/c in A.MasterBunshinList)
					ppl+=c
				for(var/mob/c in A.EdoCloneList)
					ppl+=c
				if(A.Familiar)
					ppl+=A.Familiar
				if(A == src)
					continue
				if(A.dead)
					continue
				if(A.protect)
					continue
				if(A.invisibility > see_invisible)
					continue
				if(get_dist(A,src) > 12)
					continue
				if(A.Yield && YieldCheck(A))
					HitList-=A
					continue
				ppl+=A
			if(!t && ppl.len)
				t=pick(ppl)
			if(t)
				AI_Attack(t,7)
			sleep(5)

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