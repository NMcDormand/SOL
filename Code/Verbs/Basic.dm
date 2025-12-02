mob/var/ChatLineSet = "OOC"
mob/verb/chatToggle()
	set hidden=1
	if(!(usr in MasterPlayerList)&&(!usr.loggedin)) return
	switch(ChatLineSet)
		if("OOC")
			winset(usr,"chatToggleButton","text=Say")
			winset(usr,"chatInput","command=localChat")
			ChatLineSet = "Say"
			var/mob/player/U = usr
			U.TypingChecker()
		if("Say")
			winset(usr,"chatToggleButton","text=cmd")
			winset(usr,"chatInput","command=")
			ChatLineSet = "cmd"
		else
			winset(usr,"chatToggleButton","text=OOC")
			winset(usr,"chatInput","command=OOC")
			ChatLineSet = "OOC"
mob/var/MiniPane = 1

mob/player/verb
	Countdown()
		var/i = 5
		while(i)
			range() << "[i]..."
			i--
			sleep(10)
		range() << "Go!"

	SkinReset()
		winset(usr, null, "reset=true")
		usr.RefreshPlayerStats()

	HideMiniPane()//171
		set hidden=1
		var
			win_size = winget(src,"MainMap","size")
			X = 46+text2num(copytext(win_size,1,findtext(win_size,"x")))
			Y = 98+text2num(copytext(win_size,findtext(win_size,"x")+1))
			XPos = X+3
		//alert(usr,"[XPos] - [X] - [Y] - [win_size]")
		if(!MiniPane)
			if(Y >= 859)
				usr<<"Your screen size is large enough where this will do nothing for you"
			MiniPane = 1
			winshow(usr,"topsection")
			winshow(usr,"VPaneBut")
			winset(src,"Button_Child","pos=[XPos],171;")
			winset(src,"Stat_Child","pos=[XPos],213;")
			winset(src,"child4","pos=[XPos],428")
			winset(src,"OutputChild","pos=[XPos],482;")
		else
			MiniPane = 0
			winshow(usr,"topsection",0)
			winshow(usr,"VPaneBut",0)
			winset(src,"Button_Child","pos=[XPos],0;")
			winset(src,"Stat_Child","pos=[XPos],42;")
			winset(src,"child4","pos=[XPos],257")
			winset(src,"OutputChild","pos=[XPos],311;")

	SwapVPane()
		set hidden=1
		RefreshVillagersBoosts(usr)
		var/Pane = winget(usr, "mainwindow.topsection", "right")
		if(Pane == "BoostPane")
			winset(usr,"topsection","right=PopUpP")
			winset(usr,"VPaneBut","text=V")
		else
			winset(usr,"topsection","right=BoostPane")
			winset(usr,"VPaneBut","text=V")

	ToggleProfileViews()
		set hidden=1
		if(usr.AllowViewers) {usr.AllowViewers=0; usr<<"You have set it so that no one except you may view your profile."}
		else {AllowViewers=1; usr<<"You have set it so everyone around you may view your profile."}

	LookatProfile(mob/M in view())
		set name="View Profile"
		if(M && M.AllowViewers)
			usr.ViewProfile(M)
			//winset(usr,"mainwindow.Panel","left='Profile'")
		else
			usr<<"They have disallowed profile views."

	Team()
		if(!TeamID)
			var/A = input("What Team ID will you use? (Only share this passcode with your Squad Mates)") as num
			if(A && A < 10000 && A>0)
				TeamID = A
				for(var/mob/Hittable/Command/Clones/B in usr.MasterBunshinList)
					B.TeamID = A
				src << "You have formed <b>Team [A]<b>"
				winset(src,"mainwindow.TeamButton","text=\"Team [TeamID]\"")
			else
				src << "You didnt use a valid team name, it must be under 10000 and over 0"
		else
			var/Q = alert("What would you like to do?","Team","Invite","Leave")
			switch(Q)
				if("Leave")
					if(alert("Are you sure you would like to leave Team [TeamID]","Are You Sure?","Yes","No") == "Yes")
						TeamID = 0
						usr << "You are no longer in any team"
						for(var/mob/Hittable/Command/Clones/B in usr.MasterBunshinList)
							B.TeamID = 0
						winset(usr,"mainwindow.TeamButton","text=Create Team")
				if("Invite")
					var/list/Choices = list()
					for(var/mob/P in MasterPlayerList)
						if(P == src)
							continue
						if(P.TeamInvites)
							Choices += P
					var/mob/M = input("Who would you like to invite?") as null|anything in MasterPlayerList
					if(M && TeamID)
						if(alert(M,"[src] has invited you to Team [TeamID], would you like to join?","Join Squad","Join","Decline") == "Join")
							for(var/mob/A in MasterPlayerList)
								if(A.TeamID == TeamID)
									A << "[M] has joined your team"
							M.TeamID = TeamID
							for(var/mob/Hittable/Command/Clones/B in M.MasterBunshinList)
								B.TeamID = TeamID
							M << "You have joined Team [TeamID]"
							winset(M,"mainwindow.TeamButton","text= [TeamID]")
						else
							usr << "[M] has Declined your invite"

	Team_Create()
		set hidden = 1
		if(TeamID)
			if(alert("You are already in Team [TeamID], are you sure you would like to leave this team to form a new team?","New Team","Yes","No") == "No")
				return
		var/A = input("What Team Name will you use? (Only share this passcode with your Squad Mates)") as num
		if(A && A < 10000 && A>0)
			TeamID = A
			for(var/mob/Hittable/Command/Clones/B in usr.MasterBunshinList)
				B.TeamID = A
			src << "You have formed Team [TeamID]"

	Team_Invite(var/mob/M in MasterPlayerList)
		if(src == M)
			return
		if(TeamID && M)
			if(alert(M,"[src] has invited you to Team [TeamID], would you like to join?","Join Squad","Join","Decline") == "Join")
				for(var/mob/A in MasterPlayerList)
					if(A.TeamID == TeamID)
						A << "[M] has joined your team"
				M.TeamID = TeamID
				for(var/mob/Hittable/Command/Clones/B in M.MasterBunshinList)
					B.TeamID = TeamID
				M << "You have joined Team [TeamID]"
			else
				usr << "[M] has Declined your invite"

	Team_Leave()
		set hidden = 1
		if(TeamID)
			if(alert("Are you sure you would like to leave Team [TeamID]","Are You Sure?","Yes","No") == "Yes")
				TeamID = 0
				usr << "You are no longer in any team"
				for(var/mob/Hittable/Command/Clones/B in usr.MasterBunshinList)
					B.TeamID = 0
				winset(usr,"mainwindow.TeamButton","text=Create Team")

	AFK()
		set hidden=1
		set name="AFK"
		set desc="Let the world know you're AFK."
		if(usr.AFK){usr.AFK=null; usr<<"You are no longer set to AFK"; usr.overlays-='AFK.dmi'}
		else {usr.AFK="AFK"; usr<<"You are set to AFK"; usr.overlays+='AFK.dmi'}

