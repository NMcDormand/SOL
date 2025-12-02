turf/var
	Lighting
obj/ArenaChallengeSpawns
	River
		r1
		r2
		r3
		r4
		r5
	Islands
		i1
		i2
	Tropical
		t1
		t2
		t3
		t4
		t5
	Desert
		d1
		d2
		d3
		d4
		d5
	Mountain
		m1
		m2
		m3
		m4
		m5
	Warehouse
		w1
		w2
		w3
		w4
		w5
		w6
	Forest
		f1
		f2
		f3
		f4
		f5
turf/NewOnes
	icon = 'ExtraNewTurfs.dmi'
	Stonework
		icon_state = "Stonework"
	BWtile
		icon_state = "bwtile"
	StoneFloor
		icon_state = "stonefloor"
	BrickWall01
		icon_state = "bwall"
	BrickWall02
		icon_state = "brickwall"
	Door
		icon_state = "Door"
	BrickFloor
		icon_state = "Brickfloor"
	CrystalBrick
		icon_state = "crystalbrick"
	Granite
		icon_state = "granitetile"
	Marble01
		icon_state = "marble"
	Marble02
		icon_state = "marble2"
	Steps2
		icon_state = "Steps"
	DirtyTiles
		icon_state = "dirtytiles"
	MatrixDoor
		icon_state = "MD"
	MatrixDoorOpen
		icon_state = "MDopen"
	MatrixDoorOpening
		icon_state = "MDopening"
	MatrixDoorClosing
		icon_state = "MDclosing"
	GreyTile
		icon_state = "greytile"

turf/Flooring
	Outside
		Grass2
			icon = 'ExtraNewTurfs.dmi'
			icon_state = "Grass"
		Grass
			icon = 'Landscapes.dmi'
			icon_state = "grass"
		DarkGrass
			icon = 'Landscapes.dmi'
			icon_state = "darkgrass"
		Lagoon
			icon = 'Landscapes.dmi'
			icon_state = "lagoon"
		Water
			icon = 'Landscapes.dmi'
			icon_state = "water2"
			density=0
		Sand
			icon = 'Landscapes.dmi'
			icon_state = "sand"
		Sand2
			icon = 'Sand.dmi'
			icon_state = "sand"
		BrownGrass
			icon = 'Landscapes.dmi'
			icon_state = "browngrass"
		Dirt
			icon = 'Landscapes.dmi'
			icon_state = "dirt"
		BloodPond
			icon = 'turfs.dmi'
			icon_state = "bloodpond"
//-----------------------------------
turf/Waterfalls
	New
		icon='NewWaterfall.dmi'
		W1
			icon_state="1"
		W2
			icon_state="2"
		W3
			icon_state="3"
		W4
			icon_state="4"
		W5
			icon_state="5"
		W6
			icon_state="6"
		W7
			icon_state="7"
		W8
			icon_state="8"
		W9
			icon_state="9"

	icon='waterfall.dmi'
	wFG
		icon_state="1"
	Bottom
		icon_state="6"
	BottomL
		icon_state="3"
	BottomR
		icon_state="4"
	Top1
		icon_state="2"
	Top2
		icon_state="5"
	wBG
		icon='turfs2.dmi'
		icon_state="waterfall"
	Boulder
		icon='Mountain.dmi'
		icon_state="waterb"
		density=1
obj
	Map
		Arena
			icon='Arena.png'
			density=1
			bound_width = 192
			bound_height = 160
