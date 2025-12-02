mob
	var
		tmp
			BindScreen
	verb
		BindPane(CMD as text,SCREEN as text,FULLTITLE as text)
			set hidden=1
			usr.SettingMacro=CMD
			usr.BindScreen=SCREEN	//previous screen
			if(!Binds)
				Binds = list()
			usr.BindScreen(FULLTITLE,Binds["[CMD]"])
	proc
		BindScreen(TITLE,CURRENT)
			winset(src,null,{"Settings_Keys.KeyBindChild.left="Keys_SettingsBind"; Keys_SettingsBind.KeyBindTitle.text="[TITLE]"; Keys_SettingsBind.CurrentBind.text="[CURRENT]""})

