mob
	var
		BattleRoyaleWins = 0
		tmp
			InRoyale = 0
	proc
		BattleRoyaleMedal(var/P)
			BattleRoyaleWins++; EventWins++
			switch(P)
				if(2 to 5)
					if(client)
						if(!world.GetMedal("Battle Royale Winner (bronze)", src)) world.SetMedal("Battle Royale Winner (bronze)", src)
						gold+=2500; StatPoints+=25
						src<<"Congratulations! You have been awarded the <i>bronze</i> Battle Royale medal!"
						src<<"+2500 Gold!"; src<<"+25 Stat Points!"
				if(6 to 15)
					if(client)
						if(!world.GetMedal("Battle Royale Winner (silver)", src)) world.SetMedal("Battle Royale Winner (silver)", src)
						gold+=5000; StatPoints+=50
						src<<"Congratulations! You have been awarded the <i>silver</i> Battle Royale medal!"
						src<<"+5000 Gold!"; src<<"+50 Stat Points!"
				if(16 to 25)
					if(client)
						if(!world.GetMedal("Battle Royale Winner (gold)", src)) world.SetMedal("Battle Royale Winner (gold)", src)
						gold+=10000; StatPoints+=100
						src<<"Congratulations! You have been awarded the <i>gold</i> Battle Royale medal!"
						src<<"+10,000 Gold!"; src<<"+100 Stat Points!"
				else
					if(client)
						if(!world.GetMedal("Battle Royale Winner (platinum)", src)) world.SetMedal("Battle Royale Winner (platinum)", src)
						gold+=20000; StatPoints+=200
						src<<"Congratulations! You have been awarded the <i>platinum</i> Battle Royale medal!"
						src<<"+20,000 Gold!"; src<<"+200 Stat Points!"
			StatUpdate_gold(); StatUpdate_statpoints()

var
	RoyaleCount

proc
	BattleRoyale()
		set waitfor = 0
		if(EventCount > 1)
			EventOpen = 1
			for(var/mob/M in EventParticipants)
				RoyaleCount++
				M<<"You will now be taken to the arena! The Battle will begin in 15 seconds!"
				M.protect = 1
				M.CantWalk++
				M.loc=locate(rand(841,894),rand(107,154),2)
				M.InRoyale = 1
			spawn(120)
				var/count = 3
				while(count)
					for(var/mob/M in EventParticipants)
						M << "[count].."
						if(count == 1)
							spawn(10)
								M<<"GO!"
								M.protect = 0
								M.CantWalk--
								break
					sleep(10)
					count--
			BattleRoyaleCheck()

	BattleRoyaleCheck()
		set waitfor = 0
		REDO
		var/ECount = 0
		for(var/mob/P in EventParticipants)
			ECount++
		if(RoyaleCount == 1 || ECount == 1)
			for(var/mob/P in EventParticipants)
				P.BattleRoyaleMedal(EventCount)
			EventClose()
		else
			spawn(20)
				goto REDO

