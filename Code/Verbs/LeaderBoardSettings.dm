mob/var
	ShowLevel=1
	ShowTournamentWins=1
	ShowArenaWins=1
	ShowKills=1
	ShowMissions=1
	ShowOnlineTime=1

mob/verb/UpdateLeaderBoard()
	set name="Update Leaderboard"
	set category="Commands"
	set hidden=1
	if(CooldownCheck("LeaderBoard",3600)) return
	usr.LeaderBoardUpdate(); usr<<"Your latest settings and stats have been sent to the leaderboard."



mob/proc/LeaderBoardUpdate()
	set waitfor = 0
//	var/L = list("<font","<h","<div","<style","<hr","<br","<p")   <--- HTML list

	var/OT = "[round(((Hours*60)+Minutes)/60)]"
	var/PlayerLevel = list("Level"="[Level]")
	var/PKills = list("Kills (K/D Ratio)"="[PlayerKills] ([ratio])")
	var/AW
	if(ArenaWins+ArenaLosses>19) AW = list("Arena Wins (Ratio)"="[ArenaWins] ([num2text(round(ArenaRatio,1),4)])")
	else AW = list("Arena Wins (Ratio)"="0 (N/A)")
	var/TW = list("Event Wins"="[EventWins]")
	var/ign
	if(length(name)>30) ign = copytext(name,1,30) + "..."
	else ign=name
	var/playername = list("IGN"="[ign]")
	var/PlayerTime = list("Online Time (hours)"="[OT]")

	world.SetScores(key,list2params(PlayerLevel))
	world.SetScores(key,list2params(TW))
	world.SetScores(key,list2params(AW))
	world.SetScores(key,list2params(PKills))
	world.SetScores(key,list2params(PlayerTime))
	world.SetScores(key,list2params(playername))


mob/proc/LeaderBoardClear()
	var/PlayerLevel = list("")
	var/TW = list("Tournament Wins"="")
	var/AW = list("Arena Wins"="")
	var/PlayerKills = list("Kills"="")
	var/PlayerSMissions = list("S Missions"="")
	var/PlayerAMissions = list("A Missions"="")
	var/PlayerBMissions = list("B Missions"="")
	var/PlayerTime = list("Online Time"="")
	var/playername = list("IGN"="")

	world.SetScores(key,list2params(PlayerLevel))
	world.SetScores(key,list2params(TW))
	world.SetScores(key,list2params(AW))
	world.SetScores(key,list2params(PlayerKills))
	world.SetScores(key,list2params(PlayerSMissions))
	world.SetScores(key,list2params(PlayerAMissions))
	world.SetScores(key,list2params(PlayerBMissions))
	world.SetScores(key,list2params(PlayerTime))
	world.SetScores(key,list2params(playername))