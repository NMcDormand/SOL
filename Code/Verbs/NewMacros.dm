client/proc
	addMacro(kKey as text, runProc as command_text, repeat, release, shift, alt, ctrl)
		kKey += "+"
		if(repeat) kKey += "REP+"
		if(release) kKey += "UP+"
		if(shift) kKey += "SHIFT+"
		if(alt) kKey += "ALT+"
		if(ctrl) kKey += "CTRL+"
		winset(src,kKey,{"parent="Game";name=[kKey];command="[escape_text(runProc)]""})

	removeMacro(kKey as text, runProc as command_text, repeat, release, shift, alt, ctrl)
		kKey += "+"
		if(repeat) kKey += "REP+"
		if(release) kKey += "UP+"
		if(shift) kKey += "SHIFT+"
		if(alt) kKey += "ALT+"
		if(ctrl) kKey += "CTRL+"
		winset(src,kKey,{"parent="Game";name=;command="""})
		//winset(src, kKey, {"parent="})

mob
	var
		m_cmd[]; m_rep[]; m_rel[]; m_shf[]; m_alt[]; m_ctrl[]; macs[]
		tmp
			SettingMacro

	proc
		loadMacro()
			set waitfor = 0
			for(var/x in macs)
				if(x)
					client.addMacro(x,m_cmd[x],m_rep[x],m_rel[x],m_shf[x],m_alt[x],m_ctrl[x])

proc
    escape_text(txt)
        txt = replacetext1(txt,"\\","\\\\")
        txt = replacetext1(txt,"\"","\\\"")
        return txt

    replacetext1(txt,txt1,txt2)
        var/found = findtext(txt,txt1)
        if(found)
            return copytext(txt,1,found)+txt2+replacetext1(copytext(txt,found+length(txt1)),txt1,txt2)
        return txt
