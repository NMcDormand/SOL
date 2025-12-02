mob/var
	ShadowLimit=1
	tmp
		var/mob/ShadowCaptured
		ShadowMoved
		Shadows
		list
			TrailList=list()
			ShadowList=list()
			AcquiringList=list()
//-------------------------------------------------------------------------------------------------------------
obj/proc
	ShadowCaptured(mob/M)
		var/mob/P=Owner
		if(!P.ShadowList)
			P.ShadowList = list()
		if(!(M in P.ShadowList))
			P.ShadowList+=M
		M.ShadowCaptured=P; P.AcquiringList-=M
		spawn()P.ShadowDrain(M)
		if(istype(M,/mob/Hittable/Responsive)&&!(P in M.HitList)) M.HitList+=P
		var/shadowtime = P.Ninjutsu*1.23-((M.Taijutsu*0.6)+(M.Ninjutsu*0.4))
		shadowtime/=10
		if(shadowtime<=20) shadowtime=20
		if(shadowtime>=350) shadowtime=350
		KagemaneCaptured(P,M,shadowtime)

//--------------------------------------------------------------------------------------------------------
mob/proc
	ShadowDrain(mob/M)
		if(M&&(M in ShadowList)&&M.ShadowCaptured)
			Chakra-=52; RefreshChakra()
			if(Chakra<=1) {Chakra=1; EndAllKagemane()}
			spawn(20) ShadowDrain(M)
		else ReleaseKagemane(M)

//--------------------------------------------------------------------------------------------------------
//---------------------- [ World proc ] ------------------------
mob/proc
	KagemaneMiss(mob/M)
		if(Shadows)
			Shadows--
		if(Shadows<0)
			Shadows = 0
		if(M)AcquiringList-=M
		for(var/obj/T in TrailList) if((M&&T.target==M)||!T.target) del(T)
//---------------------------------------------
	ReleaseKagemane(mob/M)
		if(M)
			if(Shadows)
				Shadows--
			if(Shadows<0)
				Shadows = 0
			ShadowList-=M
			M.ShadowCaptured=0
			M.overlays-='Neck-Bind.dmi'
			if(!length(ShadowList)&&length(TrailList))
				for(var/obj/T in TrailList) del(T)
			for(var/obj/T in TrailList) if((M&&T.target==M)||!T.target) del(T)
//---------------------------------------------
proc
	KagemaneCaptured(mob/s,mob/M,var/Time)
		if(s)
			if((M && Time<=0)||!s||s.KO||s.dead||!M||M.KO||M.dead)
				if(s&&s.Shadows>0) s.Shadows--
				spawn(13)
					if(s) s.ShadowList-=M
					if(M) M.ShadowCaptured=0

				for(var/obj/T in s.TrailList) if((M&&T.target==M)||!T.target) del(T)
				return
			else
				Time-=5
				spawn(5) KagemaneCaptured(s,M,Time)
//---------------------------------------------
mob/proc
	EndAllKagemane()
		if(Chakra<=1) src<<"You ran out of chakra."; Chakra=1
		Shadows=0
		for(var/mob/B in ShadowList) if(B){B.ShadowCaptured=0; ShadowList-=B}
		for(var/obj/S in TrailList) if(S)del(S)