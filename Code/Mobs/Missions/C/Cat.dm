mob/proc
	CatMission()
		switch(input("How can I help?","Mission Man")in list("I've completed this mission","What do I have to do?","Cancel"))
			if("What do I have to do?")
				src<<{"Mission Man: <i>"Use the Cat Collar to locate the Cat on the minimap; find the cat and bring it back here.</i>""}
				var/obj/Item/CatCollar/C=locate(/obj/Item/CatCollar) in contents
				if(!(C in contents)) {src<<"Cat Collar added to <i>Items</i>"; C=new(src); UpdateInventory()}
				Talking=0
			if("I've completed this mission")
				var/obj/Item/Cat/C=locate(/obj/Item/Cat) in contents
				if(!(C in contents)) {src<<"You don't have any cat!"; return}
				src<<{"Mission Man: <i>"Well done! The Fuedal Lady will be most pleased! Here's 120 gold.</i>""}
				gold +=120; StatUpdate_gold()
				CatSP++; if(CatSP>=4) {CatSP=0; StatPoints+=4; StatUpdate_statpoints(); src<<"<b>Statpoints Earned!</b>"}
				MissionsComplete["C"]++; MissionsComplete["Total"]++
				MissionPoints+=CMPREWARD
				C.loc=null; UpdateInventory(); del(C)
				Talking=0
			else Talking=0