turf/Buildings
	Arena
		ArenaEntry
			Enter()
				if(istype(usr,/mob/player))
					if(usr.NinjaRank == "Academy Student") {usr<<"Only licensed Ninja can enter this event"; return}
					else if(EventOpen)
						usr.loc=locate(793,4,2)
						EventParticipants+=usr
						usr.protect=1
						EventCount++
					else {usr<<"You can only enter here when a tournament is being hosted."; return}
		ArenaExit
			Enter()
				usr.ExitArena()
				usr.protect=0
				EventParticipants-=usr
				if(EventCount)
					EventCount--
	JapaneseStyle
		icon='NewBuildings.dmi'
		Walls
			layer=MOB_LAYER-1
			density=1
			W01
				icon_state="01"
				density=0
			W02
				icon_state="02"
			W03
				icon_state="03"
				density=0
			W04
				icon_state="04"
			W05
				icon_state="05"
				density=0
			W06
				icon_state="06"
		Entrance
			density=0
			layer=MOB_LAYER+1
			Door1
				icon_state="door1"
				layer=MOB_LAYER+1
			Door2
				icon_state="door2"
				layer=MOB_LAYER+1
			E01
				icon_state="19"
				layer=MOB_LAYER-1
			E02
				icon_state="20"
				layer=MOB_LAYER-1
			E03
				icon_state="21"
				density=1
			E04
				icon_state="22"
			E05
				icon_state="23"
			E06
				icon_state="24"
				density=1
			E07
				icon_state="25"
				density=1
			E08
				icon_state="26"
			E09
				icon_state="27"
			E10
				icon_state="28"
				density=1
			E11
				icon_state="29"
				density=1
			E12
				icon_state="30"
			E13
				icon_state="31"
			E14
				icon_state="32"
				density=1
//----------AREA
			E16
				icon_state="33"
			E17
				icon_state="34"
			E18
				icon_state="35"
			E19
				icon_state="36"
			E20
				icon_state="37"
	icon='Buildings.dmi'
	Walls
		density=1
		Jail
			density=0
			layer=MOB_LAYER+1
			icon='Jail.dmi'
			Bars
				icon_state="bars"
				Enter(mob/M)
					if(istype(M,/mob)&&M.VillageJailed) return 1
					else return 0
			Door
				Enter(mob/M)
					if(istype(M,/mob)&&M.VillageJailTime&&!M.Escaping)
						return 0
					else
						M.VillageJailed=0
						var/obj/d=M.JailDoor
						if(d) d.icon_state="door"
						return 1
		Door
			density=0
			icon_state = "door"
		Wall2
			icon_state = "2"
		Wall1
			icon_state = "9a"
		Wall3
			icon_state = "3"
		Wall4
			icon_state = "4"
		Wall5
			icon_state = "5"
		Wall6
			icon_state = "6"
		Wall7
			icon_state = "7"
		Wall8
			icon_state = "8"
		Wall8Corner1
			icon_state = "8corner1"
		Wall8Corner2
			icon_state = "8corner2"
		Wall8Corner3
			icon_state = "8corner3"
		Wall8Corner4
			icon_state = "8corner4"
		Wall9
			icon_state = "9"
		WallTop
			icon_state = "walltop"
			nondense
				density=0
				icon_state = "walltop"
		Wall10
			icon_state = "japanesewall"
			END
				icon_state = "japanesewallEND"
		Stonework
			icon_state = "Stonework"
		BrickWall01
			icon_state = "bwall"
		BrickWall02
			icon_state = "brickwall"
		Door
			icon_state = "door2"
		CrystalBrick
			icon_state = "crystalbrick"
		Blank_Jail
			icon=null
			density=0
			Enter(mob/M)
				if(istype(M,/mob)&&M.VillageJailed) return 0
				else return 1
		Blank
			icon=null
			Enter()
				return
		Blank_Opaque
			icon=null
			opacity = 1
			Enter()
				return
		Blank_Opaque2
			icon=null
			opacity = 1
			density=0
		Black_Opaque
			//name="Void"
			icon = 'stadium.dmi'
			icon_state = "black"
			opacity = 1
			Cross()
				return
		Black
			icon = 'stadium.dmi'
			icon_state = "black"
			Cross()
				return
	Roofs
		layer=7
		Roof1
			icon_state = "roofmain"
			density=1
		Roof2
			icon_state = "roofover"
			density=0
			Roof2a
				icon_state = "roofover2"
			Roof2b
				icon_state = "roofover3"

	Floors
		Floor01
			icon_state = "floor_1"
		Floor02
			icon_state = "floor_2"
		Floor03
			icon_state = "floor_3"
			Floor03a
				icon_state = "floor_3a"
			Floor03b
				icon_state = "floor_3b"
			Floor03c
				icon_state = "floor_3c"
			Floor03d
				icon_state = "floor_3d"
		Floor04
			icon_state = "floor_4"
		Floor05
			icon_state = "floor_5"
		Floor06
			icon_state = "floor_6"
		Floor07
			icon_state = "floor_7"
		Floor08
			icon_state = "floor_8"
		Floor09
			icon_state = "floor_9"
		BWtile
			icon_state = "bwtile"
		StoneFloor
			icon_state = "stonefloor"
		BrickFloor
			icon_state = "Brickfloor"
		Marble01
			icon_state = "marble"
		Marble02
			icon_state = "marble2"
		DirtyTiles
			icon_state = "dirtytiles"
		GreyTile
			icon_state = "greytile"

	Dark1
		mouse_opacity = 0
		icon='dark.dmi'
		density=0
		layer=MOB_LAYER+10
	Dark2
		mouse_opacity = 0
		icon='dark.dmi'
		icon_state="FoD"
		layer=MOB_LAYER+10
		Lighting=1
		density=0
	Signs
		density=1
		MissionRankSigns
			density=0
			DMission
				icon='DRankMat.png'
			CMission
				icon='CRankMat.png'
			BMission
				icon='BRankMatNew.png'
			AMission
				icon='ARankMat.png'
			SMission
				icon='SRankMatNew.png'
		ChuuninBanner
			icon='Chuunin.png'
		AcademyBanner
			icon='Academy.png'
		icon='Buildings.dmi'
		Weapons
			icon_state="Weapons"
		Barber
			icon_state="Barber"
		Scrolls
			icon_state="Scrolls"
		Vet
			icon_state="Vet"
		Hospital
			icon_state="Hospital"
		Chef
			icon_state="Chef"
		Clothes
			icon_state="Clothes"
		Banker
			icon_state="Banker"
