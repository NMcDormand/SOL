mob/var/tmp
	GMMUTE
	FJ
	GodMode
var
	worldannounce
	worldannouncet
	worldannouncem
proc
	WorldAnnounce()
		set background=1, waitfor = 0
		world<<"[worldannouncem]"
		spawn(worldannouncet*10)
			if(worldannounce) WorldAnnounce()
mob/proc
	FJP()
		while(!resting)
			usr.Cooldowns=null
			usr.firing=0
			sleep(1)

mob/VerbHolder/Admin/Creator/verb
	Make_Kage(mob/m in MasterPlayerList)
		set category="Kage Debug"
		m.AssignKageRank(m.Village)

	wipeAll()
		set name="Server Wipe"
		set category="Server"
		if(ckey == ckey(world.host) || AdminLevel > 5)
			var/confirm=input("Type 'mysting' to wipe the server","") as null|text
			if(confirm=="mysting")
				fdel("Data/Wipe/");
				TotalSavePrevention=1;
				usr<<"Please standby.";
				fdel("Saves/");
				spawn(10)world<<"<font color=red><b>A server wipe has been initiated.</b></font>"
				sleep(25)
				for(var/i=0, i <=100, i+=rand(1,20))
					world<<"<font color=red>Wiping: [i]%</font>"
					sleep(rand(2,25))
				sleep(10)
				world << "<font color=red><b>Enjoy the next wipe!</b></font>"; world << "<font color=red>Rebooting...</font>";
				sleep(10)
				world.Reboot()
		else
			var/shouldWe=input("Type 'yes' to confirm the wipe!","") as null|text
			if(shouldWe=="yes")
				AdminActionLog("WIPE", "LMAO THEY TRIED TO WIPE!", , , src, 1)
				src << "<font color=red><b>Enjoy the next wipe!</b></font>"; src << "<font color=red>Rebooting...</font>";
				Logout()

	Tournament_Entrants()
		set category="DEBUG"
		for(var/mob/player/P in MasterPlayerList)
			if(P in EventParticipants) usr<<"[P] is in TournamentList"

	BatteList_Entrants()
		set category="DEBUG"
		for(var/mob/player/P in MasterPlayerList)
			if(P in BattleList) usr<<"[P] is in BattleList"

	Chuunin_Entrants()
		set category="DEBUG"
		for(var/mob/player/P in MasterPlayerList)
			if(P in ChuuninList) usr<<"[P] is in ChuuninList"

	GuildWar_Entrants()
		set category="DEBUG"
		for(var/mob/player/P in MasterPlayerList)
			if(P in GuildWarList) usr<<"[P] is in GuildWarList"

	Arena_Entrants()
		set category="DEBUG"
		for(var/mob/player/P in MasterPlayerList)
			if(P.Arena) usr<<"[P] is in an Arena"

	ArrestPlayer(mob/M in MasterPlayerList)
		set category="Special"
		if(M.Fines[usr.Village]>0&&M.Village==usr.Village&&M.InVillage==usr.Village)
			M<<"[usr] has ordered your arrest!"
			usr<<"[M] has been arrested with [M.Fines[usr.Village]] fines"
			M.Arrest()
		else
			if(M.Fines[usr.Village]<=0) usr<<"They are not wanted ninjas in your village!"
			else if(M.Village!=usr.Village) usr<<"They are not your shinobi to punish!"
			else if(M.InVillage!=usr.Village) usr<<"They are not within your jurisdiction!"
	/*ResetKageCycle()
		set category="Special"
		set name="Reset Kage Cycle"
		switch(alert("Are you sure?","Reset Kage Cycle","Yes","No"))
			if("Yes")
				MasterKageList=new()
				KageNumber=new()
				TheCurrentKage=new()
				WorldKageNumber=new()*/
