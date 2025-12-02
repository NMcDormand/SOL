var/
	CarriageDrivers = list()

mob/NPC/CarraigeDriver
	shadow=1
	name = "Carraige Driver"
	icon = 'Student.dmi'

	New()
		..()
		CarriageDrivers[Village] = src
	CD_Leaf
		Village="Leaf"
	CD_Waves
		Village="Waves"
	CD_Rain
		Village="Rain"
	CD_Rock
		Village="Rock"
	CD_Sand
		Village="Sand"
	CD_Grass
		Village="Grass"
	CD_Waterfall
		Village="Waterfall"
	CD_Sound
		Village="Sound"
	CD_Cloud
		Village="Cloud"
	CD_Mist
		Village="Mist"

	protect=1
	CantHenge=1
	stamina=10000

	Action(mob/user)
		if(!(user in range(2, src))) return
		if(user.DeliverTo) {user<<"Driver: <i>I'm sorry but I don't allow strange parcels on my cart</i>"; return}
		if(!MobDistanceCheck(user,src)) return

		var/
			goldReq = 50000
			rideDelay = 0

		// Let the user pick their carriage.
		var/carriageType = input("Which carriage would you like to take?","Carraige Driver")in list("Llama","Race Horse","The Legendary 3.6 Speed","The Necktus","Nevermind")
		switch(carriageType)
			if("Llama")
				goldReq = 0
				rideDelay = 600
			if("Race Horse")
				goldReq = 1000
				rideDelay = 300
			if("The Legendary 3.6 Speed")
				goldReq = 5000
				rideDelay = 100
			if("The Necktus")
				goldReq = 5000000
				rideDelay = 1
			if("Nevermind")
				return

		// Validate the user can afford the carriage they chose.
		if(user.gold<goldReq) {user<<"Driver: <i>I'm sorry but it costs [goldReq] gold to travel there via the [carriageType] carriage...</i>"; return}

		var/
			villageOptions = list()
			majorVillageOptions = list("Rock Village","Sand Village","Leaf Village","Cloud Village","Mist Village")
			minorVillageOptions = list("Rain Village","Grass Village","Waterfall Village","Sound Village","Waves Village")
			travelMessage="Where would you like to take the [carriageType] carriage? "

		// Determine the valid village options for the user to travel to.
		travelMessage += (carriageType == "Llama") ? "It's free." : "It only costs [goldReq] gold."

		// Determine the valid village options for the user to travel to.
		villageOptions = majorVillageOptions
		if(user.NinjaRank!="Academy Student") {villageOptions+=minorVillageOptions;}
		if(carriageType == "The Necktus") {villageOptions+="Narnia"}
		villageOptions+="Nevermind";
		villageOptions-=(src.Village + " Village");

		// Figure out which village the user would like to travel to.
		var/travelChoice = input(travelMessage,"Driver") in villageOptions

		// Narnia logic
		if(travelChoice == "Narnia") {
			user << "Taking the Necktus to Narnia are you? Best of luck brave soul!"
			user.gold-=goldReq; user.StatUpdate_gold()
			if(prob(1)) {
				user << "By a stroke of unbelievable luck almost as legendary as a neck - the Necktus has taken you to the chicken palace!"
				user.loc = locate(15, 11, 3)
				return
			} else if(prob(1)) {
				user << "By a stroke of unbelievable luck almost as legendary as a neck - the Necktus has taken you to the chakra caves!"
				user.loc = locate(45, 13, 3)
				return
			} else {
				user << "The necktus found you unworthy of travel to Narnia! Try again later."
				user.Kill(user)
				return
			}
		}

		// Normal figure out where you're going logic
		if(travelChoice == "Nevermind") { user << "No problem, have a good day!"; return}
		var/travelVillage = copytext(travelChoice, 1, findtext(travelChoice, " "))

		// Ensure the user has not an enemy of the village they're travelling to.
		var/hitLists = list("Leaf" = LeafHitList, "Rain" = RainHitList, "Rock" = RockHitList, "Sand" = SandHitList, "Grass" = GrassHitList, "Waterfall" = WaterfallHitList, "Sound" = SoundHitList, "Cloud" = CloudHitList, "Mist" = MistHitList)
		if(travelVillage != "Waves" && user in hitLists[travelVillage])
			user<<"Driver: <i>I'm afraid I can't take you; you're a wanted criminal there!</i>"
			return

		// If all is well, travel.
		user<<"Driver: <i>Climb aboard! We're headed for [travelVillage] Village!</i>"; user.gold-=goldReq; user.StatUpdate_gold()
		user.loc=locate(4,46,2); user.protect=1; user.canfindrocks=0; user.onmountain=0; user.onwater=0; user.onsand=0
		spawn(rideDelay)
			user.loc=CarriageDrivers[travelVillage].loc
			user.ZCoordVillage(travelVillage);
			user<<"Driver: <i>We've arrived at the [travelVillage] village!</i>"; user.protect=0; user.canfindrocks=1
