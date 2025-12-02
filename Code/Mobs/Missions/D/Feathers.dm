mob
	proc
		FeatherMission()
			var/requiredFeathers=60
			switch(input("How can I help?","Mission Man")as null|anything in list("I've completed this mission","What do I have to do?"))
				if("What do I have to do?") {src<<{"Mission Man: <i>"Collect [requiredFeathers] Feathers and bring them back to me.</i>""}; src.Talking=0}
				if("I've completed this mission")
					src.Talking=0
					var/obj/Item/Material/Feather/F = locate() in src.contents
					if(!F)
						src << "Nope"
					var/fTimes = (F.amount-(F.amount % requiredFeathers)) / requiredFeathers
					if(F.amount>=(requiredFeathers*2))
						var/fInput = input("You can complete this mission [fTimes] times with those feathers! How many would you like to complete?","Feather Mission") as num
						var/decimal = fInput - round(fInput)
						if(decimal!=0) fInput -= decimal
						if(fInput<1) fInput=1; //Set to one otherwise it GIVES feathers if negative
						if(F.loc != src || !F)
							src<<"The Machine: Hmm i wonder where those feathers went"
							return
						if((fInput*requiredFeathers)<=F.amount)
							F.amount-=(fInput*requiredFeathers)
							awardFeathers(fInput)
						else
							src<<{"Mission Man: <i>"Sorry, but you do not have enough Feathers.</i>""}
					else if(F.amount>=requiredFeathers)
						F.amount-=requiredFeathers
						awardFeathers(1)
					else
						src<<{"Mission Man: <i>"Sorry, but you do not have enough Feathers.</i>""}
					UpdateInventory()
				else src.Talking=0

		awardFeathers(times=1)
			if(times<1) return
			var/awardGold = 70
			src<<{"Mission Man: <i>"Well done! Feathers received. Here is [awardGold*times] gold.</i>""}
			while(times)
				gold += awardGold; StatUpdate_gold()
				FeathersSP++;
				if(FeathersSP>=4) {FeathersSP=0; StatPoints+=3; ; StatUpdate_statpoints(); src<<"<b>Statpoints Earned!</b>"}
				MissionD++;
				MissionPoints+=DMPREWARD
				times--
				sleep(1)

			MissionCount=(MissionD+MissionC+MissionB+MissionA+MissionS)
			UpdateInventory()