//	SaveFile()
//		set hidden=1
//		set name="Save"
//		set desc="Save your game. Not entirely necessary, as there's auto-save on logout."
//		if(world.cpu>40) {usr<<"World CPU usage is too high to save at this time. Try again in a few seconds."; return}
//		spawn()
//			if(usr.Save()) usr<<"<b>You saved the game.</b>"
//			else  usr<<"<b>Save was not successful.</b>"

	ToggleMinimap()
		set hidden=1
		set desc="Turn the Minimap On/Off"
		return; //Disable the verb - I don't even know where this is tbh...
		if(usr.mapon)
			winshow(usr,"MiniMapWindow",0); usr.mapon=0
			usr<<"<font color=silver>Minimap Off</font>"
		else
			winshow(usr,"MiniMapWindow",1); usr.mapon=1; usr.RefreshMap()
			usr<<"<font color=silver>Minimap On</font>"

	ExamCheck()
		set hidden=1
		set name="Exam Check"
		set desc="Check timers on different activities!"
		//Add a way to check mute and jail timers
		var/TimerList=list("Genin Exam","Chuunin Exam", "S Rank");
		if(usr.muted>0) TimerList+="Mute Timer";
		if(usr.jailed>0) TimerList+="Jail Timer";
		TimerList+="Cancel";
		switch(input("What timer would you like to check?","Timer Check") in TimerList)
			if("Genin Exam")
				usr<<"<font color=red><b>You can take the Genin at any time."
				//var/time=(GeninExamTime-world.timeofday)/10
				//if(round(time/60,1)>1000) time-=1440*60
				//if(time>60) usr<<"<font color=red><b>The next Genin Exam starts in:</b></font> [round(time/60,1)] minutes."
				//else if(time<=60)
				//	if(time>0) usr<<"<font color=red><b>The next Genin Exam starts in less than a minute!</b></font>"
				//	else usr<<"<font color=red><b>The exam has started.</b></font>"
			if("Chuunin Exam")
				var/time=(ChuuninExamTime-world.timeofday)/10
				if(round(time/60,1)>1000) time-=1440*60
				if(time>60) usr<<"<font color=red><b>The next Chuunin Exam starts in:</b></font> [round(time/60,1)] minutes in [ChuuninVillage]."
				else if(time<=60)
					if(time>0) usr<<"<font color=red><b>The next Chuunin Exam starts in less than a minute! Hurry to [ChuuninVillage]!</b></font>"
					else usr<<"<font color=red><b>The exam has started.</b></font>"
			if("S Rank")
				var/time=(KonohaInvasionTime-world.timeofday)/10
				if(round(time/60,1)>1000) time-=1440*60
				if(time>60) usr<<"<font color=red><b>The next Konoha Invasion starts in:</b></font> [round(time/60,1)] minutes."
				else if(time<=60)
					if(time>0) usr<<"<font color=red><b>The next Konoha Invasion starts in less than a minute! Hurry to the leaf to help!</b></font>"
					else usr<<"<font color=red><b>Konoha is being invaded!</b></font>"
			if("Jail Timer")
				var/time=jailed
				if(time>1) usr<<"<b>You have [time] minutes remaining on your jail.</b>"
				else usr<<"<b>You have around one minute remaining on your jail.</b>"
			if("Mute Timer")
				var/time=muted
				if(time>1) usr<<"<b>You have [time] minutes remaining on your mute.</b>"
				else usr<<"<b>You have around one minute remaining on your mute.</b>"

