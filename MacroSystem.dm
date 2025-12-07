mob
	verb
		MacroWindowOpen()
			winshow(src, "MacroWindowMain", 1)
			ButtonUpdate()
		MacroWindowClose()
			winshow(src, "MacroWindowMain", 0)
mob
	verb
		ButtonUpdate()


			var/Sum = 0
			if(winget(usr, "MacroWindowMain.Shift", "is-checked") == "true")
				winset(usr, "MacroWindowMain.Shift", "background-color=#cfcf40")
				Sum += 1
			else
				winset(usr, "MacroWindowMain.Shift", "background-color=#969696")


			if(winget(usr, "MacroWindowMain.Ctrl", "is-checked") == "true")
				winset(usr, "MacroWindowMain.Ctrl", "background-color=#cfcf40")
				Sum += 2


			else
				winset(usr, "MacroWindowMain.Ctrl", "background-color=#969696")


			if(winget(usr, "MacroWindowMain.Alt", "is-checked") == "true")
				winset(usr, "MacroWindowMain.Alt", "background-color=#cfcf40")
				Sum += 4


			else
				winset(usr, "MacroWindowMain.Alt", "background-color=#969696")


			winset(usr, "MacroWindowMain.Pane", "left=MacroWindow[Sum]")
			winset(usr, "MacroWindowMain.WindowID", "text=MacroWindow[Sum]")
			Sum = 0




//-------------------------------------------------
//FRY the following scripts were needed to be modified for this system to work
//Techniques.dm at the end of the MouseDrop function add ..() on line 134
//InventoryButtons.dm at the end of the MouseDrop function add ..() on line 53




obj/SkillCards
	New()
		..()




	var/drag_skill = ""
	var/grid_id = ""
	var/window_id = "MacroWindow0"
	var/state = ""




	proc/Create_Macro(key, command, Move)
		winset(usr, "macro_[state][key]","parent=Game;name=\"[state][key]\";command=\"[command]\"")
		if(Move == TRUE)
			world << "Macro succesfully moved:[state][key],[command]"
		else
			world << "Macro succesfully created:[state][key],[command]"




	proc/check_Window_Id(VariableToCheck)
		window_id = winget(usr, "MacroWindowMain.WindowID", "text")
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
		winset(usr, "MacroWindowMain.WindowID", "text=MacroWindow0")




	proc/Button_state()
		state = ""
		if(winget(usr, "MacroWindowMain.Shift", "is-checked") == "true")
			state += "Shift+"
		if(winget(usr, "MacroWindowMain.Ctrl", "is-checked") == "true")
			state += "Ctrl+"
		if(winget(usr, "MacroWindowMain.Alt", "is-checked") == "true")
			state += "Alt+"




	MouseDown(object,location,control,params)
		window_id = winget(usr, "MacroWindowMain.WindowID", "text")
		Button_state()
		mouse_drag_pointer = icon_state
		drag_skill = cmdstring




	MouseDrop(over_object, src_location, over_location, src_control, over_control, params)
		if(check_Window_Id(over_control) == FALSE)
			resetvariables()
			return


		else
			get_grid_id(over_control)
			usr << output(src, "[over_control]:0,0")
			Create_Macro(grid_id, drag_skill)
		if(check_Window_Id(src_control) == TRUE)
			world << src_control
			get_grid_id(src_control)
			Create_Macro(grid_id, "", TRUE)
			usr << output("", "[src_control]:0,0")
		resetvariables()














//-------------------------------------------------
