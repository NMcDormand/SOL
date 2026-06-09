proc
	GetMacroSave(client/c)

		return new /savefile("players/macros/keybinds_[c.ckey].sav")


proc
	CreateMacroFile(client/c)
		var/savefile/F = GetMacroSave(c)
		if(CheckMacroFile(c))
			return

		F["initialized"] << 1

proc
	CheckMacroFile(client/c)
		var/savefile/F = GetMacroSave(c)

		var/initialized = 0
		F["initialized"] >> initialized

		if(initialized == 1)
			return TRUE
		return FALSE
proc
	WriteMacroFileRow(client/c, var/key, var/command, var/obj/SkillCards/skill)

		var/savefile/F = GetMacroSave(c)
		var/list/row = list()
		row["command"] = command
		row["skill"]   = "[skill.type]"

		F["rows/[key]"] << row

proc
	ReadMacroFileRow(client/c, var/key)
		var/savefile/F = GetMacroSave(c)

		var/list/row = list()
		F["rows/[key]"] >> row
		world << "ReadMacroFile [row["command"]]_[row["skill"]]"

		return row

proc
	ClearMacroFileRow(client/c, var/key)
		if(!key)
			return

		var/savefile/F = GetMacroSave(c)
		F.dir.Remove("rows/[key]")



proc/LoopThroughMacroFileRows(client/c, wipe)
	var/savefile/F = GetMacroSave(c)
	F.cd = "rows"

	for(var/key in F.dir) //loops a number of times == to the number of keys
		F.cd = "/"
		var/list/row = list() // creates a empty list
		F["rows/[key]"] >> row //fills that list with the variables from the current key in the loop
		var/command = row["command"]
		var/skill   = row["skill"]

		if(wipe == 1) //removes all SkillCards from the macromenu.
			usr << output(null, "MacroWindow.[copytext(key, 2)]:0,0")
			F.cd = "rows"

		else//after the system checks what modifiers are activated it will loop through and place the correct ones.
			if(copytext(key, 1, 2) == "[c.KeyModBitMask]")
				var/skillobject = text2path(skill) // if i dont save the path as a string the savefile fucks it up :(
				usr << output(locate(skillobject), "MacroWindow.[copytext(key, 2)]:0,0")
				F.cd = "rows"