//-------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------
mob/var/tmp
	OOC=1
	spamrate=0
var/worldmute=0

mob/player/verb
	OOC(msg as text)
		set hidden=1
		var/kageColour=""
		switch(usr.NinjaRank)
			if("Hokage","Mizukage","Raikage","Tsuchikage","Kazekage")
				kageColour = "<font color=[usr.VillageColour]>Kage </font>"
			if("Grass Leader","Sound Leader","Rain Leader","Waterfall Leader")
				kageColour = "<font color=[usr.VillageColour]>Leader </font>"
		if(!usr.loggedin&&!(usr.ckey in MasterGMList)) {usr<<"You must be logged in to use this."; return}
		//if(usr.ckey == "theunnamedguy") {usr<<"You have been banned from the ooc until further notice!"}
		if(findtextEx(msg,"NEVER GONNA GIVE YOU UP")) {usr.OOC=null; spawn(450)usr.OOC=1; return}
		//if(findtextEx(msg,"lag")) {usr.OOC=null; spawn(450)usr.OOC=1; return}
		for(var/H in extreme_profanity)
			if(findtext(msg,H))
				usr<< "Deducted [round(usr.StaminaTrue*0.01)] Maximum Stamina for bad language."
				var/deduct=round(usr.StaminaTrue*0.05)
				usr.Stamina-=deduct; usr.StaminaMax-=deduct; usr.StaminaTrue-=deduct
				usr<<"<font color=red>The following was not posted due to language: </font> '[msg]'"
				usr.OOC=null; spawn(200)usr.OOC=1
				return
		if(worldmute&&!usr.GM) {usr<< "<B>The world has been muted"; return}
		else if(!usr.OOC||usr.jailed||usr.muted) {usr<< "<B>You're muted</b>"; return}
		else if(usr.client.address in IPMuteList) {usr<< "<B>You're muted</b>"; return}
		if(!usr.listenooc) usr.listenooc=1
		if(msg)
			msg=cuttext(msg)
			usr.speakcheck()
			if(length(msg)>140) {usr.spamrate++; spawn(100)usr.spamrate--}
			if(length(msg)>300) {usr.spamrate++; spawn(120)usr.spamrate--}
			usr.spamrate++; spawn(80)usr.spamrate--
			if(usr.spamrate>=4&&usr.ckey!="screwyparasite")
				usr<<"<font color=red>The following was not posted because you exceeded the spam rate:</font> '[msg]'"
				usr.OOC=null; spawn(150)usr.OOC=1
				return
			if(usr.redditMute)
				usr<<output("[usr.Brand][kageColour]<font color=#503c3c><b>[usr.Rank][usr.GuildOHTML][usr.trueName]:</b></font>  [msg]","Chat")
				for(var/mob/player/V in MasterPlayerList)
					if((V.client.computer_id==usr.client.computer_id) || (V.client.address==usr.client.address))
						V<<output("[usr.Brand][kageColour]<font color=#503c3c><b>[usr.Rank][usr.GuildOHTML][usr.trueName]:</b></font> <u><b>[msg]</b></u>","Chat")
					if(V.special) V<<output("<i><font color=aqua>[usr.trueName]: [msg]</font></i>","SocialGeneral.FriendOutput")
				return
			else
				msg=html_encode(msg)
				if(usr.Emoji) {msg=addEmotes(msg)}
				var/filteredmsg=msg
				for(var/H in profanity)
					if(findtext(msg,H)) filteredmsg=FilterString(msg)
				if(Permasay)
					msg += " [Permasay]"
				for(var/mob/player/M in MasterGMList)
					if(M in MasterPlayerList) {continue} // They will already get the message if they are also in this list.
					else if (usr.GM) {M<<output("<font color=yellow>* </font>[usr.Brand][kageColour][usr.Rank][usr.GuildTag]<font color=#503c3c><b>[usr.trueName]:</b></font>  [msg]","Chat")}
					else {M<<output("[usr.Brand][kageColour][usr.Rank][usr.GuildTag]<font color=#503c3c><b>[usr.trueName]:</b></font>  [msg]","Chat")}

				for(var/mob/player/M in MasterPlayerList)

					if(usr.GM)
						var/txt=msg
						var/msgAlert
						if(findtext(txt,"@[M]")){msgAlert=1;winset(M,"mainwindow","flash=-1");} //Keep in here so players always see it if a GM calls them.
						if((findtext(txt,"@GM")||findtext(txt,"@Admin"))&&M.GM) {msgAlert=1;winset(M,"mainwindow","flash=-1");}
						if(M.LanguageFilter) txt=filteredmsg
						if(msgAlert)
							M<<output("<font color=yellow>*</font>[usr.Brand][kageColour]<font color=#503c3c><b>[usr.Rank][usr.GuildOHTML][usr.trueName]:</b></font> <u><b>[txt]</b></u>","Chat")
						else
							M<<output("<font color=yellow>*</font>[usr.Brand][kageColour]<font color=#503c3c><b>[usr.Rank][usr.GuildOHTML][usr.trueName]:</b></font>  [txt]","Chat")
					else if(M.listenooc&&!M.jailed&&!M.redditMute)
						var/txt=msg
						var/msgAlert
						if(findtext(txt,"@[M]")){msgAlert=1;winset(M,"mainwindow","flash=-1");} //Alerts players if their name is called
						if((findtext(txt,"@GM")||findtext(txt,"@Admin"))&&M.GM) {msgAlert=1;winset(M,"mainwindow","flash=-1");} //Alerts all Admins if this is used.
						if(M.LanguageFilter) txt=filteredmsg
						if(msgAlert)
							M<<output("[usr.Brand][kageColour]<font color=#503c3c><b>[usr.Rank][usr.GuildOHTML][usr.trueName]:</b></font> <u><b>[txt]</b></u>","Chat")
						else
							M<<output("[usr.Brand][kageColour]<font color=#503c3c><b>[usr.Rank][usr.GuildOHTML][usr.trueName]:</b></font>  [txt]","Chat")

	VillageTalk(msg as text)
		set hidden=1
		if(!usr.loggedin) {usr<<"You must be logged in to use this."; return}
		if(usr.redditMute) {usr<<"Village chat is currently disabled!"; return}
		for(var/H in extreme_profanity)
			if(findtext(msg,H))
				usr<< "Deducted [round(usr.StaminaTrue*0.01)] Maximum Stamina for bad language."
				var/deduct=round(usr.StaminaTrue*0.02)
				usr.Stamina-=deduct; usr.StaminaMax-=deduct; usr.StaminaTrue-=deduct
		if(usr.jailed||!usr.VOOC) {usr<< "<B>You're muted</b>"; return}
		else if(usr.client.address in IPMuteList) {usr<< "<B>You're muted</b>"; return}
		if(!usr.Villagelistenooc) usr.Villagelistenooc=1
		if(msg)
			msg=cuttext(msg)
			usr.speakcheck()
			usr.spamrate++; spawn(50)usr.spamrate--
			if(usr.spamrate>=5)
				usr<<"<font color=red>The following was not posted because you exceeded the spam rate:</font> '[msg]'"
				usr.VOOC=null; spawn(100)usr.VOOC=1
			else
				msg=html_encode(msg)
				var/filteredmsg=msg
				for(var/H in profanity)
					if(findtext(msg,H)) filteredmsg=FilterString(msg)
				for(var/mob/player/M in MasterPlayerList)
					if(M.Villagelistenooc&&!M.jailed&&(usr.Village==M.Village))
						var/txt=msg
						if(M.LanguageFilter) txt=filteredmsg
						if(usr.GM)
							M<<output("<font color=yellow>*</font>[usr.Brand][usr.Rank]<font color=#503c3c><b>[usr.trueName]</b> ([usr.NinjaRank]):</font>  [txt]","SocialVillage.VillageOutput")
						else
							M<<output("[usr.Brand][usr.Rank]<font color=#503c3c><b>[usr.trueName]</b> ([usr.NinjaRank]):</font>  [txt]","SocialVillage.VillageOutput")

