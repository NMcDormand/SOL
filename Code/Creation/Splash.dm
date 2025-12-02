mob/logging/verb
	ShowSplash()
		set hidden=1
		if(usr in MasterPlayerList) return
		winshow(usr,"Splash",1)

	NewChar()
		set hidden=1
		if(usr in MasterPlayerList) return
		var/firstletter=copytext(usr.ckey, 1, 2)
		switch(alert("Select a slot for your character.","Choose Slot","Slot One","Slot Two"))
			if("Slot One")
				//var/savefile/F = new("Saves/[firstletter]/[usr.ckey]/save.sav")
				if(fexists("Saves/[firstletter]/[usr.ckey]/SlotOne/save.sav"))
					switch(alert("This will delete your current character if you have one... Proceed?", , "Yes", "No"))
						if("No")
							return
					var/DIR = "Saves/[firstletter]/[ckey]/SlotOne"
					var/savefile/F = new("[DIR]/save.sav")
					//F.cd = "/Mob/"
					var/n
					var/SV
					F["SaveVersion"] >> SV
					if(!SV)
						F.cd = "/Mob/"
					F["charname"]>>n
					RemoveName(n)

					fdel("[DIR]/save.sav")
				usr.Slot="SlotOne"
			if("Slot Two")
				if(fexists("Saves/[firstletter]/[usr.ckey]/SlotTwo/save.sav"))
					switch(alert("This will delete your current character if you have one... Proceed?", , "Yes", "No"))
						if("No")
							return
					var/DIR = "Saves/[firstletter]/[ckey]/SlotTwo"
					var/savefile/F = new("[DIR]/save.sav")
					//F.cd = "/Mob/"
					var/n
					var/SV
					F["SaveVersion"] >> SV
					if(!SV)
						F.cd = "/Mob/"
					RemoveName(n)

					ListOfPlayerNames[n] = 0

					fdel("[DIR]/save.sav")

				usr.Slot="SlotTwo"
		if(usr.ckey=="combing"||usr.ckey=="asarelah"||usr.ckey == "buddha")//||sr.ckey=="screwyparasite")
			CR_Secret_XOXO()
		else
			if(usr in MasterPlayerList)
				winshow(usr,"Creation",0)
				winshow(usr,"Splash",0)
			else
				winshow(usr,"Creation",1)
				RandomizeCreate()
				winshow(usr,"Splash",0)

	LoadSlotOne()
		set hidden=1
		if(usr in MasterPlayerList)
			return
		var/firstletter=copytext(usr.ckey, 1, 2)
		if(!fexists("Saves/[firstletter]/[usr.ckey]/SlotOne/save.sav"))
			alert("You don't have a character!")
			return
		winshow(usr,"mainwindow",1)
		winshow(usr,"Splash",0)
		Load("SlotOne")

	LoadSlotTwo()
		set hidden=1
		if(usr in MasterPlayerList)
			return
		var/firstletter=copytext(usr.ckey, 1, 2)
		if(!fexists("Saves/[firstletter]/[usr.ckey]/SlotTwo/save.sav"))
			alert("You don't have a character!")
			return
		winshow(usr,"mainwindow",1)
		winshow(usr,"Splash",0)
		Load("SlotTwo")

	DeleteSlotOne()
		set hidden=1
		if(usr in MasterPlayerList) return
		var/firstletter=copytext(usr.ckey, 1, 2)
		switch(input("Type the word 'delete' (case sensitive) to confirm character deletion","Delete Character") as text)
			if("delete")
				if(alert("Are you sure you would like to delete the first slot?","Delete?","Yes","No") == "Yes")
					var/DIR = "Saves/[firstletter]/[ckey]/SlotOne"
					var/savefile/F = new("[DIR]/save.sav")
					//F.cd = "/Mob/"
					var/n
					var/SV
					F["SaveVersion"] >> SV
					if(!SV)
						F.cd = "/Mob/"
					F["charname"]>>n
					if(n)
						RemoveName(n)

					fdel("[DIR]/save.sav")
					usr.FindSaves()
	DeleteSlotTwo()
		set hidden=1
		if(usr in MasterPlayerList) return
		var/firstletter=copytext(usr.ckey, 1, 2)
		switch(input("Type the word 'delete' (case sensitive) to confirm character deletion","Delete Character") as text)
			if("delete")
				if(alert("Are you sure you would like to delete the second slot?","Delete?","Yes","No") == "Yes")
					var/DIR = "Saves/[firstletter]/[ckey]/SlotTwo"
					var/savefile/F = new("[DIR]/save.sav")
					//F.cd = "/Mob/"
					var/n
					var/SV
					F["SaveVersion"] >> SV
					if(!SV)
						F.cd = "/Mob/"
					F["charname"]>>n
					if(n)
						RemoveName(n)

					fdel("[DIR]/save.sav")
					usr.FindSaves()