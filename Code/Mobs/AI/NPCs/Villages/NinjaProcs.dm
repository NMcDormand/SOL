mob/var/tmp/Hunting=0
mob/var/
	VillageHitList=list()
	LeafNinList=list()
	SandNinList=list()
	RainNinList=list()
	RockNinList=list()
	GrassNinList=list()
	WaterfallNinList=list()
	SoundNinList=list()
	MistNinList=list()
	CloudNinList=list()
mob/proc
	steprand()
		/*var/d = pick(WEST, EAST, NORTH, SOUTH, NORTHEAST, NORTHWEST, SOUTHEAST, SOUTHWEST)
		step(src,d)*/
		//dir=pick(1,2,4,5,6,8,9,10); step_rand(src)
		step_rand(src)
	NinjaShunshin(mob/M)
		..()
	NinjaShunshinnoJutsu(mob/T)
		..()
	NinjaShuriken(mob/M)
		..()
	NinjaSunaShuriken(mob/M)
		..()
	NinjaJutsu(mob/M)
		..()
	VillageHitListCheck(mob/v)
		if(!(v in VillageHitList))
			if(Village=="Sand"&&v in SandHitList) VillageHitList+=v
			if(Village=="Leaf"&&v in LeafHitList) VillageHitList+=v
			if(Village=="Rain"&&v in RainHitList) VillageHitList+=v
			if(Village=="Rock"&&v in RockHitList) VillageHitList+=v
			if(Village=="Grass"&&v in GrassHitList) VillageHitList+=v
			if(Village=="Sound"&&v in SoundHitList) VillageHitList+=v
			if(Village=="Mist"&&v in MistHitList) VillageHitList+=v
			if(Village=="Cloud"&&v in CloudHitList) VillageHitList+=v
			if(Village=="Waterfall"&&v in WaterfallHitList) VillageHitList+=v

	VillageHitListAdd(mob/v)
		if(Village=="Sand"&&!(src in SandHitList)) SandHitList+=v
		if(Village=="Leaf"&&!(src in LeafHitList)) LeafHitList+=v
		if(Village=="Rain"&&!(src in RainHitList)) RainHitList+=v
		if(Village=="Rock"&&!(src in RockHitList)) RockHitList+=v
		if(Village=="Grass"&&!(src in GrassHitList)) GrassHitList+=v
		if(Village=="Sound"&&!(src in SoundHitList)) SoundHitList+=v
		if(Village=="Mist"&&!(src in MistHitList)) MistHitList+=v
		if(Village=="Cloud"&&!(src in CloudHitList)) CloudHitList+=v
		if(Village=="Waterfall"&&!(src in WaterfallHitList)) WaterfallHitList+=v

mob/var/Wandering = 0
mob/Hittable/Responsive
	NinjaShunshin(mob/M)
		for(var/turf/T in range(src,12)) if(T.density) T.opacity=1
		if(M in oview(12,src)&&!throwing) NinjaShunshinnoJutsu(M)
		for(var/turf/t in range(src,12)) if(t.density) t.opacity=initial(t.opacity)

	NinjaShunshinnoJutsu(mob/T)
		if(GENERICATTACKCHECK(src)||InMirrors) return
		firing=1
		spawn(1)
			spawn(50)firing=0
			view(4,src) << "<b>[src]: Shunshin no Jutsu!</b>"
			flick("kawarimi",src); flick('Flicker.dmi',src)
			spawn(3)
				flick("kawarimi",src); flick('Flicker.dmi',src)
				moving=1
				spawn(movespeed) {moving=0; loc=T.loc}
