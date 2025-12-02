mob
	verb
		Reset_AllSettings()
			set hidden=1
			var/x=input("Type 'reset' if you are sure you want to reset all settings.","Are you sure you want to reset ALL settings?") as text|null
			if(x=="reset")
				usr.R_General()
				usr.R_Audio()
				usr.R_Keys()
				usr.R_Alerts()
				usr.SetButtons()

		Reset_General()
			set hidden=1
			var/x=input("Type 'reset' if you are sure you want to reset all settings.","Are you sure you want to reset ALL settings?") as text|null
			if(x=="reset") {usr.R_General(); usr.SetButtons()}

		Reset_Audio()
			set hidden=1
			usr.R_Audio()
			usr.SetButtons()

		Reset_Keys()
			set hidden=1
			var/x=input("Type 'reset' if you are sure you want to reset all settings.","Are you sure you want to reset ALL settings?") as text|null
			if(x=="reset") {usr.R_Keys(); usr.SetButtons()}

		Reset_Alerts()
			set hidden=1
			var/x=input("Type 'reset' if you are sure you want to reset all settings.","Are you sure you want to reset ALL settings?") as text|null
			if(x=="reset") {usr.R_Alerts(); usr.SetButtons()}
	proc
		R_General()
			usr.Settings["Screen"]=9
			screensize=Settings["Screen"]
			client.view=Settings["Screen"]
			FinishMSG=null
			ArenaOff=0
			FriendRequests=1
			GuildRequests=1
			LanguageFilter=1
			StatusBar=0
			winset(src,"mainwindow","statusbar=false")
			popupsoff=0
			popuplocation=list("0,0")
			popupcoordsX=0; popupcoordsY=0

		R_Audio()
			Settings["SFX"]=80
			Settings["MUSIC"]=70

		R_Keys()
			return

		R_Alerts()
			return