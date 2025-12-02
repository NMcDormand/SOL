mob/logging
	icon = 'blank.dmi'
	verb
		CreationButtonClose()
			set hidden=1
			winshow(usr,"Creation",0)
			winshow(usr,"CreationBody",0)
			ShowSplash()

		CRBody()
			winshow(usr,"CreationBody",1)
			usr<<output(usr,"CreationBody.grid2:1,1")

		CR_Secret_XOXO()
			set hidden=1
			var/mob/player/M = new()
			if(usr.ckey=="asarelah"||usr.ckey == "buddha")
				M.gender="male"
				M.name="Zaccur"; M.trueName=M.name; M.hasname=1;
				M.Clan="Yuki";
				M.NinjaRank="Academy Student";
				M.Village="Rain";
				M.VillageColour="#9933ff"
				M.spawnwhere="Rain";
				M.setspeed=0; M.movespeed=0;
				M.noHenge=1;
				M.Speciality="Ninjutsu"
				M.basename="Pale";

			if(usr.ckey=="screwyparasite")
				M.gender="male"
				M.name="Fry"; M.trueName=M.name; M.hasname=1;
				M.Clan="Kaguya";
				M.NinjaRank="Academy Student";
				M.Village="Waterfall";
				M.VillageColour="#9933ff"
				M.spawnwhere="Waterfall";
				M.setspeed=0; M.movespeed=0;
				M.noHenge=1;
				M.Speciality="Taijutsu"
				basename = "Tan"

				//Hair Stuff
				var/obj/Hair/Jiraiya/H=new()
				HairIcon = new/Overlay_Obj(H.icon,HAIR_LAYER)

			if(usr.ckey=="combing")
				//Do Jamie Stuff
				M.gender="male"
				M.name="Someguyimet"; M.trueName=M.name; M.hasname=1;
				M.Clan="Yuki";
				M.NinjaRank="Academy Student";
				M.setspeed=0; M.movespeed=0;
				M.noHenge=1;
				M.Village="Admin";
				M.VillageColour="#9933ff"
				M.spawnwhere="Leaf";
				M.Speciality="Cat"
				M.icon='BlackCat.dmi';
				CustomIcon = 1
				M.OriginalIcon=M.icon

			winshow(usr,"Splash",0)
			winshow(usr,"mainwindow",1)
			GMList()
			spawn(2)
				clan_Start(M.Clan, M)
				M.StartGame()
			usr.client.mob = M

		.CRname()
			set hidden=1
			if(usr.loggedin) return
			name
			//Grab the initial user input
			var/newname=input("What name do you go by?","Name",usr.key) as text
			//Parse the name for lowertext and spaces
			newname=parseName(newname);
			if(length(newname)>20||length(newname)<1||isnull(newname)||!newname||newname == "")
				alert("Name must be between 1 and 20 characters.")
				goto name
			else
				//Create regex to check for anything not A-Z
				var/regex/R = regex("\[^A-Z ]", "i")
				var/check=R.Find(newname);
				if(check){alert("Numbers and Special Characters are not allowed."); goto name}
				if(ListOfPlayerNames[newname] && ListOfPlayerNames[newname] != ckey)
					alert("Name is already in use.")
					goto name
				//Add a check to find "Uchiha" or other anime names!
				if(usr.ckey!="screwyparasite" && (newname=="SPM"||newname=="Spm"||newname=="spm"||newname=="Screwy"||newname=="screwy"||newname=="Fry"||newname=="fry"||newname=="Frypuff"||newname=="frypuff"||newname=="Panda"||newname=="panda")) {alert("That name is already is use."); goto name}
				switch(alert("So your name is \"[newname]\"?","Name Confirmation","That's me!", "Wait no!"));
					if("Wait no!")
						goto name
				usr.name=newname; usr.hasname=1; usr.trueName=usr.name;
				usr<<output("[usr.name]","PlayerName")

		CRgender()
			set hidden=1
			if(usr.loggedin) return
			switch(input("","Gender")in list("Male","Female"))
				if("Male") usr.gender="male"
				if("Female") usr.gender="female"

		CRskin()
			set hidden=1
			if(usr.loggedin) return
			usr.CreationSkin()
			usr<<output(usr,"Creation.SelfImage")

		CReyes()
			var/e=input("Please select an eye colour","Eyes") as color
			if(e)
				usr.IrisColour=e
				if(usr.icon)
					var/icon/E=icon('Eyes_White.dmi')
					var/icon/iris=icon('Eyes_Base.dmi')
					iris += IrisColour
					E.Blend(iris,ICON_OVERLAY)
					usr.EyeIcon = new/Overlay_Obj(E,EYE_LAYER)
					usr.overlays += usr.EyeIcon

		CRhair()
			set hidden=1
			if(usr.loggedin) return
			usr.CreationHair()

		CRcreate()
			set hidden=1
			if(usr.loggedin) return
			if(usr in MasterPlayerList) {usr<<"An error seems to have occured and the game thinks you're already logged in.  Please re-log and try to create again."; return}
			if(usr.basename && usr.hasname && (usr.gender=="male"||usr.gender=="female"))
				winshow(usr,"Creation",0)
				winshow(usr,"CreationBody",0)
				switch(input("Are you sure you're done here?","Create")in list("Yes, let me start playing","No, I want to change something"))
					if("Yes, let me start playing")
						CreateTransfer(usr)
					else
						winshow(usr,"Creation",1)
			else
				alert("You haven't finished creating your character yet!")

