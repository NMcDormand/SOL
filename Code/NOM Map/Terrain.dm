var/list/OutdoorAreas = list()

area
	layer=255
	var
		Cat=0
		Outdoor=1
		SpnAble=1
		HasSand = 0
		NoGo = 1

#if !TESTING
	mouse_opacity = 0
#endif

	New()
		..()
		if(Outdoor)
			OutdoorAreas += src

	Entered(atom/movable/O)
		..()
		if(isobj(O))
			return
		if(istype(O,/mob/player))
			var/mob/player/M=O
			if(name != "area" && name != "Water")
				M.ZCoord="[name]"
				M.ZCoordProc(name)
			if(HasSand)
				M.onsand = 1

	Exited(atom/O)
		..()
		if(isobj(O))
			return
		if(istype(O,/mob/player))
			if(HasSand)
				var/mob/player/M=O
				M.onsand = 0

	Indoor
		Outdoor=0
		NoGo = 1
		Cat = 0
		Academy
		ChuDone
		ChuEx
		Arena
			ArenaD
				icon='Caves.dmi'
				icon_state="Darkness"

		Pursuit
		Hospital
			Cloud
			Grass
			Leaf
			Mist
			Rain
			Rock
			Sand
			Sound
			Waterfall

		Prison
			icon='Caves.dmi'
			icon_state="Darkness"
			Cloud
				name = "Cloud Jail"
			Grass
				name = "Grass Jail"
			Leaf
				name = "Leaf Jail"
			Mist
				name = "Mist Jail"
			Rain
				name = "Rain Jail"
			Rock
				name = "Rock Jail"
			Sand
				name = "Sand Jail"
			Sound
				name = "Sound Jail"
			Waterfall
				name = "Waterfall Jail"

	Outdoor
		icon='Floods.dmi'
		icon_state="Village"
		Cat = 1
		NoGo = 0
		New()
			..()
			if(!NoGo)
				AreaList += src

		var
			Temperature
			Weather
			VillageWall = 0
		ChickenCoop
			Outdoor=1
			/*New()
				..()
				if(name=="Mist")
					for(var/turf/T in contents)
						T.overlays+=/turf/overlay/Fog*/

			Enter()
				if(istype(usr,/mob/Hittable/Responsive/Animal/Wild/Bird))
					return
				else
					return 1
		Locations
			New()
				..()
				if(name == "Konoha Invasion")
					NoGo = 1
					Cat = 0
			Enter(mob/M)
				if(istype(M,/mob/player))
					if(M.NinjaRank=="Academy Student")
						if(M.reset)
							return
						else
							M<<"<b>You cannot leave the safety of the village until you pass the Genin Exam</b>";
							M.reset=1;
							spawn(50)
								if(M)
									M.reset=0
							return
					else
						M.InVillage = null
						return 1
				else
					return 1
			//icon='Diag.dmi'
			//icon_state="WaterC2"
		Desert
			Entered(mob/M)
				if(istype(M,/mob))
					if(!M.onsand)
						M.onsand=1
				..()

			Exited(mob/M)
				if(istype(M,/mob))
					if(M.onsand)
						M.onsand=0
				..()
		Mountain
			//icon='Diag.dmi'
			//icon_state="Mountain"
			NoGo = 1
			Entered(mob/M)
				if(istype(M,/mob/))
					M.onmountain=1
					M.WeightSpeed()
				..()

			Enter(mob/M)
				if(istype(M,/mob/))
					if(M.StaminaMax<1500 && M.client)
						M<<"You need at least 1500 Stamina to climb mountains"
						return
					else return 1
				else return

			Exited(mob/M)
				if(istype(M,/mob/player))
					M.onmountain=null
					M.WeightSpeed()
					M.MountainWalk()
				..()
		NoGo
			name="Outdoor"
			SpnAble=0
			NoGo = 1
			Cat = 0
			//icon='Diag.dmi'
			//icon_state="NoGo"

		Village
			//icon='Diag.dmi'
			//icon_state="Village"
			var
				Active=0
				ActiveS=0
				Village=""
			mouse_opacity = 0
			/*New()
				..()
				if(name=="Mist")
					for(var/turf/T in contents)
						T.overlays+=/turf/overlay/Fog*/

			Entered()
				if(istype(usr,/mob/player))
					if(usr.InVillage!=name)
						usr<<"<b>You are now entering the Village Hidden in [name].</b>"
						usr.InVillage=name; usr.ZCoord="[name]"; usr.ZCoordProc(usr.ZCoord)
						if((usr.BingoBookAssociations[name])) usr.CheckEntry()
						if(usr.Fines[usr.InVillage]) usr.ArrestCheck()
				.=..()

			Exit(var/mob/Living/O)
				.=..()

			Exited(var/mob/Living/O)
				.=..()

	Roof
		Outdoor=0
		var/image/image
		Entered(atom/O)
			if(istype(O,/mob/player))
				var/mob/player/M=O
				M.client.images -= image
				M.InBuilding=1
			.=..()

		Exited(atom/O)
			if(istype(O,/mob/player))
				var/mob/player/M=O
				M.client.images += image
				M.InBuilding=0
			.=..()

		Sound
			name="Sound"
		Sound2
			name="Sound"
		Cloud
			name="Cloud"
		Leaf
			name="Leaf"
		Leaf2
			name="Leaf"
		Leaf3
			name="Leaf"
		Rain
			name="Rain"
		Sand
			name="Sand"
		Grass
			name="Grass"
		Rock
			name="Rock"
		Rock2
			name="Rock"
		Waterfall
			name="Waterfall"
		Waterfall2
			name="Waterfall"
		Mist1
			name="Mist"
		Mist2
			name="Mist"

	Cave
		Outdoor=0
		NoGo = 0
		icon='Caves.dmi'
		icon_state="Darkness"
		FOD
			NoGo = 1

		Zaccurland
			NoGo = 1
			Enter(var/mob/A)
				if(ismob(A))
					if(A.InSexy)
						return 1
					else
						return 0
			Exit(var/mob/A)
				if(ismob(A))
					if(A.TeamID == "Zaccur Disciple")
						return 0
					else
						return 1
			Door
				Enter(var/mob/A)
					if(ismob(A))
						if(A.InSexy)
							return 1
						else
							return 0
		NoGo
			//name="Outdoor"
			NoGo = 1
			SpnAble=0
			//icon='Diag.dmi'
			//icon_state="NoGo"
			Samehada

