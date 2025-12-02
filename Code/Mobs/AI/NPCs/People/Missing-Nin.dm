mob/Hittable/Responsive/NPC/Mission/Bounty/MissingNin
	name="Missing Nin"
	icon='Itachi.dmi'
	Village="None"
	NinjaRank="Missing-Nin"
	Taijutsu=15000
	Ninjutsu=20000
	Genjutsu=20000
	TaijutsuMax=15000
	NinjutsuMax=20000
	GenjutsuMax=20000
	Stamina=650000
	StaminaMax=650000
	ChakraMax=20000
	FireElemental=450
	Reflex=40
	gender="male"
	movespeed=2
	atkspeed=3
	protect=0

	New()
		respawn=loc
		icon = pick(BASEICONLIST)

		var/icon/A = icon(pick('Hair_Hidan.dmi','Hair_Neji.dmi','Hair_Myst.dmi','Hair_Long.dmi','Hair_LongStraight.dmi','Hair_Mohawk.dmi'))
		A += rgb(204,204,102)
		overlays += A
		A = icon('Eyes_Base.dmi')
		A += rgb(pick(102,50,10),pick(102,50,10),pick(102,50,10))
		overlays += A
		overlays += icon(pick('Pants.dmi','Shorts.dmi'))
		overlays += icon(pick('LShirt.dmi','VShirt.dmi','WShirt.dmi'))
		respawn=loc
		spawn(4) AI()

	FreeMe()
		if(Kanashibari)
			KawaEvade()
			Kanashibari--
			if(Kanashibari < 0)
				Kanashibari = 0
		if(IceBlasted)
			overlays-='iceblastcover.dmi'
			KazanFunka()//Volcanic erruption
			IceBlasted--
			if(IceBlasted < 0)
				IceBlasted = 0
		if(JubakuBound)
			KawaEvade()
			JubakuBound = 0
		..()

	AI_KO(mob/M)
		if(M&&get_dist(src,M)>1)
			step_to(src,M)
		else if(M&&get_dist(src,M)<=1)
			spawn(31)
				if(M)
					dir=get_dir(src,M)
					if(TAICHECKBOTH(src,M)) return
					if(M.KO)
						attacking=1; spawn(atkspeed+3)attacking=0
						flick("punch",src); M.Wounds=150; M.KillMe(src)

	LocateTarget(mob/T)
		if(Darkness)
			if(prob(80)&&T) {ReverseGenjutsu=1; HuntList+=T}
		else if(!T.icon)
			if(T.InKawarimi) {if(prob(100)&&T) HuntList+=T}
			else if(T.InCamo) {if(prob(100)&&T) HuntList+=T}
			else if(T.InCloak) {if(prob(100)&&T) HuntList+=T}
			else if(T.InMeiMei) {if(prob(100)&&T) HuntList+=T}
		else HuntList+=T
		for(var/mob/Hittable/Command/Clones/C in T.KageBunshinList)
			if(!(C in HitList)) HuntList+=C
