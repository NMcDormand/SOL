var/list/CloudHitList=list()
mob/var/tmp/CloudClearance=0

var/list/GrassHitList=list()
mob/var/tmp/GrassClearance=0

var/list/LeafHitList=list()
mob/var/tmp/LeafClearance=0

var/list/MistHitList=list()
mob/var/tmp/MistClearance=0

var/list/RainHitList=list()
mob/var/tmp/RainClearance=0

var/list/RockHitList=list()
mob/var/tmp/RockClearance=0

var/list/SandHitList=list()
mob/var/tmp/SandClearance=0

var/list/SoundHitList=list()
mob/var/tmp/SoundClearance=0

var/list/WaterfallHitList=list()
mob/var/tmp/WaterfallClearance=0

var/AI_IconList=list('Base_Pale.dmi','Base_Medium.dmi','Base_Tan.dmi','Base_Dark.dmi')
var/AI_IconList_Hair=list('Hair_Deidara.dmi','Hair_kakashi.dmi','Hair_Naruto.dmi','Hair_Orochimaru.dmi','Hair_RockLee.dmi','Hair_Sasuke.dmi','Hair_Shikamaru.dmi','Hair_Afro.dmi','Hair_Sakura.dmi','Hair_TenTen.dmi')
mob/Hittable/Responsive/VillageNinjas
	icon='Base_Medium.dmi'
	taitraining=20
	movespeed=3
	protect=0
	SS=8
	atkspeed = 6
	Taijutsu=2400; TaijutsuMax=2400
	Ninjutsu=3000; NinjutsuMax=3000
	Genjutsu=3000; GenjutsuMax=3000
	Stamina=10000; StaminaMax=10000
	ThrowingSkill=50
	KnifeSkill=50
	SwordSkill=50
	layer=4
	verb
		ActivateMe()
			set src in view(10)
			AI()
	New()
		//GenerateShadow(src, EAST)
		var/icon/i=pick(AI_IconList)
		var/icon/E = new(i)
		E.Blend('BrownEyes.dmi',ICON_OVERLAY)
		icon = E
		NinjaRank = pick("Chuunin","Special Jounin", "Anbu","Jounin")
		NinStat()
		DressNin()
		/*
		TaijutsuMax+=rand(20000,70000);Taijutsu=TaijutsuMax;TaijutsuTrue = Taijutsu
		NinjutsuMax+=rand(20000,70000);Ninjutsu=NinjutsuMax;NinjutsuTrue = Ninjutsu
		GenjutsuMax+=rand(20000,70000);Genjutsu=GenjutsuMax;GenjutsuTrue = Genjutsu
		StaminaMax+=rand(800000,7200000);Stamina=StaminaMax;StaminaTrue = Stamina
		*/
		ThrowingSkill+=rand(100,800)
		SS=rand(1,15)
		step_rand(src)
		if(!respawn) respawn=loc
		spawn(10)AI()

	Bump(mob/A)
		if(A in HitList)
			var/mob/M=A
			if(!(istype(M,/mob/NPC)))
				if(HitCheck(M)) AI_Punch(M)
				else M<<"You dodged [src]'s attack"

	AI()
		set waitfor = 0
		while(!dead)
			if(RinneBlown)
				sleep(1)
				continue
			if(KO || InIzanami)
				sleep(10)
				continue
			if(InIllusion)
				if(InFirudo)
					step_rand(src)
					sleep(10)
				if(Clan == "Uchiha" && prob(10))
					DispelProc()
				else if(prob(1))
					DispelProc()
				else
					if(InFakeEnemyView)
						Attack1(Projection)
					else if(InSenKaze)
						step_rand(src)
						sleep(10)
					else if(InFakeView)
						sleep(10)
					else if(InIzanami)
						sleep(10)

			var/mob
				M; t
			HuntList=list()
			var/moveit = 0
			var/list/tmplist=list()
			for(var/mob/m in MasterPlayerList)
				if(get_dist(src,m)<10)
					moveit = 1
					if(!m.BingoBookAssociations)
						m.BingoBookAssociations = list()
						continue
					else if(m.BingoBookAssociations[Village])
						tmplist+=m

			for(M in (HitList|tmplist))
				if(get_dist(src,M)<15)
					if(((M in tmplist)&&BountyCheck(M))||(M in HitList))
						if(!(M in YieldList)) VillageYieldCheck(M)
						if(M in YieldList) {HitList-=M; VillageHitList-=M; YieldList-=M}
						else if(M in (HitList|tmplist)) LocateTarget(M)

			for(var/mob/Hittable/Responsive/CR in view(8,src))
				if(CR.Aggressive||istype(CR,/mob/Hittable/Responsive/NPC/Criminal))
					if(!(CR in HuntList))
						HuntList += CR

			if(length(HuntList))
				if(RESTRAINEDCHECK(src))
					sleep(10)
					continue
				t=pick(HuntList)
				if(t)
					if(!(t in HitList)) HitList+=t
					if(Wounds<30)
						Attack1(t)
					else
						switch(pick(1,2))
							if(1)
								Attack1(t)
							if(2)
								Attack2(t)
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
						if(F.amount<=0) del(F)
				else
					sleep(rand(10,50))
					if(!Wandering && moveit)
						if(KO||JubakuBound)
							sleep(5)
							continue
						Wander_Sentry()
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
				if(A>=10)
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
			CHECK_TICK
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
				KOChase = 0

	LocateTarget(mob/T)
		if(T&&Darkness)
			if(prob(2)&&T) HuntList+=T
		else if(T&&!T.icon)
			if(T.InKawarimi) {if(prob(40)&&T) HuntList+=T}
			else if(T.InCamo) {if(prob(40)&&T) HuntList+=T}
			else if(T.InCloak) {if(prob(5)&&T) HuntList+=T}
			else if(T.InMeiMei) {if(prob(35)&&T) HuntList+=T}
		else if(T) HuntList+=T

	Attack1(mob/M)
		if(sleepy&&prob(20)) {sleepy=0; DispelProc()}
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(get_dist(src,M)>3)
				if(M&&M.icon_state=="seals"&&prob(40)) Evade1(M)
				else if(M&&!firing&&prob(18))
					Move_Away_To_Aim1(M)
					sleep(18)
					NinjaJutsu(M)
				else if(M&&!throwing&&prob(22))
					step_to(src,M)
					sleep(3)
					NinjaShuriken()
				else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,17,3)
			else
				if(M&&M.icon_state=="seals"&&prob(20)) Evade1(M)
				else if(M&&!throwing&&prob(22))
					Move_Away_To_Aim1(M)
					sleep(18)
					NinjaShuriken()
				else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,15,10)

	Attack2(mob/M)
		if(sleepy&&prob(10)) {sleepy=0; DispelProc()}
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(get_dist(src,M)>5)
				if(M&&M.icon_state=="seals"&&prob(70)) Evade1(M)
				else if(M&&!firing) NinjaShunshin(M)
				else if(M&&!throwing&&prob(30))
					step_towards(src,M)
					sleep(2)
					NinjaShuriken()
				else if(M)
					Move_In(M)
					if(M&&!M.kaiten&&!M.MushiKabe)
						AI_Attack(M,17)
			else
				if(M&&M.icon_state=="seals"&&prob(40)) Evade1(M)
				else if(M&&!throwing&&prob(22))
					Move_Away_To_Aim1(M)
					sleep(16)
					NinjaShuriken()
				else if(M)
					Move_In(M)
					if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,14)

	LeafNin
		name="Leaf-nin"
		Village="Leaf"
		FireElemental=500
		InVillage="Leaf"
		New()
			..()
			LeafNinList+=src

	WaterNin
		name="Mist-nin"
		Village="Mist"
		WaterElemental=500
		InVillage="Mist"
		New()
			..()
			MistNinList+=src

	SoundNin
		name="Sound-nin"
		Village="Sound"
		FireElemental=200
		WindElemental=300
		InVillage="Sound"
		New()
			..()
			SoundNinList+=src

	WaterfallNin
		name="Waterfall-nin"
		Village="Waterfall"
		WaterElemental=250
		EarthElemental=250
		InVillage="Waterfall"
		New()
			..()
			WaterfallNinList+=src

	RockNin
		name="Rock-nin"
		Village="Rock"
		EarthElemental=500
		InVillage="Rock"
		New()
			..()
			RockNinList+=src

	RainNin
		name="Rain-nin"
		Village="Rain"
		WaterElemental=250
		WindElemental=250
		InVillage="Rain"
		New()
			..()
			RainNinList+=src

	GrassNin
		name="Grass-nin"
		Village="Grass"
		EarthElemental=250
		FireElemental=250
		InVillage="Grass"
		New()
			..()
			GrassNinList+=src

	WindNin
		name="Sand-nin"
		Village="Sand"
		WindElemental=500
		InVillage="Sand"
		New()
			..()
			SandNinList+=src

	LightningNin
		name="Cloud-nin"
		Village="Cloud"
		FireElemental=250
		WindElemental=250
		InVillage="Cloud"
		New()
			..()
			CloudNinList+=src