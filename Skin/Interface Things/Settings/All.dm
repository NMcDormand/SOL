mob
	verb
		ShowSettings()
			set hidden=1
			if(usr.TakingExam||!usr.client||!(usr.loggedin)) return
			usr.SetButtons()
			winshow(usr,"Settings",1)
		Set_General()
			set hidden=1
			winset(src,"Settings.ContentTitle","text='General'")
		Set_Audio()
			set hidden=1
			winset(src,"Settings.ContentTitle","text='Audio'")
		Set_KeyBindings()
			set hidden=1
			winset(src,"Settings.ContentTitle","text='Key Bindings'")
		Set_Alerts()
			set hidden=1
			winset(src,"Settings.ContentTitle","text='Alerts'")
	proc
		ApplyAll()
			//general
			Apply_FinishMessage()
			Apply_ArenaChallenges()
			Apply_FriendRequests()
			Apply_GuildRequests()
			Apply_LanguageFilter()
			Apply_StatusBar()
			Apply_ScreenSize()
			Apply_PopUps()
			Apply_PopupCoords()
			Apply_ProfilePrivacy()

		SetButtons()
			if(!Settings) Settings=new()
			//General
			if(StatusBar) winset(src,"Settings_General.StatusBar_YES","is-checked=true")
			else winset(src,"Settings_General.StatusBar_NO","is-checked=true")
			if(FinishMSG) winset(src,"Settings_General.FinishMessage","text='[FinishMSG]'")
			else winset(src,"Settings_General.FinishMessage","text='Type your finish message here'")
			if(!ArenaOff) winset(src,"Settings_General.ArenaChallenges_YES","is-checked=true")
			else winset(src,"Settings_General.ArenaChallenges_NO","is-checked=true")
			if(FriendRequests) winset(src,"Settings_General.FriendRequests_YES","is-checked=true")
			else winset(src,"Settings_General.FriendRequests_NO","is-checked=true")
			if(GuildRequests) winset(src,"Settings_General.GuildRequests_YES","is-checked=true")
			else winset(src,"Settings_General.GuildRequests_NO","is-checked=true")
			if(LanguageFilter) winset(src,"Settings_General.LanguageFilter_YES","is-checked=true")
			else winset(src,"Settings_General.LanguageFilter_NO","is-checked=true")
			if(!(popupsoff)) winset(src,"Settings_General.PopUp_YES","is-checked=true")
			else winset(src,"Settings_General.PopUp_NO","is-checked=true")
			if(DOLAYS) winset(src,"Settings_General.DOLAYS_Yes","is-checked=true")
			else winset(src,"Settings_General.DOLAYS_NO","is-checked=true")
			if(HideDMGMSG) winset(src,"Settings_General.DMGMSG_NO","is-checked=true")
			else winset(src,"Settings_General.DMGMSG_YES","is-checked=true")
			if(TeamInvites) winset(src,"Settings_General.S_TINVITES_ON","is-checked=true")
			else winset(src,"Settings_General.S_TINVITES_OFF","is-checked=true")
			if(!IgnoreVillageInvite) winset(src,"Settings_General.SVINVITES_ON","is-checked=true")
			else winset(src,"Settings_General.SVINVITES_OFF","is-checked=true")

			//Audio
			var
				X
				Y
			X=round( text2num(winget (src,"Settings_Audio.SFX_Slider","value") ) )
			Y=Settings["SFX"]
			if(X!=Y) winset(src,"Settings_Audio.SFX_Slider","value=[Y]")
			X=round( text2num(winget (src,"Settings_Audio.Music_Slider","value") ) )
			Y=Settings["MUSIC"]
			if(x!=y) winset(src,"Settings_Audio.Music_Slider","value=[Y]")