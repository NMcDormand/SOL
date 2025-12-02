proc
	Get_Rand_DirStep(var/atom/A, DENSECHECK = 1, MOBCHECK = 1)
		if(A)
			var/list/DIRS = list(NORTH,NORTHWEST,NORTHEAST,SOUTH,SOUTHWEST,SOUTHEAST,WEST,EAST)
			DIRS -= A.dir
			REDO
			if(length(DIRS))
				var/DIR = pick(DIRS)
				var/turf/Tile = get_step(A,DIR)
				if(!Tile)
					DIRS -= DIR
					goto REDO
				else
					if(DENSECHECK)
						if(Tile.density)
							DIRS -= DIR
							goto REDO
					if(MOBCHECK)
						for(var/atom/movable/B in Tile.contents)
							if(B.density)
								DIRS -= DIR
								goto REDO
					return Tile
/*Effect/Visual
	Hiraishin
		icon = 'Hiraishin.dmi'
		New()
			..()
			spawn(4)
				del src*/
mob
	var
		list/MarkedLocations = list()
		HiraishinMax = 1
		HiraishinAuto = 0
		HiraishinAutoDodge = 0
		HiraishinAutoDist = 1
		HiraishinBlock = 0
		HiraishinXP = 0
		HiraishinMXP = 20
		tmp
			Marked = 0
			list/MarkedMe = list()
			list/MarkedThings = list()
			list/MarkedTargets = list()
			HiraishinToggled = 0
			InHiraiBarrage = 0

	proc
		LearnHiraishinDanmaku()
			if(HiraishinMax >= 15)
				src<<"<b><font size=2>You've just learned <i>Hiraishin Danmaku</i>!</font></b>"
				new/obj/SkillCards/Ninjutsu/Special/HiraishinDanmaku(src)

		HiraishinPort(turf/LOC,atom/M,PCost=1)
			if(GENERICATTACKCHECK(src))
				return 0
			if(HiraishinToggled && PCost > HiraishinToggled)
				PCost = HiraishinToggled
			var/D = get_dist(LOC,src) - 10
			var/Cost = D * 250
			if(Cost < (3000*PCost))
				Cost = 3000*PCost
			if(Chakra >= Cost)
				Chakra -= Cost
				RefreshChakra()
				if(!usr)
					return
				if(Cost > 10000)
					usr.JutsuChakra(100)
				else
					usr.JutsuChakra(Cost*0.01);
				HiraishinUP(2)
				var/turf/HL = loc
				var/mob/IzanagiClone/M2 = new(loc)
				M2.appearance = appearance
				M2.name = name
				spawn(-1)
					animate(M2,alpha = 0, 2, 4)
					sleep(32)

					M2.loc = null
					spawn(30)
						if(M2)
							del M2
				HL.overlays += 'Hiraishin.dmi'
				spawn(4)
					HL.overlays -= 'Hiraishin.dmi'

				/*var/mob/IzanagiClone/IC = new(HL)
				IC.appearance = appearance

				IC.name = name
				IC.dir = dir
				spawn(-1)
					animate(IC,alpha = 0, 2, 4)
					sleep(8)
					IC.loc = null
					spawn(30)
						if(IC)
							del IC
							*/
				loc.loc.Exited(src)
				loc = LOC
				loc.loc.Entered(src)
				if(M)
					dir = get_dir(src, M)
				MoveUses["Hiraishin"]++
				#if DEBUGGING
				return
				#endif
				HiraishinToggled -= PCost
				if(HiraishinToggled<1)
					Cooldowns["Hiraishin"] = world.time+4000
					src << "Your body can no longer take the stress of the Hiraishin and is now recovering"
					HiraishinToggled = 0
				return 1
			else
				usr << "You do not have enough to Chakra to travel this far (Need:[Cost] Chakra)"
				return 0

		HiraishinUP(A)
			HiraishinXP += A
			if(HiraishinXP >= HiraishinMXP)
				if(HiraishinToggled == HiraishinMax)
					HiraishinToggled++
				HiraishinMax++
				HiraishinXP -= HiraishinMXP
				HiraishinMXP += 30

		HiraishinBlockCheck()
			if(protect||dead||Arena||KI_InMission)
				return 1
			else
				switch(ZCoord)
					if("Sound 5 Quest", "Hospital", "Inside", "Guild House", "Chuunin Fight", "Ninja Academy", "Jail", "Forest of Death", "Samehada")
						return 1
					if("Leaf Jail", "Mist Jail", "Sand Jail", "Cloud Jail", "Grass Jail", "Rock Jail", "Rain Jail", "Sound Jail")
						return 1
				return 0

		PortBlockCheck()
			if(protect||dead||Arena||KI_InMission)
				return 1
			else
				switch(ZCoord)
					if("Sound 5 Quest", "Hospital", "Inside", "Guild House", "Chuunin Fight", "Ninja Academy", "Jail", "Forest of Death", "Samehada")
						return 1
					if("Leaf Jail", "Mist Jail", "Sand Jail", "Cloud Jail", "Grass Jail", "Rock Jail", "Rain Jail", "Sound Jail")
						return 1
					else
						return 0