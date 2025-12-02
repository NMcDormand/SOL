mob/proc
	GarbageMission()
		switch(input("How can I help?","Mission Man")as null|anything in list("I've completed this mission","What do I have to do?"))
			if("What do I have to do?")
				src<<{"Mission Man: <i>"Collect 30 items of garbage from local streams and waterways then come see me.</i>""}
				var/obj/Item/GarbageNet/G=locate(/obj/Item/GarbageNet) in src.contents
				if(!(G in src.contents)) {src<<"Garbage collection device added to <i>Items</i>"; G=new(src); UpdateInventory()}
				src.Talking=0
			if("I've completed this mission")
				var/m=src.MissionD
				check
				src.Talking=0
				for(var/obj/Item/Material/Garbage/g in src.contents)
					if(g.amount>=30)
						src.gold+=10; src.GarbageSP++; src.StatUpdate_gold()
						src.MissionD++; src.MissionCount=(src.MissionD+src.MissionC+src.MissionB+src.MissionA+src.MissionS)
						MissionPoints+=DMPREWARD
						g.amount-=30
						if(g.amount<=0) del(g)
						else g.Checkamount()
						UpdateInventory()
						goto check
					else if(src.MissionD>m) src<<{"Mission Man: <i>"Well done! Our waters are cleaner and you are richer.</i>""}
					else src<<{"Mission Man: <i>"Sorry, but you do have not collected enough.</i>""}
			else src.Talking=0