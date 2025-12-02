var
	TRoundList=list("1" = list())
	TFightList=list()
	mob/NextToFight1
	mob/NextToFight2
	TRLoser
	TRemain = 0
	TRound = 1

mob
	var
		OneOnOneWins = 0
		OneonOneMedal = 0
		tmp
			InOneOnOne = 0

	verb
		CheckOneOne()
			var/msg = "Round Parts:"
			for(var/A in TRoundList)
				msg+="<br>[A] = "
				for(var/B in TRoundList)
					msg += "[B], "
			msg += "<br>[TRound]"
			msg += "<br>[NextToFight1] vs [NextToFight2]"
			for(var/mob/A in TFightList)
				msg += "[A]"

	proc
		OneOnOneMedal(var/P)
			OneOnOneWins++; EventWins++
			switch(P)
				if(2 to 5)
					if(ismob(src) && key)
						if(!world.GetMedal("1 on 1 Winner (bronze)", src))
							world.SetMedal("1 on 1 Winner (bronze)", src)
						gold+=1000; StatPoints+=25
						src<<"Congratulations! You have been awarded the <i>bronze</i> 1 on 1 medal!"
						src<<"+1000 Gold!"; src<<"+25 Stat Points!"
				if(6 to 15)
					if(ismob(src) && key)
						if(!world.GetMedal("1 on 1 Winner (silver)", src))
							world.SetMedal("1 on 1 Winner (silver)", src)
						gold+=2500; StatPoints+=50
						src<<"Congratulations! You have been awarded the <i>silver</i> 1 on 1 medal!"
						src<<"+2500 Gold!"; src<<"+50 Stat Points!"
				if(16 to 25)
					if(ismob(src) && key)
						if(!world.GetMedal("1 on 1 Winner (gold)", src))
							world.SetMedal("1 on 1 Winner (gold)", src)
						gold+=50000; StatPoints+=100
						src<<"Congratulations! You have been awarded the <i>gold</i> 1 on 1 medal!"
						src<<"+50,000 Gold!"; src<<"+100 Stat Points!"
				else
					if(ismob(src) && key)
						if(!world.GetMedal("1 on 1 Winner (platinum)", src))
							world.SetMedal("1 on 1 Winner (platinum)", src)
						gold+=100000; StatPoints+=200
						src<<"Congratulations! You have been awarded the <i>platinum</i> 1 on 1 medal!"
						src<<"+100,000 Gold!"; src<<"+200 Stat Points!"
			StatUpdate_statpoints()
			StatUpdate_gold()
proc
	OneonOne()
		TRemain = EventCount
		for(var/mob/M in EventParticipants)
			M<<"You will now be taken to the arena! The tournament will begin in 3 Minutes"
			M.loc=locate(rand(910,961),rand(106,110),2)
			M.protect=1
			M.InOneOnOne = 1
			TRoundList["1"] += M
		var/count = 1
		while(count)
			for(var/mob/B in EventParticipants)
				B.Popup("Event","One on One",count)
			sleep(600)
			count--
		TRound()
	TRound()
		set waitfor = 0
		TFightList=list()
		NextToFight1 = null
		NextToFight2 = null
		if(TRemain == 1 || !EventParticipants.len ||EventParticipants.len == 1)
			for(var/mob/M in EventParticipants)
				M.OneOnOneMedal(EventCount)
			EventClose()
		else
			var/list/TList = TRoundList
			if(!length(TList["[TRound]"]))
				TRound++
			TList = TRoundList["[TRound]"]
			NextToFight1=pick(TList)
			TList -= NextToFight1
			TFightList += NextToFight1

			NextToFight2=pick(TList)
			TList -= NextToFight2
			TFightList += NextToFight2

			for(var/mob/player/M in EventParticipants)
				M << output("Next to fight will be <u>[NextToFight1]</u> vs. <u>[NextToFight2]</u>!","ann")
			spawn(10)
				var/mob/a=NextToFight1; var/mob/b=NextToFight2
				a.loc=locate(932,93,2)
				b.loc=locate(939,93,2)
				a.CantWalk++
				b.CantWalk++
				var/CD = 3
				while(CD)
					a << "[CD]..."
					b << "[CD]..."
					CD--
					sleep(10)
				a<<"GO!"
				b<<"GO!"
				a.protect=0
				b.protect=0
				a.CantWalk--
				b.CantWalk--
				TRoundCheck()

	TRoundCheck()
		CHECK
		var/count=0
		for(var/mob/P in TFightList)
			if(P.dead)
				TFightList-=P
				EventParticipants-=P
				TRLoser=P
				TRemain--
			else
				count++
		if(count==1)
			if(TRLoser)
				for(var/mob/player/m in EventParticipants)
					m<<output("<i>[TRLoser] is eliminated!</i>","ann")
			spawn(20)
				for(var/mob/player/P in TFightList)
					P.loc=locate(rand(910,961),rand(106,110),2)
					P.protect=1
					if(TRound+1 > length(TRoundList))
						TRoundList["[TRound+1]"] = list()
					TRoundList["[TRound+1]"] += P
				TRound()
		else if(count>1)
			spawn(20)
				goto CHECK