turf
	overlay
		Fog
			mouse_opacity = 0
			icon='Suitons.dmi'
			icon_state="Mist Fog"
			layer = 200
	terrain
		New()
			..()
		//Entered()
			//var/obj/Map/A=locate(/obj/Map/Cliff/Top)
		//nom
		Ground
			var
				BlockMove=0
				BlockN
				BlockW
				BlockE
				BlockS
			Floor
				icon='Floor.dmi'
			Snow
				icon='Snowfield.dmi'
			Sand
				icon='Desert.dmi'
				Dense
					density=1
			Beach
				icon='Beach.dmi'
				Dense
					density=1
			Dirt
				icon='Rock2020.dmi'
				Dense
					density=1
			Grass
				icon='Grass2020.dmi'
				Dense
					density=1
			Paths
				icon='Paths.dmi'
			Mountain
				icon='Mountain2020.dmi'
				Dense
					density=1
		Opaque
			opacity=1
			density=1
		Blocker
			Cell
				DESW=1
				DESE=1
				DES=1
				DN=1
				DNW=1
				DNE=1
				Open=1
				Cell1
				Cell2
				Cell3
				Cell4
				Cell5
				Cell6
			var
				DN=0
				DS=0
				DE=0
				DW=0
				DNW=0
				DNE=0
				DSW=0
				DSE=0
				DEN=0
				DES=0
				DEE=0
				DEW=0
				DENW=0
				DENE=0
				DESW=0
				DESE=0
				Open=0
			Enter(mob/L)
				if(Open)
					return 1
				if(L.dir==NORTH&&DN)
					return
				if(L.dir==SOUTH&&DS)
					return
				if(L.dir==EAST&&DE)
					return
				if(L.dir==WEST&&DW)
					return
				if(L.dir==NORTHWEST&&DNW)
					return
				if(L.dir==SOUTHWEST&&DSW)
					return
				if(L.dir==SOUTHEAST&&DSE)
					return
				if(L.dir==NORTHEAST&&DNE)
					return
				return 1
			Exit(mob/L)
				if(Open)
					return 1
				if(L.dir==NORTH&&DEN)
					return
				if(L.dir==SOUTH&&DES)
					return
				if(L.dir==EAST&&DEE)
					return
				if(L.dir==WEST&&DEW)
					return
				if(L.dir==NORTHWEST&&DENW)
					return
				if(L.dir==SOUTHWEST&&DESW)
					return
				if(L.dir==SOUTHEAST&&DESE)
					return
				if(L.dir==NORTHEAST&&DENE)
					return
				return 1

		CaveFill
			icon='Caves.dmi'
			layer = 200
			mouse_opacity = 0
		Doors
			density=1
			mouse_opacity = 0
			var
				Message=null
				GoX=null
				GoY=null
				GoZ=null
				GoM=null
				Key=null
				isLocked=null
				isSZ=0
				EnOrEx=null
				locname=null
				GoOutDoor=1
			Bumped(mob/M)//atom/movable/Z)
				var/mob/player/A=M
				A.x = GoX
				A.y = GoY
				A.z = GoZ
				//A.IsOutside = GoOut

				//A.protect=GoSZ
		Sand
			icon='Sand.dmi'
			Entered(A)
				..()

		Beach
			icon='Beach.dmi'
			Entered(A)
				..()

		Snow
			icon='Snowfield.dmi'
			Entered(A)
				..()

		Grass
			icon='Grass.dmi'
			Entered(A)
				..()
		Plants
			icon='Plants.dmi'
		Rocks
			icon='Rock2020.dmi'
		Paths
			icon='Paths.dmi'
		BuildingExt
			icon='Buildings.dmi'
			var/Special=""
			Roof
			Shop_Symbols
				Barber
				Banker
				Chef
				Clothes
				Scrolls
				Vet
				Weapons
		Stadium
			icon='Stadium.dmi'
		Flags
			icon='Flags.dmi'
		Furniture
			icon='Furniture.dmi'
		VillageWalls
			icon='VillageWalls.dmi'
		Mountain
			icon='Mountain.dmi'
		Fence
			icon='Fence.dmi'
		Rock
			icon='Rock.dmi'
		ShallowWater
			icon='ShallowWater.dmi'
		Bridge
			icon='Bridge.dmi'
			layer=4
			Bridge2
				icon='Bridge2.dmi'
			Bridge3
				icon='Bridge Red.dmi'
			BridgeSnow
				icon='Bridge_Snow.dmi'
		Stairs
			icon='Stairs.dmi'
			layer=4
		Bridge2 //Obsolete
			icon='Bridge2.dmi'
			layer=4
		Water
			icon='Water.dmi'
			var
				isntWater=0
			New()
				/*switch(icon_state)
					if("1","16","019","024","M1","A1")//NW
						new/obj/Map/WaterEdge/NW(src)
					if("5","18","20","022","026","A2","A19","M3","Ani19")//NE
						new/obj/Map/WaterEdge/NE(src)
					if("M5","N3","WFC1","101","108B","A4")//SW
						new/obj/Map/WaterEdge/SW(src)
					if("M4","N1","WFC3","110B","A3")//SE
						new/obj/Map/WaterEdge/SE(src)
					if("4","17","025","A7","A13","A17","S7","E3","E8","M2","Ani7","Ani13","Ani17")//S
						new/obj/Map/WaterEdge/S(src)
					if("A8","S8","M10","A8","Ani10","N2","WFC2","102","109B")//N
						new/obj/Map/WaterEdge/N(src)
					if("2","15","027","A5","A14","A15","S5","E4","E6","M8","Ani5","Ani14","Ani15")//E
						new/obj/Map/WaterEdge/E(src)
					if("7","21","028","A6","A16","A18","S6","E5","E7","M9","Ani6","Ani16","Ani18")//W
						new/obj/Map/WaterEdge/W(src)
					if("10","023","031","M12","E2")//NWC
						new/obj/Map/WaterEdge/Corner/NW(src)
					if("12","14","032","M11")//NEC
						new/obj/Map/WaterEdge/Corner/NE(src)
					if("6","029","M6")//SWC
						new/obj/Map/WaterEdge/Corner/SW(src)
					if("3","030","M7")//SEC
						new/obj/Map/WaterEdge/Corner/SE(src)*/
				..()