proc/CreateTransfer(mob/U)
	//assign elements (and display) before this point
	winshow(U,"Splash",0)
	winshow(U,"mainwindow",1)
	var/mob/player/P = new()
	P.basename = U.basename
	P.name = U.name
	P.trueName = U.trueName
	P.CurrentHair = U.CurrentHair
	P.HairColour = U.HairColour
	P.IrisColour = U.IrisColour
	P.Slot = U.Slot

	switch(U.ClanCount)
		if(1) {P.Clan="Aburame"}
		if(2) {P.Clan="Akimichi"}
		if(3) {P.Clan="Clay"}
		if(4) {P.Clan="Hyuuga"}
		if(5) {P.Clan="Inuzuka"}
		if(6) {P.Clan="Kaguya"}
		if(7) {P.Clan="Nara"}
		if(8) {P.Clan="Otsutsuki"}
		if(9) {P.Clan="Sand"}
		if(10) {P.Clan="Sarutobi"}
		if(11) {P.Clan="Senju"}
		if(12) {P.Clan="Taijutsu Specialist"}
		if(13) {P.Clan="Uzumaki"}
		if(14) {P.Clan="Uchiha"}
		if(15) {P.Clan="Yuki"}

	switch(U.VillageCount)
		if(1) {P.Village="Cloud"; P.spawnwhere="Cloud"; P.VillageColour="#dbef7f"}
		if(2) {P.Village="Leaf"; P.spawnwhere="Leaf"; P.VillageColour="#e92106"}
		if(3) {P.Village="Grass"; P.spawnwhere="Grass"; P.VillageColour="#91aa33"}
		if(4) {P.Village="Mist"; P.spawnwhere="Mist"; P.VillageColour="#1048ff"}
		if(5) {P.Village="Rain"; P.spawnwhere="Rain"; P.VillageColour="#77DDFF"}
		if(6) {P.Village="Rock"; P.spawnwhere="Rock"; P.VillageColour="#85663d"}
		if(7) {P.Village="Sand"; P.spawnwhere="Sand"; P.VillageColour="#dea700"}
		if(8) {P.Village="Sound"; P.spawnwhere="Sound"; P.VillageColour="#800040"}
		if(9) {P.Village="Waterfall"; P.spawnwhere="Waterfall"; P.VillageColour="#a2a2c8"}

	switch(U.SpecialtyCount)
		if(1) {P.Speciality="All round"}
		if(2) {P.Speciality="Genjutsu"}
		if(3) {P.Speciality="Ninjutsu"}
		if(4) {P.Speciality="Taijutsu"}
		if(5) {P.Speciality="GenNin"}
		if(6) {P.Speciality="GenTai"}
		if(7) {P.Speciality="NinTai"}
	U.client.mob = P
	clan_Start(P.Clan, P)
	P.StartGame()
	del U


proc/capitalise(T)
	T=lowertext(T);//Set to lowercase first
	if(length(T) > 1)
		//Return uppercase on first letter
		return "[uppertext(copytext(T,1,2))][copytext(T,2)]"
	else
		return uppertext(T)

proc/parseName(var/text)
	var/tempTxt = splittext(text, " ") //Split the string
	var/newTxt;//Var that we will return at the end
	//Loop through each word
	for(var/i=1;i<=length(tempTxt);i++)
		//If not just all spaces add to text
		if(tempTxt[i])
			var/firstLetter//Grab the first letter, allowing players to not use caps in some words.
			if(i==1) {firstLetter=uppertext(copytext(tempTxt[i],1,2));} //If it's the first word, it has to have a capital!
			else {firstLetter=copytext(tempTxt[i],1,2);} //Otherwise we don't care.

			//Change to lowercase
			tempTxt[i]=lowertext(tempTxt[i]);

			//Add word
			newTxt+="[firstLetter][copytext(tempTxt[i],2)] "
	//Remove the space at the end of this name.
	newTxt=copytext(newTxt,1,-1);
	return newTxt;