turf/var/turfpassword
turf/GuildHouses/Doorways


//----------------------------------------------------------------------------------------------------------- OLD
	Hakumei
		MainDoor
			Entry
				Enter(mob/M)
					return;
					if(M.Guild=="Hakumei") {M.loc=locate(922,971,1); M.ZCoord="Guild House"; M.ZCoordProc(M.ZCoord)}
					else {M<<"You are not a member of Hakumei!"; return}
			Exit
				Entered(mob/M)
					M.loc=locate(929,546,1); M.ZCoord="Roaming"; M.ZCoordProc(M.ZCoord)

	QuarterKnights
		Maindoor
			Entry
				Enter(mob/M)
					return;
					if(M.Guild=="Quarter Knights") {M.loc=locate(858,925,2); M.ZCoord="Guild House"; M.ZCoordProc(M.ZCoord)}
					else {M<<"You are not a member of Quarter Knights!"; return}
			Exit
				Entered(mob/M)
					M.loc=locate(631,143,1); M.ZCoord="Roaming"; M.ZCoordProc(M.ZCoord)
		LeaderRoom
			Entry
				density=1
				opacity=1
				turfpassword=0
				verb
					LockUnlockDoor()
						set src in oview(1)
						set category="leader door"
						set name="Toggle lock"
						if(turfpassword) {usr<<"LOCKED THE DOOR!"; turfpassword=0}
						else {usr<<"OPENED THE DOOR (WITH CAPS LOCK ON, WHOOO GO CAPS LOCK!)"; turfpassword=0}
				Enter(mob/M)
					return;
					if(turfpassword) M.loc=locate(859,985,2)
					else {M<<"This door is locked."; return}

			Exit
				Enter(mob/M)
					return;
					M.loc=locate(859,980,2)
	Kireji
		Maindoor
			Entry
				Enter(mob/M)
					return;
					if(M.Guild=="Kireji") {M.loc=locate(984,970,1); M.ZCoord="Guild House"; M.ZCoordProc(M.ZCoord)}
					else {M<<"You are not a member of Kireji!"; return}
			Exit
				Entered(mob/M)
					M.loc=locate(39,967,1); M.ZCoord="Lost Caves"; M.ZCoordProc(M.ZCoord)

	Kakumei
		Maindoor
			Entry
				Enter(mob/M)
					return;
					if(M.Guild=="the Revolution")
						//M.loc=locate(891,970,1); M.ZCoord="Guild House"; M.ZCoordProc(M.ZCoord)}
						usr<<"Disabled Kakumei GH. Reason: mutiny"
					else return
			Exit
				Entered(mob/M)
					M.loc=locate(440,30,1); M.ZCoord="Roaming"; M.ZCoordProc(M.ZCoord)

	Blitzkrieg
		Maindoor
			Entry
				Enter(mob/M)
					return;
					if(M.Guild=="BlitzKrieg") {M.loc=locate(796,970,1); M.ZCoord="Guild House"; M.ZCoordProc(M.ZCoord)}
					else return
			Exit
				Entered(mob/M)
					M.loc=locate(5,299,1); M.ZCoord="Roaming"; M.ZCoordProc(M.ZCoord)

	DrPandaMedicalStaff
		Maindoor
			Entry
				Enter(mob/M)
					return;
					if(M.Guild=="Dr.Panda's Medical Staff") {M.loc=locate(829,970,1); M.ZCoord="Guild House"; M.ZCoordProc(M.ZCoord)}
					else return
			Exit
				Entered(mob/M)
					M.loc=locate(594,541,1); M.ZCoord="Roaming"; M.ZCoordProc(M.ZCoord)

	Saviors
		Maindoor
			Entry
				Enter(mob/M)
					return;
					if(M.Guild=="Mysterys Guild") {M.loc=locate(860,970,1); M.ZCoord="Guild House"; M.ZCoordProc(M.ZCoord)}
					else return
			Exit
				Entered(mob/M)
					M.loc=locate(336,125,1); M.ZCoord="Roaming"; M.ZCoordProc(M.ZCoord)

	Zetsumei
		MainDoor
			Entry
				Enter(mob/M)
					return;
					if(M.Guild=="Zetsumei") {M.loc=locate(956,970,1); M.ZCoord="Guild House"; M.ZCoordProc(M.ZCoord)}
					else {M<<"You are not a member of Zetsumei!"; return}
			Exit
				Entered(mob/M)
					M.loc=locate(763,285,1); M.ZCoord="Roaming"; M.ZCoordProc(M.ZCoord)

		LeaderRoom
			Entry
				density=1
				opacity=1
				turfpassword="icecream"
				Enter(mob/M)
					return;
					var/p=input("Enter access code:","") as text
					if(p&&p==turfpassword)
						M.x-=2
						if(M.y>975) M.y=975
						else M.y=max(M.y,974)
					else {M<<"Password was incorrect."; return}
			Extit
				opacity=1
				Entered(mob/M)
					M.x+=2
					if(M.y>975) M.y=975
					else M.y=max(M.y,974)