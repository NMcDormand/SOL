mob/logging
	Login()
		FindSaves()
mob/player
	Login()
		sight = 0
		client.view=9
		//..()
//		spawn(10)
//			if(!(client.computer_id in SubmittedResolutions))
//				src<<output({"<script type='text/Javascript'>
//	document.location.href = 'byond://?action=resol&width=' + screen.width+'&height='+screen.height;
//	</script>"},"resodet")

//________________________________________________
var
	Cexam=1; Gexam=1
	WorldSaveVersion = 4

mob/proc/LoginStuff()
	set waitfor = 0
	var/NOKEY = 0
	while(!key)
		if(NOKEY >= 10)
			del src
			return
		else
			NOKEY++
			sleep(5)

	loggedin=1
	SavePrevention = 1
	underlays = null;
	Targeting=null
	tradingWith=null
	name=trueName;
	maptext = null
	var/MSG = ""
	//if(SV<#)
	/*
	for(var/A in SkillSeeds)
		src << "[A] = [SkillSeeds[A]]"
		if(SkillSeeds[A])
			Rebirthdata.JL[A] = SkillSeeds[A]
			SkillSeeds -= A
	SkillSeeds = list()
	*/

	if(!Slot)
		alert(src,"Your Character seems to be corrupted, but it can be fixed")
		switch(alert(src,"Please select which slot this Character is on, (Note: Choose wisely or it will cause problems)","Which Slot","Slot One","Slot Two"))
			if("Slot One")
				Slot = "SlotOne"
			if("Slot Two")
				Slot = "SlotTwo"
		Repair_Start(src)
	else if(Multipliers["Stamina"] == Multipliers["Chakra"] && Multipliers["Stamina"] == Multipliers["Taijutsu"] &&Multipliers["Stamina"] == Multipliers["Ninjutsu"] && Multipliers["Stamina"] == Multipliers["Genjutsu"])
		Repair_Start(src)

	for(var/obj/Clothing/Custom/TestOutfit/IT in contents)
		del IT

	for(var/obj/A in contents)
		if(istype(A,/obj/Weapon) && !A.icon)
			A.icon = initial(A.icon)
			if(A.Material)
				if(!A.Creator)
					A.Creator = trueName
				var/icon/I = CreWeap(A)
				A.icon = I
		A.layer=initial(A.layer)

	for(var/DNA/D in EdoList)
		if(D.Summoned)
			D.Summoned = 0
			D.Destroyed = 1

	if(!PlayerID)
		PlayerID = CID
		CID++
		if(!PID)
			PID = list()
		PID[trueName] = PlayerID

	for(var/A in SpecialMobs)
		var/mob/M = SpecialMobs[A]
		if(M && ismob(M))
			if(M.InactiveList[trueName])
				M.HitList[trueName] = src
				M.InactiveList -=  trueName

	if(Permasay)
		Permasay = 0

	if(!name || name=="")
		name="A Big Idiot";

	icon_state = ""
	SV = WorldSaveVersion
	if(!(src in MasterPlayerList))
		MasterPlayerList+=src
	if(!MoveUses)
		MoveUses=new()
	redditMute=0
	//if(ckey == "kingrememberedintime" || ckey== "king kunta" || ckey == "chuckthaiv" || client.computer_id =="2627495227" || client.address == "73.58.159.81" || client.address == "73.58.153.205" || client.address=="73.58.156.154") {Logout(); redditMute=1; WhisperListen=0; GuildDisabled=1}
//	if(ckey == "skywiiz"||client.computer_id == "2450350037")
//		redditMute=1
	if(client)
		client.perspective=MOB_PERSPECTIVE|EDGE_PERSPECTIVE //Disconnects camera if on edge of map
		winshow(src,"Creation",0)
		winshow(src,"Splash",0)
		winshow(src,"CreationBody",0)
		winshow(src,"mainwindow",1)

	if(ckey!="saucepanman" && ckey!="screwyparasite")
		if(client.IsByondMember()) {BYONDMEMBER=1; world << "[Brand]<font color=#71C671><b>[name]/[key] has logged in!</b></font>"}
		else world << "[Brand]<font color=#007bba><b>[name]/[key] has logged in!</b></font>"

	for(var/mob/player/M in MasterPlayerList)
		M.WhichWho()
	Contributorlogin()
	BB_LoginCheck()

	if(!z||dead||ZCoord=="Sound 5 Quest"||ZCoord == "Forest of Death"||Arena||KI_InMission)
		SpawnWhere(); dead=0; Arena=0; KI_InMission=0

	if(Escaping)
		Arrest()
	else if(VillageJailTime>1)
		SendToJail()

