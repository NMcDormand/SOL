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
	var/KeyModifierSum = 0
	verb
		ButtonUpdate()



			if(winget(usr, "MacroWindowMain.Shift", "is-checked") == "true")
				winset(usr, "MacroWindowMain.Shift", "background-color=#cfcf40")
				KeyModifierSum += 1
			else
				winset(usr, "MacroWindowMain.Shift", "background-color=#969696")


			if(winget(usr, "MacroWindowMain.Ctrl", "is-checked") == "true")
				winset(usr, "MacroWindowMain.Ctrl", "background-color=#cfcf40")
				KeyModifierSum += 2
			else
				winset(usr, "MacroWindowMain.Ctrl", "background-color=#969696")


			if(winget(usr, "MacroWindowMain.Alt", "is-checked") == "true")
				winset(usr, "MacroWindowMain.Alt", "background-color=#cfcf40")
				KeyModifierSum += 4
			else
				winset(usr, "MacroWindowMain.Alt", "background-color=#969696")


			winset(usr, "MacroWindowMain.Pane", "left=MacroWindow[KeyModifierSum]")
			winset(usr, "MacroWindowMain.WindowID", "text=MacroWindow[KeyModifierSum]")

client
	verb
		RepeaterSwitch(id as text)
			var/RepeaterID = copytext(id, 5, 6)
			var/row = ReadMacroFileRow(src, RepeaterID)
			var/rowcommand = row["command"]
			Modifier_State("MacroWindow[KeyModifierSum]", RepeaterID)
			Create_Macro(row["skill"], RepeaterID, rowcommand, 0)

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
	var/window_id = "MacroWindow0"
	var/state = ""
	var/Repeater = ""
	var/drag_skill = ""



	proc/Create_Macro(skill, keybind, command, Move)
		Modifier_State(window_id, keybind)
		if(Move == 1)
			world << "Macro for Key:[state][keybind] Sucessfully Unbound"
			ClearMacroFileRow(src, keybind)
		else
			world << "Macro Succesfully Created:[state][keybind],[command]"
			WriteMacroFileRow(src, keybind, command, skill)
		winset(usr, "macro_[state][keybind]",
			"parent=Game;name=\"[state][keybind][Repeater]\";command=\"[command]\"")






	proc/check_Window_Id(VariableToCheck)
		window_id = winget(usr, "MacroWindowMain.WindowID", "text")
		if(copytext(VariableToCheck, 1, length(window_id) + 1) == window_id)
			return TRUE
		else
			return FALSE




	proc/get_grid_id(VariableToCheck)
		grid_id = copytext(VariableToCheck, length(window_id) + 2)




	proc/resetvariables()
		drag_skill_command = ""
		grid_id = ""
		src.mob.mouse_drag_pointer = null
		drag_skill = ""




	proc/Modifier_State(window_id, keybind)
		state = ""
		if(winget(usr, "MacroWindowMain.Shift", "is-checked") == "true")
			state += "Shift+"
		if(winget(usr, "MacroWindowMain.Ctrl", "is-checked") == "true")
			state += "Ctrl+"
		if(winget(usr, "MacroWindowMain.Alt", "is-checked") == "true")
			state += "Alt+"
		if(winget(usr, "[window_id].Rep_[keybind]", "is-checked") == "true")
			Repeater += "+REP"
		if(winget(usr, "[window_id].Rep_[keybind]", "is-checked") == "false")
			Repeater = ""
		return state



obj/SkillCards
	MouseDown(object,location,control,params)
		usr.client.window_id = winget(usr, "MacroWindowMain.WindowID", "text")
		usr.client.mob.mouse_drag_pointer = icon_state
		usr.client.drag_skill_command = cmdstring


	MouseDrop(over_object, src_location, over_location, src_control, over_control, params)
		if(usr.client.check_Window_Id(over_control) == FALSE)
			usr.client.resetvariables()
			return
		else
			usr.client.get_grid_id(over_control)
			usr << output(src, "[over_control]:0,0")
			world << "[src]_[over_control]"
			usr.client.drag_skill = src
			usr.client.Create_Macro(usr.client.drag_skill, usr.client.grid_id, usr.client.drag_skill_command, 0)

		if(usr.client.check_Window_Id(src_control) == TRUE)
			usr.client.get_grid_id(src_control)
			usr.client.Create_Macro(usr.client.drag_skill, usr.client.grid_id, "", 1)
			usr << output("", "[src_control]:0,0")
		usr.client.resetvariables()