mob/player
	verb
		Event_Spectate()
			if(SpyStatus)
				if(alert("Would you like to stop Spectating?","Spectate?","Yes","No") == "Yes")
					usr.client.perspective= MOB_PERSPECTIVE|EDGE_PERSPECTIVE;
					usr.client.eye = usr
					usr.SpyStatus = 0
					return

			if(!EventOngoing)
				usr << "There is no event taking place"
			else if(!EventStarted)
				usr << "The event hasn't started yet"
			else
				var/list/P = list()
				for(var/mob/player/A in MasterPlayerList)
					if(EventParticipants[A.trueName])
						P += A
				var/mob/M = input("Who would you like to invite?","Invite Event") as null|anything in P+list("Stop")
				if(M!="Cancel" && M)
					usr.SpyStatus=M
					usr.client.perspective= EYE_PERSPECTIVE;
					usr.client.eye = M
				else
					usr.client.perspective= MOB_PERSPECTIVE|EDGE_PERSPECTIVE;
					usr.client.eye = usr
					usr.SpyStatus = 0

	proc
		InviteMeToEvent()
			set waitfor = 0
			if(Rank2Num(NinjaRank) >= EventRequirement)
				if(alert(src,"[EventCreator.trueName] has invited you to join an Event, would you like to join?","Join Event","Yes","No") == "Yes")
					if(src)
						if(EventOngoing)
							if(!EventStarted)
								if(EventParticipants.len)
									EventParticipants[trueName] = src
									world << "[trueName] has joined [EventCreator.trueName]'s Event There are now [EventParticipants.len] Participants"
								else
									EventParticipants[trueName] = src
									world << "[trueName] was the first to join [EventCreator.trueName]'s Event"
								alert(src,"You have been added to the Invite List, once the event begins you will be transported to the event area")
							else
								alert(src,"It appears you took too long to respond and the event has already begun")
						else
							alert(src,"It appears you took too long to respond and the event has already ended or has been cancelled")

proc
	CreateEvent(mob/Creator)
		EventCreator = Creator
		EventOngoing = 1
		EventRequirement = 0
		EventRequirement = Rank2Num(input("What is the minimum Rank required to join?","Event Rank") as null|anything in list("Academy Student","Genin","Chuunin","Special Jounin","Anbu","Missing-Nin","Jounin","Kage Level","Kage"))
		if(EventRequirement)
			for(var/mob/player/M in MasterPlayerList)
				//if(M.AdminLevel)
				//	continue
				//if(M == Creator)
				//	continue
				M.InviteMeToEvent()
			REDO
			EventResponse = 0
			sleep(200)
			if(!EventParticipants.len)
				alert("there was no one who wanted to participate")
				return
			spawn(300)
				if(!EventResponse)
					for(var/mob/player/G in MasterPlayerList)
						if(G.AdminLevel)
							EventCreator = G
							goto REDO
							break
			EventResponse = alert(EventCreator,"There is currently [EventParticipants.len] waiting to begin, are you ready to summon all the participants to your location?","Begin","Yes","No","Cancel")
			if(!EventStarted)
				if(EventResponse == "No")
					goto REDO
				else if(EventResponse == "Cancel")
					for(var/A in EventParticipants)
						var/mob/M = EventParticipants[A]
						if(M)
							M << "[EventCreator] has Cancelled the event"
					EventParticipants = list()
					EventOngoing = 0
					EventStarted = 0
					EventRequirement = 0
				else
					EventStarted = 1
					for(var/A in EventParticipants)
						var/mob/M = EventParticipants[A]
						if(M)
							spawn()
								alert(M,"The Event is about to begin, you now have 10 seconds before the summon commences")
								spawn(100)
									M.sx=M.x
									M.sy=M.y
									M.sz=M.z
									M.loc = locate(Creator.x,Creator.y,Creator.z)
									M.summoned=1
									if(M.loc.loc)
										M.loc.loc.Entered(M)

mob/VerbHolder/Admin/Level4/verb
	Event_Invite()
		if(!EventOngoing)
			usr << "There is no event taking place"
		else
			var/list/P = list()
			for(var/mob/player/A in MasterPlayerList)
				if(!EventParticipants[A.trueName])
					P += A
			var/mob/player/M = input("Who would you like to invite?","Invite Event") as null|anything in P
			if(M)
				M.InviteMeToEvent()

	Event_Remove()
		if(!EventOngoing)
			usr << "There is no event taking place"
		else
			var/list/P = list()
			for(var/A in EventParticipants)
				var/mob/M = EventParticipants[A]
				if(M)
					P += M
			var/mob/M = input("Who would you like to Remove?","Invite Event") as null|anything in P
			if(M)
				if(!M.protect)
					M.loc.loc.Exited(M)
					M.loc=locate(M.sx,M.sy,M.sz)
					M.loc.loc.Entered(M)
				EventParticipants -= M.trueName
				usr << "[M] has been removed from the event"
				M << "[usr] has removed you from the event"
				M.summoned=0

	Event_Countdown()
		var/i = 5
		while(i)
			world << "<h2>[i]...</h2>"
			i--
			sleep(10)
		world << "<h2>Go!</h2>"

	Event_Complete()
		for(var/A in EventParticipants)
			var/mob/M = EventParticipants[A]
			if(M)
				if(!M.protect)
					M.loc.loc.Exited(M)
					M.loc=locate(M.sx,M.sy,M.sz)
					M.loc.loc.Entered(M)
				M.summoned=0
		for(var/mob/player/M in MasterPlayerList)
			if(M.SpyStatus)
				M.client.perspective= MOB_PERSPECTIVE|EDGE_PERSPECTIVE;
				M.client.eye = M
				M.SpyStatus = 0
		EventParticipants = list()
		EventOngoing = 0
		EventStarted = 0
		EventRequirement = 0
		EventResponse = 0

	Event_Create_Summon()
		if(!EventOngoing)
			CreateEvent(usr)
		else
			usr << "There is already an event taking place"