//				for(var/a in MasterKageList) MasterKageList-=a
//				for(var/b in KageNumber) KageNumber-=b
//				for(var/c in TheCurrentKage) TheCurrentKage-=c
//				for(var/d in WorldKageNumber) WorldKageNumber-=d
	ToggleSaveAbility()
		set name="Save Prevention"
		set category="Special"
		if(ckey=="saucepanman" || ckey=="screwyparasite" || ckey == ckey(world.host))
			if(TotalSavePrevention)
				TotalSavePrevention=0; usr<<"People may now save the game"
			else
				var/confirm=input("Type 'confirm' to prevent saving","") as null|text
				if(confirm=="confirm") {TotalSavePrevention=1; usr<<"People may no longer save the game"}
	CreateInvasionNin()
		set name="Create Quest Ninja"
		set category="Special"
		var/n
		switch(input("","") as null|anything in list("Baki","Gaara","Kabuto","Temari","Sand Ninja"))
			if("Baki")
				n=input("How many?","") as null|num
				if(n)
					for(var/i=1,i<=n,i++) new/mob/Hittable/Responsive/NPC/KonohaInvasion/Baki(loc)
			if("Gaara")
				n=input("How many?","") as null|num
				if(n)
					for(var/i=1,i<=n,i++) new/mob/Hittable/Responsive/NPC/KonohaInvasion/Gaara(loc)
			if("Kabuto")
				n=input("How many?","") as null|num
				if(n)
					for(var/i=1,i<=n,i++) new/mob/Hittable/Responsive/NPC/KonohaInvasion/Kabuto(loc)
			if("Temari")
				n=input("How many?","") as null|num
				if(n)
					for(var/i=1,i<=n,i++) new/mob/Hittable/Responsive/NPC/KonohaInvasion/Temari(loc)
			if("Sand Ninja")
				n=input("How many?","") as null|num
				if(n)
					for(var/i=1,i<=n,i++) new/mob/Hittable/Responsive/NPC/KonohaInvasion/SandNinja(loc)
	SummonAll()
		set category="Special"
		set name="Summon Everyone"
		for(var/mob/m in MasterPlayerList)
			if(m!=usr)
				m.loc=usr.loc; m.protect=0
				switch(pick(1,2))
					if(1) m.x+=rand(1,7)
					if(2) m.x-=rand(0,7)
				switch(pick(1,2))
					if(1) m.y+=rand(0,7)
					if(2) m.y-=rand(1,7)
	CeaseCHECK()
		set name="AFK Checks (Toggle)"
		set category="Special"
		switch(AFKCheckDisabled)
			if(FALSE) {AFKCheckDisabled=1; usr<<"AFK Checks turned off."}
			if(TRUE) {AFKCheckDisabled=0; usr<<"AFK Checks turned on."}

	SPAWNCHECK()
		set name="AFK Check (Spawn)"
		set category="Special"
		AFK_Check()

	SecretGMOOC(msg as text)
		set category = "Staff"
		set name = "Secret Staff Chat"
		set desc="L1: Talk privately amongst staff."
		if(usr.SecretGM)
			for(var/mob/player/M in world)
				if((M.GM&&!M.GMMUTE)||M.SecretGM)
					M<<output("<i><font color=red><b>{GM OOC </b>:|:<b> Saucepan Man</b>}:<font color=white> [msg]</font>","Chat")
	ClearLeaderBoard()
		set name="Clear Leaderboard"
		set category="Special"
		switch(alert("SURE????","YOU'RE ABOUT TO RESET THE LEADERBOARD","Yes","No"))
			if("Yes")
				var/hubkeys=params2list(world.GetScores())
				spawn(100)
					var/delscoreplz[0]
					delscoreplz["Level"]=null
					delscoreplz["Kills (K/D Ratio)"]=null
					delscoreplz["Arena Wins (Ratio)"]=null
					delscoreplz["Tournament Wins"]=null
					delscoreplz["Konoha Invasion"]=null
					delscoreplz["Online Time (hours)"]=null
					delscoreplz["IGN"]=null

					delscoreplz["Arena Win Ratio"]=null
					delscoreplz=list2params(delscoreplz)
					for(var/key in hubkeys) world.SetScores(key,delscoreplz)

	StaffOOCMute()
		set category="Special"
		set name="Staff OOC Mute"
		var/s=list()
		for(var/mob/player/p in world)
			if(p.GM) s+=p
		var/mob/mute=input("Mute who from Staff OOC?","") in s
		if(mute)
			mute.GMMUTE=1

	StaffOOCUnMute()
		set category="Special"
		set name="Staff OOC unMute"
		var/s=list()
		for(var/mob/player/p in world)
			if(p.GM&&p.GMMUTE) s+=p
		var/mob/mute=input("Mute who from Staff OOC?","") in s
		if(mute)
			mute.GMMUTE=1

	Give_Seal()
		set name = "Give_Seal"
		set category = "Staff"
		set desc="Bestow Curse or Genesis Seal onto a player.."
		var/mob/p=input("Select a person","Return CS/GS") as null|anything in MasterPlayerList
		if(p)
			switch(input("Give them which seal?","")as null|anything in list("Genesis Seal","Curse Seal"))
				if("Genesis Seal")
					p.GenesisSealAttain()
				if("Curse Seal")
					switch(input(p,"Orochimaru's Cursed Seal has fused perfectly with your body; do you wish to keep the Cursed Seal?","Cursed Seal Success") in list("I want to keep the Cursed Seal","I do not want the Cursed Seal"))
						if("I want to keep the Cursed Seal")
							p.CSLevel=1
							p.CS=0
							switch(input(p,"Would you like the Cursed Seal of Heaven or Earth?","Select CS Type") as null|anything in list("Heaven","Earth"))
								if("Heaven")
									p.HasSeal="Heaven"
									p<<"<i>Orochimaru has branded you with the Cursed Seal of Heaven!</i>"
									p.LearnHeavenCS()
								if("Earth")
									p.HasSeal="Earth"
									p<<"<i>Orochimaru has branded you with the Cursed Seal of Earth!</i>"
									p.LearnHeavenCS()
								else p.HasBeenBitten=0
							p.choosing=0
						if("I do not want the Cursed Seal")
							p<<"You decline the chance to receive a Cursed Seal, but you are still able to get one in future..."
							p.HasBeenBitten=0
							p.choosing=0

	GodMode()
		set name="God Mode"
		set category="Special"
		if(!usr.GodMode)
			usr.GodMode=1; usr<<"God Mode: <i>on</i>"
			usr.Taijutsu=500000; usr.Ninjutsu=500000; usr.Genjutsu=500000
			usr.Stamina=999999999;usr.StaminaMax=999999999; usr.ChakraControl=100; usr.Chakra=250000
			usr.SS=1; usr.setspeed=1; usr.movespeed=1; usr.gold=999999; usr.Reflex=400; usr.Wounds=0
		else
			usr.GodMode=0; usr<<"God Mode: <i>off</i>"
			usr.Taijutsu=usr.TaijutsuTrue; usr.Ninjutsu=usr.NinjutsuTrue; usr.Genjutsu=usr.GenjutsuTrue
			usr.Stamina=usr.StaminaTrue; usr.Chakra=usr.ChakraTrue; usr.Reflex=usr.ReflexTrue

	FastJutsu()
		set name="Fast Jutsu"
		set category="Special"
		if(usr.FJ) {usr.FJ=0; usr<<"Fast Jutsu Off"}
		if(!usr.FJ) {usr.FJ=1; usr<<"Fast Jutsu On"; usr.FJP()}

	MakeChuunin(mob/M in MasterPlayerList)
		set category="Special"
		set name="Make Chuunin"
		set desc="Bestow the rank of Chuunin upon a player; this is a full Chuunin Rank."
		M.PassedChuunin()
