mob/proc
	C_CraftingMission()
		if(src.CraftMission==1) CraftingMission_two()
		if(src.CraftMission==2) CraftingMission_three()

	CraftingMission_two()
		switch(input("How can I help?","Mission Man")as null|anything in list("I've completed this mission","What do I have to do?"))
			if("What do I have to do?") {src<<{"Mission Man: <i>"Craft a Katana and bring it to me.</i>""}; src.Talking=0}
			if("I've completed this mission")
				src.Talking=0
				for(var/obj/Weapon/Wield/Katana/K in src.contents)
					if(K.CraftedBy==Engrave(src)&&!K.worn)
						src<<"Mission Man: <i>\"Well done! Katana received.</i>\""
						StatPoints+=5; src.StatUpdate_statpoints(); src<<"<b>Statpoints Earned!</b>"
						MissionC++; src.CraftMission=2; del(K)
						MissionPoints += CMPREWARD
						MissionCount=(MissionD+MissionC+MissionB+MissionA+MissionS)
						break
					else src<<{"Mission Man: <i>"You do not have a Katana crafted by you that I can take.</i>""}
			else src.Talking=0

	CraftingMission_three()
		switch(input("How can I help?","Mission Man")as null|anything in list("I've completed this mission","What do I have to do?"))
			if("What do I have to do?") {src<<{"Mission Man: <i>"Craft a Broad Sword and bring it to me.</i>""}; src.Talking=0}
			if("I've completed this mission")
				src.Talking=0
				for(var/obj/Weapon/Wield/BroadSword/K in src.contents)
					if(K.CraftedBy==Engrave(src)&&!K.worn)
						src<<"Mission Man: <i>\"Well done! Broad Sword received.</i>\""
						StatPoints+=10; src.StatUpdate_statpoints(); src<<"<b>Statpoints Earned!</b>"
						MissionC++; src.CraftMission=3; del(K)
						MissionPoints += CMPREWARD
						MissionCount=(MissionD+MissionC+MissionB+MissionA+MissionS)
						break
					else src<<{"Mission Man: <i>"You do not have a Broad Sword crafted by you that I can take.</i>""}
			else src.Talking=0