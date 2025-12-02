var
	list
		CLOUD_KAGELIST[0]
		LEAF_KAGELIST[0]
		MIST_KAGELIST[0]
		ROCK_KAGELIST[0]
		SAND_KAGELIST[0]
		RAIN_KAGELIST[0]
		SOUND_KAGELIST[0]
		GRASS_KAGELIST[0]
		WATERFALL_KAGELIST[0]
		KageNumber[0]
		TheCurrentKage[0]
		WorldKageNumber[0]
		KageDowntime[0]
		PassiveBoost[0]
		TotalVillagePoints[0]
	list/MasterKageList = list("Cloud" = list(), "Leaf" = list(), "Mist" = list(), "Rock" = list(), "Sand" = list())
mob/var
	EXTRA_VillagePoints[0]
	BeenKage=0
	KageID
mob/proc
	kageHat(var/giving)
		set waitfor = 0
		//giving is getting the hat, otherwise you are taking it
		if(giving)
			//give hat
			switch(src.Village)
				if("Cloud")
					new/obj/Clothing/Head/KageHat/Cloud/(src)
				if("Sand")
					new/obj/Clothing/Head/KageHat/Sand/(src)
				if("Leaf")
					new/obj/Clothing/Head/KageHat/Leaf/(src)
				if("Mist")
					new/obj/Clothing/Head/KageHat/Mist/(src)
				if("Rock")
					new/obj/Clothing/Head/KageHat/Rock/(src)
				if("Rain")
					new/obj/Clothing/Head/KageHat/Rain/(src)
				if("Grass")
					new/obj/Clothing/Head/KageHat/Grass/(src)
				if("Waterfall")
					new/obj/Clothing/Head/KageHat/Waterfall/(src)
				if("Sound")
					new/obj/Clothing/Head/KageHat/Sound/(src)
			src.UpdateInventory()
		else
			for(var/obj/Clothing/Head/KageHat/H in src)
				src.overlays-=H.icon;
				del(H)

	AwardVP_check(AMOUNT,EXTRA,REQ)
		if(IsCurrentKage(src.Village))
			var/bonus=0
			if(EXTRA&&REQ&&EXTRA>=REQ) bonus=1
			if(!(AMOUNT)) AMOUNT=1

			var/mob/player/K=TheCurrentKage[src.Village]
			if(K)
				if(!(K.EXTRA_VillagePoints)) K.EXTRA_VillagePoints=new()
				if(K.EXTRA_VillagePoints[K.KageID]<0) K.EXTRA_VillagePoints[K.KageID]=0
				K.EXTRA_VillagePoints[K.KageID]+=(AMOUNT+bonus)
				K.CalculateMaxVillagePoints()
				src<<"<b>You earned an extra [AMOUNT+bonus] Village Points for [src.Village] under [K]'s leadership!</b>\nThese can be spent on your stat boosts."

	ResetVillagePoints()
		if(src.client) winset(src,null,"VillagePoints.Stamina.value=5;VillagePoints.Chakra.value=5;VillagePoints.Ninjutsu.value=5;VillagePoints.Genjutsu.value=5;VillagePoints.Taijutsu.value=5;VillagePoints.Primary.value=5;VillagePoints.Secondary.value=5;VillagePoints.Skills.value=5;VillagePoints.Reflexes.value=5")
		RefreshVillagersBoosts(src)
		VillagePoints[src.Village]=40
		TaiBoost[src.Village]=0; NinBoost[src.Village]=0; GenBoost[src.Village]=0
		StamBoost[src.Village]=0; ChakBoost[src.Village]=0
		SkillBoost[src.Village]=0; PEBoost[src.Village]=0; SEBoost[src.Village]=0; RFXBoost[src.Village]=0
		src.CalculateMaxVillagePoints()
		PassiveBoost[src.Village]=1

	CalculateMaxVillagePoints()
		var
			a; b; c; d; e; f; g; h; i; j; k
		a= VillagePoints[src.Village]
		b= (StamBoost[src.Village] * Cost_Stamina)
		c= (ChakBoost[src.Village] * Cost_Chakra)
		d= (TaiBoost[src.Village] * Cost_Taijutsu)
		e= (NinBoost[src.Village] * Cost_Ninjutsu)
		f= (GenBoost[src.Village] * Cost_Genjutsu)
		g= (SkillBoost[src.Village] * Cost_Skills)
		h= (PEBoost[src.Village] * Cost_Primary)
		i= (SEBoost[src.Village] * Cost_Secondary)
		j= (RFXBoost[src.Village] * Cost_Reflexes)
		k= src.EXTRA_VillagePoints[src.KageID]

		VillagePointsMax[src.Village]=(a+k)
		TotalVillagePoints[src.Village]=(a+k)-(b+c+d+e+f+g+h+i+j)

	Setup_VP_Screen()
		if(!src.client) return
		var/c
		switch(src.Village)
			if("Cloud") {c="#fee768"; winset(src,null,"VillagePoints.image=['VillagePoints_Cloud.png']; VillagePoints.L_stam.image=['Cloud_Left.png']; VillagePoints.L_chakra.image=['Cloud_Left.png']; VillagePoints.L_nin.image=['Cloud_Left.png']; VillagePoints.L_tai.image=['Cloud_Left.png']; VillagePoints.L_gen.image=['Cloud_Left.png']; VillagePoints.L_PE.image=['Cloud_Left.png']; VillagePoints.L_SE.image=['Cloud_Left.png']; VillagePoints.L_skills.image=['Cloud_Left.png']; VillagePoints.L_rfx.image=['Cloud_Left.png']; VillagePoints.R_stam.image=['Cloud_Right.png']; VillagePoints.R_chakra.image=['Cloud_Right.png']; VillagePoints.R_nin.image=['Cloud_Right.png']; VillagePoints.R_tai.image=['Cloud_Right.png']; VillagePoints.R_gen.image=['Cloud_Right.png']; VillagePoints.R_PE.image=['Cloud_Right.png']; VillagePoints.R_SE.image=['Cloud_Right.png']; VillagePoints.R_skills.image=['Cloud_Right.png']; VillagePoints.R_rfx.image=['Cloud_Right.png']")}
			if("Leaf") {c="#740000"; winset(src,null,"VillagePoints.image=['VillagePoints_Leaf.png']; VillagePoints.L_stam.image=['Leaf_Left.png']; VillagePoints.L_chakra.image=['Leaf_Left.png']; VillagePoints.L_nin.image=['Leaf_Left.png']; VillagePoints.L_tai.image=['Leaf_Left.png']; VillagePoints.L_gen.image=['Leaf_Left.png']; VillagePoints.L_PE.image=['Leaf_Left.png']; VillagePoints.L_SE.image=['Leaf_Left.png']; VillagePoints.L_skills.image=['Leaf_Left.png']; VillagePoints.L_rfx.image=['Leaf_Left.png']; VillagePoints.R_stam.image=['Leaf_Right.png']; VillagePoints.R_chakra.image=['Leaf_Right.png']; VillagePoints.R_nin.image=['Leaf_Right.png']; VillagePoints.R_tai.image=['Leaf_Right.png']; VillagePoints.R_gen.image=['Leaf_Right.png']; VillagePoints.R_PE.image=['Leaf_Right.png']; VillagePoints.R_SE.image=['Leaf_Right.png']; VillagePoints.R_skills.image=['Leaf_Right.png']; VillagePoints.R_rfx.image=['Leaf_Right.png']")}
			if("Mist") {c="#006cff"; winset(src,null,"VillagePoints.image=['VillagePoints_Mist.png']; VillagePoints.L_stam.image=['Mist_Left.png']; VillagePoints.L_chakra.image=['Mist_Left.png']; VillagePoints.L_nin.image=['Mist_Left.png']; VillagePoints.L_tai.image=['Mist_Left.png']; VillagePoints.L_gen.image=['Mist_Left.png']; VillagePoints.L_PE.image=['Mist_Left.png']; VillagePoints.L_SE.image=['Mist_Left.png']; VillagePoints.L_skills.image=['Mist_Left.png']; VillagePoints.L_rfx.image=['Mist_Left.png']; VillagePoints.R_stam.image=['Mist_Right.png']; VillagePoints.R_chakra.image=['Mist_Right.png']; VillagePoints.R_nin.image=['Mist_Right.png']; VillagePoints.R_tai.image=['Mist_Right.png']; VillagePoints.R_gen.image=['Mist_Right.png']; VillagePoints.R_PE.image=['Mist_Right.png']; VillagePoints.R_SE.image=['Mist_Right.png']; VillagePoints.R_skills.image=['Mist_Right.png']; VillagePoints.R_rfx.image=['Mist_Right.png']")}
			if("Rock") {c="#563500"; winset(src,null,"VillagePoints.image=['VillagePoints_Rock.png']; VillagePoints.L_stam.image=['Rock_Left.png']; VillagePoints.L_chakra.image=['Rock_Left.png']; VillagePoints.L_nin.image=['Rock_Left.png']; VillagePoints.L_tai.image=['Rock_Left.png']; VillagePoints.L_gen.image=['Rock_Left.png']; VillagePoints.L_PE.image=['Rock_Left.png']; VillagePoints.L_SE.image=['Rock_Left.png']; VillagePoints.L_skills.image=['Rock_Left.png']; VillagePoints.L_rfx.image=['Rock_Left.png']; VillagePoints.R_stam.image=['Rock_Right.png']; VillagePoints.R_chakra.image=['Rock_Right.png']; VillagePoints.R_nin.image=['Rock_Right.png']; VillagePoints.R_tai.image=['Rock_Right.png']; VillagePoints.R_gen.image=['Rock_Right.png']; VillagePoints.R_PE.image=['Rock_Right.png']; VillagePoints.R_SE.image=['Rock_Right.png']; VillagePoints.R_skills.image=['Rock_Right.png']; VillagePoints.R_rfx.image=['Rock_Right.png']")}
			if("Sand") {c="#d68800"; winset(src,null,"VillagePoints.image=['VillagePoints_Sand.png']; VillagePoints.L_stam.image=['Sand_Left.png']; VillagePoints.L_chakra.image=['Sand_Left.png']; VillagePoints.L_nin.image=['Sand_Left.png']; VillagePoints.L_tai.image=['Sand_Left.png']; VillagePoints.L_gen.image=['Sand_Left.png']; VillagePoints.L_PE.image=['Sand_Left.png']; VillagePoints.L_SE.image=['Sand_Left.png']; VillagePoints.L_skills.image=['Sand_Left.png']; VillagePoints.L_rfx.image=['Sand_Left.png']; VillagePoints.R_stam.image=['Sand_Right.png']; VillagePoints.R_chakra.image=['Sand_Right.png']; VillagePoints.R_nin.image=['Sand_Right.png']; VillagePoints.R_tai.image=['Sand_Right.png']; VillagePoints.R_gen.image=['Sand_Right.png']; VillagePoints.R_PE.image=['Sand_Right.png']; VillagePoints.R_SE.image=['Sand_Right.png']; VillagePoints.R_skills.image=['Sand_Right.png']; VillagePoints.R_rfx.image=['Sand_Right.png']")}
			if("Grass") {c="#91aa33"; winset(src,null,"VillagePoints.image=['VillagePoints_Grass.png']; VillagePoints.L_stam.image=['Grass_Left.png']; VillagePoints.L_chakra.image=['Grass_Left.png']; VillagePoints.L_nin.image=['Grass_Left.png']; VillagePoints.L_tai.image=['Grass_Left.png']; VillagePoints.L_gen.image=['Grass_Left.png']; VillagePoints.L_PE.image=['Grass_Left.png']; VillagePoints.L_SE.image=['Grass_Left.png']; VillagePoints.L_skills.image=['Grass_Left.png']; VillagePoints.L_rfx.image=['Grass_Left.png']; VillagePoints.R_stam.image=['Grass_Right.png']; VillagePoints.R_chakra.image=['Grass_Right.png']; VillagePoints.R_nin.image=['Grass_Right.png']; VillagePoints.R_tai.image=['Grass_Right.png']; VillagePoints.R_gen.image=['Grass_Right.png']; VillagePoints.R_PE.image=['Grass_Right.png']; VillagePoints.R_SE.image=['Grass_Right.png']; VillagePoints.R_skills.image=['Grass_Right.png']; VillagePoints.R_rfx.image=['Grass_Right.png']")}
			if("Sound") {c="#800040"; winset(src,null,"VillagePoints.image=['VillagePoints_Sound.png']; VillagePoints.L_stam.image=['Sound_Left.png']; VillagePoints.L_chakra.image=['Sound_Left.png']; VillagePoints.L_nin.image=['Sound_Left.png']; VillagePoints.L_tai.image=['Sound_Left.png']; VillagePoints.L_gen.image=['Sound_Left.png']; VillagePoints.L_PE.image=['Sound_Left.png']; VillagePoints.L_SE.image=['Sound_Left.png']; VillagePoints.L_skills.image=['Sound_Left.png']; VillagePoints.L_rfx.image=['Sound_Left.png']; VillagePoints.R_stam.image=['Sound_Right.png']; VillagePoints.R_chakra.image=['Sound_Right.png']; VillagePoints.R_nin.image=['Sound_Right.png']; VillagePoints.R_tai.image=['Sound_Right.png']; VillagePoints.R_gen.image=['Sound_Right.png']; VillagePoints.R_PE.image=['Sound_Right.png']; VillagePoints.R_SE.image=['Sound_Right.png']; VillagePoints.R_skills.image=['Sound_Right.png']; VillagePoints.R_rfx.image=['Sound_Right.png']")}
			if("Rain") {c="#77DDFF"; winset(src,null,"VillagePoints.image=['VillagePoints_Rain.png']; VillagePoints.L_stam.image=['Rain_Left.png']; VillagePoints.L_chakra.image=['Rain_Left.png']; VillagePoints.L_nin.image=['Rain_Left.png']; VillagePoints.L_tai.image=['Rain_Left.png']; VillagePoints.L_gen.image=['Rain_Left.png']; VillagePoints.L_PE.image=['Rain_Left.png']; VillagePoints.L_SE.image=['Rain_Left.png']; VillagePoints.L_skills.image=['Rain_Left.png']; VillagePoints.L_rfx.image=['Rain_Left.png']; VillagePoints.R_stam.image=['Rain_Right.png']; VillagePoints.R_chakra.image=['Rain_Right.png']; VillagePoints.R_nin.image=['Rain_Right.png']; VillagePoints.R_tai.image=['Rain_Right.png']; VillagePoints.R_gen.image=['Rain_Right.png']; VillagePoints.R_PE.image=['Rain_Right.png']; VillagePoints.R_SE.image=['Rain_Right.png']; VillagePoints.R_skills.image=['Rain_Right.png']; VillagePoints.R_rfx.image=['Rain_Right.png']")}
			if("Waterfall") {c="#a2a2c8"; winset(src,null,"VillagePoints.image=['VillagePoints_Waterfall.png']; VillagePoints.L_stam.image=['Waterfall_Left.png']; VillagePoints.L_chakra.image=['Waterfall_Left.png']; VillagePoints.L_nin.image=['Waterfall_Left.png']; VillagePoints.L_tai.image=['Waterfall_Left.png']; VillagePoints.L_gen.image=['Waterfall_Left.png']; VillagePoints.L_PE.image=['Waterfall_Left.png']; VillagePoints.L_SE.image=['Waterfall_Left.png']; VillagePoints.L_skills.image=['Waterfall_Left.png']; VillagePoints.L_rfx.image=['Waterfall_Left.png']; VillagePoints.R_stam.image=['Waterfall_Right.png']; VillagePoints.R_chakra.image=['Waterfall_Right.png']; VillagePoints.R_nin.image=['Waterfall_Right.png']; VillagePoints.R_tai.image=['Waterfall_Right.png']; VillagePoints.R_gen.image=['waterfall_Right.png']; VillagePoints.R_PE.image=['Waterfall_Right.png']; VillagePoints.R_SE.image=['waterfall_Right.png']; VillagePoints.R_skills.image=['waterfall_Right.png']; VillagePoints.R_rfx.image=['waterfall_Right.png']")}
		winset(src,null,"VillagePoints.Stamina.bar-color=[c];VillagePoints.Chakra.bar-color=[c];VillagePoints.Ninjutsu.bar-color=[c];VillagePoints.Genjutsu.bar-color=[c];VillagePoints.Taijutsu.bar-color=[c];VillagePoints.Primary.bar-color=[c];VillagePoints.Secondary.bar-color=[c];VillagePoints.Skills.bar-color=[c];VillagePoints.Reflexes.bar-color=[c]")

	EligibleForKage(VILLAGE)
		if(!MasterKageList)
			MasterKageList = list()
			MasterKageList[VILLAGE] = list()
		for(var/n in MasterKageList[VILLAGE])
			if(src.HasRequiredRank("Kage Level") && src.MissionsComplete["S"]>=20 && !(KageDowntime[VILLAGE]))
				Called("<u>EligibleForKage: [src] - [VILLAGE]</u>") //Debug message

			if( (!(isnull(src.KageID))) && (n==src.KageID) && (!(KageDowntime[VILLAGE])) && (KageNumber[src.KageID]>0)) return TRUE;
				//world<<"kageID: [src.KageID]; N: [n]; Downtime: [KageDowntime[VILLAGE]]; KageNumber: [KageNumber[src.KageID]]"; return TRUE

			if(src.HasRequiredRank("Kage Level") && src.MissionsComplete["S"]>=20 && !(KageDowntime[VILLAGE]))
				if(isnull(src.KageID)) Called("Not eligible: src.KageID is null!")
				if(n!=src.KageID) Called("Not eligible: their name doesn't match")
				if(KageNumber[src.KageID]<=0) Called("Their Kage number is less than 0... o_O")

	SwapKageCheck(ASSIGN)
		if(KageDowntime[src.Village]) return
		var/x=WorldKageNumber[src.Village]
		for(var/mob/player/p in MasterPlayerList)
			if(!(isnull(KageNumber[p.KageID]))&&src.Village==p.Village)
				x=min(KageNumber[p.KageID],x)	//gets the lowest number of the available kages
		if(x<1)x=1
		if(!ASSIGN)
			var/mob/K=TheCurrentKage[src.Village]
			if(IsCurrentKage(src.Village)&&K)
				if(x==KageNumber[src.KageID]) K.SwapKageRank(src)
		else
			return x

	SwapKageRank(mob/r)
		src<<"[r] has just logged in and \he is the [r.DaimeCheck()] [src.NinjaRank]; accordingly you are to step aside during \his reign."
		src<<"You are now a <i>Kage Level</i> ninja, and no longer have your [src.NinjaRank] priviledges."
		src.NinjaRank="Kage Level"
		StatUpdate_rank();
		//return robes
		src.verbs -= typesof(/mob/VerbHolder/Kage/verb)
		src.kageHat(0)
		src.Popup("swap kage",r.DaimeCheck(),,10)
		r.AssignKageRank(r.Village)

	RePromoteKage(mob/l)
		src.AssignKageRank(src.Village)
		src<<"[l] has just logged out and so it is up to you to fill \his shoes as [src.NinjaRank]. [src.Village] believes in you, don't let them down!"

	ReAppointKage()
		if(KageDowntime[src.Village]) return
		src.AssignKageRank(src.Village)
		src<<"You are the only ninja from [src.Village] worthy of being called the [src.NinjaRank], and so you have been reinstated!"

	EndKage_NewCycle()
		src<<"A new era of Kages has begun, and so you are once again a <i>Kage Level</i> ninja, without your [src.NinjaRank] priviledges."
		src.NinjaRank="Kage Level"
		src.kageHat(0)
		StatUpdate_rank();
		//return robes
		src.verbs -= typesof(/mob/VerbHolder/Kage/verb)

	UndoKage()
		src.NinjaRank="Kage Level"
		src.verbs -= typesof(/mob/VerbHolder/Kage/verb)
		src.kageHat(0)
		StatUpdate_rank();
		//return robes

	EjectKageFromCycle(OFFENSE)
		src<<"<b><i>You have been ejected from the Kage Cycle because you [OFFENSE]! As such, you are no longer the [src.DaimeCheck()] [src.NinjaRank] of [src.Village] Village.</b></i>"
		src.NinjaRank="Kage Level"
		src.verbs -= typesof(/mob/VerbHolder/Kage/verb)
		src.kageHat(0)
		//return robes
		src.Popup("lose kage",,,10)
		PassiveBoost[src.Village]=0
		src.EXTRA_VillagePoints[src.KageID]=round(src.EXTRA_VillagePoints[src.KageID]/2)
		TheCurrentKage[src.Village]=null
		PatchUpKageCycle(src,KageNumber[src.KageID],src.Village)

		StatUpdate_rank();

