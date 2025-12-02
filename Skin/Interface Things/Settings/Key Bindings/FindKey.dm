mob
	var
		Binds[]
	verb
		maks()
			usr.loadMacro()
		k(k as text)
			set hidden=1
			if(usr.SettingMacro)
				winset(usr,null,{"Keys_SettingsBind.CurrentBind.text="[k]"; FINDKEY.is-visible="false""})

		AcceptKeybind_Settings()
			set hidden=1
			var/k=winget(usr,"Keys_SettingsBind.CurrentBind","text")
			winset(usr,"Settings_Keys.KeyBindChild","left=[usr.BindScreen]")
			usr.Binds[usr.SettingMacro]=k
			usr.ShowKeyBinds()
			usr.ApplyBind(k,usr.SettingMacro)


		FindKey_Settings()
			set hidden=1
			if(!usr.SettingMacro) return
			usr.init_BindLists()
			winshow(usr,"FINDKEY",1)

		DelShortcutKey()
			set hidden=1
			for(var/k in usr.macs)
				world<<"[k]"
				var/cmd=usr.m_cmd[k]
				usr.client.removeMacro("[k]","[cmd]",1,0,0,0)

	proc
		ShowKeyBinds(x)
			if(!Binds) Binds=new()
			if(x=="misc"||!x)
				winset(src,null,"K_OOC.text=[Binds["OOC"]]; K_TALK.text=[Binds["Talk"]]; K_GET.text=[Binds["Get"]]; K_FISH.text=[Binds["Fish"]]; K_DROPGOLD.text=[Binds["Dropgold"]]; K_LOOK.text=[Binds["Look"]]; K_SCREENSHOT.text=[Binds[".screenshot"]]; K_SAVE.text=[Binds["Save"]];\
				K_TECHNIQUES.text=[Binds["TechniquesAll"]]; K_INVENTORY.text=[Binds["OpenInventory" ]]; K_PROFILE.text=[Binds["ProfileButton"]]; K_STATPOINTS.text=[Binds["UseSPS"]]; K_SOCIAL.text=[Binds["OpenSocialWindow"]]; K_SETTINGS.text=[Binds["ShowSettings"]]; K_HELP.text=[Binds["Help"]]; K_BINGOBOOK.text=[Binds["BingoBookButton"]]; K_MAP.text=[Binds["WorldMapButton"]]")

		init_BindLists()
			if(!macs) macs=new()
			if(!m_cmd) m_cmd=new()
			if(!m_shf) m_shf=new()
			if(!m_alt) m_alt=new()
			if(!m_ctrl) m_ctrl=new()
			if(!m_rep) m_rep=new()
			if(!m_rel) m_rel=new()
			if(!Binds) Binds=new()

		ApplyBind(k,cmd)
			if(!macs) macs = list()
			if(!m_cmd) m_cmd = list()
			if(!m_shf) m_shf = list()
			if(!m_alt) m_alt = list()
			if(!m_ctrl) m_ctrl = list()
			if(!m_rep) m_rep = list()
			if(!m_rel) m_rel = list()
			if(!Binds) Binds = list()
			switch(winget(src,"Keys_SettingsBind.SHIFT","is-checked"))
				if("true") m_shf[k]=1
			switch(winget(src,"Keys_SettingsBind.ALT","is-checked"))
				if("true") m_alt[k]=1
			switch(winget(src,"Keys_SettingsBind.CTRL","is-checked"))
				if("true") m_ctrl[k]=1
			switch(winget(src,"Keys_SettingsBind.REPEAT","is-checked"))
				if("true") m_rep[k]=1
			switch(winget(src,"Keys_SettingsBind.RELEASE","is-checked"))
				if("true") m_rel[k]=1
			macs[k]=usr.SettingMacro
			m_cmd[k]=cmd
			client.addMacro(k,m_cmd[k],m_rep[k],m_rel[k],m_shf[k],m_alt[k],m_ctrl[k])
			SettingMacro=null