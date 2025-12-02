mob/var
	CTFWins=0
proc
	CTF()
		if(TournamentHosted) return
		TournamentHosted=1; TournamentOpen=1; TournamentCount=0; TournamentParticipants=0; TournamentList=new/list; TournamentMasterList=new/list
		for(var/mob/player/p in MasterPlayerList)
			if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Capture the Flag",8)
		spawn(1800)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Capture the Flag",5)
		spawn(3000)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Capture the Flag",3)
		spawn(3600)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Capture the Flag",2)
		spawn(4200)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Capture the Flag",1,60)
		spawn(4800)
			TournamentOpen=0
			TournamentCounter(0)
			if(TournamentCount>1)
				TournamentParticipants=TournamentCount
				spawn(20) CTFSpawn()
			else
				for(var/mob/player/B in TournamentList)
					B<<"You were the only entrant in the tournament, so the tournament has been called off."; TournamentHosted=0


	CTFSpawn()
		for(var/obj/SpawnPoints/OneOnOne/GeneralPop/G in world) sp+=G
		for(var/mob/player/B in TournamentList)
			B<<"You will now be taken to the arena!"
			spawn(15) B.loc=locate(rand(920,961),rand(78,98),2)


	WinCTF(mob/W)
		world<<output("<b>[W] has won the 1 on 1 Tournament!</b>","ann"); TournamentHosted=0
		W.ExitArena()
		W.OneOnOneMedal(TournamentParticipants)

/*
mob/AJ/verb
	CreateTournamentMobs()
		set category="Tournament"
		set name="Create Mobs"
		var/mob/player/n=new(src.loc)
		usr.gold++
		n.name="Number [usr.gold]"
		n.icon=usr.icon
		n.Clan="Kaguya"
		n.Village="Sound"
		TournamentList+=n
*/

// FLAG OBJECT STUFF

obj/flag
	FlagB
		icon='Icons/flagstand.dmi'
		icon_state="blueflag"
		name="Blue Flag"
	FlagR
		icon='Icons/flagstand.dmi'
		icon_state="redflag"
		name="Red Flag"
/*verb
			Get()
				set src in oview(1)
				if(usr.blueflag)del(src)
				if(usr.redflag)
					usr<<"You can only hold one flag at a time!"
					return
				if(usr.redteam)
					world<<"<font color=red size=2>[usr] has the Blue Flag!"
					usr.blueflag=1
					BlueTeamFlag=0
					del src
				if(usr.blueteam)
					if(!BlueTeamFlag)
						world<<"<font color=blue size=2>[usr] has recovered the Blue Flag!"
						usr.blueflag=1
						del src
					else
						usr<<"\blue The flag is already on it's stand!"*/