//----------------------------------------
	NinjaShuriken(mob/M)
		if(ThrowAttackCheck()) return
		throwing=1; spawn(5) throwing=0
		if(M) dir=get_dir(src,M)
		CantWalk++; spawn(2)CantWalk--
		var/obj/Weapon/Thrown/ThrownShuriken/S = new(loc)
		S.Taijutsu=Taijutsu; S.ThrowingSkill=ThrowingSkill; S.dir=dir; S.name="[src]"; S.Owner=src
		walk(S,dir)
		spawn(11)del(S)

	NinjaSunaShuriken(mob/M)
		if(ThrowAttackCheck()) return
		if(M) dir=get_dir(src,M)
		CantWalk++; spawn(2)CantWalk--
		var/obj/SandNin/SunaShuriken/S = new(loc)
		S.Taijutsu=Taijutsu; S.ThrowingSkill=ThrowingSkill; S.dir=dir; S.name="[src]"; S.Owner=src
		walk(S,dir)
		spawn(11)del(S)

	NinjaJutsu(mob/M)
		if(GENERICATTACKCHECK(src)) return
		switch(Village)
			if("Leaf")
				icon_state="seals"
				firing=1
				spawn(8)
					spawn(1)icon_state=null
					spawn(120)firing=0
					if(M)
						view(4,src)<<"<b>[src]: Katon: Housenka!</b>"
						var/obj/Jutsu/Katon/Housenka/K=new/obj/Jutsu/Katon/Housenka
						K.Ninjutsu=Ninjutsu; K.FireElemental=FireElemental
						K.loc=loc; K.dir=dir; K.target=M; K.Owner=src
						K.BetterHoming(M,M.loc)
						spawn(25)
							del(K)
						spawn(3)
							if(M)
								var/obj/Jutsu/Katon/Housenka/S=new/obj/Jutsu/Katon/Housenka
								S.Ninjutsu=Ninjutsu; S.FireElemental=FireElemental
								S.loc=loc; S.dir=dir; S.target=M; S.Owner=src
								S.BetterHoming(M,M.loc)
								spawn(25)
									del(S)
								spawn(3)
									if(M)
										var/obj/Jutsu/Katon/Housenka/D=new/obj/Jutsu/Katon/Housenka
										D.Ninjutsu=Ninjutsu; D.FireElemental=FireElemental
										D.loc=loc; D.dir=dir; D.target=M; D.Owner=src
										D.BetterHoming(M,M.loc)
										spawn(25)
											del(D)
			if("Mist")
				if(onwater)
					icon_state="seals"
					firing=1
					spawn(8)
						spawn(120)firing=0
						icon_state=null
						hearers(4,src)<<"<b>[src]: Suiton: Suiryuudan!</b>"
						var/obj/Jutsu/Suiton/Suiryuudan/S=new/obj/Jutsu/Suiton/Suiryuudan
						S.Ninjutsu=Ninjutsu; S.WaterElemental=WaterElemental
						S.loc=loc; S.dir=dir; S.target=M; S.Owner=src
						S.BetterHoming(M,M.loc)
						spawn(16)del(S)
				else
					firing=1
					spawn(1)
						spawn(80)
							firing=0
						throwing=1; spawn(12)throwing=0
						var/obj/Weapon/Thrown/ThrownShuriken/S=new/obj/Weapon/Thrown/ThrownShuriken
						S.loc=loc; S.Taijutsu=Taijutsu; S.ThrowingSkill=ThrowingSkill; S.Owner=src
						walk(S,dir); spawn(11)del(S)
						JutsuNin(80)
						spawn(2)
							var/obj/Weapon/Thrown/ThrownShuriken/H=new/obj/Weapon/Thrown/ThrownShuriken
							H.loc=loc; H.Taijutsu=Taijutsu; H.ThrowingSkill=ThrowingSkill; H.Owner=src
							walk(H,dir); spawn(11)del(H)
			if("Rock")
				if(!onwater)
					icon_state="seals"
					firing=1
					spawn(8)
						spawn(1)icon_state=null
						spawn(120)firing=0
						view(4,src)<<"<b>[src]: Doton: Doryuu Dango!</b>"
						var/obj/Jutsu/DoryuuDango/D=new/obj/Jutsu/DoryuuDango
						D.Ninjutsu=Ninjutsu; D.EarthElemental=EarthElemental
						D.loc = loc; D.dir=dir; D.movespeed=0; D.name="[src]"; D.Owner=src; walk(D,dir)
						spawn(8)del(D)
			if("Sound")
				icon_state="seals"
				firing=1
				spawn(2)
					spawn(1)icon_state=null
					spawn(140)firing=0
					view(4,src)<<"<b>[src]: Kyoumeisen!</b>"
					for(var/mob/m in range(2,src))
						if(dir==get_dir(src,m)&&m in HuntList)
							if(!m.Blasted)
								m<<"[src] has blasted you with sound."
								spawn(8)
									if(m) {m<<"Your inner ear has been damaged."; m.Blasted=1}
									spawn(90) if(m) {m<<"Your sense of balance has returned."; m.Blasted=0}
			if("Cloud")
				icon_state="seals"
				firing=1
				spawn(10)
					spawn(1)icon_state=null
					spawn(150)firing=0
					if(M)
						view(4,src)<<"<b>[src]: Raiton: Rairyuu no Tatsumaki!</b>"
						var/obj/Jutsu/Raiton/RairyuunoTatsumaki/R=new(loc)
						R.Ninjutsu=Ninjutsu; R.LightningElemental=LightningElemental
						R.target=M; R.Owner=src; R.BetterHoming(M,M.loc)
						spawn(8)
							if(R)
								del(R)
			else
				firing=1
				spawn(1)
					spawn(80)
						firing=0
					throwing=1; spawn(12)throwing=0
					var/obj/Weapon/Thrown/ThrownShuriken/S=new/obj/Weapon/Thrown/ThrownShuriken
					S.loc=loc; S.Taijutsu=Taijutsu; S.ThrowingSkill=ThrowingSkill; S.Owner=src
					walk(S,dir); spawn(11)del(S)
					JutsuNin(80)
					spawn(2)
						var/obj/Weapon/Thrown/ThrownShuriken/H=new/obj/Weapon/Thrown/ThrownShuriken
						H.loc=loc; H.Taijutsu=Taijutsu; H.ThrowingSkill=ThrowingSkill; H.Owner=src
						walk(H,dir); spawn(11)del(H)


mob/proc/BountyCheck(mob/M)
	if(!M.Bounty) M.Bounty=new()
	if((M.Bounty[Village]>400)||(M in HitList)) return 1
	else return 0