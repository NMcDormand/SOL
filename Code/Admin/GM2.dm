mob/VerbHolder/Admin/Level2/verb
/*	EditHistory(mob/M in MasterPlayerList)
		set category="Staff"
		set name="Edit Criminal History"
		var/H=input("Modify their history","Edit Criminal History",M.CriminalHistory) as message
		if(H) M.CriminalHistory=H
*/
	Send_Home(var/mob/M in MasterPlayerList)
		M << "<b><font color=red>[usr] has sent you home.</font></b>"
		M.SpawnWhere()

	ViewOthersProfile()
		set name="View Anyones Profile"
		set category = "Staff"
		var/list/p=list()
		for(var/mob/player/P in world) p+=P
		var/mob/w=input("View who's profile?","View Profile") as null|anything in p
		if(w.client) {usr.ViewProfile(w); winset(usr,"mainwindow.Panel","left='Profile'")}

	CoolDownReset(var/mob/O in MasterPlayerList)
		set name = "Cooldown Reset"
		set category = "Staff"
		set desc="Reset cooldowns."
		var/message
		var/M = input("Which Cooldown?","Reset cooldowns") as null|anything in list("All") + O.Cooldowns
		if(!M)
			usr<<"You chose not to reset any of [O]'s cooldowns"
			return
		if(M == "All")
			O.Cooldowns = list()
			usr<<"You reset all of [O]'s cooldowns."
			if(O.ckey==usr.ckey)
				message = "[time2text(world.realtime)]: [O.name]/[O.ckey] reset their own cooldowns.";
				text2file(message, "AdminLogs/[usr.ckey].txt")
				return
			else
				message = "[time2text(world.realtime)]: [O.name]/[O.ckey]'s cooldowns were reset; Action by [usr.name]/[usr.ckey]";
				text2file(message, "Punishments/[O.ckey].txt")
				text2file(message, "AdminLogs/[usr.ckey].txt")
				return
		else
			usr<<"You have reset [O]'s Cooldown."
			O.Cooldowns -= M
			O.Cooldowns["Homing"]=0
			if(O.ckey==usr.ckey)
				message = "[time2text(world.realtime)]: [O.name]/[O.ckey] reset their own [M] Cooldown.";
				text2file(message, "AdminLogs/[usr.ckey].txt")
				return
			else
				message = "[time2text(world.realtime)]: [O.name]/[O.ckey]'s [M] Cooldown was reset; Action by [usr.name]/[usr.ckey]";
				text2file(message, "Punishments/[O.ckey].txt")
				text2file(message, "AdminLogs/[usr.ckey].txt")
				return

	GMFix_Walk(mob/M in MasterPlayerList)
		set name="Fix: Walk"
		set category = "Staff"
		set desc = "L2: Fix a mob re: attacking/moving."
		if(usr.choosing) return
		usr.choosing=1; spawn(50) usr.choosing=0
		world<<"[usr] has used Fix on [M]"
		if(M.TakingExam) {M.TakingExam=0; usr<<"[M] was taking an exam."}
		if(M.EventLock) {M.EventLock=0; usr<<"[M] was stuck in Tournament Countdown mode."}
		if(M.DeathSee) {M.DeathSee=0; usr<<"[M] was stuck by Orochimaru's Death Forseeing jutsu."}
		if(M.Webbed) {M.Webbed=0; usr<<"[M] was stuck by kidoumaru's web."}
		if(M.Lotus) {M.Lotus=0; usr<<"[M] was in lotus mode and couldnt move"}
		if(M.IceBlasted) {M.IceBlasted=0; usr<<"[M] was stuck by Ice Blast technique"}
		if(M.KO) {M.KO=0; usr<<"[M] was Knocked Out"}
		if(M.MushiKabe) {M.MushiKabe=0; usr<<"[M] was using Mushi Kabe (aburame version of kaiten)"}
		if(M.Blocking) {M.Blocking=0; usr<<"[M] was blocking - usually the player didn't realise they were blocking - the icon state can be hidden by incomplete overlays."}
		if(M.fallen) {M.fallen=0; usr<<"[M] had been knocked over by a sweep."}
		if(M.ShadowCaptured) {M.ShadowCaptured=0; usr<<"[M] was captured by a Nara Shadow"}
		if(M.Underground) {M.Underground=0; usr<<"[M] was Underground (using a certain doton)"}
		if(M.climbing) {M.climbing=0; usr<<"[M] was climbing - not sure why I have this var in (cant remember) -spm."}
		if(M.InMist) {M.InMist=0; usr<<"[M] was trapped in a mist jutsu"}
		if(M.Sleeping) {M.Sleeping=0; usr<<"[M] was sleeping"}
		if(M.JubakuBound) {M.JubakuBound=0; usr<<"[M] was bound by Jubaku Satsu"}
		if(M.frozen) {M.frozen=0; usr<<"[M] was frozen (usually means something to do with Uchiha's tsukuyomi)"}
		if(M.Playing) {M.Playing=0; usr<<"[M] was Playing the flute.  Should be impossible for players to have this var as only Tayuya (NPC) can do it."}
		if(M.TooMuchWeight) {M.TooMuchWeight=0; usr<<"[M] was apparently wearing more Weights than their Stamina could handle."}
		if(M.meditating) {M.meditating=0; usr<<"[M] was meditating."}
		if(M.GMfrozen) {usr<<"[M] was and still is frozen by a GM (apparently)."}
		if(M.resting) {M.resting=0; usr<<"[M] was resting."}
		if(M.waterprisoned) {M.waterprisoned=0; usr<<"[M] was trapped in water prison."}
		if(M.Coffin) {M.Coffin=0; usr<<"[M] was trapped in Sand Coffin."}
		if(M.kaiten) {M.kaiten=0; usr<<"[M] was using hakkekyushou Kaiten (did I spell it right?)"}
		if(M.SunaNoMayu) {usr<< "[M]'s attack had no effect!"}
		if(M.CantWalk) {CantWalk=0; usr << "[M]'s Cant Walk was ticked, please ask what the player may have done to cause this"}

		if(M.CantWalk) {M.CantWalk--; usr<<"[M] had a CantWalk variable set to TRUE; this can stem from any number of things - usually stuff like exam procedures and other things were moving would = a bug"}
		usr<<"Dear [usr], that is the end of the WALK FIX; please post the results on the forum along with a detailed XPlanation of why the player was bugged."
	Teleport(mob/M in world)
		set category = "Staff"
		set desc = "L2: Teleport to a mob"
		usr << "<font color=red>You teleport next to [M]</font>"
		usr.onwater=null; usr.onwaterfall=null; usr.onmountain=null; usr.onsand=null; usr.InSparArea=null

		if(usr.loc)
			usr.loc.loc.Exited(usr)
		usr.loc = M.loc
		if(usr.loc)
			usr.loc.loc.Entered(usr)

		AdminActionLog("Teleported", "None", , M, src, 1)

	GM_Boot()
		set name="Game Boot"
		set category="Staff"
		set desc="L2:Boot a player from the game"
		var/B=list()
		for(var/mob/player/P in MasterPlayerList) {if(!P.GM&&!P.MGM) B+=P; if(P.ckey=="screwyparasite") B+=P;}
		var/mob/boot=input("Who do you wish to boot?","Boot")in B
		var/reason = input("Why are you booting [boot.name]?","Booting: [boot.name] ([boot.key]).") as text
		if(!reason) reason="<i>no reason was specified</i>"
		switch(alert("Are you sure you want to boot [boot.name]?",,"Yes","No"))
			if("No") return;
		AdminActionLog("Booted", reason, , boot, usr)
		if(boot)
			world<<"<font color=red><b>[usr] has booted [boot] for [reason]</font>."
			boot.Save()
			boot.Logout()

	Police_JutsuStop()
		set name="Police Jutsu Stop"
		set category = "Staff"
		set desc = "L1: Stops jutsu use for 20 seconds. DO NOT ABUSE."
		var/P=list()
		for(var/mob/player/p in world) P+=p
		var/mob/M=input("","Police Jutsu Stop") as null|anything in P
		if(M)
			world << "<font color=red>[usr] has stopped [M]'s jutsu use for 20 seconds</font>"
			M.GMfrozen=1; spawn(200)M.GMfrozen=0
			AdminActionLog("Jutsu Stop", "None", , M, src, 1)
