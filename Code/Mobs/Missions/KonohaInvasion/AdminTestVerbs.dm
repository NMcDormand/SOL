mob/VerbHolder/Admin/Creator/verb
	AddSelfToInvasionList(mob/M in world)
		set name="Add Mob to mission"
		set category="Invasion"
		if(!(M in KI_Participants))KI_Participants+=M
		usr<<"[M] is now part of the invasion mission!"
	ModifyScore(mob/M in KI_Participants)
		set name="Modify Mission Score"
		set category="Invasion"
		var/s=input("","") as null|num
		if(s) {M.KonohaInvasionPoints=s; usr<<"[M]'s score is now [M.KonohaInvasionPoints]"; M.Refresh_InvasionScore()}
	StartMission()
		set name="Initiate S Rank Mission"
		set category="Invasion"
		KonohaInvasionMission()
	KillAllNPCs()
		set name="Kill All Quest NPCs"
		set category="Invasion"
		for(var/mob/Hittable/Responsive/NPC/KonohaInvasion/k in KonohaInvasionAIList) k.KillMe(usr)

	CheckWin()
		set name="Check for quest completion"
		set category="Invasion"
		KonohaInvasionCheck_Win()