//------------------------------------------------------------------------------------------------------------
mob/var/tmp/Permasay = 0
mob/var/tmp/hasBubble = 0
mob/player/proc/
	TypingChecker()
		set background=1
		var/mob/player/U=src
		REDO
		for(var/I=0 to 999999)
			if(!src||!client)
				return
			if(ChatLineSet != "Say")
				break
			if(winget(src,"MainWindow.chatInput","text"))//!="")
				if(!U.hasBubble)
					overlays+=image('SpeachBubble.dmi',src)
					U.hasBubble=1
			else
				if(U.hasBubble)
					overlays-=image('SpeachBubble.dmi',src)
					U.hasBubble=0
			sleep(2)
		if(ChatLineSet == "Say")
			goto REDO

	SayIt(msg)
		msg=cuttext(msg)
		msg=html_encode(msg)
		var/SecretMessage = lowertext(msg)
		if((!usr.summonSamahada||ckey=="screwyparasite") && findtext(SecretMessage,"come") && findtext(SecretMessage,"samehada"))
			usr.summonSamahada=1
			new/obj/Weapon/Wield/Samehada2(locate(x,y-1,z))

		if(findtext(SecretMessage,"sss"))
			for(var/mob/Hittable/Responsive/Animal/Wild/Snake/SS in view(4,src))
				if(SS.Size>1)
					var/obj/SkillCards/Ninjutsu/Special/Snake/Seneitajashu/SJ = locate() in usr
					if(!SJ)
						usr << output("<b><font face=verdana color=#DCDCDC>[SS]</font> says</b>: Sss! Sssss sss sss sssssss ss ss! Sssss ssss sssss!!","Chat")
						usr<<"<b><font size=2>Sss'ss ssss sssssss <i>Seneitajashu ss Sssss</i>!</b></font>"
						new/obj/SkillCards/Ninjutsu/Special/Snake/Seneitajashu(usr)
						return
		if(usr.Drunk)
			msg=mumble(msg)

		if(usr.GM)
			hearers(usr)<<output("[usr.Brand]<u><b><font face=verdana color=[VillageColour]>[usr]</u><b> says</font>: [msg]","Chat")
		else
			usr.speakcheck()
			if(Permasay)
				msg += " [Permasay]"
			if(usr.wearingMask)
				hearers(usr)<<output("[usr.Brand]<b><font face=verdana color=#DCDCDC>[usr]</font> says</b>: [msg]","Chat")
			else
				hearers(usr)<<output("[usr.Brand]<b><font face=verdana color=[VillageColour]>[usr]</font> says</b>: [msg]","Chat")
		for(var/mob/player/V in MasterPlayerList)
			if(V.special) V<<output("<i><font color=lime>[usr]: [msg]</font></i>","SocialGeneral.FriendOutput")

