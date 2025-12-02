var
	AFKCheckInProgress
	AFKCheckDisabled
	AFKs=list()
	CorrectButton
	CorrectAnswer

	//AFKAnswer AFKQuestion
mob/var/tmp/AFKSelection
proc
	AFK_Check()
	//	AFKCheckDisabled = 0
		if(AFKCheckDisabled) return
		if(AFKCheckInProgress) return
		AFKCheckInProgress=1
		CorrectButton=null; CorrectAnswer=null
		AFKs=new/list
		sleep(2)
		switch(pick(1,2,3,4))
			if(1) CorrectButton="A"
			if(2) CorrectButton="B"
			if(3) CorrectButton="C"
			if(4) CorrectButton="D"
		switch(pick(1,2,3))
			if(1) CorrectAnswer=2
			if(2) CorrectAnswer=36
			if(3) CorrectAnswer=16
		for(var/mob/player/p in MasterPlayerList)
			if((p in AFKs)||p.AFK||p.ckey=="screwyparasite") continue
			else AFKs+=p
			spawn(rand(1,3))
				switch(CorrectButton)
					if("A") winset(p,null,"OutputChild.left='AFKpane'; AFKpane.ButtonA.image=['Flashy.png']; AFKpane.ButtonB.image=['Circlez.png']; AFKpane.ButtonC.image=['Circlez.png']; AFKpane.ButtonD.image=['Circlez.png']")
					if("B") winset(p,null,"OutputChild.left='AFKpane'; AFKpane.ButtonA.image=['Circlez.png']; AFKpane.ButtonB.image=['Flashy.png']; AFKpane.ButtonC.image=['Circlez.png']; AFKpane.ButtonD.image=['Circlez.png']")
					if("C") winset(p,null,"OutputChild.left='AFKpane'; AFKpane.ButtonA.image=['Circlez.png']; AFKpane.ButtonB.image=['Circlez.png']; AFKpane.ButtonC.image=['Flashy.png']; AFKpane.ButtonD.image=['Circlez.png']")
					if("D") winset(p,null,"OutputChild.left='AFKpane'; AFKpane.ButtonA.image=['Circlez.png']; AFKpane.ButtonB.image=['Circlez.png']; AFKpane.ButtonC.image=['Circlez.png']; AFKpane.ButtonD.image=['Flashy.png']")
				switch(CorrectAnswer)
					if(2) {p<<output("9 minus 7 =","AFKpane.AFKQuestion"); AFKAnswer(2)}
					if(16) {p<<output("10 plus 6 =","AFKpane.AFKQuestion"); AFKAnswer(16)}
					if(36) {p<<output("6 times 6 =","AFKpane.AFKQuestion"); AFKAnswer(36) }
			p<<output("<b>An AFK Check has been initiated. Please click the highlighted button and answer the question then click submit. You have one minute to comply.</b>","Chat")
		sleep(600)
		//AFK_Warning()
		AFK_Boot()
		spawn(15000) AFKCheckInProgress=0//18000 30 minutes
		spawn(rand(27000,72000)) AFK_Check() // 45 minutes to 2 hours
		//spawn(3000) AFKCheckInProgress=0//5
		//spawn(rand(3120,3150)) AFK_Check() // 5

	AFK_Warning()
		for(var/mob/player/M in AFKs)
			if(M)
				alert(M,"It's been 1 minute and you still haven't completed the AFK Check!  Just click the blue light, answer the question and then click submit.","AFK Checker")

	AFK_Boot()
		for(var/mob/player/M in AFKs)
			if(M.client) {winset(M,null,"OutputChild.left='damagepane'");}
			M<<"<b>You have been booted for not complying with an AFK Check.</b>"
			world << "<font color=#007bba><b>[M.name]/[M.key] was booted by the AFK Check!</b></font>"
			M.Save()
			sleep(10)
			del(M)
			sleep(1)
	AFKAnswer(var/answer)
		switch(CorrectAnswer)
			if(2) {if(answer=="2"||answer=="two"||answer=="Two") return 1}
			if(16) {if(answer=="16"||answer=="sixteen"||answer=="Sixteen") return 1}
			if(36) {if(answer=="36"||answer=="thirtysix"||answer=="thirty six") return 1}
mob/verb
/*	checkList()
		for(var/mob/player/p in MasterPlayerList)
			world<<"[p] is in the player list..."
	checkList2()
		for(var/mob/player/p in AFKs)
			world<<"[p] is in the AFK list..."*/
	SubmitCheck()
		set hidden=1
		var/ans= winget(usr, "AFKpane.AFKAnswer","text")
		if(usr.AFKSelection==CorrectButton && AFKAnswer(ans))
			winset(usr,null,"OutputChild.left='damagepane'")
			if((usr in AFKs)) AFKs-=usr
			usr.AFKSelection=null
		else
			winset(usr,null,"OutputChild.left='damagepane'")
			usr<<"<b>You have been booted for an incorrect submission during an AFK Check</b>."
			usr.Save()
			spawn(10) usr.Logout()
	xButtonA()
		set hidden=1
		if(AFKCheckInProgress) usr.AFKSelection="A"

	xButtonB()
		set hidden=1
		if(AFKCheckInProgress) usr.AFKSelection="B"

	xButtonC()
		set hidden=1
		if(AFKCheckInProgress) usr.AFKSelection="C"

	xButtonD()
		set hidden=1
		if(AFKCheckInProgress) usr.AFKSelection="D"