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


var/global/database/Player_Keybinds = new("Player_Keybinds.db")
obj/SkillCards
	New()
		..()

	var/database/query/q = new()

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
			ModifyTable("", keybind, "")
		else
			world << "Macro Succesfully Created:[state][keybind],[command]"
			CreateTable()
			ModifyTable(skill, keybind, command)
//Debug		PrintTable()
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
		mouse_drag_pointer = null
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
		return state




	MouseDown(object,location,control,params)
		tableName = "[usr.client.ckey]_keybinds"
		window_id = winget(usr, "MacroWindowMain.WindowID", "text")
		mouse_drag_pointer = icon_state
		drag_skill_command = cmdstring


	MouseDrop(over_object, src_location, over_location, src_control, over_control, params)
		if(check_Window_Id(over_control) == FALSE)
			resetvariables()
			return
		else
			get_grid_id(over_control)
			usr << output(src, "[over_control]:0,0")
			drag_skill = src.name
			Create_Macro(drag_skill, grid_id, drag_skill_command, 0)

		if(check_Window_Id(src_control) == TRUE)
			get_grid_id(src_control)
			Create_Macro(drag_skill, grid_id, "", 1)
			usr << output("", "[src_control]:0,0")
		resetvariables()




//--------------------------------------------------
//sqlite stuff
	proc/CreateTable()
		q = new()

		q.Add(
		{"
		CREATE TABLE IF NOT EXISTS [tableName]
		(
		skill TEXT NOT NULL,
		keybind TEXT NOT NULL PRIMARY KEY UNIQUE,
		command TEXT NOT NULL
		);
		"})


		if(!q.Execute(Player_Keybinds))
			world << "MacroSystem.CreateTable proc fail: [q.ErrorMsg()]"


//debug	q.Add("DELETE FROM [tableName]")
//debug	q.Execute()


	proc/ModifyTable(skill, keybind, command)
		q = new()
		world << "INSERT TABLE=[tableName]"
		q.Add({"
		INSERT OR REPLACE INTO [tableName]
		(skill, keybind, command)
		VALUES (?,?,?);
		"}, skill, keybind, command)



		if(!q.Execute(Player_Keybinds))
			world << "MacroSystem.ModifyTable proc fail: [q.ErrorMsg()]"


	proc/PrintTable()
		q = new()
		world << "SELECT TABLE=[tableName]"
		q.Add("SELECT keybind, command FROM [tableName];")



		if(!q.Execute(Player_Keybinds))
			world << "MacroSystem.PrintTable proc fail: [q.ErrorMsg()]"


		while(q.NextRow())
			var/list/row = q.GetRowData()
			world << "Keybind: [row["keybind"]]"
			world << "Command: [row["command"]]"




//-------------------------------------------------
