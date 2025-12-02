var
	list
		Villages = list("Cloud", "Leaf", "Mist", "Rock","Sand", "Grass", "Rain", "Sound", "Waterfall")

		VillagePoints = list(
			"Cloud" = 0, "Leaf" = 0, "Mist" = 0, "Rock" = 0,
			"Sand" = 0, "Grass" = 0, "Rain" = 0, "Sound" = 0, "Waterfall" = 0
		)

		ElligibleKageList = list(
			"Cloud" = list(), "Leaf" = list(), "Mist" = list(), "Rock" = list(),
			"Sand" = list(), "Grass" = list(), "Rain" = list(), "Sound" = list(), "Waterfall" = list()
		)

		KageList = list(
			"Cloud" = list(), "Leaf" = list(), "Mist" = list(), "Rock" = list(),
			"Sand" = list(), "Grass" = list(), "Rain" = list(), "Sound" = list(), "Waterfall" = list()
		)

		KageLastLogged = list()

		KageTimeOut = list()

		KageCurrent = list(
			"Cloud" = 0, "Leaf" = 0, "Mist" = 0, "Rock" = 0,
			"Sand" = 0, "Grass" = 0, "Rain" = 0, "Sound" = 0, "Waterfall" = 0
		)

		KageTemp = list(
			"Cloud" = 0, "Leaf" = 0, "Mist" = 0, "Rock" = 0,
			"Sand" = 0, "Grass" = 0, "Rain" = 0, "Sound" = 0, "Waterfall" = 0
		)

		KageMob = list(
			"Cloud" = 0, "Leaf" = 0, "Mist" = 0, "Rock" = 0,
			"Sand" = 0, "Grass" = 0, "Rain" = 0, "Sound" = 0, "Waterfall" = 0
		)

proc
	CheckKageTimes()
		for(var/V in KageLastLogged)
			if((world.realtime - KageLastLogged[V]) / 864000 > 2)
				KageTimeOut[V] = 1

	OffenseOutput(OFFENSE,other,village)
		if(!OFFENSE)
			OFFENSE="failed as a kage"

		switch(OFFENSE)
			if("suicide") return "have been killed"
			if("homicide") return "were assassinated by [other] from the [village] Village"
			if("murder") return "killed [other], a ninja from [village] Village"
			if("duties") return "failed to protect the [village] Village"
			if("assassination") return "assassinated the current kage"
			if("timeout") return "went missing"

	LoadKages()
		if(fexists("Data/Wipe/Kages.sav"))
			var/savefile/F = new ("Data/Wipe/Kages.sav")
			F["VillagePoints"] >> VillagePoints

			F["ElligibleKageList"] >> ElligibleKageList
			F["KageList"] >> KageList
			F["KageCurrent"] >> KageCurrent
			F["KageTemp"] >> KageTemp
			if(!KageTemp)
				KageTemp = list(
			"Cloud" = 0, "Leaf" = 0, "Mist" = 0, "Rock" = 0,
			"Sand" = 0, "Grass" = 0, "Rain" = 0, "Sound" = 0, "Waterfall" = 0
			)

			F["KageLastLogged"] >> KageLastLogged
			F["KageTimeOut"] >> KageTimeOut

			F["TaiBoost"] >> TaiBoost
			F["NinBoost"] >> NinBoost
			F["GenBoost"] >> GenBoost
			F["StamBoost"] >> StamBoost
			F["ChakBoost"] >> ChakBoost
			F["SkillBoost"] >> SkillBoost
			F["PEBoost"] >> PEBoost
			F["SEBoost"] >> SEBoost
			F["RFXBoost"] >> RFXBoost

	SaveKages()
		if(TotalSavePrevention) return
		var/savefile/F = new("Data/Wipe/Kages.sav")
		F["VillagePoints"] << VillagePoints

		F["ElligibleKageList"] << ElligibleKageList
		F["KageList"] << KageList
		F["KageCurrent"] << KageCurrent
		F["KageTemp"] << KageTemp

		F["KageLastLogged"] << KageLastLogged
		F["KageTimeOut"] << KageTimeOut

		F["TaiBoost"] << TaiBoost
		F["NinBoost"] << NinBoost
		F["GenBoost"] << GenBoost
		F["StamBoost"] << StamBoost
		F["ChakBoost"] << ChakBoost
		F["SkillBoost"] << SkillBoost
		F["PEBoost"] << PEBoost
		F["SEBoost"] << SEBoost
		F["RFXBoost"] << RFXBoost

	CheckForKages(Vi)
		CheckKageTimes()
		if(!Vi)
			for(var/V in KageCurrent)
				var/mob/KK = KageMob[V]
				if(!KageCurrent[V] || KK && KK.TempKage || KageTimeOut[KageCurrent[V]])
					var/best=0
					var/mob/K
					for(var/m in ElligibleKageList[V])
						if(ismob(ElligibleKageList[V][m]))
							var/mob/PL = ElligibleKageList[V][m]
							if(PL.KageBlocked)
								if(PL.KageBlocked < world.time)
									PL.KageBlocked = 0
								else
									continue
							if(PL.KageScore > best)
								K = PL
								best = PL.KageScore
					if(K)
						K.AssignKageRank(V)
					else if(KageList[V].len)
						if(!KK)
							SetTempKage(V)
		else
			var/mob/KK = KageMob[Vi]
			if(!KageCurrent[Vi] || KK && KK.TempKage || KageTimeOut[KageCurrent[Vi]])
				var/best=0
				var/mob/K
				for(var/m in ElligibleKageList[Vi])
					if(ismob(ElligibleKageList[Vi][m]))
						var/mob/PL = ElligibleKageList[Vi][m]
						if(PL.KageScore > best)
							K = PL
							best = PL.KageScore
				if(K)
					K.AssignKageRank(Vi)
				else if(KageList[Vi].len && !KK)
					SetTempKage(Vi)

	SetTempKage(V)
		var/mob/NK
		var/CS = 0
		var/list/VPList = list()
		for(var/mob/M in MasterPlayerList)
			if(M.Village == V)
				VPList += M
				if(M.BeenKage && !M.DisgracedKage && M.KageBlocked < world.time)
					if(M.KageScore > CS)
						NK = M
						CS = M.KageScore
		if(NK)
			world << "[NK.trueName], the [NK.DaimeCheck()] of the [V] village, has been named the Interim Leader"
			NK.verbs += typesof(/mob/VerbHolder/Kage2/verb)
			KageCurrent[V] = NK.trueName
			KageTemp[V] = 1
			KageMob[V] = NK
			NK.TempKage = 1
		else
			for(var/mob/M in VPList)
				M << "No suitable Leader was found, as such the [V] Village has no current Leader"
			KageCurrent[V] = 0
			KageMob[V] = 0

