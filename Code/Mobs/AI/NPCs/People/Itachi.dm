mob/Hittable/Responsive/NPC/Mission/Bounty/ItachiClone
	name="Itachi Uchiha"
	Village="None"
	icon='Base_Pale.dmi'
	NinjaRank="Missing-Nin"
	Taijutsu=20000
	Ninjutsu=20000
	Genjutsu=65000
	TaijutsuMax=20000
	NinjutsuMax=20000
	GenjutsuMax=65000
	Stamina=750000
	StaminaMax=750000
	ChakraMax=20000
	FireElemental=4500
	Reflex=80
	gender="male"
	movespeed=2
	atkspeed=3
	protect=0
	Cooldowns = list()

	New()
		var/icon/A = icon('Eyes_Base.dmi')
		A += rgb(255,0,0)
		overlays += A
		overlays += icon('Pants.dmi')
		overlays += icon('LShirt.dmi')
		overlays += icon('Jounin_Leaf.dmi')
		if(prob(90))
			overlays += icon('AkatCloak.dmi')
		overlays += icon('Headband.dmi')
		overlays += icon('Hair_Itachi.dmi')
		respawn=loc
		spawn(10) AI()

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
			viewers(3,src)<<"<b>[src] says:</b> Before me, your jutsu are <i>nothing</i>."
			spawn(31)
				if(M)
					dir=get_dir(src,M)
					if(TAICHECKBOTH(src,M)) return
					if(!M.KO)
						viewers(3,src)<<"<b>[src] says:</b> You're not dead yet?"
					else
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

	Attack1(mob/M)
		if(prob(15)) ReverseGenjutsu=1
		else ReverseGenjutsu=0
		if(sleepy&&prob(98)) {sleepy=0; DispelProc()}
		if(waterprisoned || Kanashibari || Coffin || InKageArashi || IceBlasted || ShadowCaptured || JubakuBound)
			FreeMe()
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(get_dist(src,M)>3)
				step_towards(src,M)
				spawn(2)
					if(M&&M.icon_state=="seals"&&prob(90)) Evade1(M)
					else if(M&&firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,10,60)
					else if(M&&!firing) {Move_In(M); spawn(15) Goukakyuu()}
					else if(M) AI_Attack(M,12,66)

			else
				if(M&&!(KageBunshinList.len)&&prob(23)) ShadowClone(M)
				else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,80)
				else if(M) AI_Attack(M,12,66)

	Attack2(mob/M)
		ReverseGenjutsu=1
		if(sleepy&&prob(75)) {sleepy=0; DispelProc()}
		if(waterprisoned || Kanashibari || Coffin || InKageArashi || IceBlasted || ShadowCaptured || JubakuBound)
			FreeMe()
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(get_dist(src,M)>3)
				step_towards(src,M)
				spawn(2)
					if(M&&M.icon_state=="seals"&&prob(90)) Evade1(M)
					else if(M&&firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,10,60)
					else if(M&&!firing) {Move_In(M); spawn(15) {step_towards(src,M); Ryuuka()}}
					else if(M) AI_Attack(M,12,66)

			else
				if(M.client && loc==get_step(M,M.dir) )
					dir=get_dir(src,M)
					AI_Tsukuyomi(M)
				if(M && !M.Tsukuyomi && Cooldowns["Tsuku"]<4)
					if(get_dist(src,M)==1)
						if(loc!=get_step(M,M.dir))
							step_towards(src,get_step(M,M.dir))
							sleep(2)
						if(loc==get_step(M,M.dir)) {dir=get_dir(src,M); AI_Tsukuyomi(M)}
						else if(M&&firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,10,23)
						if(Cooldowns["Tsuku"]<2)
							Cooldowns["Tsuku"] = 1
						else
							Cooldowns["Tsuku"]++
						spawn(600)
							if(src)
								Cooldowns["Tsuku"]--
					else if(M)
						Move_Aim(M)
						Housenka(M)
				else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,80)
				else if(M) AI_Attack(M,12,66)


//--------------------------------------------------------
mob/proc
	AI_Tsukuyomi(mob/M)
		set waitfor = 0
		if(GENERICATTACKCHECK(src)||M.frozen||M.kaiten||M.protect||!M.icon) return
		var/freezetime = Genjutsu-M.Genjutsu
		freezetime*=0.12
		if(freezetime<20) freezetime=20
		if(freezetime>400) freezetime=400
		firing=1;
		spawn(freezetime*0.1)
			firing=0
		viewers(4,src)<<"<b>[src]: Tsukuyomi!</b>"
		if(istype(M,/mob/NPC)&&!(src in M.HitList))
			M.HitList+=src
		M.frozen=1
		M.Tsukuyomi=1
		M.AI_TsukuyomiHurt(src,Genjutsu,freezetime);
//				------- Visuals -------
		if(M)
			var/image/C=image(/obj/Jutsu/Uchiha/Tsukuyomi/Totem,M,)
			M<<C; M.RemoveT(C)
			var/image/self=image(M,M,layer=11,dir=2)
			M<<self; M.RemoveT(self)
			for(var/turf/A in view(10,M))
				if(get_dist(A,M)<7)
					var/image/X=image(/obj/Jutsu/Uchiha/Tsukuyomi/T1,A)
					M<<X; M.RemoveT(X)
				if(get_dist(A,M)>=7)
					var/image/Y=image(/obj/Jutsu/Uchiha/Tsukuyomi/T2,A)
					M<<Y; M.RemoveT(Y)

	AI_TsukuyomiHurt(mob/U,var/G,FT)
		set waitfor = 0
		spawn(FT)
			if(src)
				frozen=0
				Tsukuyomi=0
		while(!KO && Tsukuyomi && U)
			DamageMe(U,G,"tsukuyomi")
			//src<<"You are hurt by [U]'s Tsukuyomi."
			sleep(20)
		if(U)
			if(!KO)
				src<<"<b>You break out of [U]'s Tsukuyomi.</b>"
			else if(Tsukuyomi)
				src<<"<b>[U]'s Tsukuyomi ended.</b>"
		else
			Tsukuyomi = 0
			frozen = 0