#if TESTING
				return
#endif
				spawn(10)
					switch(icon_state)
						if("16","019","M1","18","20","N2","A19","M3","Ani19","M5","N3","WFC1","101","108B","A4","M4","N1","WFC3","110B","A3","103","102")//SE
							return
					if(loc)
						spawn(10)
							var/area/AR = loc
							if(!AR.Outdoor)
								if(AR.icon)
									Overlay = new/Overlay_Obj(AR.icon,AR.layer,0,0,AR.icon_state)
									overlays += Overlay
								WaterMain.contents += src
							else
								WaterOut.contents += src

			Entered(A)
				..()

		Waterfall
			icon='Waterfall.dmi'
			var/Shallow=0
			layer=4
			New()
				..()
#if TESTING
				return
#endif
				spawn(10)
					if(loc)
						var/area/AR = loc
						if(!AR.Outdoor)
							if(AR.icon)
								Overlay = new/Overlay_Obj(AR.icon,AR.layer,0,0,AR.icon_state)
								overlays += Overlay
							switch(icon_state)
								if("1","2","3","10","11","12","13","14","15","16","17","18","25","26","27","28","29","30","31","32","33")
									WaterMain.contents += src
							/*	if("1","2","3","26","27","28","32","33")
									WaterMain.contents += src*/
								else
									WaterFalls.contents += src
						else
							switch(icon_state)
								if("1","2","3","10","11","12","13","14","15","16","17","18","25","26","27","28","29","30","31","32","33")
									WaterOut.contents += src
								/*if("1","2","3","26","27","28","32","33")
									WaterOut.contents += src*/
								else
									WaterFallOut.contents += src

			Entered(A)
				..()

		TreePlaceholder
			icon='Diag.dmi'
			icon_state="Village"

		Tree
			icon='Tree1.dmi'
		Swamp
			icon='Swamp.dmi'

		RedWorld
			icon='Tsukiyomi.dmi'
		Decoration
			Building
				icon='Buildings.dmi'
			Furniture
				icon='Furniture.dmi'
			Scenery
				Plants
					icon='Plants.dmi'
				Rocks
					icon='Rock2020.dmi'
			Fence
				density=1
				icon='Fence.dmi'
			Bridges
				Bridge1
					icon='Bridge.dmi'
				Bridge2
					icon='Bridge2.dmi'
				Bridge3
					icon='Bridge_Red.dmi'