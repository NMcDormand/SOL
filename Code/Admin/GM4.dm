var
	VioleDisabled = 0
	MinatoDisabled = 0
	mob/player/EventCreator = 0
	EventOngoing = 0
	EventStarted = 0
	EventRequirement = 0
	EventResponse = 0

mob/player
	var
		CustomSayColour = 0
	proc
		PickSayColour()
			REDO
			var C = input(src,"What Colour would you like? (Format #000000)","Colour") as text
			src << output("<font color=\"[C]\">[name]:</font> This is the colour you requested", "Chat")
			if(alert(src,"Was this colour you were hoping for?","Colour","Yes","No") == "Yes")
				VillageColour = C
				CustomSayColour = 1
				return 1
			else
				goto REDO


mob/VerbHolder/Admin/Level4/verb
	Repair_Start(var/mob/player/M in MasterPlayerList)
		Repair_Start(M)

	Rebuild_Skill_List()
		ReadySkills = list()
		GlobalSkills = list()
		for(var/Card in typesof(/obj/SkillCards))
			var/obj/SkillCards/A = new Card(null)
			if(A)
				if(istype(A,/obj/SkillCards/Ninjutsu/Special/EdoTensei/Commands)||istype(A,/obj/SkillCards/ClimbTree)||istype(A,/obj/SkillCards/ActionButton)) //We dont want standard skills and commands to be given again via a seed
					continue
				if(istype(A,/obj/SkillCards/Clan/Lee/HachimonClose)||istype(A,/obj/SkillCards/Ninjutsu/Doton/YomiNumaRelease)||istype(A,/obj/SkillCards/Clan/Nara/KagemaneRelease)||istype(A,/obj/SkillCards/Ninjutsu/Fuuton/FujinHekiRelease)||istype(A,/obj/SkillCards/Clan/Kaguya/SawarabiNoMaiRelease))
					continue
				if(istype(A,/obj/SkillCards/Starter)||istype(A,/obj/SkillCards/Taijutsu/Starter)||istype(A,/obj/SkillCards/Ninjutsu/Starter)||istype(A,/obj/SkillCards/Genjutsu/Starter))
					continue
				if(istype(A,/obj/SkillCards/Ninjutsu/CursedSeal_Heaven)||istype(A,/obj/SkillCards/Taijutsu/CursedSeal_Earth)) //We still want a count of these but dont want a skill seed for skills obtained through another skillcard
					continue
				ReadySkills[A.name] = A.type
				GlobalSkills[A.name] = 0
		SaveSkills()

	Create_Candy()
		var/obj/Event/C
		switch(input("What type of Candy do you want to create?","Candy Choice") as null|anything in list("Red Candy","Blue Candy","Green Candy","Large Candy"))
			if("Red Candy")
				C = locate(/obj/Event/CandyHunt/Candy1) in usr
				if(!C)
					C = new/obj/Event/CandyHunt/Candy1()
					C.amount = 0
			if("Blue Candy")
				C = locate(/obj/Event/CandyHunt/Candy2) in usr
				if(!C)
					C = new/obj/Event/CandyHunt/Candy2()
					C.amount = 0
			if("Green Candy")
				C = locate(/obj/Event/CandyHunt/Candy3) in usr
				if(!C)
					C = new/obj/Event/CandyHunt/Candy3()
					C.amount = 0
			if("Large Candy")
				C = locate(/obj/Event/CandyHunt/Candy4) in usr
				if(!C)
					C = new/obj/Event/CandyHunt/Candy4()
					C.amount = 0
		if(C)
			var/A = input("How many would you like to create?") as num
			if(A>0)
				C.amount += A
				C.Checkamount()
				C.loc = usr
				usr.UpdateInventory()
				usr << "You have created [A] [C.trueName]"
				AdminActionLog("Created [A] [C.trueName]","Event",0,0,usr)
			if(C.loc != usr)
				del C

	Give_Reward(var/mob/player/M in MasterPlayerList)
		switch(input("What kind of reward would you like to give?","Reward") as null|anything in list("Gold","Feather","Stones","Village Colour","Icon Scroll","Stat Points"))
			if("Gold")
				var/G = input("How much Gold would you like to give [M.trueName]","Gold Reward") as num
				if(G>0)
					M.gold += G
					M.StatUpdate_gold()
					M << "[usr] has given you [G] Gold as a reward"
					usr << "You have given [M] [G] Gold as a reward"
					AdminActionLog("Given [G] Gold", "Event", 0, M, usr)
			if("Feather")
				var/G = input("How man Feathers would you like to give [M.trueName]","Feather Reward") as num
				if(G>0)
					var/obj/Item/Material/Feather/F = locate() in M
					if(F)
						F.amount += G
					else
						F = new(M)
						F.amount = G
					F.Checkamount()
					M.UpdateInventory()
					if(G>1)
						M << "[usr] has given you [G] Feathers as a reward"
						usr << "You have given [M] [G] Feathers as a reward"
					else
						M << "[usr] has given you a Feather as a reward"
						usr << "You have given [M] a Feather as a reward"

					AdminActionLog("Given [G] Feather", "Event", 0, M, usr)
			if("Stones")
				var/G = input("How man Stones would you like to give [M.trueName]","Feather Reward") as num
				if(G>0)
					var/obj/Item/Material/Ore/Stone/R = locate() in M
					if(R)
						R.amount += G
					else
						R = new(M)
						R.amount = G
					R.Checkamount()
					M.UpdateInventory()
					if(G>1)
						M << "[usr] has given you [G] Stones as a reward"
						usr << "You have given [M] [G] Stones as a reward"
					else
						M << "[usr] has given you a Stone as a reward"
						usr << "You have given [M] a Stone as a reward"
					AdminActionLog("Given [G] Stone", "Event", 0, M, usr)

			if("Village Colour")
				usr << "You have given [M.trueName] the option to select a new colur"
				if(M.PickSayColour())
					usr << "[M.trueName] ha successfully chosen a new colour"
					AdminActionLog("Given a new Village Colour", "Event", 0, M, usr)

			if("Icon Scroll")
				var/obj/Item/Icon_Scroll/I = locate() in M
				if(!I)
					new/obj/Item/Icon_Scroll(M)
				else
					I.amount++
					I.Checkamount()
				M.UpdateInventory()
				usr << "You gave [M] 1 Icon Scroll"
				M << "[usr.trueName] gave you 1 Icon Scroll"
				AdminActionLog("Given 1 Icon Scroll", "Event", 0, M, usr)

			if("Stat Points")
				var/A = input("How many would you like to give?") as num
				if(M && A)
					M.StatPoints += A
					M.StatUpdate_statpoints()
					usr << "You gave [M] [A] SPS"
					M << "[usr.trueName] gave you [A] SPS"
					AdminActionLog("Given [A] Stat Points", "Event", 0, M, usr)

	Reset_Bank(var/mob/player/M in MasterPlayerList)
		if(alert("Are you sure you would like to reset their bank?","Reset Bank","Yes","No") == "Yes")
			M.bankaccount = 0
			M.SDBaccount = 0
			CitiBank -= M.ckey
			AdminActionLog("Bank Reset", "Fix", 0, M, usr)

	Toggle_Viole()
		if(VioleDisabled)
			VioleDisabled = 0
			world << "Viole is now Enabled"
		else
			VioleDisabled = 1
			if(SpecialMobs["Viole"])
				var/mob/A = SpecialMobs["Viole"]
				del A
			world << "Viole is now Disabled"

	Toggle_Minato()
		if(MinatoDisabled)
			MinatoDisabled = 0
			world << "Minato is now Enabled"
		else
			MinatoDisabled = 1
			if(SpecialMobs["Minato"])
				var/mob/A = SpecialMobs["Minato"]
				del A
			world << "Minato is now Disabled"

	DelayAutoReboot()
		if(alert("This will delay the Auto Reboot by an hour, are you sure you would like to do this? (This does not stack, you will need to delay it again)","Delay?","Yes","No") == "Yes")
			DelayedReboot = 1
			AdminActionLog("Delayed Auto Reboot", "Event",0,0,usr)

	FixAllSaveBlocks()
		for(var/mob/M in MasterPlayerList)
			if(M.Saving)
				M.Saving = 0
				M << "[usr] fixed your save"

	FixAllItems()
		set name="Fix Everyone's Items"
		set category="Fix"
		for(var/mob/player/user in MasterPlayerList)
			for(var/obj/O in user.contents)
				O.OnSpeedRail=0; O.ItemSlot="Inventory.ItemGrid"
			user.SpeedRailSlotsUsed=new()
			user.SpeedRailSlotsUsed["speedrail.ItemSlot_01"]=null
			user.SpeedRailSlotsUsed["speedrail.ItemSlot_02"]=null
			user.SpeedRailSlotsUsed["speedrail.ItemSlot_03"]=null
			user.SpeedRailSlotsUsed["speedrail.ItemSlot_04"]=null
			user.SpeedRailSlotsUsed["speedrail.ItemSlot_05"]=null
			user.SpeedRailSlotsUsed["speedrail.ItemSlot_06"]=null
			user.SpeedRailSlotsUsed["speedrail.ItemSlot_07"]=null
			user.SpeedRailSlotsUsed["speedrail.ItemSlot_08"]=null
			user.UpdateInventory()
			sleep(1)
