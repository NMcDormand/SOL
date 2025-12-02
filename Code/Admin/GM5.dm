mob/VerbHolder/Admin/MGM/verb
	Village_Points_Fix()
		if(!VillagePoints)
			VillagePoints = list(
				"Cloud" = 0, "Leaf" = 0, "Mist" = 0, "Rock" = 0,
				"Sand" = 0, "Grass" = 0, "Rain" = 0, "Sound" = 0, "Waterfall" = 0
			)

	Village_Points_Reset()
		VillagePoints = list(
			"Cloud" = 0, "Leaf" = 0, "Mist" = 0, "Rock" = 0,
			"Sand" = 0, "Grass" = 0, "Rain" = 0, "Sound" = 0, "Waterfall" = 0
		)

		TaiBoost = list()
		NinBoost = list()
		GenBoost = list()
		StamBoost = list()
		ChakBoost = list()
		SkillBoost = list()
		PEBoost = list()
		SEBoost = list()
		RFXBoost = list()

	Kage_Give_Req(mob/M in MasterPlayerList)
		ElligibleKageList[M.Village][M.trueName] = M
		M.KageScore = 1000
		M.MissionsComplete["S"] = 21
		M.BeenKage = 0
		M.DisgracedKage = 0

	Kage_Check()
		CheckForKages()

	Kage_Remove(mob/M in MasterPlayerList)
		if(M.Kage || M.TempKage)
			M.EjectKage(OffenseOutput(input("What is the offense to test?") in list("suicide","homicide","murder","duties","assassination","timeout")), input("Test Disgraced exit?","Disgraced?") as num)

	ResetKageCycle()
		set category="Special"
		set name="Reset Kage Cycle"
		switch(alert("Are you sure?","Reset Kage Cycle","Yes","No"))
			if("Yes")
				MasterKageList=new()
				KageNumber=new()
				TheCurrentKage=new()
				WorldKageNumber=new()

				ElligibleKageList = list(
					"Cloud" = list(), "Leaf" = list(), "Mist" = list(), "Rock" = list(),
					"Sand" = list(), "Grass" = list(), "Rain" = list(), "Sound" = list(), "Waterfall" = list()
				)
				KageList = list(
					"Cloud" = list(), "Leaf" = list(), "Mist" = list(), "Rock" = list(),
					"Sand" = list(), "Grass" = list(), "Rain" = list(), "Sound" = list(), "Waterfall" = list()
				)

				KageLastLogged = list()
				KageTimeOut = list()

				KageCurrent = list(
					"Cloud" = 0, "Leaf" = 0, "Mist" = 0, "Rock" = 0,
					"Sand" = 0, "Grass" = 0, "Rain" = 0, "Sound" = 0, "Waterfall" = 0
				)
				KageMob = list(
					"Cloud" = 0, "Leaf" = 0, "Mist" = 0, "Rock" = 0,
					"Sand" = 0, "Grass" = 0, "Rain" = 0, "Sound" = 0, "Waterfall" = 0
				)
				KageTemp = list(
					"Cloud" = 0, "Leaf" = 0, "Mist" = 0, "Rock" = 0,
					"Sand" = 0, "Grass" = 0, "Rain" = 0, "Sound" = 0, "Waterfall" = 0
				)

	PortSame()
		loc = SamehadaDoor

	ResetPlayerRebirth(var/mob/M in MasterPlayerList)
		if(M)
			if(alert("Are you sure?","Sure?","Yes","No") == "Yes")
				ResetRebirth()
	Edit_Icon(i as icon)
		set hidden=1
		var/icon/I=icon(i)
		switch(alert("Would you like to recolor it?","Icon","Yes","No","Cancel"))
			if("Cancel")
				return
			if("Yes")
				var/r = input("How much red?","Color") as num
				var/g = input("How much green?","Color") as num
				var/b = input("How much blue?","Color") as num
				I += rgb(r,g,b)
		redo
		switch(alert("Would you like to resize it?","Icon","Yes","No","Cancel"))
			if("Cancel")
				return
			if("Yes")
				var/Hei = input("How Tall?","Hair Color") as num
				var/Wid = input("How Wide?","Hair Color") as num
				if(Hei<1||Wid<1)
					goto redo
				I.Scale(Hei,Wid)
		var/sl = input("What do you want the icon's name to be?") as text
		sl = "[sl]"
		usr<<"\icon[I]"
		switch(alert("Do you want this icon?","Icon:","Yes","No"))
			if("Yes")
				usr << ftp(I,sl)

	StartAnnouncement()
		set name="Recurring Announcement"
		set category="Special"
		set desc="Spawn an announcement."
		if(worldannounce)
			switch(alert("Would you like to turn World Announce off?","World Announce","Yes","No"))
				if("Yes")
					worldannounce=0
					return
		worldannouncem=input("What message would you like to be repeated?","") as text
		worldannouncet=input("What delay would you like to put between messages (in seconds)?","") as num
		if(!worldannounce&&worldannouncem&&worldannouncet) {worldannounce=1; WorldAnnounce()}
