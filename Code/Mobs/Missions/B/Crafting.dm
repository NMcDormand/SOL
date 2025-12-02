mob/proc
	B_CraftingMission()
		if(src.CraftMission==3) CraftingMission_four()

	CraftingMission_four()
		switch(input("How can I help?","Mission Man")as null|anything in list("I've completed this mission","What do I have to do?"))
			if("What do I have to do?") {src<<{"Mission Man: <i>"Craft a Premium Rod and bring it to me.</i>""}; src.Talking=0}
			if("I've completed this mission")
				src.Talking=0
				for(var/obj/Item/rod/Rod3/K in src.contents)
					if(K.CraftedBy==Engrave(src)&&!K.worn)
						src<<"Mission Man: <i>\"Well done! Premium Rod received.</i>\""
						StatPoints+=20; src.StatUpdate_statpoints(); src<<"<b>Statpoints Earned!</b>"
						MissionC++; src.CraftMission=4; del(K)
						MissionPoints += CMPREWARD
						MissionCount=(MissionD+MissionC+MissionB+MissionA+MissionS)
						src.UpdateInventory()
						break
					else src<<{"Mission Man: <i>"You do not have a Premium Rod crafted by you that I can take.</i>""}
			else src.Talking=0