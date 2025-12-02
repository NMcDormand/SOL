mob/proc
	D_FishingMission()
		if(!src.FishMission) FishingMission_one()
		else if(src.FishMission==1) FishingMission_two()

	FishingMission_one()
		switch(input("How can I help?","Mission Man")as null|anything in list("I've completed this mission","What do I have to do?"))
			if("What do I have to do?") {src<<{"Mission Man: <i>"Collect 5 Small Fish and bring them back to me.</i>""}; src.Talking=0}
			if("I've completed this mission")
				src.Talking=0
				for(var/obj/Fish/Small/F in src.contents)
					if(F.amount>=5)
						var/g=F.price*20
						src<<{"Mission Man: <i>"Well done! Fish received. Here is [g] gold.</i>""}
						gold+=g; src.StatUpdate_gold()
						StatPoints++; src.StatUpdate_statpoints(); src<<"<b>Statpoint Earned!</b>"
						MissionD++; F.amount-=5; src.FishMission=1
						MissionPoints+=DMPREWARD
						MissionCount=(MissionD+MissionC+MissionB+MissionA+MissionS)
						if(F.amount<=0) del(F)
						else F.Checkamount()
						UpdateInventory()
						break
					else src<<{"Mission Man: <i>"Sorry, but you do not have enough Small Fish.</i>""}
			else src.Talking=0

	FishingMission_two()
		switch(input("How can I help?","Mission Man")as null|anything in list("I've completed this mission","What do I have to do?"))
			if("What do I have to do?") {src<<{"Mission Man: <i>"Collect 8 Medium Fish and bring them back to me.</i>""}; src.Talking=0}
			if("I've completed this mission")
				src.Talking=0
				for(var/obj/Fish/Medium/F in src.contents)
					if(F.amount>=8)
						var/g=F.price*40
						src<<{"Mission Man: <i>"Well done! Fish received. Here is [g] gold.</i>""}
						gold+=g; src.StatUpdate_gold()
						StatPoints++; src.StatUpdate_statpoints(); src<<"<b>Statpoint Earned!</b>"
						MissionD++; F.amount-=8; src.FishMission=2
						MissionCount=(MissionD+MissionC+MissionB+MissionA+MissionS)
						if(F.amount<=0) del(F)
						else F.Checkamount()
						UpdateInventory()
						break
					else src<<{"Mission Man: <i>"Sorry, but you do not have enough Medium Fish.</i>""}
			else src.Talking=0