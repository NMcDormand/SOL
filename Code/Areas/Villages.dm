mob/var
	InVillage
area/VillageBorders
	Cloud
		Inner
			Enter()
				if(istype(usr,/mob/player))
					if(usr.NinjaRank=="Academy Student")
						if(usr.reset) return
						else {usr<<"<b>You cannot leave the safety of the village until you pass the Genin Exam</b>"; usr.reset=1; spawn(20)usr.reset=0; return}
					else
						if(usr.InVillage!="Cloud")
							usr<<"<b>You are now entering the Village Hidden in Cloud.</b>"
							usr.InVillage="Cloud"; usr.ZCoord="Cloud Village"; usr.ZCoordProc(usr.ZCoord)
							if((usr.BingoBookAssociations["Cloud"])) usr.CheckEntry()
							if(usr.Fines[usr.Village]) usr.ArrestCheck()
						return 1
				else return 1
		Outer
			Enter()
				if(istype(usr,/mob/player))
					if(usr.InVillage=="Cloud")
						usr<<"<b>You are now leaving the Village Hidden in Cloud.</b>"
						usr.InVillage=null; usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)
						if((usr.BingoBookAssociations["Cloud"])) usr.CheckExit()
					return 144
				else return 1
	Grass
		Inner
			Enter()
				if(istype(usr,/mob/player))
					if(usr.NinjaRank=="Academy Student")
						if(usr.reset) return
						else {usr<<"<b>You cannot leave the safety of the village until you pass the Genin Exam</b>"; usr.reset=1; spawn(20)usr.reset=0; return}
					else
						if(usr.InVillage!="Grass")
							usr<<"<b>You are now entering the Village Hidden in Grass.</b>"
							usr.InVillage="Grass"; usr.ZCoord="Grass Village"; usr.ZCoordProc(usr.ZCoord)
							if((usr in BingoBook)) usr.CheckEntry()
						return 1
				else return 1
		Outer
			Enter()
				if(istype(usr,/mob/player))
					if(usr.InVillage=="Grass")
						usr<<"<b>You are now leaving the Village Hidden in Grass.</b>"
						usr.InVillage=null; usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)
					return 1
				else return 1
	Leaf
		Inner
			Enter()
				if(istype(usr,/mob/player))
					if(usr.NinjaRank=="Academy Student")
						if(usr.reset) return
						else {usr<<"<b>You cannot leave the safety of the village until you pass the Genin Exam</b>"; usr.reset=1; spawn(20)usr.reset=0; return}
					else
						if(usr.InVillage!="Leaf")
							usr<<"<b>You are now entering the Village Hidden in Leaves.</b>"
							usr.InVillage="Leaf"; usr.ZCoord="Leaf Village"; usr.ZCoordProc(usr.ZCoord)
							if((usr.BingoBookAssociations["Leaf"])) usr.CheckEntry()
							if(usr.Fines[usr.Village]) usr.ArrestCheck()
						return 1
				else return 1
		Outer
			Enter()
				if(istype(usr,/mob/player))
					if(usr.InVillage=="Leaf")
						usr<<"<b>You are now leaving the Village Hidden in Leaves.</b>"
						usr.InVillage=null; usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)
						if((usr.BingoBookAssociations["Leaf"])) usr.CheckExit()
					return 1
				else return 1
	Mist
		Inner
			Enter()
				if(istype(usr,/mob/player))
					if(usr.NinjaRank=="Academy Student")
						if(usr.reset) return
						else {usr<<"<b>You cannot leave the safety of the village until you pass the Genin Exam</b>"; usr.reset=1; spawn(20)usr.reset=0; return}
					else
						if(usr.InVillage!="Mist")
							usr<<"<b>You are now entering the Village Hidden in Mist.</b>"
							usr.InVillage="Mist"; usr.ZCoord="Mist Village"; usr.ZCoordProc(usr.ZCoord)
							if((usr.BingoBookAssociations["Mist"])) usr.CheckEntry()
							if(usr.Fines[usr.Village]) usr.ArrestCheck()
						return 1
				else return 1
		Outer
			Enter()
				if(istype(usr,/mob/player))
					if(usr.InVillage=="Mist")
						usr<<"<b>You are now leaving the Village Hidden in Mist.</b>"
						usr.InVillage=null; usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)
						if((usr.BingoBookAssociations["Mist"])) usr.CheckExit()
					return 1
				else return 1
	Rain
		Inner
			Enter()
				if(istype(usr,/mob/player))
					if(usr.NinjaRank=="Academy Student")
						if(usr.reset) return
						else {usr<<"<b>You cannot leave the safety of the village until you pass the Genin Exam</b>"; usr.reset=1; spawn(20)usr.reset=0; return}
					else
						if(usr.InVillage!="Rain")
							usr<<"<b>You are now entering the Village Hidden in the Rain.</b>"
							usr.InVillage="Rain"; usr.ZCoord="Rain Village"; usr.ZCoordProc(usr.ZCoord)
							if((usr in BingoBook)) usr.CheckEntry()
						return 1
				else return 1
		Outer
			Enter()
				if(istype(usr,/mob/player))
					if(usr.InVillage=="Rain")
						usr<<"<b>You are now leaving the Village Hidden in the Rain.</b>"
						usr.InVillage=null; usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)
					return 1
				else return 1
	Rock
		Inner
			Enter()
				if(istype(usr,/mob/player))
					if(usr.NinjaRank=="Academy Student")
						if(usr.reset) return
						else {usr<<"<b>You cannot leave the safety of the village until you pass the Genin Exam</b>"; usr.reset=1; spawn(20)usr.reset=0; return}
					else
						if(usr.InVillage!="Rock")
							usr<<"<b>You are now entering the Village Hidden in the Rocks.</b>"
							usr.InVillage="Rock"; usr.ZCoord="Rock Village"; usr.ZCoordProc(usr.ZCoord)
							if((usr.BingoBookAssociations["Rock"])) usr.CheckEntry()
							if(usr.Fines[usr.Village]) usr.ArrestCheck()
						return 1
				else return 1
		Outer
			Enter()
				if(istype(usr,/mob/player))
					if(usr.InVillage=="Rock")
						usr<<"<b>You are now leaving the Village Hidden in the Rocks.</b>"
						usr.InVillage=null; usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)
						if((usr.BingoBookAssociations["Rock"])) usr.CheckExit()
					return 1
				else return 1
	Sand
		Inner
			Enter()
				if(istype(usr,/mob/player))
					if(usr.NinjaRank=="Academy Student")
						if(usr.reset) return
						else {usr<<"<b>You cannot leave the safety of the village until you pass the Genin Exam</b>"; usr.reset=1; spawn(20)usr.reset=0; return}
					else
						if(usr.InVillage!="Sand")
							usr<<"<b>You are now entering the Village Hidden in Sand.</b>"
							usr.InVillage="Sand"; usr.ZCoord="Sand Village"; usr.ZCoordProc(usr.ZCoord)
							if((usr.BingoBookAssociations["Sand"])) usr.CheckEntry()
							if(usr.Fines[usr.Village]) usr.ArrestCheck()
						return 1
				else return 1
		Outer
			Enter()
				if(istype(usr,/mob/player))
					if(usr.InVillage=="Sand")
						usr<<"<b>You are now leaving the Village Hidden in Sand.</b>"
						usr.InVillage=null; usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)
						if((usr.BingoBookAssociations["Sand"])) usr.CheckExit()
					return 1
				else return 1
	Sound
		Inner
			Enter()
				if(istype(usr,/mob/player))
					if(usr.NinjaRank=="Academy Student")
						if(usr.reset) return
						else {usr<<"<b>You cannot leave the safety of the village until you pass the Genin Exam</b>"; usr.reset=1; spawn(20)usr.reset=0; return}
					else
						if(usr.InVillage!="Sound")
							usr<<"<b>You are now entering the Village Hidden in Sound.</b>"
							usr.InVillage="Sound"; usr.ZCoord="Sound Village"; usr.ZCoordProc(usr.ZCoord)
							if((usr in BingoBook)) usr.CheckEntry()
						return 1
				else return 1
		Outer
			Enter()
				if(istype(usr,/mob/player))
					if(usr.InVillage=="Sound")
						usr<<"<b>You are now leaving the Village Hidden in Sound.</b>"
						usr.InVillage=null; usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)
					return 1
				else return 1