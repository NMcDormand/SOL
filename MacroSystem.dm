client
	verb
		MacroWindowOpen()
			winshow(src, "MacroWindowMain", 1)
			ButtonUpdate()
		MacroWindowClose()
			winshow(src, "MacroWindowMain", 0)
		CheckRow(key as text)
			ReadMacroFileRow(src, key)

client
	verb
		ButtonUpdate()
			world << "buttonupdate"
			var/OnColor  = "#cfcf40"
			var/OffColor = "#969696"
			LoopThroughMacroFileRows(src, 1)
			KeyModBitMask = 0

		//Shift state
			if(winget(usr, "MacroWindowMain.Shift", "is-checked") == "true")
				winset(usr, "MacroWindowMain.Shift", "background-color=[OnColor]")
				KeyModBitMask += 1
			else
				winset(usr, "MacroWindowMain.Shift", "background-color=[OffColor]")

		//Ctrl state
			if(winget(usr, "MacroWindowMain.Ctrl", "is-checked") == "true")
				winset(usr, "MacroWindowMain.Ctrl", "background-color=[OnColor]")
				KeyModBitMask += 2
			else
				winset(usr, "MacroWindowMain.Ctrl", "background-color=[OffColor]")

		//Alt state
			if(winget(usr, "MacroWindowMain.Alt", "is-checked") == "true")
				winset(usr, "MacroWindowMain.Alt", "background-color=[OnColor]")
				KeyModBitMask += 4
			else
				winset(usr, "MacroWindowMain.Alt", "background-color=[OffColor]")

			LoopThroughMacroFileRows(src, 0)


	proc
		BitMaskDecode(var/BitMask)
			world << "BitMaskDecode"
			var/Decode = ""
			if(BitMask & 1)
				Decode += "Shift+"
			if(BitMask & 2)
				Decode += "Ctrl+"
			if(BitMask & 4)
				Decode += "alt+"
			return Decode
client
	verb
		RepeaterSwitch(id as text)
			var/RepeaterID = copytext(id, 5)
			var/row = ReadMacroFileRow(src, "[KeyModBitMask][RepeaterID]")
			Create_Macro(row["skill"], "[KeyModBitMask][RepeaterID]", row["command"], 0)

//-------------------------------------------------
//FRY the following scripts were needed to be modified for this system to work
//Techniques.dm at the end of the MouseDrop function add ..() on line 134
//InventoryButtons.dm at the end of the MouseDrop function add ..() on line 53
//login.dm added a few lines at login()

client
	New()
		..()


	var/tableName = ""
	var/drag_skill_command = ""
	var/grid_id = ""
	var/MacroWindow = "MacroWindowMain.MacroWindow"
	var/Repeater = ""
	var/drag_skill = ""
	var/KeyModBitMask = 0



	proc/Create_Macro(skill, keybind, command, Move)
		world << "Create_Macro"
		if(winget(usr, "[MacroWindow].Rep_[keybind]", "is-checked") == "true")
			Repeater = "+REP"
		else
			Repeater = ""
		var/key = BitMaskDecode(copytext(keybind ,0 ,1)) + copytext(keybind, 0,)
		if(Move == 1)
			world << "Macro for Key:[key][Repeater] Sucessfully Unbound"
			ClearMacroFileRow(src, "[KeyModBitMask][keybind]")
		else
			world << "Macro Succesfully Created:[key][Repeater],[command]"
			WriteMacroFileRow(src, "[KeyModBitMask][keybind]", command, skill)
		winset(usr, "macro_[key]",
			"parent=Game;name=\"[key][Repeater]\";command=\"[command]\"")






	proc/check_Window_Id(VariableToCheck)
		if(copytext(VariableToCheck, 1, length("MacroWindow") + 1) == "MacroWindow")
			return TRUE
		else
			return FALSE




	proc/get_grid_id(VariableToCheck)
		grid_id = copytext(VariableToCheck, length("MacroWindow") + 2)




	proc/resetvariables()
		world << "resetvariables"
		drag_skill_command = ""
		grid_id = ""
		src.mob.mouse_drag_pointer = null
		drag_skill = ""




obj/SkillCards
	MouseDown(object,location,control,params)
		world << "mousedown"
		usr.client.mob.mouse_drag_pointer = icon_state
		usr.client.drag_skill_command = cmdstring


	MouseDrop(over_object, src_location, over_location, src_control, over_control, params)
		world << "mousedrop"
		if(usr.client.check_Window_Id(over_control) == FALSE)
			usr.client.resetvariables()
			return
		else
			usr.client.get_grid_id(over_control)
			usr << output(src, "[over_control]:0,0")
			usr.client.drag_skill = src
			usr.client.Create_Macro(usr.client.drag_skill, usr.client.grid_id, usr.client.drag_skill_command, 0)

		if(usr.client.check_Window_Id(src_control) == TRUE)
			usr.client.get_grid_id(src_control)
			usr.client.Create_Macro(usr.client.drag_skill, usr.client.grid_id, "", 1)
			usr << output("", "[src_control]:0,0")
		usr.client.resetvariables()