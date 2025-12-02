mob/var
	BrainMedal
	GladiatorMedal
	MissionMedal
	FishingMedal
	CraftingMedal
	KillsMedal
	RockMedal
	MedalsWon=0
mob/proc
	Medal_BrainBox(score)
		if(score==10&&!BrainMedal)
			world.SetMedal("Brain Box", src)
			var/s=5; StatPoints+=s
			Achievement_notification("BrainMedal",client)
			src<<"<b>Congratulations! You have been awarded the <i>Brain Box</i> medal."
			src<<"<b>+[s] Stat Points!"
			BrainMedal=1; MedalsWon++
			StatUpdate_statpoints()
	Medal_Gladiator()
		if(ArenaWins>=50&&!GladiatorMedal)
			world.SetMedal("Gladiator", GladiatorMedal)
			var/s=20; StatPoints+=s
			Achievement_notification("Gladiator",client)
			src<<"<b>Congratulations! You have been awarded the <i>Gladiator</i> medal."
			src<<"<b>+[s] Stat Points!"
			GladiatorMedal=1; MedalsWon++
			StatUpdate_statpoints()
	Medal_MissionPossible()
		if(MissionsComplete["Total"]>=200 && MissionMedal==1)
			world.SetMedal("Mission Possible", src)
			var/s=20; StatPoints+=s
			Achievement_notification("MissionPossible",client)
			src<<"<b>Congratulations! You have been awarded the <i>Mission Possible</i> medal."
			src<<"<b>+[s] Stat Points!"
			MissionMedal=1; MedalsWon++
			StatUpdate_statpoints()
	Medal_FishingGuru()
		if(FishingSkill>=100&&!FishingMedal)
			world.SetMedal("Fishing Guru", src)
			var/s=10; StatPoints+=s
			Achievement_notification("FishingGuru",client)
			src<<"<b>Congratulations! You have been awarded the <i>Fishing Guru</i> medal."
			src<<"<b>+[s] Stat Points!"
			FishingMedal=1; MedalsWon++
			StatUpdate_statpoints()
	Medal_CraftingGuru()
		if(CraftingSkill>=100&&!CraftingMedal)
			world.SetMedal("Crafting Guru", src)
			var/s=12; StatPoints+=s
			Achievement_notification("CraftingGuru",client)
			src<<"<b>Congratulations! You have been awarded the <i>Crafting Guru</i> medal."
			src<<"<b>+[s] Stat Points!"
			CraftingMedal=1; MedalsWon++
			StatUpdate_statpoints()
	Medal_MassMurderer()
		if(PlayerKills >= 100 && ratio>1 && !KillsMedal)
			KillsMedal=1
			world.SetMedal("Mass Murderer", src)
			var/s=15; StatPoints+=s
			Achievement_notification("MassMurderer",client)
			src<<"<b>Congratulations! You have been awarded the <i>Mass Murderer</i> medal."
			src<<"<b>+[s] Stat Points!"
			MedalsWon++; StatUpdate_statpoints()
	Medal_YouRock()
		if(!RockMedal)
			world.SetMedal("You rock!", src)
			var/s=10; StatPoints+=s
			Achievement_notification("RockMedal",client)
			src<<"<b>Congratulations! You have been awarded the <i>You rock!</i> medal."
			src<<"<b>+[s] Stat Points!"
			RockMedal=1; MedalsWon++
			StatUpdate_statpoints()