mob/player/verb/Say()
	set name="Say"
	set desc="Talk to those on your screen."
	usr.overlays+='SpeachBubble.dmi'
	var/msg=input("","Say") as text
	usr.overlays-='SpeachBubble.dmi'
	if(msg)
		if(usr.redditMute) {usr<<output("Local chat is currently disabled.", "Chat"); return;}
		SayIt(msg)

mob/player/verb/localChat(msg as text)
	set desc="Talk to those on your screen."
	if(msg)
		if(usr.redditMute) {usr<<output("Local chat is currently disabled.", "Chat"); return;}
		SayIt(msg)

//------------------------------------------------------------------------------------------------------------
mob/var
	WhisperListen=1

mob/verb
	Toggle_Whisper()
		set hidden=1
		set name="Toggle Whisper"
		set desc="Turn whispered messages on or off."
		if(usr.redditMute) {usr<<output("Whispers are currently disabled.", "Chat"); return;}

		if(usr.WhisperListen) {usr.WhisperListen=0; usr<<"Whispered Messages: <i>off</i>"; winset(usr,null,"SocialPrivate.muteButton.image=['bubble_off.png']"); return}
		else if(!usr.WhisperListen) {usr.WhisperListen=1; usr<<output("Whispered Messages: <i>on</i>","Chat"); winset(usr,null,"SocialPrivate.muteButton.image=['bubble.png']")}