//Skin
	LoadHUD()
	LoadSkin()
	SpeedRailCheck()
	PlaceHotbarCards()
	loadMacro()
	CheckToggles()
	LeaderBoardUpdate()

	if(!Settings)
		Settings = list()
	maptext=null;

//Stats
	InEdit = 0;
	//Calories=null;
	rockLuck = 0;
	chakraWW = 0;
	//if(BunshinLimit>8) BunshinLimit=8 //Need this for this wipe online
	if(KO || reaper) KillMe(src)
	if(StaminaXP<0)
		StaminaXP = 1000
	if(Wounds<0)
		Wounds = 0
	movespeed=setspeed; WeightSpeed()
	StaminaMax=StaminaTrue; ChakraMax=ChakraTrue
	Stamina=StaminaMax; Chakra=ChakraMax
	TaijutsuMax=TaijutsuTrue; GenjutsuMax=GenjutsuTrue; NinjutsuMax=NinjutsuTrue
	Taijutsu=TaijutsuMax; Genjutsu=GenjutsuMax; Ninjutsu=NinjutsuMax
	Reflex=ReflexTrue;
	RefreshPlayerStats()

	spawn(7)
		if(HasDog && !DeadDog)
			for(var/mob/Hittable/Responsive/Animal/Pet/A in contents)
				del(A)
			var/mob/Hittable/Responsive/Animal/Pet/Dog/P=new(src)
			P.name=DogName; P.Master=src; Familiar=P
			P.Taijutsu=DogTaijutsu; P.TaijutsuXP=DogTaijutsuXP; P.TaijutsuMXP=DogTaijutsuMXP
			P.Stamina=DogStaminaMax; P.StaminaMax=DogStaminaMax; P.StaminaXP=DogStaminaExp; P.StaminaMXP=DogStaminaMXP

	/*if(RebirthData.RebirthVersion < CurrentRebirthVersion)
		ResetRebirth()*/
	if(RebirthData)
		if(RebirthData.Total && !SpecialMobs["Madara"])
			SpecialMobs["Madara"] = 1
			spawn(6000)
				world << "<h3>A titan has been reborn</h3>"
				new/mob/Hittable/Responsive/Boss/MadaraFake(locate(764,284,1))

//Jutsu
	if(!JutsuList)
		JutsuList=list()
	if(JutsuList["Hiraishin"])
		var/obj/SkillCards/Ninjutsu/Special/Hiraishin/J=locate() in contents
		if(!J)
			HasHiraishin = 0
		else
			verbs += new/mob/VerbHolder/Jutsu/Hiraishin/verb/Hiraishin_Mark()
			for(var/A in MarkedLocations)
				if(istype(MarkedLocations[A],/turf))
					var/turf/B = MarkedLocations[A]
					MarkedLocations[A] = new/SavedLoc(B)

	if(JutsuList["OniKagami"])
		var/obj/SkillCards/Clan/Yuki/OniKagami/J=locate() in contents
		if(J)
			OniKagamiCard = J

//Items
	if(BandageUses)
		BandageCheck(BandageUses)

	for(var/obj/Scrolls/ChuuninScrolls/S in contents)
		del(S)

	for(var/obj/Item/parcel/P in contents)
		DeliverWait=2
		del(P)

	if(FishingBox)
		var/obj/Item/rod/FishingBox/FB = locate() in contents
		if(!FB)
			new/obj/Item/rod/FishingBox(src)

	if(equippedweight < 0)
		if(weights)
			equippedweight = 1
		else
			equippedweight = 0