var/list
	MasterKageList
	KageNumber
	TheCurrentKage
	WorldKageNumber

mob
	var
		BeenKage = 0
		DisgracedKage = 0
		KageScore = 0
		KageDeaths = 0
		tmp/TempKage = 0
		tmp/VPEarned = 0
		tmp/KageVPNeeded = 0
		KageVPFailed = 0
		VPEject = 0
		Kage = 0
		KageBlocked = 0
		list/KageDA = list()

	proc
	//Hat
		kageHat(giving)
			set waitfor = 0
			if(giving)
				var/NH = text2path("/obj/Clothing/Head/KageHat/[Village]")
				new NH(src)
			else
				for(var/obj/Clothing/Head/KageHat/H in src)
					overlays -= H.Overlay
					del H
			UpdateInventory()

	//Village Points
		AwardVP(AMOUNT)
			if(!(AMOUNT)) AMOUNT=1
			var/K=KageCurrent[Village]
			if(K)
				src<<"<b>You earned an extra [AMOUNT] Village Point/s for [Village] under [K]'s leadership!</b>\nThese can be spent on your stat boosts by your leader [K]."
			else
				src<<"<b>You earned an extra [AMOUNT] Village Point/s for [Village]</b>\nThese can be spent on your stat boosts by a Village Leader."
			VillagePoints[Village] += AMOUNT
			VPEarned += AMOUNT

		Setup_VP_Screen()
			if(!client) return
			var/c
			/*
			switch(Village)
				if("Cloud") {c="#fee768"; winset(src,null,"VillagePoints.image=['VillagePoints_Cloud.png']; VillagePoints.L_stam.image=['Cloud_Left.png']; VillagePoints.L_chakra.image=['Cloud_Left.png']; VillagePoints.L_nin.image=['Cloud_Left.png']; VillagePoints.L_tai.image=['Cloud_Left.png']; VillagePoints.L_gen.image=['Cloud_Left.png']; VillagePoints.L_PE.image=['Cloud_Left.png']; VillagePoints.L_SE.image=['Cloud_Left.png']; VillagePoints.L_skills.image=['Cloud_Left.png']; VillagePoints.L_rfx.image=['Cloud_Left.png']; VillagePoints.R_stam.image=['Cloud_Right.png']; VillagePoints.R_chakra.image=['Cloud_Right.png']; VillagePoints.R_nin.image=['Cloud_Right.png']; VillagePoints.R_tai.image=['Cloud_Right.png']; VillagePoints.R_gen.image=['Cloud_Right.png']; VillagePoints.R_PE.image=['Cloud_Right.png']; VillagePoints.R_SE.image=['Cloud_Right.png']; VillagePoints.R_skills.image=['Cloud_Right.png']; VillagePoints.R_rfx.image=['Cloud_Right.png']")}
				if("Leaf") {c="#740000"; winset(src,null,"VillagePoints.image=['VillagePoints_Leaf.png']; VillagePoints.L_stam.image=['Leaf_Left.png']; VillagePoints.L_chakra.image=['Leaf_Left.png']; VillagePoints.L_nin.image=['Leaf_Left.png']; VillagePoints.L_tai.image=['Leaf_Left.png']; VillagePoints.L_gen.image=['Leaf_Left.png']; VillagePoints.L_PE.image=['Leaf_Left.png']; VillagePoints.L_SE.image=['Leaf_Left.png']; VillagePoints.L_skills.image=['Leaf_Left.png']; VillagePoints.L_rfx.image=['Leaf_Left.png']; VillagePoints.R_stam.image=['Leaf_Right.png']; VillagePoints.R_chakra.image=['Leaf_Right.png']; VillagePoints.R_nin.image=['Leaf_Right.png']; VillagePoints.R_tai.image=['Leaf_Right.png']; VillagePoints.R_gen.image=['Leaf_Right.png']; VillagePoints.R_PE.image=['Leaf_Right.png']; VillagePoints.R_SE.image=['Leaf_Right.png']; VillagePoints.R_skills.image=['Leaf_Right.png']; VillagePoints.R_rfx.image=['Leaf_Right.png']")}
				if("Mist") {c="#006cff"; winset(src,null,"VillagePoints.image=['VillagePoints_Mist.png']; VillagePoints.L_stam.image=['Mist_Left.png']; VillagePoints.L_chakra.image=['Mist_Left.png']; VillagePoints.L_nin.image=['Mist_Left.png']; VillagePoints.L_tai.image=['Mist_Left.png']; VillagePoints.L_gen.image=['Mist_Left.png']; VillagePoints.L_PE.image=['Mist_Left.png']; VillagePoints.L_SE.image=['Mist_Left.png']; VillagePoints.L_skills.image=['Mist_Left.png']; VillagePoints.L_rfx.image=['Mist_Left.png']; VillagePoints.R_stam.image=['Mist_Right.png']; VillagePoints.R_chakra.image=['Mist_Right.png']; VillagePoints.R_nin.image=['Mist_Right.png']; VillagePoints.R_tai.image=['Mist_Right.png']; VillagePoints.R_gen.image=['Mist_Right.png']; VillagePoints.R_PE.image=['Mist_Right.png']; VillagePoints.R_SE.image=['Mist_Right.png']; VillagePoints.R_skills.image=['Mist_Right.png']; VillagePoints.R_rfx.image=['Mist_Right.png']")}
				if("Rock") {c="#563500"; winset(src,null,"VillagePoints.image=['VillagePoints_Rock.png']; VillagePoints.L_stam.image=['Rock_Left.png']; VillagePoints.L_chakra.image=['Rock_Left.png']; VillagePoints.L_nin.image=['Rock_Left.png']; VillagePoints.L_tai.image=['Rock_Left.png']; VillagePoints.L_gen.image=['Rock_Left.png']; VillagePoints.L_PE.image=['Rock_Left.png']; VillagePoints.L_SE.image=['Rock_Left.png']; VillagePoints.L_skills.image=['Rock_Left.png']; VillagePoints.L_rfx.image=['Rock_Left.png']; VillagePoints.R_stam.image=['Rock_Right.png']; VillagePoints.R_chakra.image=['Rock_Right.png']; VillagePoints.R_nin.image=['Rock_Right.png']; VillagePoints.R_tai.image=['Rock_Right.png']; VillagePoints.R_gen.image=['Rock_Right.png']; VillagePoints.R_PE.image=['Rock_Right.png']; VillagePoints.R_SE.image=['Rock_Right.png']; VillagePoints.R_skills.image=['Rock_Right.png']; VillagePoints.R_rfx.image=['Rock_Right.png']")}
				if("Sand") {c="#d68800"; winset(src,null,"VillagePoints.image=['VillagePoints_Sand.png']; VillagePoints.L_stam.image=['Sand_Left.png']; VillagePoints.L_chakra.image=['Sand_Left.png']; VillagePoints.L_nin.image=['Sand_Left.png']; VillagePoints.L_tai.image=['Sand_Left.png']; VillagePoints.L_gen.image=['Sand_Left.png']; VillagePoints.L_PE.image=['Sand_Left.png']; VillagePoints.L_SE.image=['Sand_Left.png']; VillagePoints.L_skills.image=['Sand_Left.png']; VillagePoints.L_rfx.image=['Sand_Left.png']; VillagePoints.R_stam.image=['Sand_Right.png']; VillagePoints.R_chakra.image=['Sand_Right.png']; VillagePoints.R_nin.image=['Sand_Right.png']; VillagePoints.R_tai.image=['Sand_Right.png']; VillagePoints.R_gen.image=['Sand_Right.png']; VillagePoints.R_PE.image=['Sand_Right.png']; VillagePoints.R_SE.image=['Sand_Right.png']; VillagePoints.R_skills.image=['Sand_Right.png']; VillagePoints.R_rfx.image=['Sand_Right.png']")}
				if("Grass") {c="#91aa33"; winset(src,null,"VillagePoints.image=['VillagePoints_Grass.png']; VillagePoints.L_stam.image=['Grass_Left.png']; VillagePoints.L_chakra.image=['Grass_Left.png']; VillagePoints.L_nin.image=['Grass_Left.png']; VillagePoints.L_tai.image=['Grass_Left.png']; VillagePoints.L_gen.image=['Grass_Left.png']; VillagePoints.L_PE.image=['Grass_Left.png']; VillagePoints.L_SE.image=['Grass_Left.png']; VillagePoints.L_skills.image=['Grass_Left.png']; VillagePoints.L_rfx.image=['Grass_Left.png']; VillagePoints.R_stam.image=['Grass_Right.png']; VillagePoints.R_chakra.image=['Grass_Right.png']; VillagePoints.R_nin.image=['Grass_Right.png']; VillagePoints.R_tai.image=['Grass_Right.png']; VillagePoints.R_gen.image=['Grass_Right.png']; VillagePoints.R_PE.image=['Grass_Right.png']; VillagePoints.R_SE.image=['Grass_Right.png']; VillagePoints.R_skills.image=['Grass_Right.png']; VillagePoints.R_rfx.image=['Grass_Right.png']")}
				if("Sound") {c="#800040"; winset(src,null,"VillagePoints.image=['VillagePoints_Sound.png']; VillagePoints.L_stam.image=['Sound_Left.png']; VillagePoints.L_chakra.image=['Sound_Left.png']; VillagePoints.L_nin.image=['Sound_Left.png']; VillagePoints.L_tai.image=['Sound_Left.png']; VillagePoints.L_gen.image=['Sound_Left.png']; VillagePoints.L_PE.image=['Sound_Left.png']; VillagePoints.L_SE.image=['Sound_Left.png']; VillagePoints.L_skills.image=['Sound_Left.png']; VillagePoints.L_rfx.image=['Sound_Left.png']; VillagePoints.R_stam.image=['Sound_Right.png']; VillagePoints.R_chakra.image=['Sound_Right.png']; VillagePoints.R_nin.image=['Sound_Right.png']; VillagePoints.R_tai.image=['Sound_Right.png']; VillagePoints.R_gen.image=['Sound_Right.png']; VillagePoints.R_PE.image=['Sound_Right.png']; VillagePoints.R_SE.image=['Sound_Right.png']; VillagePoints.R_skills.image=['Sound_Right.png']; VillagePoints.R_rfx.image=['Sound_Right.png']")}
				if("Rain") {c="#77DDFF"; winset(src,null,"VillagePoints.image=['VillagePoints_Rain.png']; VillagePoints.L_stam.image=['Rain_Left.png']; VillagePoints.L_chakra.image=['Rain_Left.png']; VillagePoints.L_nin.image=['Rain_Left.png']; VillagePoints.L_tai.image=['Rain_Left.png']; VillagePoints.L_gen.image=['Rain_Left.png']; VillagePoints.L_PE.image=['Rain_Left.png']; VillagePoints.L_SE.image=['Rain_Left.png']; VillagePoints.L_skills.image=['Rain_Left.png']; VillagePoints.L_rfx.image=['Rain_Left.png']; VillagePoints.R_stam.image=['Rain_Right.png']; VillagePoints.R_chakra.image=['Rain_Right.png']; VillagePoints.R_nin.image=['Rain_Right.png']; VillagePoints.R_tai.image=['Rain_Right.png']; VillagePoints.R_gen.image=['Rain_Right.png']; VillagePoints.R_PE.image=['Rain_Right.png']; VillagePoints.R_SE.image=['Rain_Right.png']; VillagePoints.R_skills.image=['Rain_Right.png']; VillagePoints.R_rfx.image=['Rain_Right.png']")}
				if("Waterfall") {c="#a2a2c8"; winset(src,null,"VillagePoints.image=['VillagePoints_Waterfall.png']; VillagePoints.L_stam.image=['Waterfall_Left.png']; VillagePoints.L_chakra.image=['Waterfall_Left.png']; VillagePoints.L_nin.image=['Waterfall_Left.png']; VillagePoints.L_tai.image=['Waterfall_Left.png']; VillagePoints.L_gen.image=['Waterfall_Left.png']; VillagePoints.L_PE.image=['Waterfall_Left.png']; VillagePoints.L_SE.image=['Waterfall_Left.png']; VillagePoints.L_skills.image=['Waterfall_Left.png']; VillagePoints.L_rfx.image=['Waterfall_Left.png']; VillagePoints.R_stam.image=['Waterfall_Right.png']; VillagePoints.R_chakra.image=['Waterfall_Right.png']; VillagePoints.R_nin.image=['Waterfall_Right.png']; VillagePoints.R_tai.image=['Waterfall_Right.png']; VillagePoints.R_gen.image=['waterfall_Right.png']; VillagePoints.R_PE.image=['Waterfall_Right.png']; VillagePoints.R_SE.image=['waterfall_Right.png']; VillagePoints.R_skills.image=['waterfall_Right.png']; VillagePoints.R_rfx.image=['waterfall_Right.png']")}
			*/
			switch(Village)
				if("Cloud") {c="#fee768"; winset(src,null,"VillagePoints.image=['VillagePoints_Cloud.png']; VillagePoints.R_stam.image=['Cloud_Right.png']; VillagePoints.R_chakra.image=['Cloud_Right.png']; VillagePoints.R_nin.image=['Cloud_Right.png']; VillagePoints.R_tai.image=['Cloud_Right.png']; VillagePoints.R_gen.image=['Cloud_Right.png']; VillagePoints.R_PE.image=['Cloud_Right.png']; VillagePoints.R_SE.image=['Cloud_Right.png']; VillagePoints.R_skills.image=['Cloud_Right.png']; VillagePoints.R_rfx.image=['Cloud_Right.png']")}
				if("Leaf") {c="#740000"; winset(src,null,"VillagePoints.image=['VillagePoints_Leaf.png']; VillagePoints.R_stam.image=['Leaf_Right.png']; VillagePoints.R_chakra.image=['Leaf_Right.png']; VillagePoints.R_nin.image=['Leaf_Right.png']; VillagePoints.R_tai.image=['Leaf_Right.png']; VillagePoints.R_gen.image=['Leaf_Right.png']; VillagePoints.R_PE.image=['Leaf_Right.png']; VillagePoints.R_SE.image=['Leaf_Right.png']; VillagePoints.R_skills.image=['Leaf_Right.png']; VillagePoints.R_rfx.image=['Leaf_Right.png']")}
				if("Mist") {c="#006cff"; winset(src,null,"VillagePoints.image=['VillagePoints_Mist.png']; VillagePoints.R_stam.image=['Mist_Right.png']; VillagePoints.R_chakra.image=['Mist_Right.png']; VillagePoints.R_nin.image=['Mist_Right.png']; VillagePoints.R_tai.image=['Mist_Right.png']; VillagePoints.R_gen.image=['Mist_Right.png']; VillagePoints.R_PE.image=['Mist_Right.png']; VillagePoints.R_SE.image=['Mist_Right.png']; VillagePoints.R_skills.image=['Mist_Right.png']; VillagePoints.R_rfx.image=['Mist_Right.png']")}
				if("Rock") {c="#563500"; winset(src,null,"VillagePoints.image=['VillagePoints_Rock.png']; VillagePoints.R_stam.image=['Rock_Right.png']; VillagePoints.R_chakra.image=['Rock_Right.png']; VillagePoints.R_nin.image=['Rock_Right.png']; VillagePoints.R_tai.image=['Rock_Right.png']; VillagePoints.R_gen.image=['Rock_Right.png']; VillagePoints.R_PE.image=['Rock_Right.png']; VillagePoints.R_SE.image=['Rock_Right.png']; VillagePoints.R_skills.image=['Rock_Right.png']; VillagePoints.R_rfx.image=['Rock_Right.png']")}
				if("Sand") {c="#d68800"; winset(src,null,"VillagePoints.image=['VillagePoints_Sand.png']; VillagePoints.R_stam.image=['Sand_Right.png']; VillagePoints.R_chakra.image=['Sand_Right.png']; VillagePoints.R_nin.image=['Sand_Right.png']; VillagePoints.R_tai.image=['Sand_Right.png']; VillagePoints.R_gen.image=['Sand_Right.png']; VillagePoints.R_PE.image=['Sand_Right.png']; VillagePoints.R_SE.image=['Sand_Right.png']; VillagePoints.R_skills.image=['Sand_Right.png']; VillagePoints.R_rfx.image=['Sand_Right.png']")}
				if("Grass") {c="#91aa33"; winset(src,null,"VillagePoints.image=['VillagePoints_Grass.png']; VillagePoints.R_stam.image=['Grass_Right.png']; VillagePoints.R_chakra.image=['Grass_Right.png']; VillagePoints.R_nin.image=['Grass_Right.png']; VillagePoints.R_tai.image=['Grass_Right.png']; VillagePoints.R_gen.image=['Grass_Right.png']; VillagePoints.R_PE.image=['Grass_Right.png']; VillagePoints.R_SE.image=['Grass_Right.png']; VillagePoints.R_skills.image=['Grass_Right.png']; VillagePoints.R_rfx.image=['Grass_Right.png']")}
				if("Sound") {c="#800040"; winset(src,null,"VillagePoints.image=['VillagePoints_Sound.png']; VillagePoints.R_stam.image=['Sound_Right.png']; VillagePoints.R_chakra.image=['Sound_Right.png']; VillagePoints.R_nin.image=['Sound_Right.png']; VillagePoints.R_tai.image=['Sound_Right.png']; VillagePoints.R_gen.image=['Sound_Right.png']; VillagePoints.R_PE.image=['Sound_Right.png']; VillagePoints.R_SE.image=['Sound_Right.png']; VillagePoints.R_skills.image=['Sound_Right.png']; VillagePoints.R_rfx.image=['Sound_Right.png']")}
				if("Rain") {c="#77DDFF"; winset(src,null,"VillagePoints.image=['VillagePoints_Rain.png']; VillagePoints.R_stam.image=['Rain_Right.png']; VillagePoints.R_chakra.image=['Rain_Right.png']; VillagePoints.R_nin.image=['Rain_Right.png']; VillagePoints.R_tai.image=['Rain_Right.png']; VillagePoints.R_gen.image=['Rain_Right.png']; VillagePoints.R_PE.image=['Rain_Right.png']; VillagePoints.R_SE.image=['Rain_Right.png']; VillagePoints.R_skills.image=['Rain_Right.png']; VillagePoints.R_rfx.image=['Rain_Right.png']")}
				if("Waterfall") {c="#a2a2c8"; winset(src,null,"VillagePoints.image=['VillagePoints_Waterfall.png']; VillagePoints.R_stam.image=['Waterfall_Right.png']; VillagePoints.R_chakra.image=['Waterfall_Right.png']; VillagePoints.R_nin.image=['Waterfall_Right.png']; VillagePoints.R_tai.image=['Waterfall_Right.png']; VillagePoints.R_gen.image=['waterfall_Right.png']; VillagePoints.R_PE.image=['Waterfall_Right.png']; VillagePoints.R_SE.image=['waterfall_Right.png']; VillagePoints.R_skills.image=['waterfall_Right.png']; VillagePoints.R_rfx.image=['waterfall_Right.png']")}

			winset(src,null,"VillagePoints.Stamina.bar-color=[c];VillagePoints.Chakra.bar-color=[c];VillagePoints.Ninjutsu.bar-color=[c];VillagePoints.Genjutsu.bar-color=[c];VillagePoints.Taijutsu.bar-color=[c];VillagePoints.Primary.bar-color=[c];VillagePoints.Secondary.bar-color=[c];VillagePoints.Skills.bar-color=[c];VillagePoints.Reflexes.bar-color=[c]")

	//Kage
		LoginKage()
			if(VPEject)
				EjectKage("failed your duties")
				return

			if(KageTimeOut[trueName])
				if(KageCurrent[Village] != trueName && KageTemp[Village])
					EjectKage("went missing")
					return
				else
					KageTimeOut[trueName]=0

			var/mob/M = KageMob[Village]
			if(M)
				if(M.TempKage && Kage)
					world << "[trueName] the [NinjaRank] of the [Village]  has returned and [M.trueName] has relinquished control"
					M.verbs -= typesof(/mob/VerbHolder/Kage2/verb)
					verbs += typesof(/mob/VerbHolder/Kage/verb)
					verbs += typesof(/mob/VerbHolder/Kage2/verb)
					if(KageLastLogged[trueName])
						KageVPNeeded = round(((world.realtime - KageLastLogged[trueName]) / 6000)*0.5)
						src << "You will need to gain [KageVPNeeded] Village Points to hold your [NinjaRank] position"

					Setup_VP_Screen()
					KageCurrent[Village] = trueName
					KageMob[Village] = src
					M.TempKage = 0
			else
				if(Kage)
					world << "[trueName] the [NinjaRank] of the [Village] village has returned"
					verbs += typesof(/mob/VerbHolder/Kage/verb)
					verbs += typesof(/mob/VerbHolder/Kage2/verb)
					Setup_VP_Screen()
					KageCurrent[Village] = trueName
					KageMob[Village] = src

					if(KageLastLogged[trueName])
						KageVPNeeded = ((world.realtime - KageLastLogged[trueName]) / 6000)*0.5
						src << "You will need to gain [KageVPNeeded] Village Points to hold your [NinjaRank] position"

				else if(BeenKage && !DisgracedKage)
					world << "[trueName] the [NinjaRank] of the [Village] village, has assumed control until a suitable successor is found"
					Setup_VP_Screen()
					verbs += typesof(/mob/VerbHolder/Kage2/verb)
					KageCurrent[Village] = trueName
					KageMob[Village] = src

		EjectKage(OFFENSE, Murder=0)
			if(Kage)
				src<<"<b><i>You are no longer the [NinjaRank] of the [Village] because you [OFFENSE]!</b></i>"
				NinjaRank="Former [DaimeCheck()]"
				for(var/obj/Clothing/Head/KageHat/H in src)
					overlays -= H.Overlay
					del H
				UpdateInventory()
				//return robes
			else if(TempKage)
				src<<"<b><i>You are no longer the Interim Leader of the [Village] Village because you [OFFENSE]!</b></i>"
			if(Murder)
				DisgracedKage = 1

			verbs -= typesof(/mob/VerbHolder/Kage/verb)
			verbs -= typesof(/mob/VerbHolder/Kage2/verb)

			Popup("lose kage",,,10)
			if(KageCurrent[Village] == trueName)
				KageCurrent[Village]=null
				KageMob[Village]=null
			KageBlocked = world.time + 6000

			StatUpdate_rank();
			CheckForKages(Village)

		DaimeCheck()
			if(!KageList || !KageList[Village])
				return
			switch(KageList[Village][trueName])
				if(1) return "Shodai"
				if(2) return "Nidaime"
				if(3) return "Sandaime"
				if(4) return "Yondaime"
				if(5) return "Godaime"
				if(6) return "Rokdaime"
				if(7) return "Nandaime"
				if(8) return "Hachdaime"
				if(9) return "Kyuudaime"
				if(10) return "Jyuudaime"
				if(11) return "JyuuIchdaime"
				if(12) return "JyuuNidaime"
				if(13) return "JyuuSandaime"
				if(14) return "JyuuYondaime"
				if(15) return "JyuuGodaime"
				if(16) return "JyuuRokdaime"
				if(17) return "JyuuNandaime"
				if(18) return "JyuuHachdaime"
				if(19) return "JyuuKyuudaime"
				if(20) return "NiJyuudaime"
				else return "[KageList[trueName]]\th"