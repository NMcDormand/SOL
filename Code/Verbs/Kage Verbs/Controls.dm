var
	Cost_Stamina=3
	Cost_Chakra=3
	Cost_Ninjutsu=4
	Cost_Taijutsu=4
	Cost_Genjutsu=4
	Cost_Skills=2
	Cost_Primary=2
	Cost_Secondary=2
	Cost_Reflexes=1

	BarRatio=0.5

	VPMAX = 200

	TaiBoost[0]
	NinBoost[0]
	GenBoost[0]
	StamBoost[0]
	ChakBoost[0]
	SkillBoost[0]
	PEBoost[0]
	SEBoost[0]
	RFXBoost[0]

mob/VerbHolder/Kage/verb
	StaminaUp()
		set hidden=1
		var/NS = round((StamBoost[usr.Village]+StamBoost["[usr.Village]Cur"])*0.5)
		var/TC = Cost_Stamina * (NS+1)
		if(VillagePoints[usr.Village] - VillagePoints["[usr.Village]Cur"] < TC)
			usr<<"Not enough Village Points for this.<br>You need [TC] points to raise the Stamina Boost to [NS+1]"; return
		else if(NS >= VPMAX)
			usr<<"That is the maximum you can boost Stamina"; return
		else
			VillagePoints["[usr.Village]Cur"]+=TC
			StamBoost["[usr.Village]Cur"]++

			winset(usr,"VillagePoints.Stamina","value=[(StamBoost[usr.Village]+StamBoost["[usr.Village]Cur"]) * BarRatio]")
			winset(usr,"VillagePoints.VillagePointsRemaining", "text=[(VillagePoints[usr.Village]-VillagePoints["[usr.Village]Cur"])]")

	ChakraIncrease()
		set hidden=1
		var/NS = round((ChakBoost[usr.Village]+ChakBoost["[usr.Village]Cur"])*0.5)
		var/TC = Cost_Chakra * (NS+1)
		if(VillagePoints[usr.Village] - VillagePoints["[usr.Village]Cur"] < TC)
			usr<<"Not enough Village Points for this.<br>You need [TC] points to raise the Chakra Boost to [NS+1]"; return
		else if(NS >= VPMAX)
			usr<<"That is the maximum you can boost Chakra"; return
		else
			VillagePoints["[usr.Village]Cur"]+=TC
			ChakBoost["[usr.Village]Cur"]++

			winset(usr,"VillagePoints.Chakra","value=[(ChakBoost[usr.Village]+ChakBoost["[usr.Village]Cur"]) * BarRatio]")
			winset(usr,"VillagePoints.VillagePointsRemaining", "text=[(VillagePoints[usr.Village]-VillagePoints["[usr.Village]Cur"])]")

	NinjutsuUp()
		set hidden=1
		var/NS = round((NinBoost[usr.Village]+NinBoost["[usr.Village]Cur"])*0.5)
		var/TC = Cost_Ninjutsu * (NS+1)
		if(VillagePoints[usr.Village] - VillagePoints["[usr.Village]Cur"] < TC)
			usr<<"Not enough Village Points for this.<br>You need [TC] points to raise the Ninjutsu Boost to [NS+1]"; return
		else if(NS >= VPMAX)
			usr<<"That is the maximum you can boost Ninjutsu"; return
		else
			VillagePoints["[usr.Village]Cur"]+=TC
			NinBoost["[usr.Village]Cur"]++

			winset(usr,"VillagePoints.Ninjutsu","value=[(ChakBoost[usr.Village]+ChakBoost["[usr.Village]Cur"]) * BarRatio]")
			winset(usr,"VillagePoints.VillagePointsRemaining", "text=[(VillagePoints[usr.Village]-VillagePoints["[usr.Village]Cur"])]")

	GenjutsuUp()
		set hidden=1
		var/NS = round((GenBoost[usr.Village]+GenBoost["[usr.Village]Cur"])*0.5)
		var/TC = Cost_Genjutsu * (NS+1)
		if(VillagePoints[usr.Village] - VillagePoints["[usr.Village]Cur"] < TC)
			usr<<"Not enough Village Points for this.<br>You need [TC] points to raise the Genjutsu Boost to [NS+1]"; return
		else if(NS >= VPMAX)
			usr<<"That is the maximum you can boost Genjutsu"; return
		else
			VillagePoints["[usr.Village]Cur"]+=TC
			GenBoost["[usr.Village]Cur"]++

			winset(usr,"VillagePoints.Genjutsu","value=[(GenBoost[usr.Village]+GenBoost["[usr.Village]Cur"]) * BarRatio]")
			winset(usr,"VillagePoints.VillagePointsRemaining", "text=[(VillagePoints[usr.Village]-VillagePoints["[usr.Village]Cur"])]")

	TaijutsuUp()
		set hidden=1
		var/NS = round((TaiBoost[usr.Village]+TaiBoost["[usr.Village]Cur"])*0.5)
		var/TC = Cost_Taijutsu * (NS+1)
		if(VillagePoints[usr.Village] - VillagePoints["[usr.Village]Cur"] < TC)
			usr<<"Not enough Village Points for this.<br>You need [TC] points to raise the Taijutsu Boost to [NS+1]"; return
		else if(NS >= VPMAX)
			usr<<"That is the maximum you can boost Taijutsu"; return
		else
			VillagePoints["[usr.Village]Cur"]+=TC
			TaiBoost["[usr.Village]Cur"]++

			winset(usr,"VillagePoints.Taijutsu","value=[(TaiBoost[usr.Village]+TaiBoost["[usr.Village]Cur"]) * BarRatio]")
			winset(usr,"VillagePoints.VillagePointsRemaining", "text=[(VillagePoints[usr.Village]-VillagePoints["[usr.Village]Cur"])]")

	PrimaryUp()
		set hidden=1
		var/NS = round((PEBoost[usr.Village]+PEBoost["[usr.Village]Cur"])*0.5)
		var/TC = Cost_Primary * (NS+1)
		if(VillagePoints[usr.Village] - VillagePoints["[usr.Village]Cur"] < TC)
			usr<<"Not enough Village Points for this.<br>You need [TC] points to raise the Primary Boost to [NS+1]"; return
		else if(NS >= VPMAX)
			usr<<"That is the maximum you can boost Primary Elements"; return
		else
			VillagePoints["[usr.Village]Cur"]+=TC
			PEBoost["[usr.Village]Cur"]++

			winset(usr,"VillagePoints.Primary","value=[(PEBoost[usr.Village]+PEBoost["[usr.Village]Cur"]) * BarRatio]")
			winset(usr,"VillagePoints.VillagePointsRemaining", "text=[(VillagePoints[usr.Village]-VillagePoints["[usr.Village]Cur"])]")

	SecondaryUp()
		set hidden=1
		var/NS = round((SEBoost[usr.Village]+SEBoost["[usr.Village]Cur"])*0.5)
		var/TC = Cost_Secondary * (NS+1)
		if(VillagePoints[usr.Village] - VillagePoints["[usr.Village]Cur"] < TC)
			usr<<"Not enough Village Points for this.<br>You need [TC] points to raise the Secondary Boost to [NS+1]"; return
		else if(NS >= VPMAX)
			usr<<"That is the maximum you can boost Secondary Elements"; return
		else
			VillagePoints["[usr.Village]Cur"]+=TC
			SEBoost["[usr.Village]Cur"]++

			winset(usr,"VillagePoints.Secondary","value=[(SEBoost[usr.Village]+SEBoost["[usr.Village]Cur"]) * BarRatio]")
			winset(usr,"VillagePoints.VillagePointsRemaining", "text=[(VillagePoints[usr.Village]-VillagePoints["[usr.Village]Cur"])]")

	SkillsUp()
		set hidden=1
		var/NS = round((SkillBoost[usr.Village]+SkillBoost["[usr.Village]Cur"])*0.5)
		var/TC = Cost_Skills * (NS+1)
		if(VillagePoints[usr.Village] - VillagePoints["[usr.Village]Cur"] < TC)
			usr<<"Not enough Village Points for this.<br>You need [TC] points to raise the Skills Boost to [NS+1]"; return
		else if(NS >= VPMAX)
			usr<<"That is the maximum you can boost Skills"; return
		else
			VillagePoints["[usr.Village]Cur"]+=TC
			SkillBoost["[usr.Village]Cur"]++

			winset(usr,"VillagePoints.Skills","value=[(SkillBoost[usr.Village]+SkillBoost["[usr.Village]Cur"]) * BarRatio]")
			winset(usr,"VillagePoints.VillagePointsRemaining", "text=[(VillagePoints[usr.Village]-VillagePoints["[usr.Village]Cur"])]")

	ReflexesUp()
		set hidden=1
		var/NS = round((RFXBoost[usr.Village]+RFXBoost["[usr.Village]Cur"])*0.5)
		var/TC = Cost_Reflexes * (NS+1)
		if(VillagePoints[usr.Village] - VillagePoints["[usr.Village]Cur"] < TC)
			usr<<"Not enough Village Points for this.<br>You need [TC] points to raise the Reflexes Boost to [NS+1]"; return
		else if(NS >= VPMAX)
			usr<<"That is the maximum you can boost Stamina"; return
		else
			VillagePoints["[usr.Village]Cur"]+=TC
			RFXBoost["[usr.Village]Cur"]++

			winset(usr,"VillagePoints.Reflexes","value=[(RFXBoost[usr.Village]+RFXBoost["[usr.Village]Cur"]) * BarRatio]")
			winset(usr,"VillagePoints.VillagePointsRemaining", "text=[(VillagePoints[usr.Village]-VillagePoints["[usr.Village]Cur"])]")

