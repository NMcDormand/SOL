mob/var
	BunshinLimit=2
	BunshinLimitMax=2
	tmp
		Practicing
		BunshinList[0]
		MasterBunshinList[0]
		BunshinCommand
		drain=5
		drain2=0
		MasterDraining = 0

mob/proc
	RegularBunshinDrain()
		while(BunshinList.len)
			CHECK_TICK
			//if(world.cpu>80)
			//	for(var/mob/Hittable/Command/Clones/c in BunshinList) del(c)
			//	for(var/mob/player/p in MasterGMList) p<<"<b><u>Steps taken to prevent a crash!</b></u>"
			for(var/mob/Hittable/Command/Clones/C in BunshinList)
				Chakra-=C.drain; Chakra-=(ChakraTrue*C.drain2)
			if(Chakra<=1)
				Chakra=1
				for(var/mob/Hittable/Command/Clones/c in BunshinList) del(c)
			RefreshStats()
			sleep(30)
mob/proc
	SetMaxChakra()
		var/CHAKRA
		for(var/mob/Hittable/Command/Clones/C in KageBunshinList) CHAKRA+=C.ChakraMax
		return (ChakraMax-CHAKRA)

	BunshinCreate(mob/B,PERC,CHAKRA,SH=1,NH=1,TH=1,GH=1)
		B.Creator=src
		KageBunshinList+=B; MasterBunshinList+=B
		B.VillageColour = VillageColour
		B.name="[name]"
		B.Village="[Village]"; B.InVillage="[InVillage]"
		B.VillageFriendly = VillageFriendly
		B.NinjaRank="[NinjaRank]"
		B.Clan="[Clan]"
		B.Speciality="[Speciality]"
		B.dir=dir; B.icon=icon; B.overlays+=overlays
		B.movespeed=movespeed
		B.SS = SS+2

		IDCOPY(B,src)

		B.Chakra=CHAKRA;
		if(!B.Chakra)
			B.Chakra = 1
		B.ChakraMax=CHAKRA; B.ChakraControl=ChakraControl
		B.Stamina=(Stamina*PERC)*SH; B.StaminaMax=B.Stamina; B.StaminaTrue=B.Stamina
		B.Taijutsu=(Taijutsu*PERC)*TH
		B.Ninjutsu=(Ninjutsu*PERC)*NH
		B.Genjutsu=(Genjutsu*PERC)*GH
		B.Reflex=Reflex*PERC;
		if(B.Reflex < 1)
			B.Reflex = 1

		B.KnifeSkill=KnifeSkill; B.SwordSkill=SwordSkill; B.H2HSkill=H2HSkill

		B.Class=Class; B.wielding=wielding; B.atkspeed=atkspeed
		B.weights=weights; B.equippedweight=equippedweight; B.weightspeed=weightspeed

		B.WaterElemental = WaterElemental
		B.FireElemental = FireElemental
		B.WindElemental = WindElemental
		B.EarthElemental = EarthElemental
		B.LightningElemental = LightningElemental

		flick('Smoke.dmi',B)
		B.loc.loc.Entered(B)
		if(!BingoBookAssociations) BingoBookAssociations=new()
		BingoBookAssociations=B.BingoBookAssociations
		if(!BingoBook) BingoBook=new()
		if(src in BingoBook) BingoBook+=B

		spawn()
			//GenerateShadow(B, EAST)
			B.BunshinDrain()
			if(!MasterDraining)
				MasterBunshinDrain()

	OldBunshinCreate(mob/B,STAM,TAI,REFLEX)
		if(REFLEX < 1) REFLEX = 1;
		B.Creator=src
		BunshinList+=B; MasterBunshinList+=B
		B.name="[name]"; B.Village="[Village]"; B.InVillage="[InVillage]"; B.NinjaRank="[NinjaRank]"; B.Clan="[Clan]"; B.Speciality="[Speciality]"
		B.VillageFriendly = VillageFriendly
		B.dir=dir; B.icon=icon; B.overlays+=overlays
		B.movespeed=movespeed

		B.Stamina=STAM; B.Taijutsu=TAI; B.Reflex=REFLEX
		B.Class=Class; B.wielding=wielding; B.atkspeed=atkspeed

		flick('Smoke.dmi',B)
		for(var/area/A in view(0,B)) A.Entered(B)

		if(!BingoBookAssociations) BingoBookAssociations=new()
		BingoBookAssociations=B.BingoBookAssociations
		if(!BingoBook) BingoBook=new()
		if(src in BingoBook) BingoBook+=B

		spawn()
			//GenerateShadow(B, EAST)
			if(BunshinList.len==1)
				OldBunshinDrain()

	BunshinDrain()
		while(src)
			CHECK_TICK
			//if(world.cpu>80)
			//	spawn()del(src)
			//	MasterGMList<<"<b><u>Steps taken to prevent a crash!</b></u>"
			Chakra-=drain
			if(Chakra<=1||(Stamina<=(StaminaMax*0.05)))
				del(src)
			sleep(50)

	MasterBunshinDrain()
		if(!MasterDraining)
			MasterDraining = 1
			while(KageBunshinList.len)
				for(var/mob/Hittable/Command/Clones/C in KageBunshinList)
					Chakra-=(C.drain2)
					CHECK_TICK
					//if(world.cpu>80)
					//	spawn()del(C)
					//	MasterGMList<<"<b><u>Steps automatically taken to prevent a crash! [src]'s kage bunshin's were destroyed.</b></u>"
				if(Chakra<=1)
					Chakra=0
					for(var/mob/Hittable/Command/Clones/C in MasterBunshinList)
						del(C)
				RefreshChakra()
				sleep(50)
			MasterDraining = 0

	OldBunshinDrain()
		while(BunshinList.len)
			for(var/mob/Hittable/Command/Clones/c in BunshinList) Chakra -= (c.drain) + (ChakraMax*c.drain2)
			if(Chakra<=1)
				Chakra=1
				for(var/mob/Hittable/Command/Clones/C in BunshinList) del(C)
			CHECK_TICK
			//if(world.cpu>80)
			//	for(var/mob/Hittable/Command/Clones/c in BunshinList)
			//		spawn()del(c)
			//	MasterGMList<<"<b><u>Steps automatically taken to prevent a crash! [src]'s genjutsu bunshin's were destroyed.</b></u>"
			RefreshChakra()
			sleep(50)