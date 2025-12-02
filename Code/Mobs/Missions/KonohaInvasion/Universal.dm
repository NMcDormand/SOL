mob/var
	KillMessage
	LiveMessage
	Locate_Kawarimi
	Locate_Camo
	Locate_Cloak
	Locate_MeiMei
	Locate_Darkness
	DispelOdds1
	DispelOdds2
	KillValue

mob/Hittable/Responsive/NPC/KonohaInvasion
	AI()
		set waitfor = 0
		while(!dead)
			var/mob
				M; t
			//HitList=new/list
			/*var/list/ppl=KI_Participants
			for(m in view(10,src))//KI_Participants)
				for(var/mob/c in m.KageBunshinList) if(c&&!(c in ppl)) ppl+=c
				if(m.Familiar&&!(m in ppl)) ppl+=m.Familiar
			for(M in ppl)
				if(get_dist(M,src)<11&&!(M in HitList)&&LocateTarget(M)&&!M.protect) HitList+=M
			*/
			if(RinneBlown)
				sleep(1)
				continue
			var/list/ppl=list()
			for(var/mob/A in KI_Participants)
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
				if(get_dist(A,src) > 10)
					continue
				if(A.KO)
					if(PursuitMSG)
						hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b>  [PursuitMSG]", "Chat")
					t = M
					break
				ppl+=A

			if(!t && ppl.len)
				t=pick(ppl)
			if(t)
				resting=0
				switch(pick(1,2))
					if(1)
						Attack1(t)
					if(2)
						Attack2(t)
				sleep(1)
			else
				if((Stamina<StaminaMax||Chakra<ChakraMax)&&!RestCheck()&&!resting)
					icon_state="rest"; resting=1; spawn(12) rest()
				if(Wounds>20&&BandageUses<8&&!TakenDamage)
					var/obj/Item/Bandages/F = locate() in contents
					if(F)
						if(!UsingBandages) {UsingBandages=1; spawn(30) UsingBandages=0}
						BandageUses++; BandagesUsed++; F.amount--
						Wounds-=FirstAidSkill; if(Wounds<18) Wounds=18
						BandageCheck(BandageUses)
						if(F.amount<=0)
							del(F)
						sleep(5)
					else
						sleep(18)
				else
					sleep(18)

	LocateTarget(mob/T)
		if(T&&Darkness)
			if(prob(Locate_Darkness)) return TRUE
		else if(T&&!T.icon)
			if(T.InKawarimi) {if(prob(Locate_Kawarimi)&&T) return TRUE}
			else if(T.InCamo) {if(prob(Locate_Camo)&&T) return TRUE}
			else if(T.InCloak) {if(prob(Locate_Cloak)&&T) return TRUE}
			else if(T.InMeiMei) {if(prob(Locate_MeiMei)&&T) return TRUE}
		else if(T) return TRUE
		else return FALSE

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
				sleep(1)
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
						if(KillMessage)
							hearers(3,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b>  [KillMessage]", "Chat")
						attacking=1
						spawn(atkspeed+3)
							if(src)
								attacking=0
						flick("punch",src)
						M.Wounds+=150
						M.KillMe(src)
						HitList -= M
					else if(!M.KO)
						if(LiveMessage)hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> [LiveMessage]", "Chat")
					else
				KOChase = 0

mob/proc
	AI_JutsuSelection()
		switch(pick(1,2))
			if(1)
				switch(PE)
					if("Water") return Suiton_Suikoudan()
					if("Wind") return Fuuton_Daitoppa()
					if("Lightning") return Raiton_Raikyuu()
					if("Earth") return Doton_DoryuuDango()
					if("Fire") return Katon_Ryuuka()
			if(2)
				switch(SE)
					if("Water") return Suiton_Suikoudan()
					if("Wind") return Fuuton_Daitoppa()
					if("Lightning") return Raiton_Raikyuu()
					if("Earth") return Doton_DoryuuDango()
					if("Fire") return Katon_Ryuuka()