//------------------------------------------------------------------------------------------------------------
proc
	ChangeGMLevel(var/a,var/mob/player/GM)
		switch(a)
			if("Level One")
				world<<"<font size=2><b><font color=red>[GM] is now a Level 1 GM</font>"
				GMs[GM.ckey] = 1
			if("Level Two")
				world<<"<font size=2><b><font color=red>[GM] is now a Level 2 GM</font>"
				GMs[GM.ckey] = 2
			if("Level Three")
				world<<"<font size=2><b><font color=red>[GM] is now a Level 3 GM</font>"
				GMs[GM.ckey] = 3
			if("Level Four")
				world<<"<font size=2><b><font color=red>[GM] is now a Level 4 GM</font>"
				GMs[GM.ckey] = 4
			if("Level Five")
				world<<"<font size=2><b><font color=red>[GM] is now a Level 5 GM</font>"
				GMs[GM.ckey] = 5
			if("Level Six")
				world<<"<font size=2><b><font color=red>[GM] is now a Level 6 GM</font>"
				GMs[GM.ckey] = 6
			if("Remove GM Status")
				GM.GM=0
				GM.MGM=0; GM.special=0; GM.AdminLevel=0
				GM.verbs -= typesof(/mob/VerbHolder/Admin/Level1/verb)
				GM.verbs -= typesof(/mob/VerbHolder/Admin/Level2/verb)
				GM.verbs -= typesof(/mob/VerbHolder/Admin/Level3/verb)
				GM.verbs -= typesof(/mob/VerbHolder/Admin/Level4/verb)
				GM.verbs -= typesof(/mob/VerbHolder/Admin/MGM/verb)
				GM.verbs -= typesof(/mob/VerbHolder/Admin/Host/verb)
				GM.verbs -= typesof(/mob/VerbHolder/Admin/Host2/verb)
				GM.verbs -= typesof(/mob/VerbHolder/Admin/Creator/verb)
				GMs -= GM.ckey
				world<<"<font size=2><b><font color=red>[GM] is no longer a GM</font>"
		GM.GMList()
		SaveGMS();
