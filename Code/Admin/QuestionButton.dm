var/reportType

mob/verb
	QuestionMark() // Question Mark on the Skin
		var Choose = list("About","Give a Suggestion", "Report a Bug", "Reset Hotbar", "Rebirth", "Rules", "Server Info", "Skin Reset", "Stuck", "Update Log")
		if(AdminLevel)
			Choose += "Admin Window"
		else
			Choose += "Command Window"
		var/EN = "<font color=\"#00FF00\">Enabled</font>"
		var/DN = "<font color=\"#FF0000\">Disabled</font>"
		var/Choice = input(src,"What would you like to do?","Help Menu") as null|anything in  Choose
		if(Choice)
			switch(Choice)
				if("Skin Reset")
					alert("If your Skin isn't instantly reset to defaults, close and log back in to force the change")
					winset(usr, null, "reset=true")
					usr.LoadSkin()
					usr.LoadHUD()
					usr.RefreshPlayerStats()
				if("Rebirth")
					Rebirth()
				if("Reset Hotbar")
					for(var/obj/SkillCards/S in usr.contents)
						S.slot = list()
						S.OnHotBar = 0
					PreLoadHotBar()
				if("Server Info")
					var/motd_display = {"
					<html>
						<head>
							<title>Game Settings</title>
							<style>
								body {
									background-color: '#000000';
									color: '#ffffff'
								}
							</style>
						</head>
						<body>
							Welcome to Shinobi of Myth, hosted by [world.host]! <br />
							<br />
							<u>Message of the Day</u>
							<br />
							[motd_custom]
							<br /><br />
							<u>Experience Gains</u><br /><br />
							[EXPGains_Stamina]x Stamina Gains <br />
							[EXPGains_Chakra]x Chakra Gains <br />
							[EXPGains_Taijutsu]x Taijutsu Gains <br />
							[EXPGains_Ninjutsu]x Ninjutsu Gains <br />
							[EXPGains_Genjutsu]x Genjutsu Gains <br />

							<br /><br />
							<u>Rebirth Settings</u><br /><br />
							[RebirthOffer] Rebirth Offer Interval <br />
							[RebirthCap] Rebirth Cap <br />
							[RebirthPercentage * 100]% Rebirth Percentage <br />
							[CatchUP * 100]% Catch up Rate <br />
							[ForcedRebirth] Permanent Death Count <br />

							<br /><br />
							<U>Clan Settings</u>
							<br><br>
							<br>[Clan_Aburame_Enabled ? EN : DN] - Aburame
							<br>[Clan_Akimichi_Enabled ? EN : DN] - Akimichi
							<br>[Clan_Clay_Enabled ? EN : DN] - Clay
							<br>[Clan_Hyuuga_Enabled ? EN : DN] - Hyuuga
							<br>[Clan_Inuzuka_Enabled ? EN : DN] - Inuzuka
							<br>[Clan_Kaguya_Enabled ? EN : DN] - Kaguya
							<br>[Clan_Nara_Enabled ? EN : DN] - Nara
							<br>[Clan_Otsutsuki_Enabled ? EN : DN] - Otsutsuki
							<br>[Clan_Sand_Enabled ? EN : DN] - Sand
							<br>[Clan_Sarutobi_Enabled ? EN : DN] - Sarutobi
							<br>[Clan_Senju_Enabled ? EN : DN] - Senju
							<br>[Clan_TaiSpec_Enabled ? EN : DN] - Taijutsu Specialist
							<br>[Clan_Uchiha_Enabled ? EN : DN] - Uchiha
							<br>[Clan_Uzumaki_Enabled ? EN : DN] - Uzumaki
							<br>[Clan_Haku_Enabled ? EN : DN] - Yuki
						</body>
					</html>
					"}
					src << browse(motd_display, "window=hello;size=500x300")
				if("Update Log")
					src << browse(updateLogNotes, "window=hello;size=700x500")
				if("Rules")
					src << browse(Rules, "window=Check History;size=800x500")
				if("Stuck")
					stuckProck();
				if("Give a Suggestion")
					src << link("http://www.byond.com/forum/?forum=7706&command=add_post")
				if("Report a Bug")
					usr << link("http://www.byond.com/forum/?forum=7705&command=add_post")
				if("About")
					AboutSoL()
				if("Admin Window","Command Window")
					AdminWindow()

mob
	var
		stuckTimer=0
		stuckUsage=0
	proc
		stuckProck()
			if(stuckUsage) {src<<"You are currently respawning, move if you wish to cancel!"; return;}
			if(stuckTimer) {src<<"You have respawned recently, please wait [stuckTimer] minutes before respawning again!"; return;} //If respawn timer
			if(VillageJailed)
				src << "You are currently stuck in the Village Jail, we cant spring you from this one"
				return
			if(Arena||choosing||jailed) return
			//If arena
			//If s5
			//If DOing a mission
			switch(alert("Would you like to return to your village? Please do NOT move if yes.","I'm Stuck!","Yes","No"))
				if("Yes")
					stuckTimer=30;
					stuckUsage=1;
					src<<"Respawning in 60 seconds, moving will cancel this!"
					spawn(300)
						if(stuckUsage)
							src<<"Respawning in 30 seconds, moving will cancel this!"
					spawn(600)
						if(stuckUsage)
							SpawnWhere()
							stuckUsage=0
				if("No")
					return
			//src<<"Not actually in yet sorry =/"
		BugReport(message)
			set hidden=1
			message = "([time2text(world.realtime)]) [key]: [message]"
			text2file(message, "Reports/Bugs.txt")
			src << "Your bug has been reported!"
		Suggestion(message)
			set hidden=1
			message = "([time2text(world.realtime)]) [key]: [message]"
			text2file(message, "Reports/Suggestions.txt")
			src << "Your suggestion has been noted!"