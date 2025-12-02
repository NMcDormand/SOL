mob/var/list/FriendlyFire = list()
mob/player/verb/FriendlyFireSettings()
	set hidden=1
	var/list/FF_List=list("My Village","Specific Person")
	if(usr.Guild) FF_List+="My Guild"
	var/x
	switch(alert("Add or Remove?","Friendly Fire Settings","Add","Remove","Cancel"))
		if("Add")
			switch(input("Select a person or group to be protected","Friendly Fire - Add") as null|anything in FF_List)
				if("My Village")
					x="village"
					usr.FriendlyFire[x]=1
					usr.VillageFriendly = 1
				if("My Guild")
					x="guild"
					usr.FriendlyFire[x]=1
				if("Specific Person")
					var/mob/p=(input("Whom do you want to protect?","Friendly Fire - Add") as null|mob in MasterPlayerList)
					if(p)
						x="[p.PlayerID]"
						usr.FriendlyFire[x]=p.trueName
			usr<<"The following person/people are now protected from damage: [x]."
		if("Remove");
			switch(input("Select the person or group to be unprotected","Friendly Fire - Remove") as null|anything in FF_List)
				if("My Village")
					x="village"
					usr.FriendlyFire -= x
					usr.VillageFriendly = 0
				if("My Guild")
					x="guild"
					usr.FriendlyFire -= x
				if("Specific Person")
					var/list/AddList = list()
					for(var/A in usr.FriendlyFire)
						if(A != "guild" && A != "village")
							AddList[usr.FriendlyFire[A]] = A
					var/mob/p=(input("Whom do you want to protect?","Friendly Fire - Add") as null|anything in AddList)
					if(p)
						usr.FriendlyFire -= AddList[p]
			usr<<"The following person/people will now receive normal damage: [x]."