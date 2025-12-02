mob
	verb
		MacroWindowOpen()
			winshow(src, "MacroWindow", 1)
			ButtonUpdate()
		MacroWindowClose()
			winshow(src, "MacroWindow", 0)
mob
	verb
		ButtonUpdate()
			if(winget(usr, "MacroWindow.Shift", "is-checked") == "true")
				winset(usr, "MacroWindow.Shift", "background-color=#cfcf40")
			else
				winset(usr, "MacroWindow.Shift", "background-color=#969696")

			if(winget(usr, "MacroWindow.Ctrl", "is-checked") == "true")
				winset(usr, "MacroWindow.Ctrl", "background-color=#cfcf40")
			else
				winset(usr, "MacroWindow.Ctrl", "background-color=#969696")

			if(winget(usr, "MacroWindow.Alt", "is-checked") == "true")
				winset(usr, "MacroWindow.Alt", "background-color=#cfcf40")
			else
				winset(usr, "MacroWindow.Alt", "background-color=#969696")

//-------------------------------------------------
//FRY the following scripts were needed to be modified for this system to work
//Techniques.dm at the end of the MouseDrop function add ..() on line 134
//InventoryButtons.dm at the end of the MouseDrop function add ..() on line 53


obj/SkillCards
	New()
		..()


	var/drag_skill = ""
	var/grid_id = ""
	var/window_id = "MacroWindow"
	var/state = ""


	proc/Create_Macro(key, command, Move)
		winset(usr, "macro_[state][key]","parent=Game;name=[state][key];command=\"[command]\"")
		if(Move == TRUE)
			world << "Macro succesfully moved:[state][key], [command]"
		else
			world << "Macro succesfully created:[state][key], [command]"


	proc/check_Window_Id(VariableToCheck)
		if(copytext(VariableToCheck, 1, length(window_id) + 1) == window_id)
			return TRUE
		else
			return FALSE


	proc/get_grid_id(VariableToCheck)
		grid_id = copytext(VariableToCheck, length(window_id) + 2)


	proc/resetvariables()
		drag_skill = ""
		grid_id = ""
		mouse_drag_pointer = null
		state = ""


	proc/Button_state()
		if(winget(usr, "MacroWindow.Shift", "is-checked") == "true")
			state += "SHIFT+"
		if(winget(usr, "MacroWindow.Ctrl", "is-checked") == "true")
			state += "CTRL+"
		if(winget(usr, "MacroWindow.Alt", "is-checked") == "true")
			state += "ALT+"


	MouseDown(object,location,control,params)
		Button_state()
		mouse_drag_pointer = icon_state
		drag_skill = cmdstring


	MouseDrop(over_object, src_location, over_location, src_control, over_control, params)
		if(check_Window_Id(over_control) == FALSE)
			resetvariables()
			world << "invalid placement"
			return

		else
			get_grid_id(over_control)
			usr << output(src, "[over_control]:0,0")
			Create_Macro(grid_id, drag_skill)
			if(check_Window_Id(src_control) == TRUE)
				get_grid_id(src_control)
				Create_Macro(grid_id, "", TRUE)
				usr << output("", "[src_control]:0,0")
			resetvariables()







//-------------------------------------------------