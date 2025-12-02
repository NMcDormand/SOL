var/list
	DMGMSGlist[]
proc
	InitiateDMGMSG()
		if(!DMGMSGlist)
			DMGMSGlist=new()
mob
	var
		HideDMGMSG = 0
		PracticeMode
	verb
		Toggle_Practice_Mode()
			if(!(usr in MasterPlayerList)&&(!usr.loggedin)) return
			switch(winget(usr,"PracticeMode","is-checked"))
				if("true")
					usr.PracticeMode=0
					winset(usr,"PracticeMode","is-checked=false")
				if("false")
					usr.PracticeMode=1
					winset(usr,"PracticeMode","is-checked=true")
		PracticeModeButton()
			set hidden=1
			if(!(usr in MasterPlayerList)&&(!usr.loggedin)) return
			switch(winget(usr,"PracticeMode","is-checked"))
				if("true")
					usr.PracticeMode=1
				if("false")
					usr.PracticeMode=0
	proc
		CheckToggles()
			if(PracticeMode)
				winset(src, null,"PracticeMode.is-checked=true")
			else
				winset(src, null,"PracticeMode.is-checked=false")

