mob/var/ListeningToDebugs=0
var/GMLOG="- empty -"
mob/var/tmp/SpyStatus
proc/logStuff(var/data)

proc/Called(var/m)
	if(!m) m="called"
	for(var/mob/player/P in MasterPlayerList)
		if(P.ListeningToDebugs) P<<"Debug Message: [m]"

proc/adminLog(var/target, var/verbUsed)

	var/msg="<BR>[time2text(world.realtime)]: "
	if(target) msg+="[usr] used [verbUsed] on [target]"
	else msg+="[usr] used [verbUsed]"

	text2file(msg, "AdminLogs/[usr.ckey].html")
	//text2file("[time2text(world.realtime)]: [usr] had his [variable] edited by [usr]<BR>","SelfEditLog.html")

mob/player
	var/IgnorePolls = 0
	verb
		Toggle_Polls()
			if(!IgnorePolls)
				IgnorePolls = 1
				usr << "You will now ignore any pop ups about Polls"
			else
				IgnorePolls = 0
				usr << "You will now receive any pop ups about Polls"

var
	Option1 = 0
	Option2 = 0

mob/VerbHolder/Admin/Level1/verb
/*	Toggle_Debug_Messages()
		switch(usr.ListeningToDebugs)
			if(TRUE)
				usr<<"Debug messages are now OFF."
				usr.ListeningToDebugs=FALSE
			if(FALSE)
				usr<<"Debug listening is now ON."
				usr.ListeningToDebugs=TRUE*/
	Create_Poll()
		//var/list/Choices = list()
		switch(input("Which type of Poll would you like to create","Create Poll") as null|anything in list("Yes/No","Single Choice"))
			if("Yes/No")
				var/A = input("What is the question?") as text
				if(A && A != "")
					var/Timer = (input("How much time would you like to give them to submit?(in minutes)") as num)*600
					if(Timer > 0)
						var/GMI = alert("Should the GMs be asked?","GMs?","Yes","No") == "Yes" ? 1 : 0
						var/msg = "<h2>[usr.trueName] has started a poll, Yes or No; [A]<br>You have [Timer/600] Minutes</h2>"
						world << msg
						var/list/Chosen = list()
						for(var/mob/player/M in MasterPlayerList)
							if(M.IgnorePolls)
								continue
							//if(usr == M)
							//	continue
							if(!GMI && M.AdminLevel)
								continue
							if(Chosen["[M.client.address]"])
								continue
							Chosen["[M.client.address]"] = 1
							spawn(-1)
								if(alert(M,"[A]","Poll","Yes","No") == "Yes")
									Option1++
								else
									Option2++
						sleep(Timer)
						if(!Option1 && !Option2)
							world << "<h2>\"[A]\" - Poll has concluded with zero votes</h2>"
						else
							if(Option1>Option2)
								world <<"<h2>\"[A]\" - poll conlcuded with No having more votes<br/>[Option1] = Yes<br/>[Option2] = No</h2>"
							else if(Option2>Option1)
								world <<"<h2>\"[A]\" - poll conlcuded with Yes having more votes<br/>No: [Option2]<br/>Yes: [Option1]</h2>"
							else
								world <<"<h2>\"[A]\" - poll conlcuded with a tie<br/>Each scoring [Option1] Votes"

			if("Single Choice")
				var/A = input("What is the first option?") as text
				var/B = input("What is the second option?") as text
				if(A && A != "" && B && B != "")
					var/Timer = (input("How much time would you like to give them to submit?(in minutes)") as num)*600
					if(Timer > 0)
						var/GMI = alert("Should the GMs be asked?","GMs?","Yes","No") == "Yes" ? 1 : 0
						var/msg = "<h2>[usr.trueName] has started a poll, Choose One; [A] or [B]<br>You have [Timer] Minutes</h2>"
						world << msg
						var/list/Chosen = list()
						for(var/mob/M in MasterPlayerList)
							//if(usr == M)
							//	continue
							if(!GMI && M.AdminLevel)
								continue

							Chosen["[M.client.address]"] = 1
							spawn()
								if(alert(M,"[A]","Poll","[A]","[B]") == "[A]")
									Option1++
								else
									Option2++
						sleep(Timer)
						if(!Option1 && !Option2)
							world << "<h2>[usr]'s Poll has concluded with zero votes</h2>"
						else
							if(Option1>Option2)
								world <<"<h2>[usr]'s poll concluded with [B] winning<br/>[Option1] = [A]<br/>[Option2] = [B]</h2>"
							else if(Option2>Option1)
								world <<"<h2>[usr]'s poll concluded with [B] winning<br/>[Option2] = [B]<br/>[Option1] = [A]</h2>"
							else
								world <<"<h2>[usr]'s poll concluded with [B] winning<br/>[Option1] = [A]<br/>[Option2] = [B]</h2>"

	Fix_Blind(mob/M in MasterPlayerList)
		set category = "Staff"
		set name = "Fix: Blindness"
		M.invisibility = 7
		M.see_invisible = 7
		M.InIllusion = 0

	Restore_GM_Verbs()
		set category = "Staff"
		var/mob/M = input("Who's verbs would you like to restore?") as null|anything in MasterPlayerList
		if(M)
			if(M.AdminLevel)
				M<<"Your GM verbs should be back"
				M.GMList()

	Force_Save(var/mob/player/P in MasterPlayerList)
		set category = "Staff"
		if(P.SavePrevention == 1)
			P.SavePrevention = 0
		P.Save()
		//AdminActionLog("Force Save", "None", , P, src, 1)
		usr<<"You forced [P.trueName] to save"

	Police_Mute()
		set category = "Staff"
		set desc="Prevent someone from speaking."
		if(AdminLevel>3)
			switch(alert("Mute a player or the world?","Mute Type","player","World"))
				if("World")
					worldmute=1
					world<<"<font color=red><b>[usr] has muted the world</font></b>"
					return;
		var/list/AP = list()
		for(var/mob/m in MasterPlayerList)
			AP[m.trueName] = m
		var/mob/M=AP[input("Select a player to be muted","Mute") as null|anything in AP]
		if(M)
			if(M.AdminLevel > AdminLevel) {src<<"You attempt to mute [M.name] however find it is yourself who can't talk!"; muted=1; return;}
			var/reason=input({""Please enter a reason for the mute. This will be logged.""}) as text
			var/time
			if(AdminLevel>3)
				switch(input("Would you like to IP mute?", "IP Mute") in list("IP Mute", "Standard Mute"))
					if("IP Mute")
						world << "<font color=red><i>[M] has been IP-muted by [usr] for: [reason]</font></i>"
						IPMuteList+=M.client.address
						spawn(10)AdminActionLog("IP Muted", reason, time, M, src)
						return
			if(AdminLevel<3) //If low GM level
				time=5
			else
				time=input("Mute for how long (in minutes)? Minimum is 1 minute") as num
				//time*=600 //Convert minutes to seconds (with tick rate)
			M.OOC=0;
			M.muteLevel=AdminLevel;
			M.muted=time
			world << "<font color=red><i>[M] has been muted for [time] minutes. by [usr] <br/> Reason: [reason]</font></i>"

			AdminActionLog("Muted", reason, time, M, src)
			AddPunishment("Muted", reason, time, M, src)

	Jail(mob/player/M in MasterPlayerList)
		set name = "Jail"
		set category = "Staff"
		set desc="Send a player to Jail for misbehaving."
