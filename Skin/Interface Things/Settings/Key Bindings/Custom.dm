mob
//	var
	verb
		Settings_KeyBinds()//verb for the main Key Binds button in settings
			set hidden=1
			usr.ShowKeyBinds("misc")
			winset(usr,null,"Settings.SetttingsContent.left=Settings_Keys;Settings_Keys.KeyBindChild.left=Keys_misc;Settings.ContentTitle.text=Key_Bindings")

		Settings_KeyBindings_Hotbar()
			set hidden=1
			usr.ShowKeyBinds("hotbar")
			winset(usr,null,"Settings.SetttingsContent.left=Settings_Keys;Settings_Keys.KeyBindChild.left=Keys_hotbar;Settings.ContentTitle.text=Key_Bindings")

		Settings_KeyBindings_Speedrail()
			set hidden=1
			usr.ShowKeyBinds("speedrail")
			winset(usr,null,"Settings.SetttingsContent.left=Settings_Keys;Settings_Keys.KeyBindChild.left=Keys_Speedrail;Settings.ContentTitle.text=Key_Bindings")

		Macro_Custom()
			set hidden=1
			var/cmd=winget(src,"Settings_Keys.CustomMacro","text")
			if(cmd)
				usr.setSkill(cmd)
				winset(src,"Settings_Keys.CustomMacro","text=''")