Map
	parent_type = /obj///atom/movable
	icon = null

	Darkness
		icon='dark.dmi'
		layer = MOB_LAYER+10
		mouse_opacity = 0
		var/Checking = 0
		New()
			..()
		proc/LightCheck()
			spawn(-1)
				Checking = 1
				while(Checking)
					var/light = 0
					for(var/obj/Jutsu/Shinsu/A in range(3,src))
						if(A.Activated)
							light=1
							break
						else
							if(get_dist(src,A)<=1)
								light=1
								break
					if(invisibility < 50)
						if(light)
							invisibility = 50
					else
						if(!light)
							invisibility = 0
					sleep(1)
					CHECK_TICK
				invisibility = 50
	Cell
		icon='Furniture.dmi'
		layer=254
		density=0
		Bars
			icon_state="101"
			Bottom
				density=1

		CellDoor
			icon_state="102o"
			Cell1
			Cell2
			Cell3
			Cell4
			Cell5
			Cell6

	Doors
		density=1
		layer=MOB_LAYER+100
		var
			Message=null
			GoX=null
			GoY=null
			GoZ=null
			GoM=null
			GoSZ=0
			GoOut=1
			GoEx=null
			Key=null
			KeyType=null
			list/GoReq=null
			Locked=null
			LockMsg
			locname=null
			Samehada = 0

		Cross(A)
			if(ismob(A))
				var/mob/M = A
				if(M.DamagedRecently||!M.client)
					return 0
				else
					return 1
			else
				return 0

		Crossed(PLAYER(A))//atom/movable/Z)
			var/Allowed=0
			if(!Locked)
				Allowed=1
			if(!Allowed && LockMsg)
				A<<LockMsg
				return
			if(Allowed)
				if(GoX==null||GoY==null||GoZ==null)
					A<<"Broken Door, please report"
					return
				if(A.loc.loc)
					A.loc.loc.Exited(A)
				A.loc = locate(GoX,GoY,GoZ)
				if(A.loc.loc)
					A.loc.loc.Entered(A)
				A.canfindrocks=GoOut
				A.protect=GoSZ
				if(Message)
					A << Message

		New()
			..()
			//name="Door"
			if(Samehada)
				if(!SamehadaDoor)
					redo
					sleep(100)
					if(!TreeList.len)
						goto redo
					var/mob/Hittable/Unresponsive/Training/Stump/Tree/TR = pick(TreeList)
					SamehadaDoor = TR.loc
					TR.HasDoor = 1
					TR.GoX = 394
					TR.GoY = 43
					TR.GoZ = 2
					TR.GoSZ = 0
					TR.GoOut = 1
				GoX = SamehadaDoor.x
				GoY = SamehadaDoor.y
				GoZ = SamehadaDoor.z
				GoOut = 1
				GoSZ = 0
			if(GoEx==2)
				var/turf/A=locate(GoX,GoY,GoZ)
				if(A.loc)
					locname=A.loc.name
				else
					locname=A.name
			else if(GoEx==1)
				if(loc.loc)
					locname=loc.loc.name
				else
					locname=loc.name

	Cliff
		density=1
		icon='Cliffs.dmi'
		New()
			..()
			name="Cliff"
			layer = MOB_LAYER- 1 + (world.maxy - y)/world.maxy
			if(loc.name=="Waterfall"||loc.name=="Stairs")
				density=0
				return
		Block
			name=null
		Top
			Corner
				NE
					dir=5
				SE
					dir=6
				NW
					dir=9
				SW
					dir=10
			E
				dir=4
			W
				dir=8
			S
				dir=2
			SW
				dir=10
			SE
				dir=6
			N
				dir=1
			NW
				dir=9
			NE
				dir=5
		Bottom
			S
				dir=2
			SW
				dir=10
			SE
				dir=6

	WaterEdge
		//icon='Diag.dmi'
		//icon_state="Water"
		New()
			..()
			layer=3
		Corner
			density=0
			//icon_state="WaterC"
			NE
				dir=5
			SE
				dir=6
			NW
				dir=9
			SW
				dir=10
		N
			dir=1
		E
			dir=4
		S
			dir=2
		W
			dir=8
		SW
			dir=10
		SE
			dir=6
		NW
			dir=9
		NE
			dir=5

	Foliage
		Tree
			Bottom
				//layer=10
				density = 1
				New()
					..()
					layer = MOB_LAYER + (world.maxy - y)/world.maxy
				var
					Health=100000
					HealthM=100000
					TX
					TY
				Tree_Beach
					icon='Tree_Beach.dmi'
				Tree_Cherry1
					icon='Tree_Cherry1.dmi'
				Tree_Cherry2
					icon='Tree_Cherry2.dmi'
				Tree_Dead1
					pixel_x=-16
					icon='Tree_Dead1.dmi'
				Tree_Dead2
					pixel_x=-16
					icon='Tree_Dead2.dmi'
				Tree_Dead3
					pixel_x=-16
					icon='Tree_Dead3.dmi'
				Tree_DeadW
					pixel_x=-16
					icon='Tree_DeadW2.dmi'
				Tree_Forest
					Alive
						icon='Tree_Forest1.dmi'
					Dead
						icon='Tree_Forest2.dmi'
				Tree_Huge
					icon='Tree_Huge.dmi'
				Tree_Mountain
					Alive
						pixel_x=-16
						icon='Tree_Mountain1.dmi'
					Dead
						pixel_x=-16
						icon='Tree_Mountain2.dmi'
					Dead2
						pixel_x=-16
						icon='Tree_Mountain1.dmi'
				Tree_Palm
					icon='Tree_Palm.dmi'
				Tree_Rain
					icon='Tree_Rain.dmi'
				Tree_Snow1
					icon='Tree_Snow1.dmi'
				Tree_Snow2
					icon='Tree_Snow1.dmi'
				Tree_Snow3
					icon='Tree_Snow1.dmi'
				Tree_Swamp
					icon='Tree_Swamp.dmi'

				Tree
					icon='Tree1.dmi'
					name="Tree"
					Stump
						Entrance

				Tree2
					name="Big Tree"
					icon='Tree2.dmi'

				Tree3
					name="New Tree"
					icon='Tree3.dmi'

			Top
				New()
					..()
					layer = MOB_LAYER + (world.maxy - y)/world.maxy
					layer+=1.01
				name = null
				layer=40
				density=0
				Tree1
					name="Tree"
					icon='Tree1Top.dmi'
				Tree2
					name="Big Tree"
					icon='Tree2Top.dmi'
				Tree3
					name="Big Tree"
					icon='Tree3Top.dmi'
				Tree_Beach
					name="Beach Tree"
					icon='Tree_BeachTop.dmi'
				Tree_Cherry1
					icon='Tree_Cherry1Top.dmi'
				Tree_Cherry2
					icon='Tree_Cherry2Top.dmi'
				Tree_Dead1
					pixel_x=-16
					icon='Tree_DeadTop1.dmi'
				Tree_Dead2
					pixel_x=-16
					icon='Tree_DeadTop2.dmi'
				Tree_Dead3
					pixel_x=-16
					icon='Tree_DeadTop3.dmi'
				Tree_Dead4
					pixel_x=-16
					icon='Tree_DeadTop4.dmi'
				Tree_DeadW
					pixel_x=-16
					icon='Tree_DeadTop2.dmi'
				Tree_Forest
					Alive
						name="Forest Tree"
						icon='Tree_Forest1Top.dmi'
					Dead
						name="Dead Tree"
						icon='Tree_Forest2Top.dmi'
				//Tree_Huge
					//icon='Tree_Huge.dmi'
				Tree_Mountain
					Alive
						icon='Tree_MountainTop1.dmi'
					Dead
						icon='Tree_MountainTop2.dmi'
					Dead2
						icon='Tree_MountainTop3.dmi'
				Tree_Palm
					Coconut
						icon='Tree_PalmCTop.dmi'
					NoNut
						icon='Tree_PalmTop.dmi'
				Tree_Rain
					icon='Tree_RainTop.dmi'
				Tree_Snow1
					icon='Tree_SnowTop1.dmi'
				Tree_Snow2
					icon='Tree_SnowTop2.dmi'
				Tree_Snow3
					icon='Tree_SnowTop3.dmi'
				Tree_Swamp
					icon='Tree_SwampTop.dmi'

	Cliff
		density=1
		icon='Cliffs.dmi'
		New()
			..()
			name="Cliff Ledge"
			layer = MOB_LAYER- 1 + (world.maxy - y)/world.maxy
		Block
			name=null
		Top
			Corner
				density=1
				NE
					dir=5
				SE
					dir=6
				NW
					dir=9
				SW
					dir=10
			E
				dir=4
			W
				dir=8
			S
				dir=2
			SW
				dir=10
			SE
				dir=6
			N
				dir=1
			NW
				dir=9
			NE
				dir=5
		Bottom
			S
				dir=2
			SW
				dir=10
			SE
				dir=6