var
	sp=list()
	T_NextRoundList=list()
	T_FightingList=list()
	TournamentMasterList=list()
	NextToFight1
	NextToFight2
	TRWinner
	TRLoser
	TournamentOpen
mob/var
	OneOnOneWins=0
proc
	OneonOne()
		if(TournamentHosted) return
		TournamentHosted=1; TournamentOpen=1; TournamentCount=0; TournamentParticipants=0; TournamentList=new/list; TournamentMasterList=new/list
		for(var/mob/player/p in MasterPlayerList)
			if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","1 vs 1",8)
		spawn(1800)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","1 vs 1",5)
		spawn(3000)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","1 vs 1",3)
		spawn(3600)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","1 vs 1",2)
		spawn(4200)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","1 vs 1",1,60)
		spawn(4800)
			TournamentOpen=0
			TournamentCounter(0)
			if(TournamentCount>1)
				TournamentParticipants=TournamentCount
				spawn(20) OneonOneSpawn()
			else
				for(var/mob/player/B in TournamentList)
					B<<"You were the only entrant in the tournament, so the tournament has been called off."; TournamentHosted=0


	OneonOneSpawn()
		for(var/obj/SpawnPoints/OneOnOne/GeneralPop/G in world) sp+=G
		for(var/mob/player/B in TournamentList)
			TournamentMasterList+=B; B<<"You will now be taken to the arena!"
			var/obj/s=pick(sp)
			spawn(15) {B.protect=1; B.loc=s.loc}
		spawn(20) Tournament1on1Round()

	Tournament1on1Round()
		T_FightingList=new/list
		if(length(TournamentList)==1||!length(TournamentList))
			for(var/mob/player/l in TournamentList) T_NextRoundList+=l
			TournamentList=new/list; T_PassersCheck(); return
		else
			for(var/mob/player/S in TournamentList)
				T_FightingList+=S; TournamentList-=S
				NextToFight1=S; S.ZCoord="Tournament"; S.ZCoordProc(S.ZCoord)
				break
			for(var/mob/player/S in TournamentList)
				T_FightingList+=S; TournamentList-=S
				NextToFight2=S; S.ZCoord="Tournament"; S.ZCoordProc(S.ZCoord)
				break
			T_1on1ActualFightSpawn()

	T_1on1ActualFightSpawn()
		for(var/mob/player/m in TournamentMasterList)
			m<<output("Next to fight will be <u>[NextToFight1]</u> vs. <u>[NextToFight2]</u>!","ann")
		spawn(45)
			var/mob/a=NextToFight1; var/mob/b=NextToFight2
			for(var/obj/SpawnPoints/OneOnOne/S1/s in world) {a.protect=0; a.loc=s.loc}
			for(var/obj/SpawnPoints/OneOnOne/S2/ss in world) {b.protect=0; b.loc=ss.loc}
			T_RoundCheck()

	T_RoundCheck()
		var/tmp/count=0
		for(var/mob/player/P in T_FightingList)
			if(P.dead) {T_FightingList-=P; TournamentMasterList-=P; TournamentList-=P; TRLoser=P}
			count++
		if(count==1)
			for(var/mob/player/m in TournamentMasterList) m<<output("<i>[TRLoser] is eliminated!</i></font>","ann")
			spawn(20)
				for(var/mob/player/P in T_FightingList)
					var/obj/s=pick(sp)
					P.loc=s.loc; P.protect=1; T_NextRoundList+=P; TRWinner=P
				T_RoundPlayerCheck()
		else if(count>1) spawn(20)T_RoundCheck()



	T_RoundPlayerCheck()
		var/check=0
		for(var/mob/player/M in TournamentList) check++
		if(!check) T_PassersCheck()
		else Tournament1on1Round()

	T_PassersCheck()
		if(length(TournamentMasterList)==1)
			for(var/mob/S in TournamentMasterList) WinTournament(S)
		else
			for(var/mob/player/P in T_NextRoundList)
				if(!(P in TournamentList)) TournamentList+=P
			T_NextRoundList=new/list
			Tournament1on1Round()
	WinTournament(mob/W)
		world<<output("<b>[W] has won the 1 on 1 Tournament!</b>","ann"); TournamentHosted=0
		W.ExitArena()
		W.OneOnOneMedal(TournamentParticipants)

mob/proc/OneOnOneMedal(var/P)
	src.OneOnOneWins++; src.TournamentWins++
	switch(P)
		if(2 to 5)
			if(ismob(src) && src.key)
				if(!world.GetMedal("1 on 1 Winner (bronze)", src)) world.SetMedal("1 on 1 Winner (bronze)", src)
				src.gold+=1000; src.StatPoints+=8
				src<<"Congratulations! You have been awarded the <i>bronze</i> 1 on 1 medal!"
				src<<"+1000 Gold!"; src<<"+8 Stat Points!"
		if(6 to 15)
			if(ismob(src) && src.key)
				if(!world.GetMedal("1 on 1 Winner (silver)", src)) world.SetMedal("1 on 1 Winner (silver)", src)
				src.gold+=3000; src.StatPoints+=14
				src<<"Congratulations! You have been awarded the <i>silver</i> 1 on 1 medal!"
				src<<"+3000 Gold!"; src<<"+14 Stat Points!"
		if(16 to 25)
			if(ismob(src) && src.key)
				if(!world.GetMedal("1 on 1 Winner (gold)", src)) world.SetMedal("1 on 1 Winner (gold)", src)
				src.gold+=5000; src.StatPoints+=28
				src<<"Congratulations! You have been awarded the <i>gold</i> 1 on 1 medal!"
				src<<"+5000 Gold!"; src<<"+28 Stat Points!"
		else
			if(ismob(src) && src.key)
				if(!world.GetMedal("1 on 1 Winner (platinum)", src)) world.SetMedal("1 on 1 Winner (platinum)", src)
				src.gold+=10000; src.StatPoints+=40
				src<<"Congratulations! You have been awarded the <i>platinum</i> 1 on 1 medal!"
				src<<"+10,000 Gold!"; src<<"+40 Stat Points!"
	src.StatUpdate_statpoints(); src.StatUpdate_gold()
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