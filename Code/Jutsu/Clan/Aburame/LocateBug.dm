mob/var/tmp
		list/KonchuuList
		list/BuggedList = list()
		BugTracking
obj/SkillCards/Clan/Aburame/LocateBug
	icon_state="card_LocateBug"
	cmdstring="LocateBug"
	CanLevel = 0

	Description = list(
		"about"="Locate an insect that you placed on a person"
		,"title"="Locate Bug"
		,"type"="Clan-Jutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
		,"Tutorial" = "After placing a tracking insect on your targets you can track their location, this will appear on your minimap for ease of use"
//		,"pic"='MushiYose.png'
		)

	Activate(mob/U)
		if(U.jailed||U.GMfrozen) return
		var/list/L=U.KonchuuList
		var/LL = L.len
		var/mob/T
		if(LL)
			if(LL<2)
				T = pick(L)
			else
				T = input("Which target do you want to locate?","Locate bugs") as null|anything in L
		if(T)
			U.BugTrack(T)
			U.BugTrackCheck(T)
		/*	U.TrackTarget(T)
			var/d=get_dir(U,T)
			var/v=T.y-U.y
			var/h=T.x-U.x
			if(v>=0) v="[v] North"
			else v="[abs(v)] South"

			if(h>0) h="[h] East"
			else h="[abs(h)] West"
			switch(d)
				if(1) d="North"
				if(2) d="South"
				if(4) d="East"
				if(8) d="West"
				if(5) d="North-East"
				if(6) d="South-East"
				if(10) d="South-West"
				if(9) d="North-West"
			U<<"<b>[T]:</b><font color=silver>Location: [v],[h] ([T.ZCoord])</font>"
			winshow(U,"WorldMap.Tracker",1)
			winset(U,"WorldMap.Tracker","pos=[U.TrackBug(T)]")
			spawn(60) winshow(U,"WorldMap.Tracker",0)*/
mob/proc
	BugTrackCheck(mob/M)
		set waitfor = 0
		for(var/count=1,count<=2,count++)
			if(!(M in KonchuuList))
				break
			if(M.HasKonchuu[ckey])
				src << "[M] has [M.HasKonchuu[ckey]] XPlsoive bugs attached"
			sleep(600)
		if(M)
			BugTracking=0

	BugTrack(mob/PlayerTarget)
		set waitfor = 0
		BugTracking=1
		var/obj/Jutsu/Aburame/BugTracker/trackerImage = new/obj/Jutsu/Aburame/BugTracker(client)
		while((PlayerTarget in KonchuuList) && trackerImage && BugTracking)
			var
				mob_x = min(abs(x-PlayerTarget.x),64)
				mob_y = min(abs(y-PlayerTarget.y),64)
			if(x > PlayerTarget.x)
				mob_x = -mob_x
			if(y > PlayerTarget.y)
				mob_y = -mob_y

			if(abs(mob_x)==64||abs(mob_y)==64)
				trackerImage.icon_state="tracker_dir"
				if(mob_x==64)
					if(mob_y==64) trackerImage.dir=5
					else if(mob_y==-64) trackerImage.dir=6
					else trackerImage.dir=4
				else if(mob_x==-64)
					if(mob_y==64) trackerImage.dir=9
					else if(mob_y==-64) trackerImage.dir=10
					else trackerImage.dir=8
				else if(mob_y==64)
					trackerImage.dir=1
				else if(mob_y==-64)
					trackerImage.dir=2
			else
				trackerImage.icon_state="Bug_tracker"
			trackerImage.pixel_x = mob_x+16
			trackerImage.pixel_y = mob_y
			var/L="31:[trackerImage.pixel_x],17:[trackerImage.pixel_y]"
			trackerImage.screen_loc = "minimap:[L]"
			sleep(6)
		if(trackerImage)
			del(trackerImage)

obj/Jutsu/Aburame/BugTracker
	icon='Pointers.dmi'
	icon_state="Bug_tracker"
	layer=3
	New(client/c)
		screen_loc="minimap:31:16,17"
		if(c) c.screen+=src