turf/Fencing
	icon = 'Fence.dmi'
	density=1
	F01
		icon_state="1"
	F02
		icon_state="2"
	F03
		icon_state="3"
	F04
		icon_state="4"
		density=0
		layer=MOB_LAYER+1
	F05
		icon_state="5"
		opacity=1
		layer=12
	F06
		icon_state="6"
	F07
		icon_state="7"
	F08
		icon_state="8"
	F09
		icon_state="9"
	F10
		icon_state="10"
	F11
		icon_state="11"
	F12
		icon_state="12"
turf/Landscape
	Torches
		icon='Buildings.dmi'
		Torch1
			density = 1
			icon_state="torch1"
		Torch2
			layer=5
			icon_state="torch2"
	SandDune
		icon='Sand.dmi'
		S1
			icon_state="sanddune1"
		S2
			icon_state="sanddune2"
		S3
			icon_state="sanddune3"
		S4
			icon_state="sanddune4"
	PottedPlant1
		icon = 'Trees.dmi'
		icon_state = "pp1"
		density=1
	PottedPlant2
		icon = 'Trees.dmi'
		icon_state = "pp2"
		density=1
	PottedPlant3
		icon = 'HousePlant.png'
		density=1
	NiceFlowers1
		icon = 'Trees.dmi'
		icon_state = "niceflowers1"
	NiceFlowers2
		icon = 'Trees.dmi'
		icon_state = "niceflowers2"
	RoseBush
		icon = 'Trees.dmi'
		icon_state = "roses"
	Path1
		icon = 'Landscapes.dmi'
		icon_state = "Cobble"
	Path4
		icon = 'Landscapes.dmi'
		icon_state = "Cobble2"
	Stairs
		icon = 'Landscapes.dmi'
		icon_state = "Stairs"
	Stairs2
		icon = 'Landscapes.dmi'
		icon_state = "Stairs2"
	Stairs3
		icon = 'Landscapes.dmi'
		icon_state = "Stairs3"
	Path2
		icon = 'turfs2.dmi'
		icon_state = "brick path 2"
	Path3
		icon = 'turfs2.dmi'
		icon_state = "stone path 2"
	Door
		icon = 'Buildings.dmi'
		icon_state = "door"
	Bridge2
		icon = 'Bridge.dmi'
		icon_state = "2"
	Bridge1
		icon = 'Bridge.dmi'
		icon_state = "1"
	Bridge3
		icon = 'Bridge.dmi'
		icon_state = "3"
	Pen01
		icon = 'Fence.dmi'
		icon_state="chik"
		density=1
	Pen02
		icon = 'Fence.dmi'
		icon_state="chik2"
		density=1
	Pen03
		icon = 'Fence.dmi'
		icon_state="chik3"
		density=1
	Pen04
		icon = 'Fence.dmi'
		icon_state="chik4"
		density=1
	Pen05
		icon = 'Fence.dmi'
		icon_state="chik5"
		density=1
	Pen06
		icon = 'Fence.dmi'
		icon_state="chik6"
		density=1
	Pen07
		icon = 'Fence.dmi'
		icon_state="chik7"
		density=1
	Pen08
		icon = 'Fence.dmi'
		icon_state="chik8"
		density=1
	Spiked_Fecnce
		icon = 'Fence.dmi'
		icon_state="Top"
		density=1
	Bench1
		icon = 'turfs2.dmi'
		icon_state="bench1"
		density=1
	Bench2
		icon = 'turfs2.dmi'
		icon_state="bench2"
		density=1
	TumbleWeed
		icon = 'Materials.dmi'
		icon_state = "tumbleweed"
	Symbols
		density=1
		layer=MOB_LAYER+3
		Small
			icon='SmallSymbols.dmi'
			LeafSymbol
				icon_state="leaf"
			SoundSymbol
				icon_state="sound"
			CloudSymbol
				icon_state="cloud"
			MistSymbol
				icon_state="mist"
			WindSymbol
				icon_state="sand"
			GrassSymbol
				icon_state="grass"
			RainSymbol
				icon_state="rain"
			RockSymbol
				icon_state="rock"
			WaterfallSymbol
				icon_state="waterfall"
			UchihaSymbol
				icon_state="uchiha"
		LeafSymbol
			icon = 'Leaf.png'
		SoundSymbol
			icon = 'Sound.png'
		CloudSymbol
			icon = 'Cloud.png'
		MistSymbol
			icon = 'Mist.png'
		WindSymbol
			icon = 'Sand.png'
		GrassSymbol
			icon = 'Grass.png'
		RainSymbol
			icon = 'Rain.png'
		WaterfallSymbol
			icon = 'Waterfall.png'
		RockSymbol
			icon = 'Stone.png'

