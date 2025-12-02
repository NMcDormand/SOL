mob/Hittable
	NinjaShuriken(mob/M)
		if(ThrowAttackCheck()) return
		throwing=1; spawn(5) throwing=0
		if(M) dir=get_dir(src,M)
		CantWalk++; spawn(2)CantWalk--
		var/obj/Weapon/Thrown/ThrownShuriken/S = new(loc)
		S.Taijutsu=Taijutsu; S.ThrowingSkill=ThrowingSkill; S.dir=dir; S.name="Shuriken"; S.Owner=src
		walk(S,dir)
		spawn(11)del(S)

mob/proc
	Renkoudan(Shots=1)
		JutsuMessage("Renkoudan")
		var/N = round(Shots*0.5)
		var/X = x
		var/Y = y
		var/Z = z
		var/list/Bullets = list()
		for(var/i = 1 to Shots)
			var/turf/LOC
			switch(dir)
				if(NORTH)
					LOC = locate(X-1+N,Y-2,Z)
				if(SOUTH)
					LOC = locate(X-1+N,Y,Z)
				if(WEST)
					LOC = locate(X,Y-1+N,Z)
				if(EAST)
					LOC = locate(X-2,Y-1+N,Z)
				if(NORTHWEST)
					LOC = locate(X-N,Y-2-N,Z)
				if(NORTHEAST)
					LOC = locate(X-2+N,Y-2-N,Z)
				if(SOUTHWEST)
					LOC = locate(X+N,Y-N,Z)
				if(SOUTHEAST)
					LOC = locate(X-2-N,Y-N,Z)
			if(LOC)
				var/obj/Jutsu/Fuuton/Renkoudan/F=new(LOC)
				IDCOPY(F,src)
				Bullets += F
			N-=1
		var/NM = Ninjutsu * 3
		for(var/obj/Jutsu/j in Bullets)
			j.Ninjutsu = NM
			j.Power = 3
			j.WindElemental = WindElemental
			IDCOPY(j,src)
			j.dir = dir
			j.Owner = src
			j.movespeed = 2
			walk(j,j.dir,j.movespeed)
			spawn(24)
				if(j)
					walk(j,0)
					j.loc = null
	Daitoppa()
		if(GENERICATTACKCHECK(src))
			sleep(4)
		else
			icon_state="seals"
			firing=1
			spawn(2)
				spawn(1)icon_state=null
				spawn(35)firing=0
				if(!istype(src,/mob/Hittable/Command/Clones)) hearers(4,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> Fuuton: Daitoppa!", "Chat")
				var/obj/Jutsu/Fuuton/Daitoppa/F=new/obj/Jutsu/Fuuton/Daitoppa(loc)
				F.Ninjutsu=Ninjutsu; F.WindElemental=WindElemental
				F.dir=dir; F.movespeed=2; F.name="Daitoppa"; F.Owner=src
				walk(F,dir)
				ChakraXP += 20*EXPGains_Chakra
				spawn(10){if(F)del(F)}
			sleep(8)

	ShadowClone(mob/M, IC = 0)
		set waitfor = 0
		if(!M)
			return
		if(GENERICATTACKCHECK(src) && !IC)
			sleep(4)
		else
			icon_state="seals"
			firing=1
			spawn(3)
				icon_state=null
				spawn(12)firing=0
				if(!IC)
					if(!istype(src,/mob/Hittable/Command/Clones)) hearers(4,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> Kage Bunshin no jutsu!", "Chat")
				var/mob/Hittable/Command/Clones/KageBunshin/B=new(loc)
				B.name="[src]"; B.Village="[Village]"; B.dir=dir; B.movespeed=movespeed
				B.Creator=src; KageBunshinList+=B; B.icon=icon; B.overlays+=overlays
				B.Stamina=round(StaminaMax*0.20); B.StaminaMax=B.Stamina; B.Taijutsu=round(Taijutsu*0.15)
				B.KnifeSkill=KnifeSkill; B.SwordSkill=SwordSkill; B.wielding=wielding; B.Reflex = Reflex*0.8
				IDCOPY(B,src)
				flick('Smoke.dmi',B)
				if(B && B.loc)
					if(B.loc.loc)
						B.loc.loc.Entered(B)
				if(M)
					B.target=M
					if(B.Status!=STATUS_ATTACK) {B.Status=STATUS_ATTACK; spawn()B.bunatck()}
				else
					del(B)

	SageMode()
		SageBoostT = Taijutsu * 0.4
		SageBoostN = Ninjutsu * 0.4
		SageBoostS = Stamina * 0.4
		Reflex += 60
		Taijutsu += SageBoostT
		Ninjutsu += SageBoostN
		Stamina += SageBoostS
		SageMode = 1
		if(!istype(src,/mob/Hittable/Command/Clones)) hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> Sage Mode!", "Chat")

	SageModeDispel()
		Taijutsu -= SageBoostT
		Ninjutsu -= SageBoostN
		Stamina -= SageBoostS
		Reflex -= 60
		SageBoostT = 0
		SageBoostN = 0
		SageBoostS = 0
		SageMode = 0

	Suiryuudan(mob/M)
		if(GENERICATTACKCHECK(src)) return
		if(!M)
			return
		if(WaterElemental >= 2000 || onwater)
			icon_state="seals"
			firing=1
			sleep(SS+3)
			spawn(6)firing=0
			icon_state=null
			if(!istype(src,/mob/Hittable/Command/Clones)) hearers(4,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> Suiton: Suiryuudan!", "Chat")
			if(M)
				var/obj/Jutsu/Suiton/Suiryuudan/S=new/obj/Jutsu/Suiton/Suiryuudan
				S.Ninjutsu=Ninjutsu; S.WaterElemental=WaterElemental
				S.loc=loc; S.dir=dir; S.target=M; S.Owner=src
				S.BetterHoming(M,M.loc)
				ChakraXP += 20*EXPGains_Chakra
				spawn(16)del(S)

	Rairyuu(mob/M)
		if(!M)
			return
		if(GENERICATTACKCHECK(src)) return
		icon_state="seals"
		firing=1
		spawn(9)
			spawn(1)icon_state=null
			spawn(8)firing=0
			if(!istype(src,/mob/Hittable/Command/Clones)) hearers(4,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> Raiton: Rairyuu no Tatsumaki!", "Chat")
			if(M)
				var/obj/Jutsu/Raiton/RairyuunoTatsumaki/R=new(loc)
				R.Ninjutsu=Ninjutsu; R.LightningElemental=LightningElemental
				R.target=M; R.Owner=src; R.BetterHoming(M,M.loc)
				ChakraXP += 20*EXPGains_Chakra
				spawn(8)
					if(R)
						del R

	Mugen()
		if(GENERICATTACKCHECK(src)) return
		icon_state="seals"
		firing=1
		spawn(9)
			spawn(1)icon_state=null
			spawn(8)firing=0
			if(!istype(src,/mob/Hittable/Command/Clones)) hearers(4,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> Fuuton: Mugen Sajin Daitoppa!", "Chat")
			var/obj/Jutsu/Fuuton/MugenSajin/F1=new/obj/Jutsu/Fuuton/MugenSajin(get_step(src,dir))
			var/obj/Jutsu/Fuuton/MugenSajin/F2=new/obj/Jutsu/Fuuton/MugenSajin
			var/obj/Jutsu/Fuuton/MugenSajin/F3=new/obj/Jutsu/Fuuton/MugenSajin
			ChakraXP += 20*EXPGains_Chakra

			CreateProjectile(src,F1,"Wind",loc,dir,0,15,1,1.4)
			spawn(1)
				CreateProjectile(src,F2,"Wind",(get_step(src,turn(dir,90))),dir,0,15,1,0.7)
				CreateProjectile(src,F3,"Wind",(get_step(src,turn(dir,-90))),dir,0,15,1,0.7)
				F2.loc = get_step(F2,dir); F3.loc = get_step(F3,dir)

	Goukakyuu()
		if(GENERICATTACKCHECK(src)) return
		var
			c=200; s=SS+2
		icon_state="seals"
		firing=1
		spawn(s)
			spawn(1)icon_state=null
			spawn(4)firing=0
			JutsuNin(c); ElementalUp("Fire")
			if(!istype(src,/mob/Hittable/Command/Clones)) hearers(4,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> Katon: Goukakyuu!", "Chat")
			var/turf/LOC
			switch(dir)
				if(NORTH,SOUTH)
					LOC = locate(x-1,y,z)
				if(WEST,EAST)
					LOC = locate(x,y-1,z)
			var/obj/Jutsu/Katon/Goukakyuu/K=new(LOC,src)
			ChakraXP += 20*EXPGains_Chakra
			CreateProjectile(src,K,"Fire",LOC,dir,1,8,1,1.3)
			spawn(17)
				if(K)
					del(K)

	Housenka(mob/M)
		if(!M)
			return
		if(GENERICATTACKCHECK(src)) return
		icon_state="seals"
		firing=1
		spawn(SS+3)
			spawn(1)icon_state=null
			spawn(4)firing=0
			JutsuNin(80); ElementalUp("Fire")
			if(!istype(src,/mob/Hittable/Command/Clones)) hearers(4,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> Katon: Housenka!", "Chat")
			var/obj/Jutsu/Katon/Housenka/D=new/obj/Jutsu/Katon/Housenka
			var/obj/Jutsu/Katon/Housenka/S=new/obj/Jutsu/Katon/Housenka
			var/obj/Jutsu/Katon/Housenka/K=new/obj/Jutsu/Katon/Housenka
			ChakraXP += 20*EXPGains_Chakra
			K.Ninjutsu=Ninjutsu; K.FireElemental=FireElemental
			K.loc=loc; K.dir=dir; K.target=M; K.Owner=src
			if(M)
				K.BetterHoming(M,M.loc)
				spawn(3)
					if(M)
						S.Ninjutsu=Ninjutsu; S.FireElemental=FireElemental
						S.loc=loc; S.dir=dir; S.target=M; S.Owner=src
						S.BetterHoming(M,M.loc)
					spawn(3)
						if(M)
							D.Ninjutsu=Ninjutsu; D.FireElemental=FireElemental
							D.loc=loc; D.dir=dir; D.target=M; D.Owner=src
							D.BetterHoming(M,M.loc)
				spawn(25) {del(D); del(S); del(K)}

	Ryuuka()
		if(GENERICATTACKCHECK(src)) return
		var/s=SS+4
		var/c=250
		icon_state="seals"
		firing=1
		spawn(s)
			spawn(1)icon_state=null
			spawn(4)firing=0
			JutsuNin(c); ElementalUp("Fire")
			if(!istype(src,/mob/Hittable/Command/Clones)) hearers(4,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> Katon: Ryuuka!", "Chat")
			var/obj/Jutsu/Katon/Ryuuka/K=new(loc)
			K.Ninjutsu=Ninjutsu; K.FireElemental=FireElemental
			ChakraXP += 20*EXPGains_Chakra
			K.dir=dir; K.Owner=src; walk(K,dir)
			spawn(18)del(K)

//----------------------- - [ Jiroubou ] - -------------------------------------------------------------------
	DoryuuDango()
		if(!(AIGENERICCHECK(src)))
			if(!onwater || EarthElemental >= 2000)
				icon_state="seals"
				firing=1
				sleep(SS+1)
				spawn(1)icon_state=null
				spawn(120)firing=0
				if(!istype(src,/mob/Hittable/Command/Clones)) hearers(4,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> Doton: Doryuu Dango!", "Chat")
				var/obj/Jutsu/DoryuuDango/D=new/obj/Jutsu/DoryuuDango
				D.Ninjutsu=Ninjutsu; D.EarthElemental=EarthElemental
				D.loc = loc; D.dir=dir; D.movespeed=0; D.name="Doryuu Dango"; D.Owner=src; walk(D,dir)
				ChakraXP += 20*EXPGains_Chakra
				spawn(8)
					if(D)
						del D
	DoryuuHeki()
		if(onwater||AIGENERICCHECK(src)||dir==SOUTHWEST||dir==SOUTHEAST||dir==NORTHWEST||dir==NORTHEAST) return
		firing=1; spawn(90) firing=0
		if(!istype(src,/mob/Hittable/Command/Clones)) hearers(4,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> Doton: Doryuu Heki!", "Chat")

		ChakraXP += 20*EXPGains_Chakra
		var/obj/Jutsu/DoryuuHeki/D = new/obj/Jutsu/DoryuuHeki
		D.loc = get_step(src,dir)
		D.dir=dir; D.Owner=src
		spawn(30) del(D)
		var/obj/Jutsu/DoryuuHeki/O = new/obj/Jutsu/DoryuuHeki
		O.loc = (get_step(src,turn(dir,90))); O.loc = get_step(O,dir)
		O.dir=dir; O.Owner=src
		spawn(30) del(O)
		var/obj/Jutsu/DoryuuHeki/T = new/obj/Jutsu/DoryuuHeki
		T.loc = (get_step(src,turn(dir,-90))); T.loc = get_step(T,dir)
		T.dir=dir; T.Owner=src
		spawn(30) del(T)

//------------------------- - [ Kidoumaru ] - --------------------------------------------------------------

	KidoumaruBow(mob/M)
		if(!M)
			return
		if(!(AIGENERICCHECK(src)))
			firing=1; spawn(25) firing=0
			var/obj/Sound5/Arrow/A = new/obj/Sound5/Arrow
			A.loc=loc
			A.target=M
			A.Ninjutsu=round((Ninjutsu/2)+(Taijutsu/2))
			A.Owner=src
			A.Homing(M,M.loc)
			spawn(20)del(A)

	Kidoumaru_Web(mob/M)
		if(!M)
			return
		if(!(AIGENERICCHECK(src)))
			if(!istype(src,/mob/Hittable/Command/Clones)) hearers(4,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> Ninpou Kumoshi Bari!", "Chat")
			var/obj/Sound5/Web/W = new(loc)
			W.target=M; W.Owner=src
			W.Homing(M,M.loc)
			spawn(12)del(W)

	SummonSpider()
		if(!(AIGENERICCHECK(src)))
			firing=1; spawn(100)firing=null
			HasSummoned=1
			if(!istype(src,/mob/Hittable/Command/Clones)) hearers(4,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> Kyuichose no Jutsu!", "Chat")

			var/mob/Hittable/Summon/Spider/S = new(loc)
			flick('Smoke.dmi',S)
			S.movespeed=2; S.Creator=src
			var/mob/Hittable/Summon/Spider/S2 = new(loc)
			flick('Smoke.dmi',S2)
			S2.movespeed=2; S2.Creator=src
			var/mob/Hittable/Summon/Spider/S3 = new(loc)
			flick('Smoke.dmi',S3)
			S3.movespeed=2; S3.Creator=src

			spawn(150)
				if(S) del(S)
				if(S2) del(S2)
				if(S3) del(S3)
				spawn(30)HasSummoned=0