//		if(M.GM) {usr<<"<font color=red>You cannot jail a GM.</font>"; return}
		if(M.AdminLevel > AdminLevel) {src<<"You attempt to jail, however you find [M.name] is too powerful and thus it is impossible!"; return;}
		var/reason=input({""Please enter a reason for the jail. This will be logged.""}) as text
		var/time

		if(AdminLevel>2)
			//Can choose their own time
			time=input("How long should they remain in jail (in minutes)?","Send to Jail") as num
		else
			//Can select one of two times
			switch(alert("Is this a serious punishment? (Bug Abusing or AFK Training)",,"Yes","No"))
				if("Yes")
					time=120
					if(AdminLevel>3)
						if(alert("Would you like to clear their Rebirth Profile?","Rebirth Reset","Yes","No") == "Yes")
							fdel("Saves/[copytext(M.ckey, 1, 2)]/[M.ckey]/[M.Slot]/Rebirth.sav")
							M.RebirthData = null
							M.RebirthData = new(M)
				if("No")
					time=15

		//================== Jail Function ===============================================

		M.jailLevel=usr.AdminLevel;
		M.jailed=time;
		M.GMfrozen = 1;
		spawn(20) {M.overlays += 'frozen.dmi'}
		M.sy=M.y; M.sx=M.x; M.sz=M.z
		M.loc=locate(7,57,2)
		M.ZCoord="Jail"; M.ZCoordProc(M.ZCoord)
		world << "<font color=red><i>[M] has been jailed for [time] minutes. <br/> Reason: [reason]</font></i>"
		AdminActionLog("Jailed", reason, time, M, src)
		AddPunishment("Jailed", reason, time, M, src)