turf/Shallows
	icon='Shallows.dmi'
	Top
		icon_state = "South"
	Bottom
		icon_state = "North"
	Left
		icon_state = "West"
	Right
		icon_state = "East"
	TopRight
		C1
			icon_state = "C1"
		C2
			icon_state = "C2"
		C3
			icon_state = "C3"
	TopLeft
		C1
			icon_state = "CA"
		C2
			icon_state = "CB"
		C3
			icon_state = "CC"
	BottomRight
		C1
			icon_state = "BR1"
		C2
			icon_state = "BR2"
		C3
			icon_state = "BR3"
	BottomLeft
		C1
			icon_state = "BL1"
		C2
			icon_state = "BL2"
		C3
			icon_state = "BL3"

turf/Shoreline
	Grass
		icon='GrassyShore.dmi'
		Shore1
			icon_state = "GrassShore1"
		Shore2
			icon_state = "GrassShore2"
		Shore3
			icon_state = "GrassShore3"
		Shore4
			icon_state = "GrassShore4"
		Shore5
			icon_state = "GrassShore5"
		Shore6
			icon_state = "GrassShore6"
		Shore7
			icon_state = "GrassShore7"
		Shore8
			icon_state = "GrassShore8"
		Shore9
			icon_state = "GrassShore9"
		Shore10
			icon_state = "GrassShore10"
		Shore11
			icon_state = "GrassShore11"
		Shore12
			icon_state = "GrassShore12"
	Sand
		icon='SandyShore.dmi'
		SandWood1
			icon_state = "SandWood 1"
		SandWood2
			icon_state = "SandWood 2"
		Top
			icon_state = "south"
		Bottom
			icon_state = "north"
		Left
			icon_state = "west"
		Right
			icon_state = "east"
		TopRight
			C1
				icon_state = "C1"
			C2
				icon_state = "C2"
		TopLeft
			C1
				icon_state = "CA"
			C2
				icon_state = "CB"
		BottomRight
			C1
				icon_state = "CX"
			C2
				icon_state = "CY"
		BottomLeft
			C1
				icon_state = "C8"
			C2
				icon_state = "C9"