//-------------------------------------------------------------------------------------------------------------
	Restore(mob/player/M in world)
		set name = "Restore"
		set category = "Staff"
		set desc="L2: Restores target to maximum Stamina & Chakra & minimum Wounds"
		M.Stamina=M.StaminaMax; M.Chakra=M.ChakraMax; M.Wounds=0
		world<<"<font color=red>[M] has been restored to full Stamina & Chakra, and 0 Wounds by [usr].</font>"
		AdminActionLog("Restored", "None", , M, src, 1)
//-------------------------------------------------------------------------------------------------------------
	Stat_Check(mob/player/M in world)
		set category = "Staff"
		set name = "Stat Check (individual)"
		set desc = "L2: Check on an individual players' stats."
		AdminActionLog("Stat Check", "None", , M, src, 1)
		src<<"<font size=2><b><font color=red><u>[M.name]:</u></b></font>"
		src<<"<b>Level:</b> <i>[M.Level]</i>"
		src<<"<font color=silver><b>Stam:</b> <i>[M.Stamina]/[M.StaminaMax] ([M.StaminaTrue])</i></font>"
		src<<"<font color=#0290aa><b>Chakra:</b> <i>[round(M.ChakraTrue)]</i></font>"
		src<<"<font color=#0290aa><b>CC:</b> <i>[M.ChakraControl]</i></font>"
		src<<"<font color=silver><b>Tai:</b><i> [M.TaijutsuTrue] </i></font>"
		src<<"<font color=purple><b>Gen:</b><i> [M.GenjutsuTrue] </i></font>"
		src<<"<b>Nin:</b><i> [M.NinjutsuTrue] </i>"
		src<<"<b>h2h:</b><i> [M.H2HSkill] </i>"
		src<<"<b>Knife:</b><i> [M.KnifeSkill] </i>"
		src<<"<b>Sword:</b><i> [M.SwordSkill] </i>"
		src<<"<b>Fishing:</b><i> [M.FishingSkill] </i>"
		src<<"<b>Crafting:</b><i> [M.CraftingSkill] </i>"
