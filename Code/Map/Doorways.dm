atom/movable/var/DoorPassageAllowed = 0
turf/DoorWays
	Cross(mob/A)
		if(ismob(A))
			if(A.reaper || !A.client && !A.DoorPassageAllowed)
				return
		if(isobj(A))
			return
		.=..()

	Enter(mob/user)
		if(ismob(user))
			if(user.DoorPassageAllowed)
				user.DoorPassageAllowed = 0
				return 1
			if(!user.client || user.reaper || user.firing)
				return
			else//if(user.client)
				var/mob/player/U = user
				if(U.Familiar)
					spawn(-1)
						var/mob/Hittable/Responsive/Animal/Pet/A=U.Familiar
						if(A.Status == STATUS_FOLLOW)
							if(get_dist(U,A) < 16)
								A.DoorPassageAllowed++
								while(get_dist(A,src)>1)
									step_to(A,src)
									sleep(A.movespeed)
								step_towards(A,src)
								A.DogFollow(U)
				if(U.MasterBunshinList.len)
					for(var/mob/A in U.MasterBunshinList)
						spawn(-1)
							if(A.Status == STATUS_FOLLOW)
								if(get_dist(U,A) < 16)
									A.DoorPassageAllowed++
									while(get_dist(A,src)>1 && A)
										step_to(A,src)
										sleep(A.movespeed)
									if(A)
										step_towards(A,src)
										A.CloneFollow(U)
				if(U.EdoCloneList.len)
					for(var/mob/Hittable/Command/EdoClone/A in U.EdoCloneList)
						spawn(-1)
							if(A.Status == STATUS_FOLLOW)
								if(get_dist(U,A) < 16)
									A.DoorPassageAllowed++
									while(get_dist(A,src)>1)
										step_to(A,src)
										sleep(A.movespeed)
									step_towards(A,src)
									A.EdoFollow(U)
				return 1

	ProfessionHuts
		SwordNin
			Entry
				Enter()
					.=..();if(. && usr)
						if(usr.firing)return
						usr.canfindrocks=0; usr.protect=1
						usr.loc = locate(276,4,2)
						usr.ZCoord="Inside"; usr.ZCoordProc(usr.ZCoord)

			Exit
				Enter()
					.=..();if(. && usr)
						usr.canfindrocks=1; usr.protect=0
						usr.loc = locate(443,71,1)
						usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)

		SensoryNin
			Entry
				Enter()
					.=..();if(. && usr)
						if(usr.firing)return
						if(usr.reaper) return
						usr.canfindrocks=0; usr.protect=1
						usr.loc = locate(370,6,2)
						usr.ZCoord="Inside"; usr.ZCoordProc(usr.ZCoord)

			Exit
				Enter()
					.=..();if(. && usr)
						usr.canfindrocks=1; usr.protect=0
						usr.loc = locate(785,48,1)
						usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)

		SandNin
			Entry
				Enter()
					.=..();if(. && usr)
						if(usr.firing)return
						if(usr.reaper) return
						usr.canfindrocks=0; usr.protect=1
						usr.loc = locate(294,4,2)
						usr.ZCoord="Inside"; usr.ZCoordProc(usr.ZCoord)

			Exit
				Enter()
					.=..();if(. && usr)
						if(usr.firing)return
						usr.canfindrocks=1; usr.protect=0
						usr.loc = locate(54,72,1)
						usr.InVillage="Sand"; usr.ZCoord="Sand Village"; usr.ZCoordProc(usr.ZCoord)

		WindNin
			Entry
				Enter()
					.=..();if(. && usr)
						if(usr.firing)return
						if(usr.reaper) return
						usr.canfindrocks=0; usr.protect=1
						usr.loc = locate(321,4,2)
						usr.ZCoord="Inside"; usr.ZCoordProc(usr.ZCoord)

			Exit
				Enter()
					.=..();if(. && usr)
						usr.canfindrocks=1; usr.protect=0
						usr.loc = locate(945,26,1)
						usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)


		AssassinNin
			CliffEntry_Bottom
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(276,19,2)

			CliffExit_Bottom
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(711,542,1)

			CliffEntry_Top
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(270,43,2)

			CliffExit_Top
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(708,556,1)

			Entry
				Enter()
					.=..();if(. && usr)
						if(usr.firing)return
						if(usr.reaper) return
						usr.canfindrocks=0; usr.protect=1
						usr.loc = locate(306,4,2)
						usr.ZCoord="Inside"; usr.ZCoordProc(usr.ZCoord)

			Exit
				Enter()
					.=..();if(. && usr)
						usr.canfindrocks=1; usr.protect=0
						usr.loc = locate(712,551,1)
						usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)


	Hospital
		Leaf
			Entry
				Enter()
					.=..();if(. && usr)
						if(usr.firing)return
						if(!usr.BingoBookAssociations) usr.BingoBookAssociations=new()
						if(usr.BingoBookAssociations["Leaf"]||usr.icon_state=="seals") return
						if(usr.reaper) return
						usr.canfindrocks=0; usr.protect=1
						usr.loc = locate(96,4,2)
						usr.ZCoord="Hospital"; usr.ZCoordProc(usr.ZCoord)

			Exit
				Enter()
					.=..();if(. && usr)
						if(usr.mapon)
							for(var/obj/minimap/M in usr.client.screen) M.invisibility=0
						if(usr)
							usr.canfindrocks=1; usr.protect=0
							if(usr.RecentlySpawned) {usr.RecentlySpawned=0; usr.RevengeProtect=1; spawn(100) usr.RevengeProtect=0}
							usr.loc = locate(424,142,1)
							usr.ZCoord="Leaf Village"; usr.InVillage="Leaf"; usr.ZCoordProc(usr.ZCoord)

		Rock
			Entry
				Enter()
					.=..();if(. && usr)
						if(usr.firing)return
						if(!usr.BingoBookAssociations) usr.BingoBookAssociations=new()
						if(usr.BingoBookAssociations["Rock"]||usr.icon_state=="seals") return
						if(usr.reaper) return
						usr.canfindrocks=0; usr.protect=1
						usr.loc = locate(174,4,2)
						usr.ZCoord="Hospital"; usr.ZCoordProc(usr.ZCoord)

			Exit
				Enter()
					.=..();if(. && usr)
						if(usr.mapon)
							for(var/obj/minimap/M in usr.client.screen) M.invisibility=0
						usr.canfindrocks=1; usr.protect=0
						if(usr.RecentlySpawned) {usr.RecentlySpawned=0; usr.RevengeProtect=1; spawn(100) usr.RevengeProtect=0}
						usr.loc = locate(160,452,1)
						usr.ZCoord="Rock Village"; usr.InVillage="Rock"; usr.ZCoordProc(usr.ZCoord)

		Sand
			Entry
				Enter()
					.=..();if(. && usr)
						if(usr.firing)return
						if(!usr.BingoBookAssociations) usr.BingoBookAssociations=new()
						if(usr.BingoBookAssociations["Sand"]||usr.icon_state=="seals") return
						if(usr.reaper) return
						usr.canfindrocks=0; usr.protect=1
						usr.loc = locate(200,4,2)
						usr.ZCoord="Hospital"; usr.ZCoordProc(usr.ZCoord)

			Exit
				Enter()
					.=..();if(. && usr)
						if(usr.mapon)
							for(var/obj/minimap/M in usr.client.screen) M.invisibility=0
						usr.canfindrocks=1; usr.protect=0
						if(usr.RecentlySpawned) {usr.RecentlySpawned=0; usr.RevengeProtect=1; spawn(100) usr.RevengeProtect=0}
						usr.loc = locate(23,31,1)
						usr.ZCoord="Sand Village"; usr.InVillage="Sand"; usr.ZCoordProc(usr.ZCoord)

		Rain
			Entry
				Enter()
					.=..();if(. && usr)
						if(!usr.BingoBookAssociations) usr.BingoBookAssociations=new()
						if(usr.BingoBookAssociations["Rain"]||usr.icon_state=="seals") return
						if(usr.reaper) return
						usr.canfindrocks=0; usr.protect=1
						usr.loc = locate(148,4,2)
						usr.ZCoord="Hospital"; usr.ZCoordProc(usr.ZCoord)

			Exit
				Enter()
					.=..();if(. && usr)
						if(usr.mapon)
							for(var/obj/minimap/M in usr.client.screen) M.invisibility=0
						usr.canfindrocks=1; usr.protect=0
						if(usr.RecentlySpawned) {usr.RecentlySpawned=0; usr.RevengeProtect=1; spawn(100) usr.RevengeProtect=0}
						usr.loc = locate(91,265,1)
						usr.ZCoord="Rain Village"; usr.InVillage="Rain"; usr.ZCoordProc(usr.ZCoord)

		Waterfall
			Entry
				Enter()
					.=..();if(. && usr)
						if(!usr.BingoBookAssociations) usr.BingoBookAssociations=new()
						if(usr.BingoBookAssociations["Waterfall"]||usr.icon_state=="seals") return
						if(usr.reaper) return
						usr.canfindrocks=0; usr.protect=1
						usr.loc = locate(252,4,2)
						usr.ZCoord="Hospital"; usr.ZCoordProc(usr.ZCoord)

			Exit
				Enter()
					.=..();if(. && usr)
						if(usr.mapon)
							for(var/obj/minimap/M in usr.client.screen) M.invisibility=0
						usr.canfindrocks=1; usr.protect=0
						if(usr.RecentlySpawned) {usr.RecentlySpawned=0; usr.RevengeProtect=1; spawn(100) usr.RevengeProtect=0}
						usr.loc = locate(31,135,2)
						usr.ZCoord="Waterfall Village"; usr.InVillage="Waterfall"; usr.ZCoordProc(usr.ZCoord)

		Sound
			Entry
				Enter()
					.=..();if(. && usr)
						if(!usr.BingoBookAssociations) usr.BingoBookAssociations=new()
						if(usr.BingoBookAssociations["Sound"]||usr.icon_state=="seals") return
						if(usr.reaper) return
						usr.canfindrocks=0; usr.protect=1
						usr.loc = locate(226,4,2)
						usr.ZCoord="Hospital"; usr.ZCoordProc(usr.ZCoord)

			Exit
				Enter()
					.=..();if(. && usr)
						if(usr.mapon)
							for(var/obj/minimap/M in usr.client.screen) M.invisibility=0
						usr.canfindrocks=1; usr.protect=0
						if(usr.RecentlySpawned) {usr.RecentlySpawned=0; usr.RevengeProtect=1; spawn(100) usr.RevengeProtect=0}
						usr.loc = locate(458,475,1)
						usr.ZCoord="Sound Village"; usr.InVillage="Sound"; usr.ZCoordProc(usr.ZCoord)

		Cloud
			Entry
				Enter()
					.=..();if(. && usr)
						if(!usr.BingoBookAssociations) usr.BingoBookAssociations=new()
						if(usr.BingoBookAssociations["Cloud"]||usr.icon_state=="seals") return
						if(usr.reaper) return
						usr.canfindrocks=0; usr.protect=1
						usr.loc = locate(44,4,2)
						usr.ZCoord="Hospital"; usr.ZCoordProc(usr.ZCoord)

			Exit
				Enter()
					.=..();if(. && usr)
						if(usr.mapon)
							for(var/obj/minimap/M in usr.client.screen) M.invisibility=0
						usr.canfindrocks=1; usr.protect=0
						if(usr.RecentlySpawned) {usr.RecentlySpawned=0; usr.RevengeProtect=1; spawn(100) usr.RevengeProtect=0}
						usr.loc = locate(796,528,1)
						usr.ZCoord="Cloud Village"; usr.InVillage="Cloud"; usr.ZCoordProc(usr.ZCoord)

		Mist
			Entry
				Enter()
					.=..();
					if(. && usr)
						if(!usr.BingoBookAssociations) usr.BingoBookAssociations=new()
						if(usr.BingoBookAssociations["Mist"]||usr.icon_state=="seals") return
						if(usr.reaper) return
						usr.canfindrocks=0; usr.protect=1
						usr.loc = locate(122,4,2)
						usr.ZCoord="Hospital"; usr.ZCoordProc(usr.ZCoord)

			Exit
				Enter()
					.=..();
					if(. && usr)
						if(usr.mapon)
							for(var/obj/minimap/M in usr.client.screen) M.invisibility=0
						usr.canfindrocks=1; usr.protect=0
						if(usr.RecentlySpawned && usr) {usr.RecentlySpawned=0; usr.RevengeProtect=1; spawn(100) usr.RevengeProtect=0}
						usr.loc = locate(905,129,1)
						usr.ZCoord="Mist Village"; usr.InVillage="Mist"; usr.ZCoordProc(usr.ZCoord)

		Grass
			Entry
				Enter()
					.=..();
					if(. && usr)
						if(!usr.BingoBookAssociations) usr.BingoBookAssociations=new()
						if(usr.BingoBookAssociations["Grass"]||usr.icon_state=="seals") return
						if(usr.reaper) return
						usr.canfindrocks=0; usr.protect=1
						usr.loc = locate(70,4,2)
						usr.ZCoord="Hospital"; usr.ZCoordProc(usr.ZCoord)

			Exit
				Enter()
					.=..();if(. && usr)
						if(usr.mapon)
							for(var/obj/minimap/M in usr.client.screen) M.invisibility=0
						usr.canfindrocks=1; usr.protect=0
						if(usr.RecentlySpawned)
							usr.RecentlySpawned=0
							usr.RevengeProtect=1
							spawn(100)
								if(usr)
									usr.RevengeProtect=0
						usr.loc = locate(246,308,1)
						usr.ZCoord="Grass Village"; usr.InVillage="Grass"; usr.ZCoordProc(usr.ZCoord)

	Waterfall
		Entry
			Enter()
				if(usr.DoorPassageAllowed)
					usr.InVillage="Waterfall"; usr.ZCoord="Waterfall Village"; usr.ZCoordProc(usr.ZCoord)
					usr.loc = locate(56,82,2)
					return 1
				if(!usr.client)
					return
				else//if(usr.client)
					usr<<"<b>You are now entering the Village Hidden in Waterfalls.</b>"
					usr.InVillage="Waterfall"; usr.ZCoord="Waterfall Village"; usr.ZCoordProc(usr.ZCoord)
					usr.loc = locate(56,82,2)

					var/mob/player/U = usr
					if(U.Familiar)
						spawn(-1)
							var/mob/Hittable/Responsive/Animal/Pet/A=U.Familiar
							if(A.Status == STATUS_FOLLOW)
								if(get_dist(U,A) < 16)
									A.DoorPassageAllowed++
									while(get_dist(A,src)>1)
										step_to(A,src)
										sleep(A.movespeed)
									step_towards(A,src)
									A.DogFollow(U)
					if(U.MasterBunshinList.len)
						for(var/mob/A in U.MasterBunshinList)
							spawn(-1)
								if(A.Status == STATUS_FOLLOW)
									if(get_dist(U,A) < 16)
										A.DoorPassageAllowed++
										while(get_dist(A,src)>1)
											step_to(A,src)
											sleep(A.movespeed)
										step_towards(A,src)
					if(U.EdoCloneList.len)
						for(var/mob/A in U.EdoCloneList)
							spawn(-1)
								if(A.Status == STATUS_FOLLOW)
									if(get_dist(U,A) < 16)
										A.DoorPassageAllowed++
										while(get_dist(A,src)>1)
											step_to(A,src)
											sleep(A.movespeed)
										step_towards(A,src)
					return 1

		Exit
			Enter()
				if(usr.DoorPassageAllowed)
					usr.InVillage=null; usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)
					usr.loc = locate(289,472,1)
					return 1
				if(!usr.client)
					return
				else//if(usr.client)
					if(usr.NinjaRank=="Academy Student")
						if(usr.reset)
							return
						else
							usr<<"<b>You cannot leave the safety of the village until you pass the Genin Exam</b>"
							usr.reset=1
							spawn(20)
								usr.reset=0
								return
					else
						usr<<"<b>You are now leaving the Village Hidden in Waterfalls.</b>"
						usr.InVillage=null; usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)
						usr.loc = locate(289,472,1)

						var/mob/player/U = usr
						if(U.Familiar)
							spawn(-1)
								var/mob/Hittable/Responsive/Animal/Pet/A=U.Familiar
								if(A.Status == STATUS_FOLLOW)
									if(get_dist(U,A) < 16)
										A.DoorPassageAllowed++
										while(get_dist(A,src)>1)
											step_to(A,src)
											sleep(A.movespeed)
										step_towards(A,src)
										A.DogFollow(U)
						if(U.MasterBunshinList.len)
							for(var/mob/A in U.MasterBunshinList)
								spawn(-1)
									if(A.Status == STATUS_FOLLOW)
										if(get_dist(U,A) < 16)
											A.DoorPassageAllowed++
											while(get_dist(A,src)>1)
												step_to(A,src)
												sleep(A.movespeed)
											step_towards(A,src)
						if(U.EdoCloneList.len)
							for(var/mob/A in U.EdoCloneList)
								spawn(-1)
									if(A.Status == STATUS_FOLLOW)
										if(get_dist(U,A) < 16)
											A.DoorPassageAllowed++
											while(get_dist(A,src)>1)
												step_to(A,src)
												sleep(A.movespeed)
											step_towards(A,src)
						return 1

	AkatsukiHideout
		Entrance
			Enter()
				.=..();if(. && usr)
					usr.loc = locate(346,3,2)
					usr.ZCoord="Akatsuki Hideout"; usr.ZCoordProc(usr.ZCoord)

		Exit
			Enter()
				.=..();if(. && usr)
					usr.loc = locate(310,41,1)
					usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)

	AkatsukiHideout2
		Entrance
			Enter()
				.=..();if(. && usr)
					usr<<Secret
					usr.loc = locate(37,195,2)
					usr.ZCoord="Underground"; usr.ZCoordProc(usr.ZCoord)

		Exit
			Enter()
				.=..();if(. && usr)
					usr<<"This isn't where you came in..."
					usr.loc = locate(278,65,1)
					usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)


	SamehadaDungeon
		Entrance
			Entered()
				.=..();if(. && usr)
					usr<<Secret
					usr.loc = locate(22,200,2)
					usr.ZCoord="Underground"; usr.ZCoordProc(usr.ZCoord)

		Exit
			Enter()
				.=..();if(. && usr)
					usr<<"This isn't where you came in..."
					usr.loc = locate(278,65,1)
					usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)


	ExecutionerDungeon
		Entrance
			Entered()
				.=..();if(. && usr)
					usr<<Secret
					usr.loc = locate(394,11,2)
					usr.ZCoord="Dark Cave"; usr.ZCoordProc(usr.ZCoord)

		Exit
			Enter()
				.=..();if(. && usr)
					usr.loc = locate(900,162,1)
					usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)


	WaterfallPassage
		Rock_Passage
			Enter()
				.=..();if(. && usr)
					usr.loc = locate(355,57,2)
					usr.ZCoord="Passageway"; usr.ZCoordProc(usr.ZCoord)

		Passage_Rock
			Enter()
				.=..();if(. && usr)
					usr.loc = locate(115,379,1)
					usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)


		Passage_WaterfallPassage
			Enter()
				.=..();if(. && usr)
					usr.loc = locate(337,72,2)
					usr.ZCoord="Passageway"; usr.ZCoordProc(usr.ZCoord)

		WaterfallPassage_Passage
			Enter()
				.=..();if(. && usr)
					usr.loc = locate(338,66,2)
					usr.ZCoord="Passageway"; usr.ZCoordProc(usr.ZCoord)


		WaterfallPassage_Waterfall
			Enter()
				.=..();if(. && usr)
					usr.loc = locate(2,94,2)
					usr.ZCoord="Waterfall Village"; usr.ZCoordProc(usr.ZCoord)

		Waterfall_WaterfallPassage
			Enter()
				if(istype(usr,/mob/player)&&usr.NinjaRank=="Academy Student") {usr<<"<b>You cannot leave the safety of the village until you pass the Genin Exam</b>"; return}
				else .=..();if(. && usr) {usr.loc = locate(376,88,2); usr.ZCoord="Passageway"; usr.ZCoordProc(usr.ZCoord); ;}


	RockPassage
		Rock_FirstCave
			Enter()
				.=..();if(. && usr)
					usr.loc = locate(230,27,2)
					usr.ZCoord="Cave"; usr.ZCoordProc(usr.ZCoord)

		FirstCave_Rock
			Enter()
				.=..();if(. && usr)
					usr.loc = locate(129,517,1)
					usr.ZCoord="Rock Village"; usr.ZCoordProc(usr.ZCoord)

		FirstCave_FallsCave
			Enter()
				.=..();if(. && usr)
					usr.loc = locate(229,52,2)
					usr.ZCoord="Underground Waterfalls"; usr.ZCoordProc(usr.ZCoord)

		FallsCave_FirstCave
			Enter()
				.=..();if(. && usr)
					usr.loc = locate(244,45,2)
					usr.ZCoord="Cave"; usr.ZCoordProc(usr.ZCoord)

		FallsCave_LostCaves
			Enter()
				.=..();if(. && usr)
					usr.ZCoord="Lost Caves"; usr.ZCoordProc(usr.ZCoord)
					usr.loc=locate(380,92,2)

		LostCaves_FallsCave
			Enter()
				.=..();if(. && usr)
					usr.ZCoord="Underground Waterfalls"; usr.ZCoordProc(usr.ZCoord)
					usr.loc=locate(290,67,2)

		LostCaves
			RoamingEntry
				Enter()
					.=..();if(. && usr)
						usr.ZCoord="Lost Caves"; usr.ZCoordProc(usr.ZCoord)
						usr.loc=locate(355,42,2)

			WrongPath
				Enter()
					.=..();if(. && usr)
						usr.ZCoord="Roaming"; usr.ZCoordProc(usr.ZCoord)
						usr.loc=locate(253,555,1)

			CorrectPath
				North
					Enter()
						.=..();if(. && usr)
							usr.y+=4
				South
					Enter()
						.=..();if(. && usr)
							usr.y-=4
				East
					Enter()
						.=..();if(. && usr)
							usr.x+=3
				West
					Enter()
						.=..();if(. && usr)
							usr.x-=3
	Academy
		AcademyEnter
			Enter()
				if(istype(usr,/mob/))
					if(usr.firing)return
					if(usr.NinjaRank!="Academy Student")
						usr<<"<b>Only Academy Students may enter!</b>"
						return
					else
						usr.canfindrocks=0; usr.protect=1
						usr.loc = locate(15,18,2)

						usr.ZCoord="Ninja Academy"; usr.ZCoordProc(usr.ZCoord)
		AcademyExit
			Enter()
				.=..();if(. && usr)
					usr.canfindrocks=1
					usr.protect=0; usr.ExitAcademy()

					usr.ZCoord="[usr.Village] Village"; usr.ZCoordProc(usr.ZCoord)
		ExamEntrance
			Enter(mob/M)
				if(istype(M,/mob))
					if(usr.firing)return
					if((usr.StaminaTrue)<(2000*EXP_BASE)) {usr<<"<b>You must obtain [2000*EXP_BASE] Stamina prior to trying this exam!</b>"; return}
					if(GeninAccess)
						M<<"<i>The Genin exam will be starting soon. Please take your seats in silence.</i>"
						M<<"<br><i>If there is <u>any</u> form of communication, or you cause any disruption once the exam has started, you will be disqualified and ejected from the exam room.</i>"
						M.loc = locate(33,43,2); M.protect=1; M.InGeninRoom=1
					if(!GeninAccess)
						M<<"Cannot enter exam room now"
		ExamExit
			Enter(mob/M)
				if(istype(M,/mob))
					if(M.TakingExam)
						M<<"You cant leave until the exam is over"
						return
					else
						M.InGeninRoom=null
						M.loc=locate(33,37,2)
	Chuunin
		Entry
			Enter()
				if(istype(usr,/mob/))
					if(usr.firing)return
					if(usr.icon_state=="seals") return
					if(usr.NinjaRank!="Genin") {usr<<"<b>Only Genin may enter!</b>"; return}
					if(usr.InVillage!=ChuuninVillage) {usr<<"The Chuunin Exam is being held in [ChuuninVillage] Village"; return}
					if(usr.MissionsComplete["Total"]<8) {usr<<"<b>You must complete at least 8 missions first!</b>"; return}
					if((usr.TaijutsuTrue+usr.NinjutsuTrue+usr.GenjutsuTrue)<(3000*EXP_BASE)) {usr<<"<b>Your 3 fighting styles combined must be at least [3000*EXP_BASE].</b>"; return}
					else {usr.loc = locate(984,3,2); usr.canfindrocks=0; usr.ZCoord="Chuunin Exams"; usr.ZCoordProc(usr.ZCoord); usr.protect=1; ;}
		Exit
			Enter()
				if(istype(usr,/mob/)) usr.canfindrocks=1
				if(!usr.TakingChuuninExam)
					usr.ChuuninExit()

		Tower
			EnteredNorth
				Enter()
					if(istype(usr,/mob/))
						if(usr.firing)return
						if(usr.HasEarth&&usr.HasHeaven)
							usr.canfindrocks=0; usr.protect=1; usr.onwater=0
							usr.loc=locate(979,35,2)
							usr.InTower=1; usr.ZCoord="Tower"; usr.ZCoordProc(usr.ZCoord)
						else usr<<"You need <i>both</i> Heaven and Earth Scrolls."
			EnteredSouth
				Enter()
					if(istype(usr,/mob/))
						if(usr.firing)return
						if(usr.HasEarth&&usr.HasHeaven)
							usr.canfindrocks=0; usr.protect=1; usr.onwater=0
							usr.loc = locate(979,26,2)
							usr.InTower=1; usr.ZCoord="Tower"; usr.ZCoordProc(usr.ZCoord)
						else usr<<"You need <i>both</i> Heaven and Earth Scrolls."
			EnteredEast
				Enter()
					if(istype(usr,/mob/))
						if(usr.firing)return
						if(usr.HasEarth&&usr.HasHeaven)
							usr.canfindrocks=0; usr.protect=1; usr.onwater=0
							usr.loc = locate(984,31,2)
							usr.InTower=1; usr.ZCoord="Tower"; usr.ZCoordProc(usr.ZCoord)
						else usr<<"You need <i>both</i> Heaven and Earth Scrolls."
			EnteredWest
				Enter()
					if(istype(usr,/mob/))
						if(usr.firing)return
						if(usr.HasEarth&&usr.HasHeaven)
							usr.canfindrocks=0; usr.protect=1; usr.onwater=0
							usr.loc = locate(974,31,2)
							usr.InTower=1; usr.ZCoord="Tower"; usr.ZCoordProc(usr.ZCoord)
						else usr<<"You need <i>both</i> Heaven and Earth Scrolls."

	SpawnRoomDoor
		Enter()
			if(istype(usr,/mob/))
				usr.SpawnWhere()
			else
				del(src)

	KageHouse
		Entry
			Leaf
				Enter()
					.=..();if(. && usr)
						if(usr.firing)return
						if(usr in LeafHitList) {usr<<"Leaf Village does not harbour fugatives!"; return}
						if(usr.reaper) {usr<<"We can't have you leading the enemy here! Wait until you are safe!"; return}
						usr.loc=locate(57,28,2); usr.protect=1; ; usr.InVillage="Leaf"; usr.ZCoordProc("Kage House")
					else if(istype(usr,/obj/)) del(src)
					else return
			Cloud
				Enter()
					.=..();if(. && usr)
						if(usr.firing)return
						if(usr.reaper) return
						if(usr in CloudHitList)
							usr<<"Cloud Village does not harbour fugatives!"; return
						else
							usr.loc=locate(57,55,2); usr.protect=1; ; usr.InVillage="Cloud"; usr.ZCoordProc("Kage House")
					else if(istype(usr,/obj/)) del(src)
					else return
			Grass
				Enter()
					.=..();if(. && usr)
						if(usr.firing)return
						if(usr.reaper) return
						if(usr in GrassHitList)
							usr<<"Grass Village does not harbour fugatives!"; return
						else
							usr.loc=locate(90,28,2); usr.protect=1; ; usr.InVillage="Grass"; usr.ZCoordProc("Kage House")
					else if(istype(usr,/obj/)) del(src)
					else return
			Sound
				Enter()
					.=..();if(. && usr)
						if(usr.firing)return
						if(usr.reaper) return
						if(usr in SoundHitList)
							usr<<"Sound Village does not harbour fugatives!"; return
						else
							usr.loc=locate(90,55,2); usr.protect=1; ; usr.InVillage="Sound"; usr.ZCoordProc("Kage House")
					else if(istype(usr,/obj/)) del(src)
					else return
			Sand
				Enter()
					.=..();if(. && usr)
						if(usr.firing)return
						if(usr.reaper) return
						if(usr in SandHitList)
							usr<<"Sand Village does not harbour fugatives!"; return
						else
							usr.loc=locate(123,28,2); usr.protect=1; ; usr.InVillage="Sand"; usr.ZCoordProc("Kage House")
					else if(istype(usr,/obj/)) del(src)
					else return
			Rain
				Enter()
					.=..();if(. && usr)
						if(usr.firing)return
						if(usr.reaper) return
						if(usr in RainHitList)
							usr<<"Rain Village does not harbour fugatives!"; return
						else
							usr.loc=locate(123,55,2); usr.protect=1; ; usr.InVillage="Rain"; usr.ZCoordProc("Kage House")
					else if(istype(usr,/obj/)) del(src)
					else return
			Waterfall
				Enter()
					.=..();if(. && usr)
						if(usr.firing)return
						if(usr.reaper) return
						if(usr in WaterfallHitList)
							usr<<"Waterfall Village does not harbour fugatives!"; return
						else
							usr.loc=locate(156,28,2); usr.protect=1; ; usr.InVillage="Waterfall"; usr.ZCoordProc("Kage House")
					else if(istype(usr,/obj/)) del(src)
					else return
			Mist
				Enter()
					.=..();if(. && usr)
						if(usr.firing)return
						if(usr.reaper) return
						if(usr in MistHitList)
							usr<<"Mist Village does not harbour fugatives!"; return
						else
							usr.loc=locate(156,55,2); usr.protect=1; ; usr.InVillage="Mist"; usr.ZCoordProc("Kage House")
					else if(istype(usr,/obj/)) del(src)
					else return
			Rock
				Enter()
					.=..();if(. && usr)
						if(usr.firing)return
						if(usr.reaper) return
						if(usr in RockHitList) {usr<<"Rock Village does not harbour fugatives!"; return}
						usr.loc=locate(189,28,2); usr.protect=1; ; usr.InVillage="Rock"; usr.ZCoordProc("Kage House")
					else if(istype(usr,/obj/)) del(src)
					else return
		Exit
			Enter()
				.=..();if(. && usr)
					if(!usr.InVillage)
						usr.InVillage=usr.Village
					switch(usr.InVillage)
						if("Leaf") usr.loc=locate(473,187,1)
						if("Sound") usr.loc=locate(508,487,1)
						if("Cloud") usr.loc=locate(807,493,1)
						if("Mist") usr.loc=locate(878,143,1)
						if("Waterfall") usr.loc=locate(56,162,2)
						if("Grass") usr.loc=locate(268,336,1)
						if("Rain") usr.loc=locate(73,314,1)
						if("Sand") usr.loc=locate(55,37,1)
						if("Rock") usr.loc=locate(197,483,1)
					usr.protect=0
					usr.ZCoordProc("[usr.InVillage] Village")

	Sound_Mission
		SoundPad
			icon = 'Landscapes.dmi'
			icon_state = "sand"
			Enter()
				if(ismob(usr))
					if(usr.NinjaRank=="Academy Student"||usr.NinjaRank=="Genin"||!usr.client) {usr<<"You need to be at least Chuunin Rank to attempt this mission"; return}
					else return 1
				else return 1
			Entered()
				if(istype(usr,/mob/)) usr.onsandTile=1
			Exited()
				if(istype(usr,/mob/)) usr.onsandTile=0
		OrochimaruDoor
			Enter()
				if(istype(usr,/mob/))
					if(Sound5KillCount!=5) {usr<<"You must eliminate the Sound 5 first."; return}
					else return 1
				else return

	Jail
		Cloud
			ToJail
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(205,115,2); usr.ZCoordProc("Cloud Jail")
						usr.protect=1
			FromJail
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(50,74,2); usr.ZCoordProc("Kage House")
						usr.Pickpocketing=0; usr.Escaping=0; var/obj/Item/JailKey/K = locate() in usr
						if(K) {del(K); usr.UpdateInventory()}
						usr.protect=1
		Leaf
			ToJail
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(205,100,2); usr.ZCoordProc("[usr.Village] Jail")
						usr.protect=1
			FromJail
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(50,47,2); usr.ZCoordProc("Kage House")
						usr.Escaping=0; usr.Pickpocketing=0; var/obj/Item/JailKey/K = locate() in usr
						if(K) {del(K); usr.UpdateInventory()}
						usr.protect=1
		Mist
			ToJail
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(205,85,2); usr.ZCoordProc("Mist Jail")
						usr.protect=1
			FromJail
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(149,74,2); usr.ZCoordProc("Kage House")
						usr.Escaping=0; usr.Pickpocketing=0; var/obj/Item/JailKey/K = locate() in usr
						if(K) {del(K); usr.UpdateInventory()}
						usr.protect=1
		Rock
			ToJail
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(205,70,2); usr.ZCoordProc("[usr.Village] Jail")
						usr.protect=1
			FromJail
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(182,47,2); usr.ZCoordProc("Kage House")
						usr.Escaping=0; usr.Pickpocketing=0; var/obj/Item/JailKey/K = locate() in usr
						if(K) {del(K); usr.UpdateInventory()}
						usr.protect=1
		Sand
			ToJail
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(205,55,2); usr.ZCoordProc("Sand Jail")
						usr.protect=1
			FromJail
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(116,47,2); usr.ZCoordProc("Kage House")
						usr.Escaping=0; usr.Pickpocketing=0; var/obj/Item/JailKey/K = locate() in usr
						if(K) {del(K); usr.UpdateInventory()}
						usr.protect=1
		Sound
			ToJail
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(205,145,2);
						usr.ZCoordProc("Sound Jail")
						usr.protect=1
			FromJail
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(83,74,2);
						usr.ZCoordProc("Leader House")
						usr.Escaping=0; usr.Pickpocketing=0;
						var/obj/Item/JailKey/K = locate() in usr
						if(K)
							del(K)
							usr.UpdateInventory()
						usr.protect=1
		Grass
			ToJail
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(205,175,2);
						usr.ZCoordProc("Grass Jail")
						usr.protect=1
			FromJail
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(83,47,2);
						usr.ZCoordProc("Leader House")
						usr.Escaping=0; usr.Pickpocketing=0;
						var/obj/Item/JailKey/K = locate() in usr
						if(K)
							del(K)
							usr.UpdateInventory()
						usr.protect=1
		Waterfall
			ToJail
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(205,130,2);
						usr.ZCoordProc("Waterfall Jail")
						usr.protect=1
			FromJail
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(149,47,2);
						usr.ZCoordProc("Leader House")
						usr.Escaping=0; usr.Pickpocketing=0;
						var/obj/Item/JailKey/K = locate() in usr
						if(K)
							del(K)
							usr.UpdateInventory()
						usr.protect=1
		Rain
			ToJail
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(205,160,2);
						usr.ZCoordProc("Rain Jail")
						usr.protect=1
			FromJail
				Enter()
					.=..();if(. && usr)
						usr.loc = locate(116,74,2);
						usr.ZCoordProc("Leader House")
						usr.Escaping=0; usr.Pickpocketing=0;
						var/obj/Item/JailKey/K = locate() in usr
						if(K)
							del(K)
							usr.UpdateInventory()
						usr.protect=1

	NPC
		MinatoHome
			Entry
				Enter()
					.=..();if(. && usr)
						usr.canfindrocks=0; usr.protect=1
						usr.loc = locate(123,82,2)
						usr.ZCoord="Cottage"; usr.ZCoordProc(usr.ZCoord)

			Exit
				Enter()
					.=..();if(. && usr)
						if(usr.mapon)
							for(var/obj/minimap/M in usr.client.screen) M.invisibility=0
						usr.canfindrocks=1; usr.protect=0
						usr.loc = locate(219,186,1)
						usr.ZCoord="Roaming";usr.ZCoordProc(usr.ZCoord)