//================================================================================================================
	ToggleGuildCreation(var/mob/player/p in MasterPlayerList)
		set name="Toggle Players Guild"
		set category = "Staff"
		set desc="Toggle the players ability to create a guild."
		if(p.GuildDisabled) {p.GuildDisabled=0; src<<"You have enabled [p]'s Guild Creation";}
		else {p.GuildDisabled=1; src<<"You have disabled [p]'s Guild Creation";}
//================================================================================================================
	MatchStats(var/mob/player/P in MasterPlayerList)
		switch(alert("This will clone their stats to your own!","Match Stats","Go!","Nevermind"))
			if("Go!")
				Stamina=P.Stamina; StaminaMax=P.StaminaMax; StaminaTrue=P.StaminaTrue
				Chakra=P.Chakra; ChakraMax=P.ChakraMax; ChakraTrue=P.ChakraTrue;
				ChakraControl=P.ChakraControl; ChakraControlTrue=P.ChakraControlTrue;
				SS=P.SS;
				Taijutsu=P.Taijutsu; TaijutsuMax=P.TaijutsuMax; TaijutsuTrue=P.TaijutsuTrue;
				Ninjutsu=P.Ninjutsu; NinjutsuMax=P.NinjutsuMax; NinjutsuTrue=P.NinjutsuTrue;
				Genjutsu=P.Genjutsu; GenjutsuMax=P.GenjutsuMax; GenjutsuTrue=P.GenjutsuTrue;