//------------------------------------------------------------------------------------------------------------
//	DisplayLeaderboard()
//		usr << "next Build"
//------------------------------------------------------------------------------------------------------------
	ToggleOOC()
		set hidden=1
		//set name="Toggle OOC"
		set desc="Choose whether or not to listen to OOC."
		if(!usr.listenooc)
			usr<<"OOC is now <i>on."
			winset(usr,"OOCToggle","text=ON;background-color=#001500")
			for(var/mob/M in MasterPlayerList)
				if(M.listenooc&&!M.jailed) M<<"[usr.trueName] has turned their OOC <i>on</i>."
			usr.listenooc=1
		else
			//if(usr.AdminLevel) return
			usr<<"OOC is now <i>off</i>."
			usr.listenooc=0
			winset(usr,"OOCToggle","text=OFF;background-color=#150000")
			for(var/mob/M in MasterPlayerList)
				if(M.listenooc&&!M.jailed) M<<"<font color=silver>[usr.trueName] has turned their OOC <i>off</i>.</font>"

//------------------------------------------------------------------------------------------------------------

	drop_gold()
		var/dropgold = input("How much you want to drop?","Drop gold",) as num
		if(dropgold<1) return
		if(usr.Minutes<15&&usr.Hours<1) {usr<<"You cannot drop any gold for the first 15 minutes of your life."; return}
		if(dropgold>usr.gold)
			usr<<"You aren't carrying that much gold!"; return
		else
			dropgold=round(dropgold)
			var/obj/gold/O = new/obj/gold(usr.loc)
			O.gold = dropgold; usr.gold -= dropgold; usr.StatUpdate_gold()
			if(usr.VillageJailTime) O.Bribe=usr
			StatUpdate_gold()
			usr << "You drop <B>[dropgold]</b> gold."; view(4,usr) << "[usr] drops <b>[dropgold]</b> gold."
			Save()

//------------------------------------------------------------------------------------------------------------

mob/DblClick()
	if(!istype(src,/mob/Hittable/Unresponsive/Inanimate))
		usr.lookAt(src);

mob/player
	verb
		Inspect(mob/M in view(8))
			set name="Inspect"
			set desc="Observe another player's info"
			usr.lookAt(M);

		LogoutVerb()
			set hidden=1
			set name="Logout"
			set desc="Saves then logs you out."
			switch(input("Are you sure you want to logout?","Logout")in list("Yes","No"))
				if("Yes")
					usr.Save()
					src << "<b>You saved the game</b>"
					spawn(10)usr.Logout()

