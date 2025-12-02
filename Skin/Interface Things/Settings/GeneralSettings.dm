mob
	var
		StatusBar
		FinishMSG
		LanguageFilter=1
		FriendRequests=1
		GuildRequests=1
		ArenaOff
		popupsoff
		popuplocation=list("0,0")
		Settings[]
		popupcoordsX=0
		popupcoordsY=0
	verb
		Apply_General()
			set hidden=1
			Apply_FinishMessage()
			Apply_ArenaChallenges()
			Apply_FriendRequests()
			Apply_GuildRequests()
			Apply_LanguageFilter()
			Apply_StatusBar()
			Apply_PopUps()
			Apply_ProfilePrivacy()
			Apply_PopupCoords()
			Apply_DOLAYS()
			Apply_DMSG()
			Apply_TINVITE()
			Apply_VINVITE()
	proc
		Apply_ScreenSize()
			var/x=winget(src,"Settings_General.MapSizeSlider","value")
			x=DoRange(round((text2num(x)/10)))
			Settings["Screen"]=x
			if(Settings["Screen"])
				screensize=Settings["Screen"]
				client.view=Settings["Screen"]
		Apply_FinishMessage()
			var/x=winget(src,"Settings_General.FinishMessage","text")
			if(x == "Type your finish message here")
				return
			//HTML filter
			if(length(x)<160) FinishMSG=x
			else src<<"Finish message too long; it must be under 160 characters."
		Apply_ArenaChallenges()
			switch(winget(src,"Settings_General.ArenaChallenges_YES","is-checked"))
				if("true") ArenaOff=0
				else ArenaOff=1
		Apply_FriendRequests()
			switch(winget(src,"Settings_General.FriendRequests_YES","is-checked"))
				if("true") FriendRequests=1
				else FriendRequests=0
		Apply_GuildRequests()
			switch(winget(src,"Settings_General.GuildRequests_YES","is-checked"))
				if("true") GuildRequests=1
				else GuildRequests=0
		Apply_LanguageFilter()
			switch(winget(src,"Settings_General.LanguageFilter_YES","is-checked"))
				if("true") LanguageFilter=1
				else LanguageFilter=0
		Apply_StatusBar()
			switch(winget(src,"Settings_General.StatusBar_YES","is-checked"))
				if("true") {StatusBar=1; winset(src,"mainwindow","statusbar=true")}
				else {StatusBar=0; winset(src,"mainwindow","statusbar=false")}
		Apply_PopUps()
			switch(winget(src,"Settings_General.PopUp_YES","is-checked"))
				if("true") popupsoff=0
				else popupsoff=1
		Apply_ProfilePrivacy()
			switch(winget(src,"Settings_General.Profile_YES","is-checked"))
				if("true") AllowViewers=1
				else AllowViewers=0
		Apply_PopupCoords()
			var/x=winget(src,"Settings_General.PopupX","text")
			var/y=winget(src,"Settings_General.PopupY","text")
			x=text2num(x)
			y=text2num(y)
			if(isnum(x)&&isnum(y))
				x=max(x,0)
				x=min(x,999)
				y=max(y,0)
				y=min(y,999)
				popuplocation=list("[x],[y]")
				popupcoordsX=x; popupcoordsY=y
		Apply_DMSG()
			switch(winget(usr,"Settings_General.DMGMSG_YES","is-checked"))
				if("true")
					if(!(usr in DMGMSGlist))
						DMGMSGlist+=usr
					usr.HideDMGMSG=0
				if("false")
					if(usr in DMGMSGlist)
						DMGMSGlist-=usr
					usr.HideDMGMSG=1
		Apply_DOLAYS()
			switch(winget(src,"Settings_General.DOLAYS_YES","is-checked"))
				if("true") DOLAYS = 1
				else DOLAYS = 0
		Apply_TINVITE()
			switch(winget(usr,"Settings_General.S_TINVITES_ON","is-checked"))
				if("true")
					if(!usr.TeamInvites)
						usr.TeamInvites=1
						usr << "You will now receive invites to teams"
				if("false")
					if(usr.TeamInvites)
						usr.TeamInvites=0
						usr << "You will no longer receive invites to teams"

		Apply_VINVITE()
			switch(winget(usr,"Settings_General.SVINVITES_ON","is-checked"))
				if("true")
					if(usr.IgnoreVillageInvite)
						usr.IgnoreVillageInvite = 0
						usr << "You will now receive invites to villages"
				else
					if(!usr.IgnoreVillageInvite)
						usr.IgnoreVillageInvite = 1
						usr << "You will no longer receive invites to villages"
proc
	DoRange(x)
		if(x==0) x=4
		else if(x in 1 to 2) x=5
		else if(x in 3 to 4) x=6
		else if(x in 5 to 6) x=7
		else if(x in 7 to 8) x=8
		else if(x in 9 to 10) x=9
		return x