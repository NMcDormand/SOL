var
	SoundForestClosed = 0
	list/SoundMissionaries=list()
	SoundMissionTimer
	Sound5Rounds = 0
	Sound5Deaths = 0
	Sound5Entrants = 0
	SoundSpawns

obj/SoundMissionSpawnPoints
	New()
		..()
		SpawnPoints[name] = loc
	Jiroubou
	Kidoumaru
	Kimamaro
	Orochimaru
	Sakon
	Tayuya

mob/var
	tmp
		onsandTile
		ReadyForSound
		SoundMissionTalk

mob/NPC
	Sound5QuestMan
		name = "Sound 5 Quest Man"
		icon = 'MissionMan.dmi'
		var/Started = 0
		BlockTarget = 1
		meditating=1
		protect=1
		CantHenge=1
		Action(mob/user)
			if(get_dist(user,src) > 2 || SoundMissionTalk || Started)
				return
			user.choosing=1
			if(user.onsandTile)
				if(!SoundMissionTalk)
					SoundMissionTalk=1
					if(user.NinjaRank=="Academy Student"||user.NinjaRank=="Genin")
						user<<"Only those of Chuunin Rank or higher are permitted to participate in this quest."
					else if(!SoundForestClosed)
						switch(alert(user,"There is currently no one in the forest, would you like to attempt this Quest?","Sound 5 Quest Man","Yes","No"))
							if("Yes")
								if(!SoundForestClosed) //Double check it's clear, avoid stacking
									user.choosing = 0
									SoundMissionaries = list()
									CreateSound5()
									var/BA = 5
									for(var/i = 1 to 5)
										range() << "[BA].."
										sleep(10)
										BA--
									range() << "GO!"
									EnterSound()
					else
						user<<"The Sound 5 Quest is currently unavailable, try again in [SoundMissionTimer] minute(s)."
				else
					user << "I'm sorry im busy"
			else
				user<<"You must first stand on one of the Quest Pads"
			user.choosing = 0
			SoundMissionTalk=0

proc/SoundCheck(mob/Ninja)

	if(Sound5KillCount==5 && istype(Ninja,/mob/Hittable/Responsive/NPC/Mission/Sound5/))
		var/mob/Hittable/Responsive/NPC/Mission/Sound5/Orochimaru/J=new/mob/Hittable/Responsive/NPC/Mission/Sound5/Orochimaru
		for(var/obj/SoundMissionSpawnPoints/Orochimaru/s in world) J.loc=s.loc
		for(var/mob/player/M in SoundMissionaries)
			M<<"Congratulations, you have defeated the <i>Sound 5</i>"
//			M.PreSound5Complete=1
			M.MissionsComplete["A"]++
			M.MissionsComplete["CurS5"]++
			M.MissionsComplete["S5"]++
			M.MissionPoints += AMPREWARD
			M.MissionsComplete["Cur"]++
			M.MissionsComplete["Total"]++
			var/Comped=0
			while(M.MissionsComplete["Cur"]>=5)
				M.MissionsComplete["Cur"]-=5
				Comped++
			if(Comped)
				M.AwardVP(1 * Comped)
				Comped *= 2
				M.StatPoints += Comped
				M.StatPointsObtained["MisReward"]+= Comped
				M.StatPointsObtained["Total"]+= Comped
				M.StatUpdate_statpoints()
				M<<"<center><b>* You have been rewarded [2*Comped] Stat Points *</b></center>"
			M.AQuestSP++
			M.AwardVP(1)
			if(M.AQuestSP>=4) {M.AQuestSP=0; M.StatPoints+=6; M<<"<b>Statpoint Earned!</b>"; M.StatUpdate_statpoints()}
		spawn(10)
			SoundMissionaries<<"<font size=2><b>The path to Orochimaru is now open.</b></font>"

	if(Sound5KillCount==6 && istype(Ninja,/mob/Hittable/Responsive/NPC/Mission/Sound5/Orochimaru))
		spawn(40)
			for(var/mob/player/M in SoundMissionaries)
				M<<"Congratulations, you have defeated Orochimaru.</b>"
				M.gold+=300; M.gold+=M.Sound5Kills*200; M.StatUpdate_gold()
				for(var/mob/Hittable/Responsive/NPC/Mission/Sound5/S in world)
					del(S)
				spawn(10)
					M.SpawnWhere("Leaf")
					for(var/mob/r in SoundMissionaries)
						SoundMissionaries-=r
					Sound5KillCount=0
					M.Sound5Kills=0

				Sound5Entrants = 0
				Sound5Deaths = 0
			SoundForestClosed=null

proc
	CreateSound5()
		new/mob/Hittable/Responsive/NPC/Mission/Sound5/Jiroubou(SpawnPoints["Jiroubou"])
		new/mob/Hittable/Responsive/NPC/Mission/Sound5/Kidoumaru(SpawnPoints["Kidoumaru"])
		new/mob/Hittable/Responsive/NPC/Mission/Sound5/Sakon(SpawnPoints["Sakon"])
		new/mob/Hittable/Responsive/NPC/Mission/Sound5/Tayuya(SpawnPoints["Tayuya"])
		new/mob/Hittable/Responsive/NPC/Mission/Sound5/Kimamaro(SpawnPoints["Kimamaro"])

	EnterSound()
		set waitfor = 0
		Sound5Rounds++;
		for(var/mob/player/m in MasterPlayerList)
			if(m.onsandTile)
				if(!(m in SoundMissionaries))
					m << "Quick, find the Sound 5 and complete your mission!"
					SoundMissionaries+=m
				m.loc=locate(817,15,2)
				m.ZCoord="Sound 5 Quest"
				m.ZCoordProc()
				m.onsandTile = 0
				m.TempID = 55

		SoundForestClosed = 1
		Sound5Entrants = SoundMissionaries.len
		SoundCountdown()

	SoundCountdown()
		SoundMissionTimer = 5;
		Sound5KillCount = 0
		var/S5R = Sound5Rounds
		//SoundMissionaries = list()

		while(SoundMissionTimer)
			if(S5R!=Sound5Rounds)
				return
			for(var/mob/player/M in SoundMissionaries)
				M<<"You have [SoundMissionTimer] minutes before the <i>Sound 5</i> begin to flee."
			SoundMissionTimer--

			sleep(600)

			if(!SoundForestClosed)
				return
			if(Sound5Deaths >= SoundMissionaries.len)
				for(var/mob/player/M in SoundMissionaries)
					SoundMissionaries -= M
					M << "Sound 5 remain at large"
				SoundForestClosed=0
				Sound5Entrants = 0
				Sound5Deaths = 0
				for(var/mob/Hittable/Responsive/NPC/Mission/Sound5/S in SoundList)
					del S
				return
		sleep(600)
		if(SoundForestClosed && S5R == Sound5Rounds)
			for(var/mob/Hittable/Responsive/NPC/Mission/Sound5/S in world)
				del(S)
			for(var/mob/player/m in SoundMissionaries)
				m<<"You have failed to defeat the <i>Sound 5</i>."
				m.SpawnWhere("Leaf")
				SoundMissionaries-=m
				m.Sound5Kills=0
				Sound5Entrants = 0
				Sound5Deaths = 0
			spawn(10) {SoundForestClosed=0; Sound5KillCount=0}

