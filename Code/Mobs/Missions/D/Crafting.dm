mob/proc
	D_CraftingMission()
		if(!src.CraftMission) CraftingMission_one()

	CraftingMission_one()
		switch(input("How can I help?","Mission Man")as null|anything in list("I've completed this mission","What do I have to do?"))
			if("What do I have to do?") {src<<{"Mission Man: <i>"Craft a Kunai bring it back to me.</i>""}; src.Talking=0}
			if("I've completed this mission")
				src.Talking=0
				for(var/obj/Weapon/Wield/Kunai/K in src.contents)
					if(K.CraftedBy==Engrave(src)&&!K.worn)
						src<<"Mission Man: <i>\"Well done! Kunai received.</i>\""
						StatPoints+=2; src.StatUpdate_statpoints(); src<<"<b>Statpoint Earned!</b>"
						MissionD++; src.CraftMission=1; del(K)
						MissionPoints+=DMPREWARD
						MissionCount=(MissionD+MissionC+MissionB+MissionA+MissionS)
						UpdateInventory()
						break
					else if(K.worn)
						src<<{"Mission Man: <i>"You have it equipped.</i>""}
					else src<<{"Mission Man: <i>"You do not have a Kunai crafted by you that I can take.</i>""}
			else src.Talking=0