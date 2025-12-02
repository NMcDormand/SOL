mob/proc/DeliveryTimeout(var/missions)
	spawn(600)
		if(DeliverTo!=null&&MissionsComplete["C"]==missions) src<<"<b>4 minutes remain</b>"
	spawn(1200)
		if(DeliverTo!=null&&MissionsComplete["C"]==missions) src<<"<b>3 minutes remain</b>"
	spawn(1800)
		if(DeliverTo!=null&&MissionsComplete["C"]==missions) src<<"<b>2 minute remains</b>"
	spawn(2400)
		if(DeliverTo!=null&&MissionsComplete["C"]==missions) src<<"<b>1 minute remains</b>"
	spawn(2900)
		if(DeliverTo!=null&&MissionsComplete["C"]==missions) src<<"<b>Only 10 seconds remain!!</b>"
	spawn(2950)
		if(DeliverTo!=null&&MissionsComplete["C"]==missions) src<<"<b>5</b>"
	spawn(2960)
		if(DeliverTo!=null&&MissionsComplete["C"]==missions) src<<"<b>4</b>"
	spawn(2970)
		if(DeliverTo!=null&&MissionsComplete["C"]==missions) src<<"<b>3</b>"
	spawn(2980)
		if(DeliverTo!=null&&MissionsComplete["C"]==missions) src<<"<b>2</b>"
	spawn(2990)
		if(DeliverTo!=null&&MissionsComplete["C"]==missions) src<<"<b>1</b>"
	spawn(3000)
		if(DeliverTo!=null&&MissionsComplete["C"]==missions)
			for(var/obj/Item/parcel/P in contents) del(P)
			src<<"<font size=2><b>You were too slow to deliver the parcel!</b></font>"; DeliverTo=null; UpdateInventory()

