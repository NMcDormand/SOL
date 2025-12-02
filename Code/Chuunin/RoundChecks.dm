proc
	RoundOneCheck()
		var/tmp/count=0
		for(var/mob/player/P in FightingList)
			count++
			if(P.eliminated) FightingList-=P
		if(count==1)
			for(var/mob/player/P in FightingList)
				P.loc=locate(979,30,2); P.protect=1; RoundTwoList+=P; FightingList-=P
			RoundOnePlayerCheck()
		else if(count>=1)
			spawn(20)RoundOneCheck()
		else return

	RoundTwoCheck()
		var/tmp/count=0
		for(var/mob/player/P in FightingList)
			count++
			if(P.eliminated) FightingList-=P
		if(count==1)
			for(var/mob/player/P in FightingList)
				P.loc=locate(979,30,2); P.protect=1; RoundThreeList+=P; FightingList-=P
			RoundTwoPlayerCheck()
		else
			spawn(20)RoundTwoCheck()

	RoundThreeCheck()
		var/tmp/count=0
		for(var/mob/player/P in FightingList)
			count++
			if(P.eliminated) FightingList-=P
		if(count==1)
			for(var/mob/player/P in FightingList)
				P.loc=locate(979,30,2); P.protect=1; RoundFourList+=P; FightingList-=P
			RoundThreePlayerCheck()
		else
			spawn(20)RoundThreeCheck()

	RoundFourCheck()
		var/tmp/count=0
		for(var/mob/player/P in FightingList)
			count++
			if(P.eliminated) FightingList-=P
		if(count==1)
			for(var/mob/player/P in FightingList)
				P.PassedChuunin(); FightingList-=P
		else
			spawn(20)RoundFourCheck()