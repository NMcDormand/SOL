var
	list/EventChoice = list("Battle Royale", "1 on 1")//,"Clan War", "Village War", )
	list/EventParticipants = list()
	EventCount = 0
	EventNext
	EventTimer = 108000 //60 minutes
	EventOpen = 0
	EventLocked = 0

proc
	EventLoop()
		set waitfor = 0
		EventNext = pick(EventChoice)
		spawn(96000)
			if(EventOpen)
				return
			EventOpen = 1
			spawn()
				EventLocked = 20
				var/count = 20
				while(count)
					for(var/mob/M in MasterPlayerList)
						M.Popup("Event",EventNext,count)
					sleep(3000)
					count-=5
					EventLocked-=5
			spawn(10200)
				EventLocked = 3
				var/count = 3
				while(count)
					for(var/mob/M in MasterPlayerList)
						M.Popup("Event",EventNext,count)
					sleep(600)
					count--
				if(EventCount >1)
					EventStart(EventNext)
				else
					EventLocked = 0
					EventOpen = 0
					EventCount = 0
					EventLoop()

	EventStart(A)
		switch(A)
			if("Battle Royale")
				BattleRoyale()
			if("1 on 1")
				OneonOne()
			if("Clan War")
				..()//ClanWar()
			if("Village War")
				..()//VillageWar()

	EventClose()
		for(var/mob/M in EventParticipants)
			M.ExitArena()
			M.protect = 0
			EventParticipants-=M
			M.InRoyale = 0
			M.InOneOnOne = 0
		EventLocked = 0
		EventOpen = 0
		EventCount = 0
		EventLoop()

mob
	var
		tmp
			EventLock
		EventWins
	VerbHolder/Admin/Level3
		verb
			CheckTourney()
				usr << "[EventNext]"
			HostTournament()
				set name="Start Tournament"
				set category="Staff"
				if(EventLocked)
					alert("The [EventNext] has already been announced, the taxes would be too great to cancel now")
					return
				if(EventOpen)
					alert("The [EventNext] has already already begun, im sorry [trueName] its too late to stop it now")
					return
				switch(alert("A [EventNext] is the next event, what would you like to do?","Host Tourney","Switch Next","Start Now","Cancel"))
					if("Switch Next")
						var/NE = input("What type of event do you wish to initiate?","Start Event") in EventChoice
						if(!EventLocked)
							EventNext = NE
					if("Start Now")
						if(!EventLocked)
							EventLocked = 1
							var/NE = input("What kind of event do you wish to initiate?","Start Event") as null|anything in EventChoice
							if(NE)
								world << "[trueName] has initiated a [NE] it will begin in 5 minutes"
								EventOpen = 1
								sleep(30)
								EventNext = NE
								var/count = 1
								while(count)
									for(var/mob/M in MasterPlayerList)
										M.Popup("Event",EventNext,count)
									sleep(600)
									count--
								if(EventCount >1)
									EventStart(NE)
								else
									EventLocked = 0
									src << "No one entered your event!"
									AdminActionLog("Start Tournament", "Tournament: [NE]", , , src, 1)
						if("Cancel")
							return