/*		if(JailTime)
			JailTime
			M.jailed=(world.timeofday+(JailTime))
			M.GMfrozen = 1
			spawn(20) {M.overlays += 'frozen.dmi'}
			M.sy=M.y; M.sx=M.x; M.sz=M.z
			M.loc=locate(7,57,2)
			M.ZCoord="Jail"; M.ZCoordProc(M.ZCoord)
			world << "<font color=red><b>[usr] has jailed [M] for [JailTime/600] minutes!</font></b>"
			if(reason) alert(M,"You have been jailed by [usr].  Reason: [reason]","Jail")
			UnjailProc(M,JailTime)
*/

	GM_LOG()
		set category="Staff"
		set name="Log Book"
		var/H=input("","GM Log Book",GMLOG) as message
		if(H) GMLOG=H
		SaveGMLog()

	Check_History(var/mob/player/M in MasterPlayerList)
		set category="Staff"
		set name="Criminal History"
		if(M)
			var/playerAbuse = \
			      {"
					<html>
						<head>
							<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
							<title>Criminal History</title>
							<style>
								html		{overflow-x:hidden;}
								body		{background:#151515;font-family:Arial;color:#BBB;font-size:10pt;scrollbar-base-color:#333;scrollbar-highlight-color:#151515;scrollbar-arrow-color:#333;scrollbar-face-color:#333;scrollbar-shadow-color:#151515;width:100%;margin:0px;}}
								h1			{position:relative;left:35px;padding:0px;}
								#RedLine	{position:absolute;left:20px;Top:0px;background:#FF0000;height:30px;width:10px;}
							</style>
							<script>
								function ReFocus(el){window.focus();window.location='byond://?src=\ref[src]&action=ReFocus';}
							</script>
						</head>
						<body>
							<h1>[M.name] / [M.trueName] / [M.ckey]</h1>
							[file2text("Punishments/[M.ckey].txt")]
							<div id="RedLine"></div>
						</body>
					</html>
			      "}
			src << browse(playerAbuse, "window=Check History;size=800x500")

	Poke(mob/m in MasterPlayerList)
		set category = "Staff"
		if(m.client) {winset(m,"mainwindow","flash=-1"); m<<"<b><i>[usr] has poked you!</b></i>"; AdminActionLog("Poke", "None", , m, src, 1)}

	RelearnVerbs(mob/M in MasterPlayerList)
		set name="Relearn Verbs"
		set category = "Staff"
		set desc = "L1: Restore a player's verbs"
		var/ms
		if(M.JutsuList["Mangekyou"]) ms=1
		M.JutsuList=null
		if(ms) {M.JutsuList["Mangekyou"]=1}

	Police_Teleport()
		set name="Teleport Player"
		set category = "Staff"
		set desc = "L1: Teleport to a human player"
		var/list/PList = list()
		for(var/mob/A in MasterPlayerList)
			if(A==src)
				continue
			else
				PList += A
		if(!PList.len)
			usr << "There is no other player currently logged in"
		var/mob/M = input("Which player would you to teleport to?") as null|anything in PList
		if(M && usr)
			usr<<"<font color=red>You teleport next to [M]</font>"
			if(M.loc)
				if(usr.loc)
					usr.loc.loc.Exited(usr)
				usr.loc=M.loc
				usr.loc.loc.Entered(usr)

				AdminActionLog("Police Teleport", "none", , M, src, 1)

	Check_IP(mob/who in MasterPlayerList)
		set category="Staff"
		set desc="L1: View a player's IP address."
		src<<"<font color=red><b>[who]'s IP Address is:  [who.client.address]</font></b>"

	Check_Double_IP()
		set category="Staff"
		set desc="L1: Check for Double IPs."
		var/IPS[0]
		var/DList = list()
		for(var/mob/player/p in MasterPlayerList)
			var/IP = "[p.client.address]"
			if(!(IP in IPS))
				IPS[IP]="[p] ([p.key])"
			else
				if(!(IP in DList))
					DList[IP] = "[IPS[p.client.address]], [p] ([p.key])"
				else
					DList[IP] +=", [p] ([p.key])"

		for(var/P in DList)
			usr<<"[P]:"
			usr<< "[DList[P]]"

	GMOOC(msg as text)
		set category = "Staff"
		set name = "Staff Chat"
		set desc="L1: Talk privately amongst staff."
		if(msg && msg != "")
			for(var/mob/player/M in MasterPlayerList)
				if((M.GM&&!M.GMMUTE)||M.SecretGM)
					M<<output("<i><font color=red><b>{GM OOC </b>:|:<b> [usr]</b>}:<font color=white> [msg]</font>","Chat")

//-------------------------------------------------------------------------------------------------------------
	View_Players()
		set category = "Staff"
		set name = "Spy"
		set desc="L1: Watch a player from a distance"
		var/list/Choices = list()
		switch(alert("Would you like to spy a player or mob?","Type","Player","Mob","Stop"))
			if("Player")
				for(var/mob/A in MasterPlayerList)
					if(A==src)
						continue
					Choices += A
			if("Mob")
				for(var/mob/A in world)
					if(!A.client)
						Choices += A
			if("Stop")
				usr.client.perspective= MOB_PERSPECTIVE|EDGE_PERSPECTIVE;
				usr.client.eye = usr
				if(usr.SpyStatus)
					if(usr.AdminLevel < 5)
						var/mob/A = usr.SpyStatus
						A << "The GM who was watching you has now stopped"
					usr.SpyStatus=0
				return

		var/mob/M=input("Spy on whom?","Spy") as null|mob in Choices
		if(M)
			if(M.client)
				if(usr.AdminLevel < 5)
					M << "You are being watched by a GM"
					AdminActionLog("Spying", "none", , M, src, 1)
			usr.SpyStatus=M
			usr.client.perspective= EYE_PERSPECTIVE;
			usr.client.eye = M

//-------------------------------------------------------------------------------------------------------------
	Analyse_Mob(mob/x in world)
		set category = "Staff"
		var/T={"<h1 ref="\ref[x]">[x.name]</h1>"}
		var/B=0
		for(var/X in x.vars)
			if(B==0)
				B=1
			else
				B=0
			//if(istype(x.vars[X]))
			/*if(0)
			//Stats(Name,Current,Max,True,CEXP,MEXP,Multi,Cap)
				//var/Z=x.vars[X]
				//T+={"<div class="Var[B]" id="Var"><span class="varname">[Z]</span> = (

				//)</div>"}
				var/hi=1;*/
			if(istype(x.vars[X],/list))
				var/T2=OpenList(x.vars[X])
				T+={"<div class="Var[B]" id="List"><span class="varname">[X]</span>&nbsp;=&nbsp;[T2]</div>"}
			else
				T+={"<div class="Var[B]" id="Var"><span class="varname">[X]</span>&nbsp;=&nbsp;<span>[x.vars[X]]</span></div>"}
		//var/i="\[i]"
		var/HTML={"<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><title>[x.name]'s Variables</title></head>
					<style type="text/css">
						html		{overflow-x:hidden;}
						body		{background:#151515;font-family:Arial;color:#BBB;font-size:10pt;scrollbar-base-color:#333;scrollbar-highlight-color:#151515;scrollbar-arrow-color:#333;scrollbar-face-color:#333;scrollbar-shadow-color:#151515;width:100%;margin:0px;}}
						h1			{position:relative;left:35px;padding:0px;}
						#Var		{position:relative;height:24px;padding:2px;}
						#Var div	{position:relative;display:inline-block;*display:inline;zoom:1;margin:0px;padding:0px;}
						.Var0		{background:#151515}
						.Var1		{background:#202020}
						.desc		{position:absolute;top:-21px;left:-10px;color:#F00;padding:0px;}
						.Var0 .desc	{background:#202020;}
						.Var1 .desc	{background:#151515;}
						.varname	{position:relative;font-weight:bold;}
						#RedLine	{position:absolute;left:20px;Top:0px;background:#FF0000;height:30px;width:10px;}
						.InnerList	{position:relative;display:inline-block;*display:inline;zoom:1;}
						.InnerList div{position:relative;display:inline-block;*display:inline;zoom:1;}
						.ListItem	{position:relative;display:inline-block;*display:inline;zoom:1;}
					</style>
					<script type="text/javascript">
						function DispDesc(el){
							var inner = el.lastChild;
							if (inner.style.display == "none"){inner.style.display = "";}
							else{inner.style.display = "none";}
						}
						function ReFocus(el){window.focus();window.location='byond://?src=\ref[src]&action=ReFocus';}
					</script>
					<body>
						<div id="ContA">
							[T]
						</div>
						<div id="RedLine"></div>
					</body>
					</html>"}
		src<<browse(HTML,"window=Browser[x.name];size=600x400")

	Analyse_Player(mob/x in MasterPlayerList)
		set category = "Staff"
		var/T={"<h1 ref="\ref[x]">[x.name]</h1>"}
		var/B=0
		for(var/X in x.vars)
			if(B==0)
				B=1
			else
				B=0
			//if(istype(x.vars[X]))
			/*if(0)
			//Stats(Name,Current,Max,True,CEXP,MEXP,Multi,Cap)
				//var/Z=x.vars[X]
				//T+={"<div class="Var[B]" id="Var"><span class="varname">[Z]</span> = (

				//)</div>"}
				var/hi=1;*/
			if(istype(x.vars[X],/list))
				var/T2=OpenList(x.vars[X])
				T+={"<div class="Var[B]" id="List"><span class="varname">[X]</span>&nbsp;=&nbsp;[T2]</div>"}
			else
				T+={"<div class="Var[B]" id="Var"><span class="varname">[X]</span>&nbsp;=&nbsp;<span>[x.vars[X]]</span></div>"}
		//var/i="\[i]"
		var/HTML={"<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><title>[x.name]'s Variables</title></head>
					<style type="text/css">
						html		{overflow-x:hidden;}
						body		{background:#151515;font-family:Arial;color:#BBB;font-size:10pt;scrollbar-base-color:#333;scrollbar-highlight-color:#151515;scrollbar-arrow-color:#333;scrollbar-face-color:#333;scrollbar-shadow-color:#151515;width:100%;margin:0px;}}
						h1			{position:relative;left:35px;padding:0px;}
						#Var		{position:relative;height:24px;padding:2px;}
						#Var div	{position:relative;display:inline-block;*display:inline;zoom:1;margin:0px;padding:0px;}
						.Var0		{background:#151515}
						.Var1		{background:#202020}
						.desc		{position:absolute;top:-21px;left:-10px;color:#F00;padding:0px;}
						.Var0 .desc	{background:#202020;}
						.Var1 .desc	{background:#151515;}
						.varname	{position:relative;font-weight:bold;}
						#RedLine	{position:absolute;left:20px;Top:0px;background:#FF0000;height:30px;width:10px;}
						.InnerList	{position:relative;display:inline-block;*display:inline;zoom:1;}
						.InnerList div{position:relative;display:inline-block;*display:inline;zoom:1;}
						.ListItem	{position:relative;display:inline-block;*display:inline;zoom:1;}
					</style>
					<script type="text/javascript">
						function DispDesc(el){
							var inner = el.lastChild;
							if (inner.style.display == "none"){inner.style.display = "";}
							else{inner.style.display = "none";}
						}
						function ReFocus(el){window.focus();window.location='byond://?src=\ref[src]&action=ReFocus';}
					</script>
					<body>
						<div id="ContA">
							[T]
						</div>
						<div id="RedLine"></div>
					</body>
					</html>"}
		src<<browse(HTML,"window=Browser[x.name];size=600x400")

	Analyse_Object(obj/x in world)
		set category = "Staff"
		var/T={"<h1 ref="\ref[x]">[x.name]</h1>"}
		var/B=0
		for(var/X in x.vars)
			if(B==0)
				B=1
			else
				B=0
			//if(istype(x.vars[X]))
			/*if(0)
			//Stats(Name,Current,Max,True,CEXP,MEXP,Multi,Cap)
				//var/Z=x.vars[X]
				//T+={"<div class="Var[B]" id="Var"><span class="varname">[Z]</span> = (

				//)</div>"}
				var/hi=1;*/
			if(istype(x.vars[X],/list))
				var/T2=OpenList(x.vars[X])
				T+={"<div class="Var[B]" id="List"><span class="varname">[X]</span>&nbsp;=&nbsp;[T2]</div>"}
			else
				T+={"<div class="Var[B]" id="Var"><span class="varname">[X]</span>&nbsp;=&nbsp;<span>[x.vars[X]]</span></div>"}
		//var/i="\[i]"
		var/HTML={"<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><title>[x.name]'s Variables</title></head>
					<style type="text/css">
						html		{overflow-x:hidden;}
						body		{background:#151515;font-family:Arial;color:#BBB;font-size:10pt;scrollbar-base-color:#333;scrollbar-highlight-color:#151515;scrollbar-arrow-color:#333;scrollbar-face-color:#333;scrollbar-shadow-color:#151515;width:100%;margin:0px;}}
						h1			{position:relative;left:35px;padding:0px;}
						#Var		{position:relative;height:24px;padding:2px;}
						#Var div	{position:relative;display:inline-block;*display:inline;zoom:1;margin:0px;padding:0px;}
						.Var0		{background:#151515}
						.Var1		{background:#202020}
						.desc		{position:absolute;top:-21px;left:-10px;color:#F00;padding:0px;}
						.Var0 .desc	{background:#202020;}
						.Var1 .desc	{background:#151515;}
						.varname	{position:relative;font-weight:bold;}
						#RedLine	{position:absolute;left:20px;Top:0px;background:#FF0000;height:30px;width:10px;}
						.InnerList	{position:relative;display:inline-block;*display:inline;zoom:1;}
						.InnerList div{position:relative;display:inline-block;*display:inline;zoom:1;}
						.ListItem	{position:relative;display:inline-block;*display:inline;zoom:1;}
					</style>
					<script type="text/javascript">
						function DispDesc(el){
							var inner = el.lastChild;
							if (inner.style.display == "none"){inner.style.display = "";}
							else{inner.style.display = "none";}
						}
						function ReFocus(el){window.focus();window.location='byond://?src=\ref[src]&action=ReFocus';}
					</script>
					<body>
						<div id="ContA">
							[T]
						</div>
						<div id="RedLine"></div>
					</body>
					</html>"}
		src<<browse(HTML,"window=Browser[x.name];size=600x400")

	Analyse_Turf(turf/x in world)
		set category = "Staff"
		var/T={"<h1 ref="\ref[x]">[x.name]</h1>"}
		var/B=0
		for(var/X in x.vars)
			if(B==0)
				B=1
			else
				B=0
			//if(istype(x.vars[X]))
			/*if(0)
			//Stats(Name,Current,Max,True,CEXP,MEXP,Multi,Cap)
				//var/Z=x.vars[X]
				//T+={"<div class="Var[B]" id="Var"><span class="varname">[Z]</span> = (

				//)</div>"}
				var/hi=1;*/
			if(istype(x.vars[X],/list))
				var/T2=OpenList(x.vars[X])
				T+={"<div class="Var[B]" id="List"><span class="varname">[X]</span>&nbsp;=&nbsp;[T2]</div>"}
			else
				T+={"<div class="Var[B]" id="Var"><span class="varname">[X]</span>&nbsp;=&nbsp;<span>[x.vars[X]]</span></div>"}
		//var/i="\[i]"
		var/HTML={"<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><title>[x.name]'s Variables</title></head>
					<style type="text/css">
						html		{overflow-x:hidden;}
						body		{background:#151515;font-family:Arial;color:#BBB;font-size:10pt;scrollbar-base-color:#333;scrollbar-highlight-color:#151515;scrollbar-arrow-color:#333;scrollbar-face-color:#333;scrollbar-shadow-color:#151515;width:100%;margin:0px;}}
						h1			{position:relative;left:35px;padding:0px;}
						#Var		{position:relative;height:24px;padding:2px;}
						#Var div	{position:relative;display:inline-block;*display:inline;zoom:1;margin:0px;padding:0px;}
						.Var0		{background:#151515}
						.Var1		{background:#202020}
						.desc		{position:absolute;top:-21px;left:-10px;color:#F00;padding:0px;}
						.Var0 .desc	{background:#202020;}
						.Var1 .desc	{background:#151515;}
						.varname	{position:relative;font-weight:bold;}
						#RedLine	{position:absolute;left:20px;Top:0px;background:#FF0000;height:30px;width:10px;}
						.InnerList	{position:relative;display:inline-block;*display:inline;zoom:1;}
						.InnerList div{position:relative;display:inline-block;*display:inline;zoom:1;}
						.ListItem	{position:relative;display:inline-block;*display:inline;zoom:1;}
					</style>
					<script type="text/javascript">
						function DispDesc(el){
							var inner = el.lastChild;
							if (inner.style.display == "none"){inner.style.display = "";}
							else{inner.style.display = "none";}
						}
						function ReFocus(el){window.focus();window.location='byond://?src=\ref[src]&action=ReFocus';}
					</script>
					<body>
						<div id="ContA">
							[T]
						</div>
						<div id="RedLine"></div>
					</body>
					</html>"}
		src<<browse(HTML,"window=Browser[x.name];size=600x400")

//--------------------------------------------------------------------------------------------------------------
	Admin_Who()
		set category = "Staff"
		var
			T={"<h1>Admin Who</h1>"}
			A1= 0
			A2= 0
			A3= 0
			B = 0
		//var/i="\[i]"
		for(var/mob/player/M in MasterPlayerList)
			if(B==0)
				B=1
			else
				B=0
			if(M.AFK)
				T+={"<div class="Var[B]" id="Var"><span class="varname">Name:[M.name]- TrueName:[M.trueName]</span><span>&nbsp- Key:[M.key] - IP: [M.client.address] - Village: [M.Village] - Clan: [M.Clan]</span> - AFK</div>"}
				A3++
			else
				T+={"<div class="Var[B]" id="Var"><span class="varname">Name:[M.name]- TrueName:[M.trueName]</span><span>&nbsp- Key:[M.key] - IP: [M.client.address] - Village: [M.Village] - Clan: [M.Clan]</span></div>"}
				A1++

		var/HTML={"<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><title>Admin Who</title></head>
					<style type="text/css">
						html		{overflow-x:hidden;}
						body		{background:#151515;font-family:Arial;color:#BBB;font-size:10pt;scrollbar-base-color:#333;scrollbar-highlight-color:#151515;scrollbar-arrow-color:#333;scrollbar-face-color:#333;scrollbar-shadow-color:#151515;width:100%;margin:0px;}}
						h1			{position:relative;left:35px;padding:0px;}
						#Var		{position:relative;height:24px;padding:2px;}
						#Var div	{position:relative;display:inline-block;*display:inline;zoom:1;margin:0px;padding:0px;}
						.Var0		{background:#151515}
						.Var1		{background:#202020}
						.desc		{position:absolute;top:-21px;left:-10px;color:#F00;padding:0px;}
						.Var0 .desc	{background:#202020;}
						.Var1 .desc	{background:#151515;}
						.varname	{position:relative;font-weight:bold;}
						#RedLine	{position:absolute;left:20px;Top:0px;background:#FF0000;height:30px;width:10px;}
						.InnerList	{position:relative;display:inline-block;*display:inline;zoom:1;}
						.InnerList div{position:relative;display:inline-block;*display:inline;zoom:1;}
						.ListItem	{position:relative;display:inline-block;*display:inline;zoom:1;}
					</style>
					<script type="text/javascript">
						function ReFocus(el){window.focus();window.location='byond://?src=\ref[src]&action=ReFocus';}
					</script>
					<body>
						<div id="ContA">
							<span>[A1 + A2] players online,[A1] of which are active, [A3] are away</span>
							[T]
						</div>
						<div id="RedLine"></div>
					</body>
					</html>"}
		src<<browse(HTML,"window=BrowserWHO;size=600x400")
//=====================================================================
	Check_Jutsu(var/mob/player/T in MasterPlayerList)
		set category = "Staff"
		var/list/V= list()
		for(var/obj/SkillCards/O in T.contents)
			V+=O
		if(!V.len)
			src<<"[T.trueName] has nothing!"
			return
		var/obj/P=input("Pick a Jutsu","Check Jutsu") as null|anything in V
		if(P)
			var/Do
			if(GM<4)
				Do="Analysis"
			if(GM>=4)
				Do=alert("What would you like to do?","[P.name]","Analysis","Edit","Delete")
			if(Do=="Analysis")
				var/mob/VerbHolder/Admin/Level1/MM=src
				MM.Analyse_Object(P)
			else if(Do=="Edit")
				var/mob/VerbHolder/Admin/Level4/Edit/MM=src
				MM.Edit(P)
			else if(Do=="Delete")
				if(alert("are you sure you'd like to delete [P.name] from [T.trueName]?","[P.name]","Yes","No")=="Yes")
					del(P)
		return

	Check_Inventory(var/mob/player/T in MasterPlayerList)
		set category="Z"
		var/list/V= list()
		for(var/obj/O in T.contents)
			if(!istype(O,/obj/SkillCards))
				V+=O
		if(!V.len)
			src<<"[T.trueName] has nothing!"
			return
		var/obj/P=input("Pick an item from [T.trueName]'s inventory","Check Inventory") as null|anything in V
		if(P)
			var/Do
			if(GM<4)
				Do="Analysis"
			if(GM>=4)
				Do=alert("What would you like to do?","[P.name]","Analysis","Edit","Delete","Cancel")
			if(Do=="Cancel")
				return
			else if(Do=="Analysis")
				var/mob/VerbHolder/Admin/Level1/MM=src
				MM.Analyse_Object(P)
			else if(Do=="Edit")
				var/mob/VerbHolder/Admin/Level4/Edit/MM=src
				MM.Edit(P)
			else if(Do=="Delete")
				if(alert("are you sure you'd like to delete [P.name] from [T.trueName]'s pack?","[P.name]","Yes","No")=="Yes")
					del(P)
					T.UpdateInventory()
		return
proc
	LoadGMLog()
		if(fexists("Data/NoWipe/GMLog.sav"))
			var/savefile/F = new ("Data/NoWipe/GMLog.sav")
			F["GMLog"]>>GMLOG

	SaveGMLog()
		var/savefile/F = new("Data/NoWipe/GMLog.sav")
		F["GMLog"] << GMLOG

	OpenList(var/list/A) //For Variable Analysis
		//var/list/A2=A
		var/T2
		if(!A)
			return "Empty List"
		if(!istype(A,/list))
			return
		for(var/B in A)
			if(istype(B,/list))
				var/Z=OpenList(A[B])
				T2+={"<span class="ListItem">[Z]</span>"}
			/*else if(A[B])
				if(!istype(A["[B]"],/atom))
					var/Ac=A["[B]"]
					T2+={"<span class="ListItem">[B]&nbsp;=&nbsp;[Ac],&nbsp;</span>"}*/
			else
				T2+={"<span class="ListItem">[B],&nbsp;</span>"}
		var/T={"<div class="InnerList" onclick="DispDesc(this)"><div>List()</div><div class="ILObj" style="display:none;">&nbsp;[T2]</div></div>"}
		return T