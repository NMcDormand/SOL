var/COVER_LAYER = 7
area
  // icon = 'ExtraNewTurfs.dmi'
 //  icon_state = "MD"
//	icon='dark.dmi'
//	icon_state="FoD"
//	layer=999
area
	var/Block = 0
	Base
		Blocked
			Block = 1
		Open
			Block = 0
	NPKZ
		NoGo = 1
		Entered(mob/M)
			if(ismob(M))
				M.protect=1
		Exited(mob/M)
			if(ismob(M))
				M.protect=null
//-------------------------------------------------------------------------------------------------------------
	ChakraWater
		Entered(mob/M)
			if(istype(M,/mob/Hittable/Responsive/Animal/Pet/))
				M.swimming=1
				M.onwater=1
				M.icon_state="swim"
				M.WaterWalk()
			else if(ismob(M))
				M.canfindrocks=null
				if(M.WW)
					M.onwater=1
					M.onwaterfall=null
					M.overlays+='WaterWalk.dmi'
					M.WaterWalk()
				else if(!M.swimming)
					M.swimming=1
					M.onwater = 0
					M.icon_state="swim"
					M<<"<font color=#0290cc>You begin to swim!</font>"
					M.BeginSwimming()
		Enter()
			if(istype(usr,/mob/))
				usr.DaibaSmother=0
				if(usr.CantWaterWalk&&istype(usr,/mob/player))
					return 1
			if(istype(usr,/mob/Hittable/Responsive/Animal/Wild))
				return
			if(istype(usr,/mob/Hittable/Responsive/Animal/Pet))
				return 1
			else
				return 1

		Exited(mob/M)
			if(istype(M,/mob/))
				M.icon_state=null
				M.onwater=null
				M.canfindrocks=1
				M.DaibaSmother=0
				M.overlays-='WaterWalk.dmi'
		Exit(mob/M)
			if(istype(M,/mob/Hittable/Command/Clones/MizuBunshin)&&M.WaterElemental<SuitonOnEarthCheck)
				return
			if(istype(M,/mob/Hittable/Responsive/Animal/Pet))
				M.icon_state=null
				return 1
			else
				return 1

	Water
		icon='Floods.dmi'

		Enter() //Calls each time when entering
			if(istype(usr,/mob/player))
				return 1
			/*if(istype(usr,/mob/Hittable/Responsive/Animal/Wild))
				return*/
			if(istype(usr,/mob/Hittable/Responsive/Animal/Pet))
				//usr.icon_state="swim"
				return 1
			else
				return 1

		Entered(mob/M) //Called once on entering
			if(ismob(M) && !istype(M,/mob/Hittable/Unresponsive))
				if(!M.client)//istype(M,/mob/Hittable/Responsive/))
					//M.swimming=1
					M.onwater=1
					M.WaterWalk()
				else
					M.canfindrocks=null
					if(M.WW)
						M.onwater=1
						M.onwaterfall=null
						M.overlays+='WaterWalk.dmi'
						M.WaterWalk()
					else if(!M.swimming)
						M.swimming = 1
						M.onwater = 0
						M.icon_state="swim"
						M<<"<font color=#0290cc>You begin to swim!</font>"
						M.BeginSwimming()

		Exited(mob/M)
			if(istype(M,/mob/))
				M.icon_state=null
				M.onwater=null
				M.canfindrocks=1
				M.DaibaSmother=0
				M.swimming = 0
				M.icon_state=null;
				M.overlays-='WaterWalk.dmi'

		Exit(A)
			if(istype(A,/obj/Jutsu/Suiton/Goshokuzame))
				var/obj/Jutsu/Suiton/Goshokuzame/G = A
				if(G.WaterElemental >= SuitonOnEarthCheck*6)
					return 1
				else
					return 0
			else if(ismob(A))
				var/mob/M = A
				if(istype(M,/mob/Hittable/Responsive/Animal/Wild/Bird/Swan))
					return
				if(istype(M,/mob/Hittable/Command/Clones/MizuBunshin)&&M.WaterElemental<SuitonOnEarthCheck)
					return
				/*if(istype(M,/mob/Hittable/Responsive/Animal/Pet))
					return 1*/
				else
					return 1
			else
				return 1

	Shadow_Jutsu
		icon='kagemane.dmi'
		icon_state="full_shadow"
		layer=MOB_LAYER-1

