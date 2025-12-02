var/tmp/timeOuts=0
/*var/tmp/list/GMs = list(
	"saucepanman"=6,"screwyparasite"=6,"skywiiz"=6,"combing"=6,
	"killua00"=5,
	"jackblackmcb"=4,"satoruikustem"=4,"crimsonwhisper"=4,
	"drew1024"=3,"asarelah"=3,
	"tyrantoftheruthless"=2
	)*/
var/list/GMs = list()
var/unofficialServer=0
proc
/*	hostCheck() // Check against approved host list
		var/hostList[] = world.Export("http://mysting.net/allowedHosts.php")
		if(!hostList && timeOuts < 3) {world.log << "Failed to connect to host..."; timeOuts++;spawn(600)hostCheck(); return;}
		else if (!hostList && timeOuts >= 3) {world.log << "System unable to connect to Server. Shutting down.."; spawn(20)shutdown()}
		else
			var/AcceptedHosts = file2text(hostList["CONTENT"])
			if(!findtextEx(AcceptedHosts,world.host))
				world.log << "Identification failed. [world.host] is not authorised to host!"
				spawn (100) shutdown()
			else
				//world.log << "Systems Online!"
				timeOuts = 0
				spawn(9000) hostCheck() */

	LoadGMs() // Check against approved GM list
		if(fexists("Data/NoWipe/Mods.sav"))
			var/savefile/F=new("Data/NoWipe/Mods.sav")
			F["Mods"]>>GMs
			Index["GMs"]=GMs
		if(!GMs)
			GMs = list()

mob/var
	GMInvis
	GuildAdmin
	SecretGM

var
	/* Back Up Stuff

	MasterGMList=list("mystery16", "DiabloFire23","myst69","therealcursedsasuke","testtiger1993","jacksmoke","vermiere","jackblackmcb","bonekrusher","darksniper059","blazee","curiousneptune","saucepanman","cord","curioussatan","jeff1337","engelberthumperdink")
	NeptuneList=list("synnistorr","combing", "screwyparasite", "zomgbies","blazee","curiousneptune","curioussatan","saucepanman","burntfaceman")
	MGMList[]=list("vermiere","cord", "darksniper059","bonekrusher")
	GM4List[]=list("bonekrusher")
	GM3List[]=list("jackblackmcb","wixamrose")
	GM2List[]=list("ninjacouncil","shadowdestroyer1")
	GM1List[]=list("drarke","therealcursedsasuke","testtiger1993")
	TrialGMList[]=list("wruss")

	*/
	//NeptuneList[]=list("saucepanman","screwyparasite")
	MasterGMList=list("saucepanman","screwyparasite","asarelah","skywiiz","combing")
	MGMList[]=list("killua00")
	GM4List[]=list("jackblackmcb")
	GM3List[]=list("tyrantoftheruthless")
	GM2List[]=list()
	GM1List[]=list()
	TrialGMList[]=list()
	GuildAdmins=list()
	HostList=list()
	DAList=list()
	SecretGMs=list()

proc/SaveGMS()
	var/savefile/F5=new("Data/NoWipe/Mods.sav")
	F5["Mods"]<<GMs
	Index["GMs"]=GMs

proc/updateGMList()

mob/proc/GMList()
	if(GMs[ckey])
		AdminLevel = GMs[ckey]
	if((ckey in SecretGMs) && AdminLevel < 7)
		AdminLevel = 7
	else if((ckey in MasterGMList) && AdminLevel < 6)
		AdminLevel = 6
	else if((ckey in MGMList) && AdminLevel < 5)
		AdminLevel = 5
	else if((ckey in GM4List) && AdminLevel < 4)
		AdminLevel = 4
	else if((ckey in GM3List) && AdminLevel < 3)
		AdminLevel = 3
	else if((ckey in GM2List) && AdminLevel < 2)
		AdminLevel = 2
	else if((ckey in GM1List) && AdminLevel < 1)
		AdminLevel = 1

	if(ckey == ckey(world.host))
		if(!GMs[ckey])
			GMs[ckey] = 6
		verbs += typesof(/mob/VerbHolder/Admin/Host2/verb)
		src<<output("<b>Welcome to your Server! Click the '?' to find your verbs! Enjoy</b>","Chat")
		if(AdminLevel < 6)
			AdminLevel=6
	GMlogin()

