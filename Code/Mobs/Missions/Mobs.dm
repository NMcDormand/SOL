mob/NPC/Misc/MissionMen
	icon = 'MissionMan.dmi'
	name = "Mission Man"
	Action(mob/user)
		if(get_dist(user,src)>2) return
		if(user.Talking) return
		var/mob/player/Bruh = user
		if(Bruh.MissionCount >= 200 && !Bruh.MissionMedal)
			Bruh.MissionMedal++
			Bruh.Medal_MissionPossible()
		if(user.DeliverTo)
			if(user.Village==src.Village)
				switch(input("Do you want to abandon the Delivery?","Mission Man")as null|anything in list("Yes","No"))
					if("Yes")
						for(var/obj/Item/parcel/P in user.contents)
							if(P) {del(P)}
						user.DeliverWait=2; user.DeliverTo=null;

						user<<{"Mission Man: "<i>I'll take that parcel and get someone else to do the job.</i>""}; return
			if(user.DeliverTo==src.Village)
				user.Delivery_Mission_Complete(src); return
			else
				user<<{"Mission Man: "<i>That's not <u>my</u> parcel. You need to give it to the Mission Man in [user.DeliverTo].</i>""}; return
		if(user.Village!=src.Village)
			user<<"Mission Man: <i>I cannot assign missions to foreign ninjas.</i>"; return
		if(user.NinjaRank=="Academy Student")
			user<<"Mission Man: <i>Only proper ninjas may be assigned missions.</i>"; return
		else
			user.Talking=1
			//switch(input("Select a mission","Mission Man")in list("D Rank Mission","C Rank Mission","B Rank Mission","A Rank Mission","S Rank Mission","Never mind"))
			switch(src.Rank)
				if("D")
					if(!MobDistanceCheck(user,src))
						user.Talking=0
					else
						switch(alert("Hi, how can I help you?",,"Missions","Nothing"))
							if("Missions")
								user.D_Mission()
							if("nothing")
								usr.Talking=0
								return
				if("C")
					if(!MobDistanceCheck(user,src)) user.Talking=0
					else user.C_Mission(src)
				if("B")
					if(!MobDistanceCheck(user,src)) user.Talking=0
					else user.B_Mission()
				if("A")
					if(!MobDistanceCheck(user,src)) user.Talking=0
					else {user<<{"Mission Man: <i>"Sorry, but the only A rank mission available at the moment is the Sound 5 Quest, located just North of Leaf Village"</i>"}; user.Talking=0}
				if("S")
					if(!MobDistanceCheck(user,src)) user.Talking=0
					else if(user.KI_Banned) {user.RemoveBanFromKI()}
					else {user<<{"Mission Man: <i>"Unfortunately, all S Rank Missions are currently unavailable"</i>"}; user.Talking=0}
			user.Talking=0

	LeafMissionMen
		Village="Leaf"
		S_Rank
			Rank="S"
		A_Rank
			Rank="A"
		B_Rank
			Rank="B"
		C_Rank
			Rank="C"
		D_Rank
			Rank="D"

	RockMissionMan
		Village="Rock"
		S_Rank
			Rank="S"
		A_Rank
			Rank="A"
		B_Rank
			Rank="B"
		C_Rank
			Rank="C"
		D_Rank
			Rank="D"
	CloudMissionMan
		Village="Cloud"
		S_Rank
			Rank="S"
		A_Rank
			Rank="A"
		B_Rank
			Rank="B"
		C_Rank
			Rank="C"
		D_Rank
			Rank="D"
	MistMissionMan
		Village="Mist"
		S_Rank
			Rank="S"
		A_Rank
			Rank="A"
		B_Rank
			Rank="B"
		C_Rank
			Rank="C"
		D_Rank
			Rank="D"
	WaterfallMissionMan
		Village="Waterfall"
		S_Rank
			Rank="S"
		A_Rank
			Rank="A"
		B_Rank
			Rank="B"
		C_Rank
			Rank="C"
		D_Rank
			Rank="D"
	RainMissionMan
		Village="Rain"
		S_Rank
			Rank="S"
		A_Rank
			Rank="A"
		B_Rank
			Rank="B"
		C_Rank
			Rank="C"
		D_Rank
			Rank="D"
	GrassMissionMan
		Village="Grass"
		S_Rank
			Rank="S"
		A_Rank
			Rank="A"
		B_Rank
			Rank="B"
		C_Rank
			Rank="C"
		D_Rank
			Rank="D"
	SoundMissionMan
		Village="Sound"
		S_Rank
			Rank="S"
		A_Rank
			Rank="A"
		B_Rank
			Rank="B"
		C_Rank
			Rank="C"
		D_Rank
			Rank="D"
	SandMissionMan
		Village="Sand"
		S_Rank
			Rank="S"
		A_Rank
			Rank="A"
		B_Rank
			Rank="B"
		C_Rank
			Rank="C"
		D_Rank
			Rank="D"