turf/Decor
	GeninRoom
		icon='Exam.png'
	icon = 'Furniture.dmi'
	FirePlace
		icon_state="38"
		density=1
	Desk
		icon_state="56"
		density=1
	Chair
		icon_state="88"
		density=0
	LeftDesk
		icon_state = "ldesk"
		density=1
	MiddleDesk
		icon_state = "mdesk"
		density=1
	RightDesk
		icon_state = "rdesk"
		density=1
	TopDesk
		icon_state = "64"
		density=1
	MiddleDeskVert
		icon_state = "65"
		density=1
	BottomDesk
		icon_state = "66"
		density=1
	Throne
		icon='Furniture.dmi'
		icon_state="42"
turf/Trees
	Tree01_1
		density=0
		layer=MOB_LAYER+1
		icon='Trees.dmi'
		icon_state="tree2"
	Tree01_2
		icon='Trees.dmi'
		icon_state="tree1"
		density=1
	TreeStump
		density=1
		layer=MOB_LAYER+2
//-------------------------------------------------------------------------------------------------------------
turf
	Mountain
		Mountain
			icon = 'Mountain.dmi'
			icon_state = "center"
		MountainWall
			icon = 'Mountain.dmi'
			icon_state = "center"
			density=1
		WaterfallRoof
			icon = 'Mountain.dmi'
			icon_state = "waterfall"
			density=1
		Boulder
			icon='Mountain.dmi'
			icon_state="boulder"
			density=1
		MtPeak
			icon='Mountain.dmi'
			icon_state="7"
			density=0
		MtFoot
			icon='Mountain.dmi'
			icon_state="8"
			density=0

//-------------------------------------------------------------------------------------------------------------

turf/var/door
//--------------------------------------------------------------------------------------------------------
//--------------Plush-----------------------
turf/Plush
	icon='newturfs.dmi'
	Carpet01
		icon_state="carpet1"
	Clock
		icon_state="clock"
		density=1
	Hardwood01
		icon_state="hardwood1"
	Hardwood02
		icon_state="hardwood2"
	HouseWall01
		icon_state="housewall"
		density=1
	HouseWall02
		icon_state="housewall2"
		density=1
	HouseWall03
		icon_state="housewall3"
		density=1
	HouseWall_middle
		icon_state="housewallMIDDLE"
		density=1
	HouseWall04
		icon_state="housewall4"
		density=1
	HouseWallTop
		icon_state="housewalltop"
		density=1
	HouseWallRight
		icon_state="housewallleft"
		density=1
	HouseWallLeft
		icon_state="housewallright"
		density=1
	HouseWallBottom
		icon_state="housewallbottom"
		density=1
	KonohaBed
		icon='Bed.png'
		density=1
//--------------Tech-----------------------
	Tech
		icon = 'tech.dmi'
		density = 1

		AndroidPod01
			icon_state = "AndroidPod01"
		AndroidPod02
			icon_state = "AndroidPod02"
		AndroidPod03
			icon_state = "AndroidPod03"
		AndroidPod04
			icon_state = "AndroidPod04"
		AndroidPod05
			icon_state = "AndroidPod05"

		CellPod01
			icon_state = "cellpod01"
		CellPod02
			icon_state = "cellpod02"
		CellPod03
			icon_state = "cellpod03"
		CellPod04
			icon_state = "cellpod04"
		CellPod05
			icon_state = "cellpod05"
		CellPod06
			icon_state = "cellpod06"
		CellPod07
			icon_state = "cellpod07"
		CellPod08
			icon_state = "cellpod08"

		CompDual
			icon_state = "compdual"
		compleft
			icon_state = "compleft"
		compright
			icon_state = "compright"
		compdown
			icon_state = "compdown"

		ChairUp
			density=0
			icon_state = "chairup"
		ChairDown
			density=0
			icon_state = "chairdown"
		ChairLeft
			density=0
			icon_state = "chairleft"
		ChairRight
			density=0
			icon_state = "chairright"

		Elevator
			icon_state = "elevator"

		Barrel
			icon_state = "barrel"

		SubjectWindow1
			icon_state = "window1"
		SubjectWindow2
			icon_state = "window2"
		SubjectWindow3
			icon_state = "window3"
		SubjectWindow4
			icon_state = "window4"
		SubjectWindow5
			icon_state = "window5"
		SubjectWindow6
			icon_state = "window6"
		SubjectWindow7
			icon_state = "window7"
		SubjectWindow8
			icon_state = "window8"
		SubjectWindow9
			icon_state = "window9"
