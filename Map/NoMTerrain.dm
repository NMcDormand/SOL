area
	var
		Cat=0
		Outdoor=1
		SpnAble=1
	Entered(atom/O)
		.=..()
		if(isobj(O))
			return
		if(istype(O,/mob/player))
			var/mob/player/M=O
			M.ZCoord="[name]"
	Indoor
		Outdoor=0
		Academy
		ChuDone
		ChuEx
		Arena
			ArenaD
				icon='Caves.dmi'
				icon_state="Darkness"
				layer=255

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
			Entered(atom/O)
				..()

			Exited(atom/O)
				..()

			Cloud
			Grass
			Leaf
			Mist
			Rain
			Rock
			Sand
			Sound
			Waterfall

	Outdoor
		icon='Floods.dmi'
		icon_state="Village"
		layer=0
		Cat=1

		var
			EOW //East, West, Central
			Temperature
			Weather
		Locations
			//icon='Diag.dmi'
			//icon_state="WaterC2"
		Desert
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
		Mountain
			//icon='Diag.dmi'
			//icon_state="Mountain"
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
		NoGo
			name="Outdoor"
			SpnAble=0
			//icon='Diag.dmi'
			//icon_state="NoGo"
		Village
			//icon='Diag.dmi'
			//icon_state="Village"
			var
				Active=0
				ActiveS=0
				Village=""
			New()
				..()
				if(name=="Mist Village")
					for(var/turf/T in contents)
						T.overlays+=/turf/overlay/Fog

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
			..()

		Exited(atom/O)
			if(istype(O,/mob/player))
				var/mob/player/M=O
				M.client.images += image
				M.InBuilding=0
			..()

		Sound
			name="Sound Village"
		Sound2
			name="Sound Village"
		Cloud
			name="Cloud Village"
		Leaf
			name="Leaf Village"
		Leaf2
			name="Leaf Village"
		Leaf3
			name="Leaf Village"
		Rain
			name="Rain Village"
		Sand
			name="Sand Village"
		Grass
			name="Grass Village"
		Rock
			name="Rock Village"
		Rock
			name="Rock Village"
		Waterfall
			name="Waterfall Village"
		Waterfall2
			name="Waterfall Village"
		Mist1
			name="Mist Village"

	Cave
		Outdoor=0
		icon='Caves.dmi'
		icon_state="Darkness"
		layer=255
		FOD
		NoGo
			//name="Outdoor"
			SpnAble=0
			//icon='Diag.dmi'
			//icon_state="NoGo"
			Samehada
obj
	usable
		var
			inUse=null
		Hospitalbed2
			icon='Hospitalbed.dmi'
			icon_state="secondhead"
		TestPaper
			icon='TestPaper.dmi'
		TestPaper2
			icon='TestPaper.dmi'

turf
	overlay
		Fog
			icon='Suitons.dmi'
			icon_state="Mist Fog"
			layer=255
	terrain
		New()
			..()
		//Entered()
			//var/obj/Map/A=locate(/obj/Map/Cliff/Top)
		//nom
		Opaque
			opacity=1
			density=1
		Density
			density=1
			layer=255
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
			layer=255
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
			layer=255
			mouse_opacity = 0
		Doors
			density=1
			layer=256
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
			icon='Rocks.dmi'
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
				spawn(10)
					WaterMain.contents += src
			Entered(A)
				..()
		Waterfall
			icon='Waterfall.dmi'
			var/Shallow=0
			layer=4

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