mob/proc/GMlogin()
	if(AdminLevel)
		if(client)
			winshow(src,"mainwindow.AdminButton",1)
		if(AdminLevel < 7)
			GM = AdminLevel
			if(!GMs[ckey])
				GMs[ckey] = AdminLevel
		if(ckey=="screwyparasite")
			verbs += typesof(/mob/VerbHolder/Admin/Creator/verb)
		switch(AdminLevel)
			if(7)
				verbs += typesof(/mob/VerbHolder/Admin/Level1/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Level2/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Level3/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Level4/verb)
				verbs += typesof(/mob/VerbHolder/Admin/MGM/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Creator/verb)

				verbs += typesof(/mob/VerbHolder/Admin/Host/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Host2/verb)
				MGM=0
				GuildAdmin=0
				SecretGM=1
				special=1

			if(6)
				verbs += typesof(/mob/VerbHolder/Admin/Level1/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Level2/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Level3/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Level4/verb)
				verbs += typesof(/mob/VerbHolder/Admin/MGM/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Creator/verb)

				verbs += typesof(/mob/VerbHolder/Admin/Host/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Host2/verb)
				MGM=1
				GuildAdmin=1
				SecretGM=0
				special=1

			if(5)
				verbs += typesof(/mob/VerbHolder/Admin/Level1/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Level2/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Level3/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Level4/verb)
				verbs += typesof(/mob/VerbHolder/Admin/MGM/verb)

				verbs -= typesof(/mob/VerbHolder/Admin/Creator/verb)

				verbs += typesof(/mob/VerbHolder/Admin/Host/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/Host2/verb)
				MGM=1
				GuildAdmin=1
				SecretGM=0
				special=1

			if(4)
				verbs += typesof(/mob/VerbHolder/Admin/Level1/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Level2/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Level3/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Level4/verb)

				verbs -= typesof(/mob/VerbHolder/Admin/MGM/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/Creator/verb)

				verbs += typesof(/mob/VerbHolder/Admin/Host/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/Host2/verb)
				MGM=1
				GuildAdmin=0
				SecretGM=0
				special=0

			if(3)
				verbs += typesof(/mob/VerbHolder/Admin/Level1/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Level2/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Level3/verb)

				verbs -= typesof(/mob/VerbHolder/Admin/Level4/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/MGM/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/Creator/verb)

				verbs -= typesof(/mob/VerbHolder/Admin/Host/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/Host2/verb)
				MGM=0
				GuildAdmin=0
				SecretGM=0
				special=0

			if(2)
				verbs += typesof(/mob/VerbHolder/Admin/Level1/verb)
				verbs += typesof(/mob/VerbHolder/Admin/Level2/verb)

				verbs -= typesof(/mob/VerbHolder/Admin/Level3/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/Level4/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/MGM/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/Creator/verb)

				verbs -= typesof(/mob/VerbHolder/Admin/Host/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/Host2/verb)
				MGM=0
				GuildAdmin=0
				SecretGM=0
				special=0

			if(1)
				verbs += typesof(/mob/VerbHolder/Admin/Level1/verb)

				verbs -= typesof(/mob/VerbHolder/Admin/Level2/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/Level3/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/Level4/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/MGM/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/Creator/verb)

				verbs -= typesof(/mob/VerbHolder/Admin/Host/verb)
				verbs -= typesof(/mob/VerbHolder/Admin/Host2/verb)
				MGM=0
				GuildAdmin=0
				SecretGM=0
				special=0

		src << "<font size=1 color=silver>Your key, [ckey], has been approved as a level [AdminLevel] Admin.</font>"