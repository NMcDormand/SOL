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
		if(score==10&&!src.BrainMedal)
			world.SetMedal("Brain Box", src)
			var/s=5; src.StatPoints+=s
			src.Achievement_notification("BrainMedal",client)
			src<<"<b>Congratulations! You have been awarded the <i>Brain Box</i> medal."
			src<<"<b>+[s] Stat Points!"
			src.BrainMedal=1; src.MedalsWon++
			src.StatUpdate_statpoints()
	Medal_Gladiator()
		if(src.ArenaWins>=50&&!src.GladiatorMedal)
			world.SetMedal("Gladiator", src.GladiatorMedal)
			var/s=20; src.StatPoints+=s
			src.Achievement_notification("Gladiator",client)
			src<<"<b>Congratulations! You have been awarded the <i>Gladiator</i> medal."
			src<<"<b>+[s] Stat Points!"
			src.GladiatorMedal=1; src.MedalsWon++
			src.StatUpdate_statpoints()
	Medal_MissionPossible()
		if(src.MissionCount>=200&&!src.MissionMedal)
			world.SetMedal("Mission Possible", src)
			var/s=20; src.StatPoints+=s
			src.Achievement_notification("MissionPossible",client)
			src<<"<b>Congratulations! You have been awarded the <i>Mission Possible</i> medal."
			src<<"<b>+[s] Stat Points!"
			src.MissionMedal=1; src.MedalsWon++
			src.StatUpdate_statpoints()
	Medal_FishingGuru()
		if(src.FishingSkill>=100&&!src.FishingMedal)
			world.SetMedal("Fishing Guru", src)
			var/s=10; src.StatPoints+=s
			src.Achievement_notification("FishingGuru",client)
			src<<"<b>Congratulations! You have been awarded the <i>Fishing Guru</i> medal."
			src<<"<b>+[s] Stat Points!"
			src.FishingMedal=1; src.MedalsWon++
			src.StatUpdate_statpoints()
	Medal_CraftingGuru()
		if(src.CraftingSkill>=100&&!src.CraftingMedal)
			world.SetMedal("Crafting Guru", src)
			var/s=12; src.StatPoints+=s
			src.Achievement_notification("CraftingGuru",client)
			src<<"<b>Congratulations! You have been awarded the <i>Crafting Guru</i> medal."
			src<<"<b>+[s] Stat Points!"
			src.CraftingMedal=1; src.MedalsWon++
			src.StatUpdate_statpoints()
	Medal_MassMurderer()
		if(src.Kills>=100&&src.ratio>1&&!src.KillsMedal)
			src.KillsMedal=1
			world.SetMedal("Mass Murderer", src)
			var/s=15; src.StatPoints+=s
			src.Achievement_notification("MassMurderer",client)
			src<<"<b>Congratulations! You have been awarded the <i>Mass Murderer</i> medal."
			src<<"<b>+[s] Stat Points!"
			src.MedalsWon++; src.StatUpdate_statpoints()
	Medal_YouRock()
		if(!src.RockMedal)
			world.SetMedal("You rock!", src)
			var/s=10; src.StatPoints+=s
			src.Achievement_notification("RockMedal",client)
			src<<"<b>Congratulations! You have been awarded the <i>You rock!</i> medal."
			src<<"<b>+[s] Stat Points!"
			src.RockMedal=1; src.MedalsWon++
			src.StatUpdate_statpoints()