//-------------------------------------------------------------------------------------------------------------
mob/proc
	DeliveryMission()
		CantWalk++
		if(DeliverTo) {Talking=0; CantWalk--; return}
		if(DeliverWait)
			src<<{"Mission Man: "<i>We don't have any packages to deliver right now.</i>""};
			Talking=0;
			CantWalk--
			return
		if(NinjaRank=="Academy Student")
			src<<{"Mission Man: "<i>You must be at least Genin rank for this mission.</i>""}; Talking=0;CantWalk--;
		else
			switch(pick(1,2,3,4,5,6,7,8,9))
				if(1)
					if(Village=="Leaf")
						alert("I want you to deliver this parcel to the Mission Man in the Village Hidden in Grass. However, you must do it within 5 minutes.","Mission Man")
						DeliverTo="Grass"
					else
						alert("I want you to deliver this parcel to the Mission Man in the Village Hidden in Leaf. However, you must do it within 5 minutes.","Mission Man")
						DeliverTo="Leaf"
				if(2)
					if(Village=="Grass")
						alert("I want you to deliver this parcel to the Mission Man in the Village Hidden in Rocks. However, you must do it within 5 minutes.","Mission Man")
						DeliverTo="Rock"
					else
						alert("I want you to deliver this parcel to the Mission Man in the Village Hidden in Grass. However, you must do it within 5 minutes.","Mission Man")
						DeliverTo="Grass"
				if(3)
					if(Village=="Rock")
						alert("I want you to deliver this parcel to the Mission Man in the Village Hidden in Rain. However, you must do it within 5 minutes.","Mission Man")
						DeliverTo="Rain"
					else
						alert("I want you to deliver this parcel to the Mission Man in the Village Hidden in Rocks. However, you must do it within 5 minutes.","Mission Man")
						DeliverTo="Rock"
				if(4)
					if(Village=="Rain")
						alert("I want you to deliver this parcel to the Mission Man in the Village Hidden in Sand. However, you must do it within 5 minutes.","Mission Man")
						DeliverTo="Sand"
					else
						alert("I want you to deliver this parcel to the Mission Man in the Village Hidden in Rain. However, you must do it within 5 minutes.","Mission Man")
						DeliverTo="Rain"
				if(5)
					if(Village=="Sand")
						alert("I want you to deliver this parcel to the Mission Man in the Village Hidden in Waterfall. However, you must do it within 5 minutes.","Mission Man")
						DeliverTo="Waterfall"
					else
						alert("I want you to deliver this parcel to the Mission Man in the Village Hidden in Sand. However, you must do it within 5 minutes.","Mission Man")
						DeliverTo="Sand"
				if(6)
					if(Village=="Waterfall")
						alert("I want you to deliver this parcel to the Mission Man in the Village Hidden in Sound. However, you must do it within 5 minutes.","Mission Man")
						DeliverTo="Sound"
					else
						alert("I want you to deliver this parcel to the Mission Man in the Village Hidden in Waterfall. However, you must do it within 5 minutes.","Mission Man")
						DeliverTo="Waterfall"
				if(7)
					if(Village=="Sound")
						alert("I want you to deliver this parcel to the Mission Man in the Village Hidden in Cloud. However, you must do it within 5 minutes.","Mission Man")
						DeliverTo="Cloud"
					else
						alert("I want you to deliver this parcel to the Mission Man in the Village Hidden in Sound. However, you must do it within 5 minutes.","Mission Man")
						DeliverTo="Sound"
				if(8)
					if(Village=="Cloud")
						alert("I want you to deliver this parcel to the Mission Man in the Village Hidden in Mist. However, you must do it within 5 minutes.","Mission Man")
						DeliverTo="Mist"
					else
						alert("I want you to deliver this parcel to the Mission Man in the Village Hidden in Cloud. However, you must do it within 5 minutes.","Mission Man")
						DeliverTo="Cloud"
				if(9)
					if(Village=="Mist")
						alert("I want you to deliver this parcel to the Mission Man in the Village Hidden in Leaves. However, you must do it within 5 minutes.","Mission Man")
						DeliverTo="Leaf"
					else
						alert("I want you to deliver this parcel to the Mission Man in the Village Hidden in Mist. However, you must do it within 5 minutes.","Mission Man")
						DeliverTo="Mist"
			Talking=0
			CantWalk--; new/obj/Item/parcel(src); UpdateInventory()
			src<<{"Mission Man: <i>"Hurry and take it to [DeliverTo] Village!</i>""}; src<<"<b>5 minutes remain</b>."
			spawn(50) DeliveryTimeout(MissionsComplete["C"])

	Delivery_Mission_Complete(mob/M)
		if(DeliverTo==M.Village)
			var/reward=1000
			if(Village=="Mist") {reward*=1.5}
			DeliverTo=null
			DeliverWait=1;
			for(var/obj/Item/parcel/P in contents) del(P)
			UpdateInventory()
			src<<{"Mission Man: "<i>Mission Man: Parcel delivered on time; well done!.</i>""}
			src<<"<b>Received [reward] gold!</b>"
			DeliverySP++;
			AwardVP(0.25)
			if(DeliverySP>=3) {DeliverySP=0; StatPoints+=9; StatUpdate_statpoints(); src<<"<center><b>* You have been rewarded 9 Stat Points *</b></center>"}
			gold+=reward
			MissionPoints += CMPREWARD
			StatUpdate_gold()
			MissionsComplete["CurDelivery"]++
			var/RM = round(MissionsComplete["CurDelivery"])
			if(RM)
				MissionsComplete["CurDelivery"] -= RM
				MissionsComplete["Delivery"] += RM
				MissionsComplete["Cur"] += RM
				MissionsComplete["C"] += RM
				MissionsComplete["Total"] += RM
				MissionPoints += CMPREWARD * RM

				var/Comped=0
				while(MissionsComplete["Cur"]>=5)
					MissionsComplete["Cur"]-=5
					Comped++
				if(Comped)
					AwardVP(1 * Comped)
					Comped *= 2
					StatPoints += Comped
					StatPointsObtained["MisReward"] += Comped
					StatPointsObtained["Total"] += Comped
					StatUpdate_statpoints()
					src<<"<center><b>* You have been rewarded [Comped] Stat Points *</b></center>"