//Visuals
	if(!CustomIcon)
		if(OriginalIcon)
			OriginalIcon = null

		if(!basename)
			var/baseList=list("Pale","Medium","Tan","Dark","Blue","Red","Lilac","Green","Yellow","Pink","Pallid")
			if(client.IsByondMember()) baseList += list("Very Pale", "Very Dark", "Zetsu")
			basename = input(src,"Pick a skin tone.","Skin Tone") in baseList

	sight |= SEE_SELF
	invisibility = 7
	see_invisible = 7

	if(!HideDMGMSG)
		if(!(src in DMGMSGlist))
			DMGMSGlist+=src

	Set_Float()
	if(client)
		client.onResize()
		for(var/area/Roof/R in world)
			if(loc && loc.loc != R)
				if(R.image && istype(R.image,/image))
					client.images += R.image
	sight |= SEE_PIXELS
	LoginVisual()
//Verbs

	LoginVerbs()

	if(GuildAdmin&&!(src in GuildAdmins))
		GuildAdmins+=src

	if(Kage)
		LoginKage()
	else if(!KageMob[Village] && BeenKage && !DisgracedKage)
		if(!KageBlocked || KageBlocked < world.time)
			KageBlocked = 0
			world << "[trueName], the [DaimeCheck()] of the [Village], has been returned as the Interim Leader"
			verbs += typesof(/mob/VerbHolder/Kage2/verb)
			KageCurrent[Village] = trueName
			KageMob[Village] = src
			TempKage = 1

	if(ElligibleKageList[Village][trueName])
		ElligibleKageList[Village][trueName] = src

	if(src && loc)
		loc.loc.Entered(src)
		layer = text2num("[MOB_LAYER].[world.maxy - y][(32-step_y) < 10 ? 0 :][32-step_y]")

	if(EventOngoing && !EventStarted)
		for(var/A in EventParticipants)
			if(A == trueName)
				EventParticipants[A] = src

		if(!AdminLevel && src != EventCreator)
			if(!EventParticipants[trueName] && Rank2Num(NinjaRank) >= EventRequirement)
				if(alert("[EventCreator.trueName] has invited you to join an Event, would you like to join?","Join Event","Yes","No") == "Yes")
					if(!EventStarted)
						EventParticipants["M.trueName"] = src
						if(EventParticipants.len)
							world << "[trueName] has joined [EventCreator.trueName]'s Event There are now [EventParticipants.len] Participants"
						else
							world << "[trueName] was the first to join [EventCreator.trueName]'s Event"
						alert("You have been added to the Invite List, once the event begins you will be transported to the event area")
					else
						alert("It appears you took to long to respond and the event has already begun")

	MSG += {"<b>Welcome to Shinobi of Myth where we live without Mysteries</b>
	<br><a style="color:[VillageColour];" href="http://www.byond.com/games/ScrewyParasite/ShinobiofMyth">Click here for the Game Hub</a>
	<br><a style="color:[VillageColour];" href="https://docs.google.com/document/d/1KMvH4dei2_4oTVh07FcuGyYIy8qIDRixwsfIWadVD_o/edit">Click here for a guide on how to play</a>
	<br><a style="color:[VillageColour];" href="https://discord.gg/VwBggZz">Discord Server for Game Discussion</a>
	"}
	//<h3>In Honor of Sofia, you were taken from us too soon, you will be missed all of our hearts go out to you wherever you are now</h3>

	#if TESTING
	MSG += "<H2>Test Build</H2>"
	#endif
	#if DEBUGGING
	MSG += "<H2>Debug Build</H2>"
	#endif
	src<<MSG

	#if !DEBUGGING
	if(SurveyList && SurveyList[ckey])
		SurveyLogin()
	//if(SurveyList[ckey])
	//	SurveyLogin()
	#endif

	if(!PE||!SE)
		AssignElements()

	recentLogin = 1;
	spawn(600)
		recentLogin = 0;
		SavePrevention = 0
		PlayerOnlineTime()

proc
	DELREB(A)
		spawn(20)
			fdel(A)
mob
	proc
		LoadSkin()
			set waitfor = 0
			src << output(Level, "mainwindow.Level")
			src << output(StatPoints, "mainwindow.StatPoints")
			if(StatusBar) winset(src,"mainwindow","statusbar=true")
			else winset(src,"mainwindow","statusbar=false")
			UpdateInventory(0); ZCoordProc(ZCoord)
			winset(src,"ExpBar","value=[round((Exp/MXP)*100)]")
			var
				win_size = winget(src,"MainMap","size")
				X = 46+text2num(copytext(win_size,1,findtext(win_size,"x")))
				//Y = 98+text2num(copytext(win_size,findtext(win_size,"x")+1))
				XPos = X//+3

			if(MiniPane)
				MiniPane = 1
				winshow(src,"topsection")
				winshow(src,"VPaneBut")
				winset(src,"Button_Child","pos=[XPos],171;")
				winset(src,"Stat_Child","pos=[XPos],213;")
				winset(src,"child4","pos=[XPos],428")
				//winset(src,"OutputChild","size=363x206;pos=[XPos],482;")
				winset(src,"OutputChild","pos=[XPos],482;")
			else
				MiniPane = 0
				winshow(src,"topsection",0)
				winshow(src,"VPaneBut",0)
				winset(src,"Button_Child","pos=[XPos],0;")
				winset(src,"Stat_Child","pos=[XPos],42;")
				winset(src,"child4","pos=[XPos],257")
				//winset(src,"OutputChild","size=363x377;pos=[XPos],311;")
				winset(src,"OutputChild","pos=[XPos],311;")

			switch(ChatLineSet)
				if("Say")
					winset(src,"chatToggleButton","text=Say")
					winset(src,"chatInput","command=localChat")
					var/mob/player/U = src
					if(U)
						U.TypingChecker()
				if("OOC")
					winset(src,"chatToggleButton","text=OOC")
					winset(src,"chatInput","command=OOC")
				else
					winset(src,"chatToggleButton","text=cmd")
					winset(src,"chatInput","command=")

			if(client)
				if(!listenooc)
					winset(src,"OOCToggle","text=OFF;background-color=#150000")
				else
					winset(src,"OOCToggle","text=ON;background-color=#001500")

		LoadHUD()
			set waitfor = 0
			if(client.byond_version > 508 && client.byond_version < 511) { //Disable the minimap and health if between these versions!
				src<<output("<b>Due to an issue with BYOND, your version - [client.byond_version], does not support the minimap! Please upgrade to the latest version of Byond! <a style='text-decoration: none; color:#9292ff' href='http://www.byond.com/download/build/511/511.1366_byond.exe'>You can find it here!</a></b>","Chat")
				return;
			}
			winshow(src,"mainwindow.RebirthButton",1)
			winshow(src,"mainwindow.TeamButton",1)
			if(TeamID)
				winset(src,"mainwindow.TeamButton","text=\"Team [TeamID]\"")
			sleep(1)
			new/obj/minimap/minimap01(client)
			new/obj/minimap/pointer(client)
			new/obj/tracking/tracker1(client)
			RefreshMap()

			new/obj/hudMeters/GuageBackground/G_01(client); new/obj/hudMeters/GuageBackground/G_02(client); new/obj/hudMeters/GuageBackground/G_03(client); new/obj/hudMeters/GuageBackground/G_04(client)
			new/obj/hudMeters/Guage/G_01(client); new/obj/hudMeters/Guage/G_02(client); new/obj/hudMeters/Guage/G_03(client); new/obj/hudMeters/Guage/G_04(client)
			new/obj/hudMeters/Stamina/health_01(client); new/obj/hudMeters/Stamina/health_02(client); new/obj/hudMeters/Stamina/health_03(client); new/obj/hudMeters/Stamina/health_04(client)
			new/obj/hudMeters/Wounds/wounds_01(client); new/obj/hudMeters/Wounds/wounds_02(client); new/obj/hudMeters/Wounds/wounds_03(client); new/obj/hudMeters/Wounds/wounds_04(client)
			new/obj/hudMeters/Chakra/chakra_01(client); new/obj/hudMeters/Chakra/chakra_02(client); new/obj/hudMeters/Chakra/chakra_03(client)
			RefreshStats()

		LoginVerbs()
			set waitfor = 0
			verbs -= typesof(/mob/StatPointsVerbs/proc)
			verbs -= typesof(/mob/VerbHolder/Kage/verb)
			verbs -= typesof(/mob/VerbHolder/Kage2/verb)
			verbs -= /mob/Suicide/verb/Suicide
			if(!GM)
				verbs -= typesof(/mob/VerbHolder/Admin/Host/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/Host2/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/Level1/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/Level2/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/Level3/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/Level4/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/MGM/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/Creator/verb)
			GMList() //Adds back Verbs to GM's
			GuildVerbs()
			RelogJutsu()
			//RelogProfVerbs()

		LoginVisual()
			//set waitfor = 0
			var/obj/Weapon/Wield/Samehada/S = locate() in src
			if(S)
				if(S.worn)
					overlays -= S.Overlay
				S.icon = 'Samehada.dmi'
				S.wielding = "Samehada"
				S.Overlay = new/Overlay_Obj(S.icon,S.layer)
				if(S.worn)
					overlays += S.Overlay
					wielding = S.wielding
			CreationSkin(1)
			if(GMfrozen)
				overlays += 'frozen.dmi'

client/proc/RandomTip()
	switch(pick(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41))
		if(1)
			winset(src,null,"Splash.motd.image=['Tip_01.png']")
		if(2)
			winset(src,null,"Splash.motd.image=['Tip_02.png']")
		if(3)
			winset(src,null,"Splash.motd.image=['Tip_03.png']")
		if(4)
			winset(src,null,"Splash.motd.image=['Tip_04.png']")
		if(5)
			winset(src,null,"Splash.motd.image=['Tip_05.png']")
		if(6)
			winset(src,null,"Splash.motd.image=['Tip_06.png']")
		if(7)
			winset(src,null,"Splash.motd.image=['Tip_07.png']")
		if(8)
			winset(src,null,"Splash.motd.image=['Tip_08.png']")
		if(9)
			winset(src,null,"Splash.motd.image=['Tip_09.png']")
		if(10)
			winset(src,null,"Splash.motd.image=['Tip_10.png']")
		if(11)
			winset(src,null,"Splash.motd.image=['Tip_11.png']")
		if(12)
			winset(src,null,"Splash.motd.image=['Tip_12.png']")
		if(13)
			winset(src,null,"Splash.motd.image=['Tip_13.png']")
		if(14)
			winset(src,null,"Splash.motd.image=['Tip_14.png']")
		if(15)
			winset(src,null,"Splash.motd.image=['Tip_15.png']")
		if(16)
			winset(src,null,"Splash.motd.image=['Tip_16.png']")
		if(17)
			winset(src,null,"Splash.motd.image=['Tip_17.png']")
		if(18)
			winset(src,null,"Splash.motd.image=['Tip_18.png']")
		if(19)
			winset(src,null,"Splash.motd.image=['Tip_19.png']")
		if(20)
			winset(src,null,"Splash.motd.image=['Tip_20.png']")
		if(21)
			winset(src,null,"Splash.motd.image=['Tip_21.png']")
		if(22)
			winset(src,null,"Splash.motd.image=['Tip_22.png']")
		if(23)
			winset(src,null,"Splash.motd.image=['Tip_23.png']")
		if(24)
			winset(src,null,"Splash.motd.image=['Tip_24.png']")
		if(25)
			winset(src,null,"Splash.motd.image=['Tip_25.png']")
		if(26)
			winset(src,null,"Splash.motd.image=['Tip_26.png']")
		if(27)
			winset(src,null,"Splash.motd.image=['Tip_27.png']")
		if(28)
			winset(src,null,"Splash.motd.image=['Tip_28.png']")
		if(29)
			winset(src,null,"Splash.motd.image=['Tip_29.png']")
		if(30)
			winset(src,null,"Splash.motd.image=['Tip_30.png']")
		if(31)
			winset(src,null,"Splash.motd.image=['Tip_31.png']")
		if(32)
			winset(src,null,"Splash.motd.image=['Tip_32.png']")
		if(33)
			winset(src,null,"Splash.motd.image=['Tip_33.png']")
		if(34)
			winset(src,null,"Splash.motd.image=['Tip_34.png']")
		if(35)
			winset(src,null,"Splash.motd.image=['Tip_35.png']")
		if(36)
			winset(src,null,"Splash.motd.image=['Tip_36.png']")
		if(37)
			winset(src,null,"Splash.motd.image=['Tip_37.png']")
		if(38)
			winset(src,null,"Splash.motd.image=['Tip_38.png']")
		if(39)
			winset(src,null,"Splash.motd.image=['Tip_39.png']")
		if(40)
			winset(src,null,"Splash.motd.image=['Tip_40.png']")
		if(41)
			winset(src,null,"Splash.motd.image=['Tip_41.png']")