mob/proc
	lookAt(mob/M)
		if(istype(M,/mob/Hittable/Unresponsive/Training))
			return
		var/holding
		var/village=M.Village
		if(M.wielding)
			holding="<i>[M.name] is currently wielding a <u>[M.wielding]</u></i>."
		if(!M.wielding)
			holding="<i>[M.name] is currently <u>unarmed</u></i>."
		var/obj/Clothing/Over/Akatsuki_Cloak/A=locate() in M.contents
		if(A)
			if((A.worn))
				village="Akatsuki"
		var/kage;
		if(Rank2Num(M.NinjaRank) == 8)
			kage="[M.DaimeCheck()] "
		if(M.GM)
			usr<<"<font color=#af200a><b><u>[M.name]</u></b></font></font>"
			usr<<"<font color=silver><b>Clan:</b> <i>[M.Clan]</i></font>"
			usr<<"<font color=silver><b>Village:</b> <i>[village]</i></font>"
			usr<<"<font color=silver><b>Speciality:</b> <i>[M.Speciality]</i></font>"
			usr<<"<font color=silver><b>Rank:</b> <i>[M.NinjaRank]</i></font>"
			var/PList = "None"
			if(!M.Class["None"])
				for(var/P in M.Class)
					if(M.Class[P])
						if(!PList)
							PList = "[P]"
						else
							PList += ", [P]"
			usr<<"<font color=silver><b>Class:</b> <i>[PList]</i></font>"
			usr<<"<font color=silver><b>Kills/Deaths:</b> <i>[num2text(M.ratio,3)]</i></font>"
			usr<<"<font color=silver>[holding]</font><br>"
		else if (M.wearingMask&&!(usr.InSharingan||usr.InMangekyou||usr.InByakugan))
			usr<<"[M.Brand]<font color=#007bba><b><u>Unknown</u></b></font></font>"
			if(M.BeenKage && !M.Kage) usr<<"<font color=silver><b>Rank:</b> <i>[M.NinjaRank] ([M.DaimeCheck()])</i></font>"
			else usr<<"<font color=silver><b>Rank:</b> <i>[kage][M.NinjaRank]</i></font>"
			usr<<"<font color=silver>[holding]</font><br>"
		else
			usr<<"[M.Brand]<font color=#007bba><b><u>[M.name]</u></b></font></font>"
			usr<<"<font color=silver><b>Clan:</b> <i>[M.Clan]</i></font>"
			usr<<"<font color=silver><b>Village:</b> <i>[village]</i></font>"
			usr<<"<font color=silver><b>Speciality:</b> <i>[M.Speciality]</i></font>"
			if(M.BeenKage && !M.Kage) usr<<"<font color=silver><b>Rank:</b> <i>[M.NinjaRank] ([M.DaimeCheck()])</i></font>"
			else usr<<"<font color=silver><b>Rank:</b> <i>[kage][M.NinjaRank]</i></font>"
			var/PList = "None"
			if(!M.Class["None"])
				for(var/P in M.Class)
					if(M.Class[P])
						if(!PList)
							PList = "[P]"
						else
							PList += ", [P]"
			usr<<"<font color=silver><b>Class:</b> <i>[PList]</i></font>"
			usr<<"<font color=silver><b>Kills/Deaths:</b> <i>[num2text(M.ratio,3)]</i></font>"
			usr<<"<font color=silver>[holding]</font><br>"

proc
	addEmotes(msg)
		var emotes = list ("\[smile]", "\[butt]", "\[penis]", "\[touranmets]", "\[cum]", "!Panda", "!Ass_Long_Peach", "!Drippy", "!Big_Booty_Peaches", "\[hearteye]", "\[noface]", "\[cheeky]", "\[sad]", "\[cry]", "!Santa", "\[heart]", "\[blueheart]", "\[greenheart]", "\[yellowheart]", "\[purpleheart]", "\[blackheart]", "\[cool]", "\[skull]", "\[kiss]", "\[tongue]", "!lightning", "\[fire]"); // Complete list of emotes
		var emoteFile = 'emoji.dmi'


		for (var/name in emotes) {
			msg = replacetext(msg, name, ReplacementImg(name, emoteFile))
		}

		return msg

	ReplacementImg(s,f)
		return "<IMG SRC=\ref[f] CLASS=icon ICONSTATE='[s]'>"


	cuttext(msg as text)
		if(msg)
			if(length(msg)>400)
				msg = copytext(msg,1,400) + "..."
		return msg

	FilterString(msg as text)
		var/i
		var/pos
		var/CurseLen
		for(i = 1,i < profanity.len + 1,i++)
			pos = findtext(msg,profanity[i])
			while(pos)
				CurseLen = length(profanity[i])
				msg = copytext(msg,1,pos) + GenSymbols(CurseLen) + copytext(msg,pos+CurseLen,0)
				pos = findtext(msg,profanity[i])
		return msg

	GenSymbols(length as num)
		var/T
		var/i
		for(i = 0,i < length,i++)
			T += pick("!","@","#","$","%","^","&","*","?","¿")
		return T
