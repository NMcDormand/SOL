mob/proc
	B_Mission()
		var/list/missions=list("Bounty Mission")
		if(src.CraftMission>=3&&src.CraftMission<4) missions+="Crafting Mission"
		switch(input("Select a mission","Mission Man")as null|anything in missions)
			if("Bounty Mission") src.BountyMission()
			if("Crafting Mission") src.B_CraftingMission()
			else src.Talking=0