//-------------------------------------------------------------------------------------------------------------
mob/VerbHolder/Admin/Creator/verb

	Edit_Lists()//Allows you to edit lists not within any datum as long as they are defined within "Index"
		set category="Admin"
		Index["SpawnPoints"] = SpawnPoints
		Index["Movers"] = Movers
		Index["MoveRunning"] = MoveRunning
		Index["SoundRunners"] = SoundMissionaries
		Index["CitiBank"] = CitiBank
		Index["KageList"] = KageList
		Index["KageCurrent"] = KageCurrent
		Index["ElligibleKageList"] = ElligibleKageList
		Index["VillagePoints"] = VillagePoints
		Index["VillageBoosts"] = list(
			"Stamina" = StamBoost, "Chakra" = ChakBoost,
			"Ninjutsu" = NinBoost, "Taijutsu" = TaiBoost, "Genjutsu" = GenBoost,
			"Skills" = SkillBoost, "Primary" = PEBoost, "Secondary" = SEBoost,
			"Reflexes" = RFXBoost
		)
		Index["ClanMultis"] = WorldMultis
		Index["TESTME"] =MultiGainChance
		Index["ReadySkills"] = ReadySkills
		Index["GlobalSkills"] = GlobalSkills
		Index["SurveyList"] = SurveyList

		UpdateEdit(Index,1)
		Editing=Index
		EditVar=list()
		EditVar=list("Index"=Index)
		winset(src,"EditPage","is-visible=true")
		winset(src,"EditPage.Search","focus=true")
		InEdit=1
		UpdateEditVerbs(1)
		AutoSearchEdit()

	CheckGMS()
		for(var/A in GMs)
			if(GMs[A] < 7)
				world << "[A]: [GMs[A]]"

	RemoveGM(var/A in GMs)
		if(A)
			for(var/mob/player/GM in MasterPlayerList)
				if(ckey == A)
					GMs -= A
					ChangeGMLevel("Remove GM Status",GM)

	MakeGM(mob/player/GM in world)
		set category="Staff"
		set name="Make GM"
		set desc="Give a player GM status without coding it in."
		if(usr.ckey!="screwyparasite" && ckey!=ckey(world.host) && AdminLevel < 5) {usr<<"You do not have the authority."; return}
		var/list/GMLEVELS = list("Level One","Level Two","Level Three","Level Four")
		if(ckey == "screwyparasite"||ckey == ckey(world.host))
			GMLEVELS += list("Level Five","Level Six")
		var/Wut = input("What level GM do you wish to make [GM]?","Make GM") as null|anything in GMLEVELS+list("Remove GM Status")
		if(Wut)
			switch(Wut)
				if("Level One")
					switch(alert("Are you sure you wish to make [GM] a Level 1 GM?","Make Level 1 GM","Yes","No"))
						if("Yes")
							ChangeGMLevel(Wut,GM)
						if("No")
							usr<<"They were not made a L1 GM"
				if("Level Two")
					switch(alert("Are you sure you wish to make [GM] a Level 2 GM?","Make Level 2 GM","Yes","No"))
						if("Yes")
							ChangeGMLevel(Wut,GM)
						if("No")
							usr<<"They were not made a L2 GM"
				if("Level Three")
					switch(alert("Are you sure you wish to make [GM] a Level 3 GM?","Make Level 3 GM","Yes","No"))
						if("Yes")
							ChangeGMLevel(Wut,GM)
						if("No")
							usr<<"They were not made a L3 GM"
				if("Level Four")
					switch(alert("Are you sure you wish to make [GM] a Level 4 GM?","Make Level 4 GM","Yes","No"))
						if("Yes")
							ChangeGMLevel(Wut,GM)
						if("No")
							usr<<"They were not made a L4 GM"
				if("Level Five")
					switch(alert("Are you sure you wish to make [GM] a Level 5 GM?","Make Level 5 GM","Yes","No"))
						if("Yes")
							ChangeGMLevel(Wut,GM)
						if("No")
							usr<<"They were not made a L5 GM"
				if("Level Six")
					switch(alert("Are you sure you wish to make [GM] a Level 6 GM?","Make Level 6 GM","Yes","No"))
						if("Yes")
							ChangeGMLevel(Wut,GM)
						if("No")
							usr<<"They were not made a L6 GM"
				if("Remove GM Status")
					switch(alert("Are you sure you wish to remove [GM]'s status?","Remove GM","Yes","No"))
						if("Yes")
							ChangeGMLevel(Wut,GM)
						if("No")
							usr<<"They were not stripped of their rank"
//-------------------------------------------------------------------------------------------------------------