var/sound/Rick = sound('Rick.mid')
mob/VerbHolder/Admin/Host/verb
	Announce(var/t as message)
		set name = "Announce"
		set category = "Staff"
		set desc="Host: Tell the whole world something important."
		if(t)
			AdminActionLog("Announced", t, , , src, 1)
			world << "<font face=verdana size=3 color=red><b><center>[usr] would like to announce:</center></font></b><br><center><font face=verdana size=2 color=silver>[t]</font></center>"
		for(var/mob/player/m in MasterPlayerList)
			if(m.client) winset(m,"mainwindow","flash=-1")
//-------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------
	/*Upload_icon_to_server()
		set category = "Staff"
		set name = "Upload Icon"
		var/upload = input(usr,"Choose Icon to Upload","Icon") as icon
		if(check_icon(upload))
			var/facesize=length(upload)
			if(facesize<=300000)
				var/ename = input(usr, "Enter a name for the Icon for future reference","Name") as text
				var/savefile/F = new("icons/[ename].sav")
				F["icon"]<<upload
			else
				usr<<"Too big."
				return
		else
			usr<<"That was a corrupt icon"
			return*/
//-------------------------------------------------------------------------------------------------------------
	Play_Music(S as sound)
		set category = "Staff"
		src<<"Disabled."
		//world << sound(S)

//made by Ownerdan

proc/check_icon(var/icon/A)
	if(!isicon(A))
		return 0
	else
		var/tex=file2text(A)
		if(findtext(tex,"// BEGIN_INTERNALS")||findtext(tex,"// END_INTERNALS")\
		||findtext(tex,"// BEGIN_FILE_DIR")||findtext(tex,"// END_FILE_DIR")\
		||findtext(tex,"// BEGIN_PREFERENCES")||findtext(tex,"// END_PREFERENCES")\
		||findtext(tex,"// BEGIN_INCLUDE")||findtext(tex,"// END_INCLUDE"))
			return 0
		else return 1

proc/WorldSave(Speak = 0)
	for(var/mob/player/M in MasterPlayerList)
		if(M)
			M.Saving = 0
			M.Save()
		sleep(7)
	SaveGameSettings()
	SaveKages()
	SaveGuilds()
	SaveSwords()
	SaveGMS()
	SaveBank()
	SaveSkills()
	if(Speak)
		world<<"<font color=red>The world has been saved, no thanks to the Aussist.</font>"