//================================================================================================================
	CreateOld()
		set name = "CreateOld"
		set category = "Staff"
		set desc="Create anything thats in the game."
		var/varItem
		var/varType = input("What do you want to create?","Create")as null|anything in list("Object","Mob","Turf","Cancel")
		if(varType == "Object") varItem = input("What do you want to make?","Create obj") in typesof(/obj) + list("Cancel")
		if(varType == "Mob") varItem = input("What do you want to make?","Create mob") in typesof(/mob) + list("Cancel")
		if(varType == "Turf") varItem = input("What do you want to make?","Create turf") in typesof(/turf) + list("Cancel")
		if(varItem)
			if(varItem=="Samehada") return
			new varItem(locate(x,y-1,z))
//-------------------------------------------------------------------------------------------------------------
/*	TakeVerb(mob/M in world)
		set name = "Take Verb"
		set category = "Staff"
		set desc="Take a verb from a player."
		var/varVerb = input("What verb would you like to take from [M]?","Take Verb")
		if(varVerb != "Cancel")
			M:verbs -= varVerb
	GiveVerb()
		set name="Give Verb"; set category="Staff"; set desc="Give a verb to a player."
		var/People=list()
		for(var/client/C) People += C
		var/mob/M = input("Who would you like to give a verb to?","Give Verb") as null|anything in People
		if(M)
			var/verb/Verb = input("What verb would you like to give [M.name]?","Give Verb") as text
			if(Verb) M.verbs+=text2path(Verb) */
//-------------------------------------------------------------------------------------------------------------
	ObjTele(obj/O in world)
		set name = "Teleport(obj)"
		set category = "Staff"
		set desc="Teleport to an obj."
		if((usr.ckey!="screwyparasite")&&(istype(O,/obj/Weapon/Wield/Samehada)||istype(O,/obj/Weapon/Wield/ExecutionerBlade)))
			usr<< Rick; usr<<"<b>Locating target...</b>"
			spawn(50) usr<<"Haha! Rick Roll'd motherfucker!  :P"
		else
			if(istype(O.loc,/turf))
				usr.loc.loc.Exited(usr)
				usr.loc=O.loc
				usr.loc.loc.Entered(usr)
			else
				usr.loc.loc.Exited(usr)
				usr.loc = O.loc.loc
				usr.loc.loc.Entered(usr)

	Brand(mob/M in MasterPlayerList)
		set name="Brand"
		set desc="Brand this character as a cheater until a new character is created."
		set category="Staff"
		switch(alert("This is ONLY to be used if you have proof of AFK training/Bug Abuse. All other situations must be cleared first!","Brand","Brand this player","Nevermind"))
			if("Brand this player")
				var/reason=input({""Please enter a reason for the Brand. This will be logged.""}) as text
				switch(alert("Are you sure?",,"Yes","No"))
					if("Yes")
						M.cheater=1
						M.Brand="<font size=1 color=#886702>(c) </font>"
						world<<"[usr] has permanently branded [M]!"
						spawn(10)AdminActionLog("Brand", reason, , M, src)
//-------------------------------------------------------------------------------------------------------------
	Delete(M as mob|obj|turf in range())
		set desc="Deletes anything."
		set name = "Delete"
		set category = "Staff"
		del(M)
//-------------------------------------------------------------------------------------------------------------
	Send_File(mob/M in world,F as file)
		set category="Staff"
		set desc="Host: Send a file"
		switch(alert(M,"[usr] is trying to send you [F].  Do you accept the file?","File Transfer","Yes","No"))
			if("Yes")
				alert(usr,"[M] accepted the file","File Accepted")
				M<<ftp(F)
			if("No")
				alert(usr,"[M] declined the file","File Declined")

	Request_Icon(mob/M as mob in world)
		set category = "Staff"
		set name = "Request Icon"
		switch(input(M,"[usr.name] is giving you permission to send \him an Icon","Accept?") in list("Yes","No"))
			if("Yes")
				var/F = input(M,"Choose Icon to Give to Admin:[usr.name]","Icon") as icon
				usr << ftp(F)
				M<<"<font size=1 color=red><i>Sending...</i></font>"
				usr<<"<font size=1 color=red><i>Sending...</i></font>"
				return
			else
				usr<<"[M] declined"
				return