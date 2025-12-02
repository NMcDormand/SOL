proc
	BattleRoyale()
		if(TournamentHosted) return
		TournamentOpen=1; TournamentHosted=1; TournamentCount=0; TournamentParticipants=0; TournamentList=new/list
		for(var/mob/player/p in MasterPlayerList)
			if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Battle Royale",8)
		spawn(1800)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Battle Royale",5)
		spawn(3000)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Battle Royale",3)
		spawn(3600)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Battle Royale",2)
		spawn(4200)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Battle Royale",1,59)
		spawn(4800)
			TournamentCounter(0)
			if(TournamentCount>1)
				TournamentParticipants=TournamentCount
				spawn(20) BattleRoyaleSpawn()
				spawn(40) {TournamentCountdown();TournamentCheck_LastMan()}
			else
				for(var/mob/player/B in TournamentList)
					B<<"You were the only entrant in the tournament, so the tournament has been called off."; TournamentHosted=0


	BattleRoyaleSpawn()
		for(var/mob/player/B in TournamentList)
			B<<"You will now be taken to the arena!"
			spawn(15) B.loc=locate(rand(920,961),rand(78,98),2)

mob/proc
	BattleRoyaleMedal(var/P)
		src.BattleRoyaleWins++; src.TournamentWins++
		switch(P)
			if(2 to 5)
				if(ismob(src) && src.key)
					if(!world.GetMedal("Battle Royale Winner (bronze)", src)) world.SetMedal("Battle Royale Winner (bronze)", src)
					src.gold+=1000; src.StatPoints+=4
					src<<"Congratulations! You have been awarded the <i>bronze</i> Battle Royale medal!"
					src<<"+1000 Gold!"; src<<"+4 Stat Points!"
			if(6 to 15)
				if(ismob(src) && src.key)
					if(!world.GetMedal("Battle Royale Winner (silver)", src)) world.SetMedal("Battle Royale Winner (silver)", src)
					src.gold+=5000; src.StatPoints+=7
					src<<"Congratulations! You have been awarded the <i>silver</i> Battle Royale medal!"
					src<<"+5000 Gold!"; src<<"+7 Stat Points!"
			if(16 to 25)
				if(ismob(src) && src.key)
					if(!world.GetMedal("Battle Royale Winner (gold)", src)) world.SetMedal("Battle Royale Winner (gold)", src)
					src.gold+=10000; src.StatPoints+=15
					src<<"Congratulations! You have been awarded the <i>gold</i> Battle Royale medal!"
					src<<"+10,000 Gold!"; src<<"+15 Stat Points!"
			else
				if(ismob(src) && src.key)
					if(!world.GetMedal("Battle Royale Winner (platinum)", src)) world.SetMedal("Battle Royale Winner (platinum)", src)
					src.gold+=25000; src.StatPoints+=25
					src<<"Congratulations! You have been awarded the <i>platinum</i> Battle Royale medal!"
					src<<"+25,000 Gold!"; src<<"+25 Stat Points!"
		src.StatUpdate_gold(); src.StatUpdate_statpoints()