//turf
	Water_Jutsu
		icon='grass.dmi'
		icon_state="water"
		layer=MOB_LAYER-1
		Entered(mob/M)
			if(istype(M,/mob/Hittable/Responsive/Animal/Pet/))
				//M.swimming=1
				M.onwater=1
				//M.ChangeScene("inside")
				//M.icon_state="swim"
				M.WaterWalk()
			else if(istype(M,/mob/))
				M.onwater=1
				M.onwaterfall=null
				M.canfindrocks=null
				M.overlays+='WaterWalk.dmi'
				M.WaterWalk()
		Enter()
			if(istype(usr,/mob/))
				usr.DaibaSmother=0
				if(usr.CantWaterWalk&&istype(usr,/mob/player))
					return 1
			if(istype(usr,/mob/Hittable/Responsive/Animal/Wild))
				return
			if(istype(usr,/mob/Hittable/Responsive/Animal/Pet))
				return 1
			else
				return 1

		Exited(mob/M)
			if(istype(M,/mob/))
				M.icon_state=null
				M.onwater=null
				M.canfindrocks=1
				M.DaibaSmother=0
				M.overlays-='WaterWalk.dmi'
		Exit(mob/M)
			if(istype(M,/mob/Hittable/Command/Clones/MizuBunshin)&&M.WaterElemental<SuitonOnEarthCheck)
				return
			if(istype(M,/mob/Hittable/Responsive/Animal/Pet))
				M.icon_state=null
				return 1
			else
				return 1
//-------------------------------------------------------------------------------------------------------------
area
	StamMountain
		Entered(mob/M)
			if(istype(M,/mob/)) {M.onmountain=1; M.WeightSpeed()}
			else return
		Enter(mob/M)
			if(istype(M,/mob/))
				if(M.StaminaMax<500) {M<<"You need at least 500 Stamina to climb mountains"; return}
				else return 1
			else return

		Exited(mob/M)
			if(istype(M,/mob/player))
				M.onmountain=null
				M.WeightSpeed()
				M.MountainWalk()
//-------------------------------------------------------------------------------------------------------------
	SandArea
		Entered(mob/M)
			if(istype(M,/mob))
				if(!M.onsand)
					M.onsand=1
			return 1

		Exited(mob/M)
			if(istype(M,/mob))
				if(M.onsand)
					M.onsand=null
			return 1
mob/var
	onsand
	sandspeed
	InSparArea
	waterfallspeed
//-------------------------------------------------------------------------------------------------------------
turf
	SparArena
		icon='stadium.dmi'
		icon_state="10"

area
	Spar
		Enter()
			if(istype(usr,/mob/player))
				usr.taitraining=6; usr.InSparArea=1
			return 1
		Exit()
			if(istype(usr,/mob/player))
				usr.taitraining=0; usr.InSparArea=null
				usr.SparPunch=0; usr.SparringWith=null; usr.HitCount=0
			return 1
//-------------------------------------------------------------------------------------------------------------
	Waterfall
		icon='Floods.dmi'
		Enter()
			/*
			if(istype(usr,/mob/NPC/)||istype(usr,/mob/Hittable/Responsive/Animal))
				return
			else if(istype(usr,/mob/player/)||istype(usr,/mob/Hittable/Command/Clones))
			else return 0*/
			if(ismob(usr))
				if(usr.client)
					if(usr.swimming)
						usr << "You cant swim up a waterfall"
						return 0
					else if(usr.ChakraControl<25)
						usr<<"You need at least 25% Chakra Control to attemp to scale a waterfall."
						return 0
				usr.onwaterfall=1
				usr.canfindrocks=0
				return 1
			else
				return 0

		Exit()
			if(ismob(usr))
				usr.onwater=null
				usr.onwaterfall=null
			return 1
//-------------------------------------------------------------------------------------------------------------
	//Wilderness