proc/RefreshVillagersBoosts(mob/M)
	if(!(StamBoost)) StamBoost=new()
	if(!(ChakBoost)) ChakBoost=new()
	if(!(NinBoost)) NinBoost=new()
	if(!(GenBoost)) GenBoost=new()
	if(!(TaiBoost)) TaiBoost=new()
	if(!(PEBoost)) PEBoost=new()
	if(!(SEBoost)) SEBoost=new()
	if(!(SkillBoost)) SkillBoost=new()
	if(!(RFXBoost)) RFXBoost=new()
	for(var/mob/player/V in MasterPlayerList)
		if(V.Village==M.Village&&V.client)
			winset(V,"BoostPane.Stamina","value=[(StamBoost[V.Village])*BarRatio]")
			winset(V,"BoostPane.Chakra","value=[(ChakBoost[V.Village])*BarRatio]")
			winset(V,"BoostPane.Ninjutsu","value=[(NinBoost[V.Village])*BarRatio]")
			winset(V,"BoostPane.Genjutsu","value=[(GenBoost[V.Village])*BarRatio]")
			winset(V,"BoostPane.Taijutsu","value=[(TaiBoost[V.Village])*BarRatio]")
			winset(V,"BoostPane.Primary","value=[(PEBoost[V.Village])*BarRatio]")
			winset(V,"BoostPane.Secondary","value=[(SEBoost[V.Village])*BarRatio]")
			winset(V,"BoostPane.Skills","value=[(SkillBoost[V.Village])*BarRatio]")
			winset(V,"BoostPane.Reflexes","value=[(RFXBoost[V.Village])*BarRatio]")