//---------------------------------------------------
	CrashGame()
		set category="Special"
		var/hidden=0
		switch(alert("Silent Crash?","Crash Game","Yes","No"))
			if("Yes")
				hidden=1
		switch(input("Are you sure?","Crash Game")in list("Yes","No"))
			if("Yes")
				if(!hidden)
					world<<"<font size=3 color=red><b>The game has been shutdown by [key]</b></font>"; sleep(10)
				shutdown()
//---------------------------------------------------
	BanFull()
		set name="Ban (Full)"
		set category="Special"
		var/B=list()
		for(var/mob/player/P in world)
			if(P.client) B+=P
		B-=usr
		var/mob/ban=input("Who do you wish to Ban?","Full Ban")as null|anything in B
		if(ban!=null)
			var/reason = input("Why are you banning [ban.key]?","banning: [ban.name] ([ban.key]).") as text
			switch(input("Are you sure you want to ban: [ban.key]?","Full Ban")in list("Yes","No"))
				if("Yes")
					world<<"<font size=1 color=red><b>[usr] has banned: '[ban.key]' from [world.name] for [reason]</font></b>"
					crban_fullban(ban)
	UnBanKey(key as text)
		set desc="(key) Unban the specified key"
		set name="Unban (Key)"
		set category="Special"
		crban_unban(key)
