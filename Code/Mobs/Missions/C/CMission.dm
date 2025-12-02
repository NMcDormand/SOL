mob/proc
	C_Mission(mob/m)
		src.cantwalk++
		var/list/missions=list("Delivery Mission","Find the Fuedel Lady's Cat Mission")
		if(src.FishMission>=2&&src.FishMission<4) missions+="Fishing Mission"
		if(src.CraftMission>=1&&src.CraftMission<3) missions+="Crafting Mission"
		switch(input("Select a mission","Mission Man")as null|anything in missions)
			if("Delivery Mission")
				if(MobDistanceCheck(src,m)) src.DeliveryMission(m)
				else src.Talking=0
			if("Find the Fuedel Lady's Cat Mission") src.CatMission()
			if("Fishing Mission") src.C_FishingMission()
			if("Crafting Mission") src.C_CraftingMission()
			else src.Talking=0

		src.cantwalk--