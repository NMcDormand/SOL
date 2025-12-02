var
	ChuuninTime=0
	ChuuninAccess=0
	ChuuninCheck=0
	ChuuninVillage
	BattleList[]
	ForestList[]
mob/var
	ChuuninAttempts=0
	ChuuninResults=0
	tmp
		TakingChuuninExam
		InChuunin
		HasHeaven; HasEarth
		InTower; ChuuninBattle; eliminated

mob/proc
	PassedChuunin()
		protect=0
		if(ForestList)
			for(var/mob/player/C in ForestList)
				C.InChuunin=0;
			del(ForestList)
		if(BattleList)
			for(var/mob/player/D in BattleList)
				D.InChuunin=0;
			del(BattleList)
		ChuuninExit()
		RankChuunin()
		world<<"<font size=2>[src] has just become a Chuunin ranked ninja!</font>"

	ChuuninChecker()
		if(InChuunin||!ChuuninAttempts)
			return
		if(NinjaRank=="Genin"&&(NinjutsuTrue+TaijutsuTrue+GenjutsuTrue)>=(10000*EXP_BASE)&&StaminaTrue>=(100000*EXP_BASE))
			src<<"Although you did not pass the exam, the village believes you have what it takes to be Chuunin!"
			ChuuninExit()
			RankChuunin()
			world<<"<font size=2>[src] has just become a Chuunin ranked ninja!</font>"

	ChuuninExit()
		protect=0
		for(var/area/a in oview(0,src)) a.Exited(src)
		if(InVillage=="Leaf")  loc=locate(406,158,1)
		if(InVillage=="Mist") loc=locate(928,128,1)
		if(InVillage=="Cloud") loc=locate(853,488,1)
		if(InVillage=="Sand") loc=locate(61,12,1)
		if(InVillage=="Rock") loc=locate(169,475,1)