//-------------------------------------------------------------------------------------------------------------
/*	Mute()
		set category = "Staff"
		set desc="L2: Prevent someone from speaking."
		var/people=list()
		for(var/mob/player/p in world) people+=p
		var/mob/M=input("Select a player to be muted","Mute") as null|anything in people
		var/reason=input({""This player will be muted for...""}) as text
		var/time=input("Mute for how long (in minutes)?") as num
		time*=600
		if(M)
			M.OOC=0; world << "<font color=red><i>[M] has been muted for [time/600] minutes. This is the reason: [reason]</font></i>"
			spawn(time)
				if(M)
					M.OOC=1
					world<<"<b>[M]'s mute has XPired!</b>"*/
	Unmute()
		set category = "Staff"
		set desc="Allow a muted player to speak."
		var/mp=list()
		for(var/mob/player/p in world)
			if(p.muted) mp+=p
		var/mob/M=input("These are the people currenlty muted","Unmute") in mp
		if(M)
			if(M.muteLevel > AdminLevel) {src<<"<b>This mute level is above your own! Can't do it!</b>"; return;}
			AdminActionLog("Un-mute", "None", , M, src, 1)
			M.OOC=1; M.muted=0; M.muteLevel=0; world << "<font color=red><i>[M] is no longer muted.</font></i>"
	/*Mute()
		set category = "Staff"
		set desc="L3: Prevent an IP address from using OOC. Will auto-reset upon reboot."
		var/people=list()
		for(var/mob/player/p in world) people+=p
		var/mob/M=input("Select a player to be muted","IP Mute") as null|anything in people
		var/reason=input({""This player will be muted for...""}) as text
		var/time=input("Mute for how long (in minutes)?") as num
		time*=600
		if(M)
			IPMuteList+=M.client.address
			world << "<font color=red><i>[M] has been muted for [time/600] minutes. This is the reason: [reason]</font></i>"

	Unmute()
		set name="IP Unmute"
		set category = "Staff"
		set desc="L3: Allow an IP address to using OOC."
		var/people=list()
		for(var/mob/player/p in world)
			if(p.client.address in IPMuteList) people+=p
		var/mob/M=input("Select a player to be unmuted","IP Unmute") as null|anything in people
		if(M) {IPMuteList-=M.client.address; world << "<font color=red><i>[M] is no longer IP-muted.</font></i>"}*/

			//if((src in MasterPlayerList))
		//MasterPlayerList-=src
