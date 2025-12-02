mob/var/scentTracking=0
obj/SkillCards/Clan/Inuzuka/DynamicMarking
	icon_state="card_DynamicMarking"
	cmdstring="DynamicMarking"

	Seals = 2
	Range = 1
	Duration = 2
	Cooldown = 750
	CooldownCur = 250

	UpgradeChoices = list("Create Area Effect","Increase Duration","Increase Range")

	Description = list(
		"about"="Mark your opponent with urine so you can track their location."
		,"title"="Dynamic Marking"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='DynamicMarking.png'
		)

	Activate(mob/U)
		if(TAIATTACKCHECKSELF(U)) return
		if(U.CooldownCheck("DynamicMarking",(CooldownCur*U.cooldownmultiplier))) return
		U.MoveUses[name]++
		if(U.PracticeMode || ControlCheck(U)) return ..()
		for(var/mob/M in oviewers(Range,U))
			if(TAIATTACKCHECKYOU(M)||M.TreeStump) continue
			var/s=U.SS*Seals
			U.firing=1
			spawn(s)
				spawn(15)U.firing=0
				U.icon_state=null
				if(!U.DynamicMarkingList)
					U.DynamicMarkingList = list()

				if(U.DynamicMarkingList[M.trueName])
					U<<"You've already marked [M] recently."
				else
					U.DynamicMarkingList[M.trueName] = 1
					U<<"You have marked [M] with your scent."
					U.scentTracking=1;
					M<<"[U] splashed you with something..."
					U.DynamicMarkingCheck(M,Duration)
					usr.DynamicMarkingTrack(M)
			if(!AOE)
				break
		..()

mob/proc
	DynamicMarkingCheck(mob/M, C)
		set waitfor = 0
		var/TN = M.trueName
		for(var/count=1 to C)
			if(!M)
				break
			if(!DynamicMarkingList[TN]) break
			sleep(600)
		if(DynamicMarkingList[TN])
			DynamicMarkingList-=TN
			if(!DynamicMarkingList.len)
				scentTracking=0
		if(M)
			src<<"You can no longer track [M]'s scent.";  M<<"[src] can no longer follow your scent."

	DynamicMarkingTrack(mob/PlayerTarget)
		set waitfor = 0
		var/obj/Jutsu/Inuzuka/DynamicMarkingTracker/trackerImage = new/obj/Jutsu/Inuzuka/DynamicMarkingTracker(client)
		while(DynamicMarkingList[PlayerTarget.trueName] && trackerImage)
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
				trackerImage.icon_state="DynamicMarking_tracker"
			trackerImage.pixel_x = mob_x+16
			trackerImage.pixel_y = mob_y
			var/L="31:[trackerImage.pixel_x],17:[trackerImage.pixel_y]"
			trackerImage.screen_loc = "minimap:[L]"
			sleep(3)
		if(trackerImage)
			del(trackerImage)

obj/Jutsu/Inuzuka/DynamicMarkingTracker
	icon='Pointers.dmi'
	icon_state="DynamicMarking_tracker"
	layer=3
	New(client/c)
		screen_loc="minimap:31:16,17:5"
		if(c) c.screen+=src
