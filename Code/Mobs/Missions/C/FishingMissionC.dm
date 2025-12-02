mob/proc
	C_FishingMission()
		if(src.FishMission==2) FishingMission_three()
		else if(src.FishMission==3) FishingMission_four()

	FishingMission_three()
		switch(input("How can I help?","Mission Man")as null|anything in list("I've completed this mission","What do I have to do?"))
			if("What do I have to do?") {src<<{"Mission Man: <i>"Collect 15 Large Fish and bring them back to me.</i>""}; src.Talking=0}
			if("I've completed this mission")
				src.Talking=0
				for(var/obj/Fish/Large/F in src.contents)
					if(F.amount>=15)
						var/g=F.price*15
						src<<{"Mission Man: <i>"Well done! Fish received. Here is [g] gold.</i>""}
						gold+=g; src.StatUpdate_gold()
						StatPoints++; ; src.StatUpdate_statpoints(); src<<"<b>Statpoint Earned!</b>"
						MissionC++; F.amount-=15; src.FishMission=3
						MissionPoints += CMPREWARD
						MissionCount=(MissionD+MissionC+MissionB+MissionA+MissionS)
						if(F.amount<=0) del(F)
						else F.Checkamount()
						UpdateInventory()
						break
					else src<<{"Mission Man: <i>"Sorry, but you do not have enough Large Fish.</i>""}
			else src.Talking=0

	FishingMission_four()
		switch(input("How can I help?","Mission Man")as null|anything in list("I've completed this mission","What do I have to do?"))
			if("What do I have to do?") {src<<{"Mission Man: <i>"Collect 10 Lava Fish and bring them back to me.</i>""}; src.Talking=0}
			if("I've completed this mission")
				src.Talking=0
				for(var/obj/Fish/Lava/F in src.contents)
					if(F.amount>=10)
						var/g=F.price*10
						src<<{"Mission Man: <i>"Well done! Fish received. Here is [g] gold.</i>""}
						gold+=g; src.StatUpdate_gold()
						StatPoints++; ; src.StatUpdate_statpoints(); src<<"<b>Statpoint Earned!</b>"
						MissionC++; F.amount-=10; src.FishMission=4
						MissionPoints += CMPREWARD
						MissionCount=(MissionD+MissionC+MissionB+MissionA+MissionS)
						if(F.amount<=0) del(F)
						else F.Checkamount()
						UpdateInventory()
						break
					else src<<{"Mission Man: <i>"Sorry, but you do not have enough Lava Fish.</i>""}
			else src.Talking=0