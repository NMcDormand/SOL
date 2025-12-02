turf/GuildDoorways
	MyGuildHouse
		Entry
			Enter()
				if(istype(usr,/mob/player))
					usr.canfindrocks=0; usr.loc = locate(447,673,1)
					usr.ZCoord="Guild House"; usr.ZCoordProc(usr.ZCoord)
		Exit
			Enter()
				if(istype(usr,/mob/player))
					usr.canfindrocks=1; usr.loc = locate(31,981,1)
					usr.ZCoord="Lost Caves"; usr.ZCoordProc(usr.ZCoord)
		ToBattleArea
			Enter()
				if(istype(usr,/mob/player))
					usr.canfindrocks=1; usr.loc = locate(394,682,1)
		FromBattleArea
			Enter()
				if(istype(usr,/mob/player))
					usr.canfindrocks=0; usr.loc = locate(447,694,1)