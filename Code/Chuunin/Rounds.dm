var/tmp
	participants=0
	RoundSpawn="1"
	FightingList=list()
	RoundOneList=list()
	RoundTwoList=list()
	RoundThreeList=list()
	RoundFourList=list()
proc
//----------------- [ Basically checks for loggers ] ------------------
	PassersCheck()
		if(length(BattleList)==1)
			for(var/mob/S in BattleList) {BattleList-=S; S.PassedChuunin()}
		else
			RoundOne()

	RoundTwoPassersCheck()
		var/tmp/count=0
		var/tmp/count2=0
		for(var/mob/player/M in BattleList) count++
		for(var/mob/player/M in RoundTwoList) count2++
		if(count==1&&!count2)
			for(var/mob/S in BattleList) {S.PassedChuunin(); RoundTwoList-=S}
		else
			RoundTwo()

	RoundThreePassersCheck()
		var/tmp/count=0
		var/tmp/count2=0
		for(var/mob/player/M in RoundTwoList) count++
		for(var/mob/player/M in RoundThreeList) count2++
		if(count==1&&!count2)
			for(var/mob/S in RoundTwoList)
				S.PassedChuunin(); RoundTwoList-=S
		else
			RoundThree()

	RoundFourPassersCheck()
		var/tmp/count=0
		var/tmp/count2=0
		for(var/mob/player/M in RoundThreeList) count++
		for(var/mob/player/M in RoundFourList) count2++
		if(count==1&&!count2)
			for(var/mob/S in RoundThreeList)
				S.PassedChuunin(); RoundThreeList-=S
		else
			RoundFour()

//----------------- [ Adds last man to next round or spawns another match ] ------------------

	RoundOnePlayerCheck()
		var/check=0
		for(var/mob/player/M in BattleList)
			check++
		if(check<=1)
			for(var/mob/player/M in BattleList)
				RoundTwoList+=M
			RoundTwoPassersCheck()
		else
			RoundOne()

	RoundTwoPlayerCheck()
		var/check=0
		for(var/mob/player/M in RoundTwoList)
			check++
		if(check<=1)
			for(var/mob/player/M in RoundTwoList)
				RoundThreeList+=M
			RoundThreePassersCheck()
		else
			RoundTwo()

	RoundThreePlayerCheck()
		var/check=0
		for(var/mob/player/M in RoundThreeList)
			check++
		if(check<=1)
			for(var/mob/player/M in RoundThreeList)
				RoundFourList+=M
			RoundFourPassersCheck()
		else
			RoundThree()


//---------------- [Exam Protocols ] -----------------------------------

	RoundOne()
		for(var/mob/player/S in BattleList)
			FightingList+=S; BattleList-=S
			var/a=rand(975,989); var/b=rand(73,81)
			S.Wounds=0; S.Stamina=S.StaminaMax; S.Chakra=S.ChakraMax; //Heal up
			S.loc=locate(a,b,2); S.ZCoord="Chuunin Fight"; S.ZCoordProc(S.ZCoord)
			S.ChuuninBattle=1; S.protect=null
			break

		for(var/mob/player/S in BattleList)
			BattleList-=S; FightingList+=S
			var/a=rand(975,989); var/b=rand(73,81)
			S.Wounds=0; S.Stamina=S.StaminaMax; S.Chakra=S.ChakraMax; //Heal up
			S.loc=locate(a,b,2); S.ZCoord="Chuunin Fight"; S.ZCoordProc(S.ZCoord)
			S.ChuuninBattle=1; S.protect=null
			break
		RoundOneCheck()

	RoundTwo()
		for(var/mob/player/S in RoundTwoList)
			RoundTwoList-=S; FightingList+=S
			var/a=rand(975,989); var/b=rand(73,81)
			S.Wounds=0; S.Stamina=S.StaminaMax; S.Chakra=S.ChakraMax; //Heal up
			S.loc=locate(a,b,2); S.ZCoord="Chuunin Fight"; S.ZCoordProc(S.ZCoord)
			S.ChuuninBattle=1; S.protect=null
			break

		for(var/mob/player/S in RoundTwoList)
			RoundTwoList-=S; FightingList+=S
			var/a=rand(975,989); var/b=rand(73,81)
			S.Wounds=0; S.Stamina=S.StaminaMax; S.Chakra=S.ChakraMax; //Heal up
			S.loc=locate(a,b,2); S.ZCoord="Chuunin Fight"; S.ZCoordProc(S.ZCoord)
			S.ChuuninBattle=1; S.protect=null
			break
		RoundTwoCheck()

	RoundThree()
		for(var/mob/player/S in RoundThreeList)
			RoundThreeList-=S; FightingList+=S
			var/a=rand(975,989); var/b=rand(73,81)
			S.Wounds=0; S.Stamina=S.StaminaMax; S.Chakra=S.ChakraMax; //Heal up
			S.loc=locate(a,b,2); S.ZCoord="Chuunin Fight"; S.ZCoordProc(S.ZCoord)
			S.ChuuninBattle=1; S.protect=null
			break

		for(var/mob/player/S in RoundThreeList)
			RoundThreeList-=S; FightingList+=S
			var/a=rand(975,989); var/b=rand(73,81)
			S.Wounds=0; S.Stamina=S.StaminaMax; S.Chakra=S.ChakraMax; //Heal up
			S.loc=locate(a,b,2); S.ZCoord="Chuunin Fight"; S.ZCoordProc(S.ZCoord)
			S.ChuuninBattle=1; S.protect=null
			break
		RoundThreeCheck()

	RoundFour()
		for(var/mob/player/S in RoundFourList)
			RoundFourList-=S; FightingList+=S
			var/a=rand(975,989); var/b=rand(73,81)
			S.Wounds=0; S.Stamina=S.StaminaMax; S.Chakra=S.ChakraMax; //Heal up
			S.loc=locate(a,b,2); S.ZCoord="Chuunin Fight"; S.ZCoordProc(S.ZCoord)
			S.ChuuninBattle=1; S.protect=null
			break

		for(var/mob/player/S in RoundFourList)
			RoundFourList-=S; FightingList+=S
			var/a=rand(975,989); var/b=rand(73,81)
			S.Wounds=0; S.Stamina=S.StaminaMax; S.Chakra=S.ChakraMax; //Heal up
			S.loc=locate(a,b,2); S.ZCoord="Chuunin Fight"; S.ZCoordProc(S.ZCoord)
			S.ChuuninBattle=1; S.protect=null
			break
		RoundFourCheck()