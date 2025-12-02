obj/Chuunin
	Destination
	FinalDestination

mob/var/
	FinalDestination
	Destination

mob/Hittable/Responsive/NPC/ChuuninEntrant
	NinjaShuriken(mob/M)
		if(ThrowAttackCheck()) return
		throwing=1; spawn(5) throwing=0
		if(M) dir=get_dir(src,M)
		CantWalk++; spawn(2)CantWalk--
		var/obj/Weapon/Thrown/ThrownShuriken/S = new(loc)
		S.Taijutsu=Taijutsu; S.ThrowingSkill=ThrowingSkill; S.dir=dir; S.name="[src]"; S.Owner=src
		walk(S,dir)
		spawn(11)del(S)

	NinjaRank="Genin"
	taitraining=20
	movespeed=3
	SS=15
	WW = 1
	icon='Base_Medium.dmi'
	Taijutsu=3000; TaijutsuMax=3000
	Ninjutsu=3000; NinjutsuMax=3000
	Genjutsu=3000; GenjutsuMax=3000
	Stamina=120000; StaminaMax=120000

	FireElemental = 600
	WaterElemental = 600
	WindElemental = 6000
	LightningElemental = 600
	EarthElemental = 6000

	ThrowingSkill=500
	KnifeSkill=500
	SwordSkill=500
	layer=4
	New()
		for(var/obj/Chuunin/Destination/D in world) Destination=D.loc
		for(var/obj/Chuunin/FinalDestination/F in world) FinalDestination=F.loc
		var/icon/i=pick(AI_IconList)
		var/icon/E = new(i)
		E.Blend('BrownEyes.dmi',ICON_OVERLAY)
		icon = E
		new/obj/Clothing/Pants/Pants(src)
		new/obj/Clothing/Shirt/LongSleeveShirt(src)
		new/obj/Clothing/Head/Headband(src)
		for(var/obj/Clothing/C in src)
			C.worn = 1
			overlays += C.icon
		name="Chuunin Entrant"
		if(prob(33)) new/obj/Weapon/Wield/Kunai(src)
		for(var/obj/Weapon/Wield/w in src) EquipRemove_Weapon(w,w.icon)
		TaijutsuMax+=rand(0,2444);Taijutsu=TaijutsuMax
		NinjutsuMax+=rand(0,2444);Ninjutsu=NinjutsuMax
		GenjutsuMax+=rand(0,2444);Genjutsu=GenjutsuMax
		StaminaMax+=rand(0,50000);Stamina=StaminaMax
		SS-=rand(0,12)
		spawn(10) AI()

	Bump(A)
		if(ismob(A))
			var/mob/M=A
			if(!(istype(M,/mob/NPC)))
				if(HitCheck(M)) AI_Punch(M)
				else M<<"You dodged [src]'s attack"

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
					view(3,src)<<"<b>[src] says:</b> The scroll is mine!."
					spawn(10)
						for(var/obj/Scrolls/ChuuninScrolls/C in range(src))
							C.loc = src
						HasEarth=1; HasHeaven=1
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

	LocateTarget(mob/T)
		if(T.Yield) T<<"[src] refuses your yield!"
		if(Darkness)
			if(prob(35)&&T) HuntList+=T
		else if(!T.icon)
			if(T.InKawarimi) {if(prob(100)&&T) HuntList+=T}
			else if(T.InCamo) {if(prob(95)&&T) HuntList+=T}
			else if(T.InCloak) {if(prob(70)&&T) HuntList+=T}
			else if(T.InMeiMei) {if(prob(80)&&T) HuntList+=T}
		else HuntList+=T

	AI()
		while(!dead)
			if(KO || InIzanami)
				sleep(10)
				continue
			if(sleepy&&prob(40))
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
			if(HasEarth&&HasHeaven)
				step_to(src,get_dir(src,locate(976,276,2)))
			else
				var/mob/t
				HuntList=new/list

				for(var/mob/player/MO in range(10,src))
					if(MO != src && MO.Creator != src)
						if(!(MO in HitList))
							HitList += MO

				for(var/mob/M in HitList)
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
					else
						if(M.KO)
							t = M
							if(PursuitMSG)
								hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b>  [PursuitMSG]", "Chat")
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
				else
					step_to(src,locate(917,270,2))
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
