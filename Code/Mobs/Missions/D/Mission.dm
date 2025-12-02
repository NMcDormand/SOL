mob/var
	FishMission
	CraftMission
mob/proc
	D_Mission()
		var/missions=list("Feather Collection Mission","Garbage Collection Mission")
		if(src.FishMission<2) missions+="Fishing Mission"
		if(!src.CraftMission) missions+="Crafting Mission"
		switch(input("Select a mission","Mission Man")as null|anything in missions)
			if("Feather Collection Mission") src.FeatherMission()
			if("Garbage Collection Mission") src.GarbageMission()
			if("Fishing Mission") src.D_FishingMission()
			if("Crafting Mission") src.D_CraftingMission()
			else src.Talking=0