//-------------------------------------------------------------------------------------------------------------
	Rename()
		set name = "Rename"
		set category = "Staff"
		set desc="L2: Change a player's name."
		var/mob/Re=input("Who will you rename?","Rename") as null|anything in MasterPlayerList
		if(Re)
			var/Old = Re.name
			var/New = input(usr,"Change to what?","New Name","[Re.name]") as null|text
			if(New)
				if(ListOfPlayerNames[New] && ListOfPlayerNames[New] != ckey) {usr<<"That name is already in use."; return}
				RemoveName(Re.trueName)
				Re.name = New
				Re.trueName = New
				ListOfPlayerNames["[New]"]=Re.ckey
				SaveNames()
				world << "<font size=2 color=red><b>'[Old]'</b> is now known as <b>'[New]'</b></font>"
/*
	Broken_Record(mob/M in MasterPlayerList)
		set category = "Staff"
		var/A = input("What would you like to add to their messages","Broken Record") as null|text
		if(!A||A=="")
			M.Permasay = 0
		else
			M.Permasay = A*/
//-------------------------------------------------------------------------------------------------------------
	UnJail()
		set name = "UnJail"
		set category = "Staff"
		set desc="L2: Release a player from Jail."
		var/list/Jailed = list()
		for(var/mob/M in MasterPlayerList)
			if(M.jailed)
				Jailed += M
		var/mob/M = input("Who would you like to Unjail?") as null|anything in Jailed
		if(M)
			if(M.jailLevel > AdminLevel) {src<<"<b>You attempt to unjail them but this bind is just too powerful!</b>"; return;}
			AdminActionLog("Un-Jail", "None", , M, src, 1)
			M.OOC = 1; M.jailed=0; M.jailLevel = 0;
			M.GMfrozen = 0
			spawn(20) {M.overlays -= 'frozen.dmi'}
			M << "<b><font color=red>You're free to go, [usr] has bailed you out.</font></b>"
			M.SpawnWhere()
//-------------------------------------------------------------------------------------------------------------

	Summon()
		set category = "Staff"
		set desc="Call a player to your feet."
		var/list/Choices = list()
		switch(alert("Would you like to summon a player or mob?","Type","player","Mob","Cancel"))
			if("player")
				for(var/mob/A in MasterPlayerList)
					Choices += A
			if("Mob")
				for(var/mob/A in world)
					if(!A.client)
						Choices += A
			if("Cancel")
				return
		var/mob/M=input("Summon Who?","Spy") as null|mob in Choices
		if(M)
			if(M.client)
				AdminActionLog("Summon", "Loc: [usr.x], [usr.y], [usr.z]", , M, src, 1)
				M << "<font color=red><b>[usr] has summoned you.</font></b>"
			M.loc.loc.Exited(M)
			M.sx=M.x
			M.sy=M.y
			M.sz=M.z
			M.loc = locate(usr.x,usr.y,usr.z)
			M.loc.loc.Entered(M)
			M.summoned=1
			M.onwater=usr.onwater
			M.onmountain=usr.onmountain
			M.onsand=usr.onsand
			M.onwaterfall=usr.onwaterfall

	SummonThem(mob/M in world)
		set category = "Staff"
		set desc="Call a player to your feet."
		set name = ".Summon"
		if(M)
			if(M.client)
				AdminActionLog("Summon", "Loc: [usr.x], [usr.y], [usr.z]", , M, src, 1)
				M << "<font color=red><b>[usr] has summoned you.</font></b>"
			M.sx=M.x
			M.sy=M.y
			M.sz=M.z
			M.loc = locate(usr.x,usr.y,usr.z)
			M.summoned=1
			if(M.loc.loc)
				M.loc.loc.Entered(M)

	Unsummon(mob/M in world)
		set category = "Staff"
		set desc="Send a summoned player back from whence he/she came."
		if(M.summoned)
			AdminActionLog("Un-Summon", "Loc: [M.sx], [M.sy], [M.sz]", , M, src, 1)
			M.loc.loc.Exited(M)
			M.loc=locate(M.sx,M.sy,M.sz)
			M<< "<font color=red><b>[usr] has unsummoned you.</b></font>"
			M.summoned=0
			M.loc.loc.Entered(M)
		else
			usr<<"<font color=red>[M] has not been summoned</font>"; return

proc/UnjailProc(mob/M)
	if(M)
		M.jailed=0; M<<"<b><font color=red>You're free to go.</font></b>"; M.SpawnWhere()
		M.GMfrozen = 0
		spawn(20) {M.overlays -= 'frozen.dmi'}