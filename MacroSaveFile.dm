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
	WriteMacroFileRow(client/c, var/key, var/command, var/skill)
		var/savefile/F = GetMacroSave(c)
		var/list/row = list()
		row["command"] = command
		row["skill"]   = skill

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



proc/LoopThroughMacroFileRows(client/c)
	var/savefile/F = GetMacroSave(c)

	F.cd = "rows"
	for(var/key in F.dir)
		F.cd = "/"
		var/list/row = list()
		F["rows/[key]"] >> row

		var/command = row["command"]
		var/skill   = row["skill"]

		world << "WriteMacroFile [c]_[key]_[command]_[skill]"
		usr << output(skill, "macrowindow[c.KeyModifierSum].[key]:0,0")
		F.cd = "rows"


//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------