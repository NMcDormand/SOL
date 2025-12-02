/*
* universal event timer
 * lvl 5 gm verbs to control / manually fix tournys (declarewinner, disqualify, endtourny, etc.)
 * player verbs to see / know about tourny (whens next/current tourny, spy tourny participant, view current tourny stats)
 * generalize village, clan, and guild tourny as 'GroupTournaments'
 * make reward for tournys worthwhile (20k gold + 5k per kill and a similar idea for sps)
 * Implement CTF
 */
var
	TournamentHosted
	TournamentList=list()
	TournamentCount
	TournamentParticipants

mob/var
	ClanWarWins=0
	BattleRoyaleWins=0
	VillageWarWins=0
	OneonOneWins=0
	TournamentWins=0
	GuildWarWins=0
	tmp/T_Countdown

proc/StartTournament(var/t)
	set waitfor = 0
	if(t)
		switch(pick(EventOrder))
			if("Battle Royale") BattleRoyale()
			if("Clan War") ClanWar()
			if("1 on 1") OneonOne()
			if("Village") VillageWar()
	else
		switch(pick(EventOrder))
			if("Battle Royale") BattleRoyale()
			if("Clan War") ClanWar()
			if("1 on 1") OneonOne()
			if("Village") VillageWar()
		spawn(EventTimer) StartTournament()

//----------------------------------------------------------------------------------------------------
proc
	TournamentCounter(var/C)
		for(var/mob/player/P in TournamentList) C++
		TournamentCount=C

	TournamentCountdown()
		for(var/mob/player/P in TournamentList)
			P.T_Countdown=5
			spawn()
				while(P.T_Countdown)
					P<<"<font size=3>[P.T_Countdown]</font>"
					P.T_Countdown--
				P<<"<font size=3>Fight!</font>";
				P.T_Countdown=0
				P.protect=0

	TournamentCheck_LastMan()
		TournamentCounter(0)
		if(TournamentCount<2)
			for(var/mob/player/T in TournamentList)
				T<<"Congratulations! You have won the tournament!"
				T.BattleRoyaleMedal(TournamentParticipants)
				T.ExitArena()
			TournamentHosted=0
		else
			spawn(33) TournamentCheck_LastMan()