proc
	CheckForNewKage(VILLAGE)
		while(KageDowntime[VILLAGE]>0)
			KageDowntime[VILLAGE]-=1800
			if(KageDowntime[VILLAGE]==9000) world<<"<i>[VILLAGE] Village may promote a new kage in 15 minutes!</i>"
			sleep(1800)
		KageDowntime[VILLAGE]=0
		world<<"<i>[VILLAGE] Village may now promote a new kage!</i>"
		var/x=WorldKageNumber[VILLAGE]
		for(var/mob/player/p in MasterPlayerList)
			if(p.Village==VILLAGE&&p.KageID!=null&&KageNumber[p.KageID]>0&&p.EligibleForKage(VILLAGE))
				x=min(KageNumber[p.KageID],x)
		if(x<1)x=1
		var/mob/K=TheCurrentKage[VILLAGE]
		if(!K)
			for(var/mob/player/NK in MasterPlayerList)
				if(x==KageNumber[NK.KageID]&&NK.Village==VILLAGE&&NK.KageID!=null&&KageNumber[NK.KageID]>0&&NK.EligibleForKage(VILLAGE))
					NK.AssignKageRank(NK.Village)

	OffenseOutput(OFFENSE,other,village)
		if(!OFFENSE) OFFENSE="failed as a kage"
		switch(OFFENSE)
			if("suicide") return "have been killed"
			if("homicide") return "were assassinated by [other] from the [village] Village"
			if("murder") return "killed [other], a ninja from [village] Village"
			if("duties") return "failed to protect the [village] Village"
			if("assassination") return "assassinated the current kage"

	PatchUpKageCycle(mob/s,void,VILLAGE)
		if(!(KageNumber)) Called("No KageNumber!")
		if(!(WorldKageNumber)) Called("No WorldKageNumber!")
		if(!(MasterKageList)) Called("No MasterKageList!")

		if(s.KageID in MasterKageList[VILLAGE])
			MasterKageList[VILLAGE]-=s.KageID
			Called("[s] has been removed from the [VILLAGE] Master Kage List.")
		else
			Called("[s]'s KageID was not in the Master Kage List!")
		Called("KageNumber was [length(KageNumber)]")
		KageNumber[s.KageID]=null
		KageNumber -= s.KageID
		Called("---It is now [length(KageNumber)]")
		WorldKageNumber[VILLAGE]--
		for(var/v in MasterKageList[VILLAGE])
			if(KageNumber[v]>void)
				KageNumber[v]--
				Called("[v] of [VILLAGE]'s Kage Level moved up by 1, to [KageNumber[v]]!")
				Called("[VILLAGE] now has [WorldKageNumber[VILLAGE]] total Kages!")
			if(KageNumber[v]<1)
				Called("KageNumber for [VILLAGE] was less than 1, corrected to 1.")
				KageNumber[v]=1
			if(WorldKageNumber[VILLAGE]<1)
				WorldKageNumber[VILLAGE]=0
				Called("WorldKageNumber for [VILLAGE] was less than 1, corrected to 1")
		KageDowntime[VILLAGE]=18000
		spawn()
			CheckForNewKage(VILLAGE)
		SaveKages()

	CheckForReplacementKages(VILLAGE)
		var/x
		for(var/mob/M in MasterPlayerList)
			if(M.EligibleForKage(VILLAGE)) x=M.SwapKageCheck(1)	//sets the number needed for the next ranked kage if there is one
		for(var/mob/Y in MasterPlayerList)
			if(KageNumber[Y.KageID]==x&&Y.EligibleForKage(VILLAGE))//if that player is that number and is eligible
				Y.RePromoteKage(TheCurrentKage[Y.Village])

	CheckForKages(VILLAGE, VILLAGESCORE)
		if(KageDowntime[VILLAGE]) return
		if(!IsCurrentKage(VILLAGE))
			var/best=0
			for(var/mob/m in MasterPlayerList) best=max(VILLAGESCORE[m],best)
			for(var/mob/k in MasterPlayerList)
				if(k.Village==VILLAGE&&k.NinjaRank=="Kage Level"&&VILLAGESCORE[k]==best&&best>=60)
					k.AssignKageRank(VILLAGE); break

	IsCurrentKage(VILLAGE)
		var/c=0
		for(var/mob/k in MasterPlayerList)
			if(TheCurrentKage[VILLAGE]==k) {c=1; break}
		switch(c)
			if(1) return TRUE
			else return FALSE

	LoadKages()
		if(TotalSavePrevention) return
		if(fexists("Data/Kages.sav"))
			var/savefile/F = new ("Data/Kages.sav")
			F["SavedKageOrder"]>>KageNumber
			F["SavedKageNumbers"]>>WorldKageNumber
			F["MasterKageList"]>>MasterKageList

	SaveKages()
		if(TotalSavePrevention) return
		var/savefile/F = new("Data/Kages.sav")
		F["SavedKageOrder"] << KageNumber
		F["SavedKageNumbers"] << WorldKageNumber
		F["MasterKageList"] << MasterKageList

mob/proc
	DaimeCheck()
		switch(KageNumber[src.KageID])
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
			else return "[KageNumber[src.KageID]]\th"

