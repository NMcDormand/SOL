client
	verb
		MacroWindowOpen()
			winshow(src, "MacroWindow", 1)
			ButtonUpdate()
		MacroWindowClose()
			winshow(src, "MacroWindow", 0)
		CheckRow(key as text)
			ReadMacroFileRow(src, key)

client
	verb
		ButtonUpdate()
			var/OnColor  = "#cfcf40"
			var/OffColor = "#969696"
			LoopThroughMacroFileRows(src, 1)
			KeyModBitMask = 0

			//Shift modifier key is on
			if(winget(usr, "MacroWindow.Toggle_Shift", "is-checked") == "true")
				winset(usr, "MacroWindow.Toggle_Shift", "background-color=[OnColor]")
				KeyModBitMask += 1
			else
				winset(usr, "MacroWindow.Toggle_Shift", "background-color=[OffColor]")

			//Ctrl modifier key is on
			if(winget(usr, "MacroWindow.Toggle_Ctrl", "is-checked") == "true")
				winset(usr, "MacroWindow.Toggle_Ctrl", "background-color=[OnColor]")
				KeyModBitMask += 2
			else
				winset(usr, "MacroWindow.Toggle_Ctrl", "background-color=[OffColor]")

			//Alt modifier key is on
			if(winget(usr, "MacroWindow.Toggle_Alt", "is-checked") == "true")
				winset(usr, "MacroWindow.Toggle_Alt", "background-color=[OnColor]")
				KeyModBitMask += 4
			else
				winset(usr, "MacroWindow.Toggle_Alt", "background-color=[OffColor]")

			LoopThroughMacroFileRows(src, 0)


	proc
		BitMaskDecode(var/BitMask)
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
		Macro_RepeatSwitch(id as text)
			var/Macro_RepeatID = copytext(id, 5)
			var/row = ReadMacroFileRow(src, "[KeyModBitMask][Macro_RepeatID]")
			Create_Macro(row["skill"], "[KeyModBitMask][Macro_RepeatID]", row["command"], 0)

//-------------------------------------------------
//FRY the following scripts were needed to be modified for this system to work
//Techniques.dm at the end of the MouseDrop function add ..() on line 134
//InventoryButtons.dm at the end of the MouseDrop function add ..() on line 53
//login.dm added a few lines at login()

client
	New()
		..()

	var/Macro_Drag_Skill_Command = ""
	var/Macro_Grid_ID = ""
	var/Macro_Repeat = ""
	var/Macro_Drag_Skill = null
	var/KeyModBitMask = 0


	proc/Create_Macro(skill, keybind, command, Move)

		//checks to see if the skill should repeat
		if(winget(usr, "MacroWindow.Rep_[keybind]", "is-checked") == "true")
			Macro_Repeat = "+REP"
		else
			Macro_Repeat = ""

		//turns the bitmask back into the keymodifier string
		var/key = BitMaskDecode(copytext(keybind ,0 ,1)) + copytext(keybind, 0,)

		//removes the previous macro if the skill is moved from one key to another
		if(Move == 1)
			world << "Macro for Key:[key][Macro_Repeat] Sucessfully Unbound"
			ClearMacroFileRow(src, "[KeyModBitMask][keybind]")

		else //creates the macro
			world << "Macro Succesfully Created:[key][Macro_Repeat],[command]"
			WriteMacroFileRow(src, "[KeyModBitMask][keybind]", command, skill)
		winset(usr, "macro_[key]",
			"parent=Game;name=\"[key][Macro_Repeat]\";command=\"[command]\"")



	//gets the id of the grid you drop the skill onto. this is how the system knows what key you want to bind to
	proc/get_Macro_Grid_ID(VariableToCheck)
		Macro_Grid_ID = copytext(VariableToCheck, length("MacroWindow") + 2)



	//just ensures all variables are properly reset when done
	proc/resetvariables()
		Macro_Drag_Skill_Command = ""
		Macro_Grid_ID = ""
		src.mob.mouse_drag_pointer = null
		Macro_Drag_Skill = null



obj/SkillCards
	MouseDown(object,location,control,params)
		var/client/c = usr.client
		c.mob.mouse_drag_pointer = icon_state
		c.Macro_Drag_Skill_Command = cmdstring


	MouseDrop(over_object, src_location, over_location, src_control, over_control, params)
		var/client/c = usr.client

		//check if the skill is being dragged onto the right window
		if(copytext(over_control, 1, length("MacroWindow") + 1) != "MacroWindow")
			c.resetvariables()
			return

		else //get the variables needed and sends them to the create macro proc
			c.get_Macro_Grid_ID(over_control)
			usr << output(src, "[over_control]:0,0")
			c.Macro_Drag_Skill = src
			c.Create_Macro(src, c.Macro_Grid_ID, c.Macro_Drag_Skill_Command, 0)

		//checks if the skillcard was moved from one key to another, if so removes the old
		if(copytext(src_control, 1, length("MacroWindow") + 1) == "MacroWindow")
			c.get_Macro_Grid_ID(src_control)
			c.Create_Macro(c.Macro_Drag_Skill, c.Macro_Grid_ID, "", 1)
			usr << output("", "[src_control]:0,0")
		c.resetvariables()