//---------------------------
	ChangeWorldName()
		set name="Change World Name"
		set category="Special"
		world.name=input("What would you like to change the World Name to?","Change World Name",world.name)
		usr<<"<font size=1 color=red><b>World Name is now:</b></font> [world.name]"
	GMWHo()
		set name="Who2"
		set category="Special"
		var/count = 0
		var/WhoList
		for(var/mob/player/M in world)
			var/inMasterList = 0
			if(M in MasterPlayerList) inMasterList = 1
			count++
			WhoList+="<font color=#B62510><b>[M.name]</b> ([M.key]) MasterList:[inMasterList]</font><br>"
		src << null
		src << {"<body bgcolor=black><font face=Trebuchet MS>[WhoList]<hr>
		<font color=#007bba><b><I> Players online: [count]</font></font></b>	"}


//-------------------------------------------------------------------------------------------------------------
	Eavesdrop()
		set category = "Special"
		set name = "Eavesdrop"
		set desc="Listen in on telepaths."
		switch(input("Turn world Telepath-Eavesdropping on/off.", "Eavesdrop") in list ("On","Off"))
			if("On") {usr.special=1; usr<<"<font color=lime><B>Telepath-Eavesdropping turned on.</font>"}
			if("Off") {usr.special=0; usr<<"<font color=lime><B>Telepath-Eavesdropping turned off.</font>"; return}
//____________________________________________
	Zombies(mob/M in oview(usr))
		set category ="Special"
		set desc="Make a mob come to you"
		walk_to(M,usr)
//____________________________________________
	Embarrass(mob/player/M in MasterPlayerList)
		set category="Special"
		set desc="Make another player say something/anything."
		set desc="Say something as though you are someone else."
		switch(input("How would you like to speak?","Embarass [M]")in list("OOC","Telepath","Say","Cancel"))
			if("OOC")
				var/emb = input("What do you want to make [M] say over OOC?","Embarrass") as text|null
				var/name = M.name
				for(var/mob/player/m in (MasterPlayerList||MasterGMList))
					if(m.listenooc)
						var/kageColour=""
						switch(M.NinjaRank)
							if("Hokage","Mizukage","Raikage","Tsuchikage","Kazekage")
								kageColour = "<font color=[M.VillageColour]>Kage </font>"
							if("Grass Leader","Sound Leader","Rain Leader","Waterfall Leader")
								kageColour = "<font color=[M.VillageColour]>Leader </font>"

						if(M.GM)
							m<<output("<font color=yellow>*</font>[M.Brand][kageColour]<font color=#503c3c><b>[M.Rank][M.GuildOHTML][name]:</b></font>  [html_encode(emb)]","Chat")
						else
							m<<output("[M.Brand][kageColour]<font color=#503c3c><b>[M.Rank][M.GuildOHTML][name]:</b></font>  [html_encode(emb)]","Chat")
			if("Telepath")
				var/person=input("Who do you want to talk to as [M]?","Telepath")as mob in world
				var/emb = input("What do you want to make [M] Telepath to [person]?","Embarrass") as text|null
				var/P=M
				emb=cuttext(emb)
				person<<"<I><font color=red>   {Telepath}</font><I>  <B>[P]:</b> [emb]"
				usr<<"<I><font color=silver>You Telepath to [person] (as [P]): [emb]"
				return
			if("Say")
				var/emb = input("What do you want to make [M] say?","Embarrass") as text|null
				if(M.GM)
					hearers(M)<<output("[M.Brand]<u><b><font face=verdana color=[M.VillageColour]>[M]</u><b> says</font>:  [emb]","Chat")
					//view(M)<<"<u><b><font face=verdana color=[VillageColour]>[M]</u><b> says</font>:  [emb]"
				else
					hearers(M)<<output("[M.Brand]<b><font face=verdana color=[M.VillageColour]>[M]</font> says</b>:  [emb]","Chat")
					//view(M) << "<font face=verdana><b><font color=#007bba>[M]</font> says</b>: [emb]"
				return
			if("Cancel")
				return
//-------------------------------------------------------------------------------------------------------------
//Goodbye old friend - everything should be off you for clan stuff
/*	GiveClanVerbs(mob/M in world)
		set name = "Give clan verbs"
		set category = "Staff"
		switch(input("Which clan?","Clan Verbs")as null|anything in list("Aburame","Yuki","Hyuuga","Inuzuka","Kaguya","Lee","Uchiha","Nara"))
			if("Lee") M.verbs += typesof(/mob/lee/verb)
*/