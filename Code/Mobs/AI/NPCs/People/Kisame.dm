mob/verb/SpyMinato()
	set name = "Spy"
	if(usr.SpyStatus)
		usr.client.perspective = MOB_PERSPECTIVE; usr.client.eye = usr
		usr.SpyStatus=0
	else
		var/mob/M
		for(var/mob/A in world)
			if(A.name == "Minato")
				M = A
				break
		usr.client.perspective= EYE_PERSPECTIVE; usr.client.eye = M
		usr.SpyStatus=1

obj/weapon/MKunai
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

mob/NPC/People/Minato
	name="Minato"
	icon='Base_Pale.dmi'
	Village="Event"
	NinjaRank="Ex Hokage"
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
	Reflex=180
	gender="male"
	movespeed=0.7
	atkspeed=2
	protect=0
	HasHiraishin = 1
	EvadeChance = 10
	BunshinLimit = 8
	var/FEvade = 8
	var/IKunai = 18
	var/list/GKunai = list()
	var/list/Touched = list()
	var/list/DamagedMe = list()

	New()
		var/icon/A = icon('Hair_Minato.dmi')
		A += rgb(204,204,102)
		overlays += A
		A = icon('Eyes_Base.dmi')
		A += rgb(102,102,255)
		overlays += A
		overlays += icon('Pants.dmi')
		overlays += icon('LShirt.dmi')
		overlays += icon('Jounin_Leaf.dmi')
		if(prob(50))
			overlays += icon('Yondaime-Cloak.dmi')
		overlays += icon('Headband-Minato.dmi')
		for(var/obj/weapon/MKunai/B in world)
			B.Owner = src
			GKunai += B
		src.respawn=src.loc
		spawn(66) AI()

	FreeMe()
		if(waterprisond)
			if(LightningElemental)
				Inazuma() //Lightning Field
				waterprisond = 0
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
		ChakraTrue *=3
		Chakra = ChakraTrue
		StaminaTrue *=3
		Stamina = StaminaTrue
		wounds = round(wounds*0.2)
		hearers(8,src)<<output("<b><font face=verdana color=\"#9999FF\">Kisame</font> says:</b> I will enjoy shaving a few layers off you!", "Chat")
		spawn(pick(60,120,180)
			if(src && !KO && !dead)
				HiraishinBarrage()

	AI()
		if(src.dead||KO) return
		if(sleepy)
			sleepy=0
			DispelProc()
		var/mob
			M; t
		src.HuntList=new/list
		for(M in HitList)
			if(M == src)
				HitList -= M
				continue
			if(M.protect || M.dead)
				continue
			if(!(M in src.YieldList)) src.YieldCheck(M)
			if(M in src.YieldList) {src.HitList-=M; src.VillageHitList-=M; src.YieldList-=M}
			else if(M in src.HitList) src.LocateTarget(M)
		if(length(src.HuntList))
			t=pick(HuntList)
			if(t)
				if(Serious)
					Attack1(t)
				else
					if(Stamina < StaminaMax * 0.5 && !KO)
						GetSerious()
					Attack1(t)
			else
				AI()
		else
			spawn(22)
				AI()

	AI_KO(mob/M)
		spawn(40)
			if(!KO)
				AI()
		if(M&&get_dist(src,M)>1)
			step_to(src,M)
		else if(M&&get_dist(src,M)<=1)
			spawn(31)
				if(M)
					src.dir=get_dir(src,M)
					if(src.TaiAttackCheck(M)) return
					if(!M.KO)
						if(Serious)
							hearers(8,src)<<output("<b><font face=verdana color=\"#9999FF\">Kisame</font> says:</b> The next bite will pierce your bones", "Chat")
						else
							hearers(8,src)<<output("<b><font face=verdana color=\"#9999FF\">Kisame</font> says:</b> Maybe i will use my sweetheart for this one", "Chat")
					else
						hearers(8,src)<<output("<b><font face=verdana color=\"#9999FF\">Kisame</font> says:</b>  This is for you Samehada.", "Chat")
						src.attacking=1; spawn(src.atkspeed+3)src.attacking=0
						flick("punch",src); M.Wounds=150; M.KillMe(src)

	LocateTarget(mob/T)
		if(src.Darkness)
			if(prob(80)&&T) {src.ReverseGenjutsu=1; HuntList+=T}
		else if(!T.icon)
			if(T.InKawarimi) {if(prob(100)&&T) HuntList+=T}
			else if(T.InCamo) {if(prob(100)&&T) HuntList+=T}
			else if(T.InCloak) {if(prob(100)&&T) HuntList+=T}
			else if(T.InMeiMei) {if(prob(100)&&T) HuntList+=T}
		else HuntList+=T
		for(var/mob/Clones/C in T.KageBunshinList)
			if(!(C in src.HitList)) src.HuntList+=C


	Attack1(mob/M)
		if(prob(15)) src.ReverseGenjutsu=1
		else src.ReverseGenjutsu=0
		if(sleepy&&prob(98)) {sleepy=0; DispelProc()}
		FreeMe()
		if(M&&M.KO)
			spawn(4) AI_KO(M)
		else if(!M)
			AI()
		else
			if(get_dist(src,M)>3)
				step_towards(src,M)
				spawn(2)
					if(M&&M.icon_state=="seals"&&prob(90)) src.Evade1(M)
					else if(M&&src.firing&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,10,60)
					else if(M&&!src.firing) {Move_In1(M); spawn(15) src.Daibakufu()}
					else if(M) src.AI_Attack(M,12,66)
					else AI()

			else
				if(M&&!(length(src.KageBunshinList))&&prob(23)) src.ShadowClone(M)
				else if(M&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,12,80)
				else if(M) src.AI_Attack(M,12,66)