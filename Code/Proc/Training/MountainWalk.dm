mob/var/tmp/Falling=0
mob/var/tmp/RecentTrainingMessage

mob/proc/MountainWalkSpeed()
	if(onmountain)
		if(dir==SOUTH) {mountainspeed=movespeed+2; return}
		if(dir==SOUTHWEST||dir == SOUTHEAST) {mountainspeed=movespeed+3; return}
		if(dir==EAST||dir == WEST) {mountainspeed=movespeed+5; return}
		if(dir==NORTH) {mountainspeed=movespeed+6; return}
		if(dir == NORTHEAST||dir==NORTHWEST) {mountainspeed=movespeed+7; return}
		if(mountainspeed<9) mountainspeed=9

//------------------------------------------------------------------------------------------------------------

mob/proc
	MountainWalk()
		var
			Drain=1; StamExp=1
			TaiExp=pick(7,10,20,30,10,20)
		if(dir==NORTH)
			if(prob(80)) Drain+=rand(200,400)
			StamExp+=65
		if(dir==NORTHEAST||dir==NORTHWEST)
			if(prob(90)) Drain+=rand(200,450)
			StamExp+=55
		if(dir==NORTHEAST||dir==NORTHWEST||dir==NORTH)
			if(prob(50)) StamExp*=1.1
			if(prob(3)) StamExp*=3
			if(prob(30)) Drain*=3
			if(equippedweight)
				StamExp*=(8+(equippedweight)); Drain+=(Drain*(equippedweight/2))
			ApplyEXP(StamExp,"Stamina")
			ApplyEXP(TaiExp,"taijutsu")
			//Stamina-=Drain
			var/PB
			switch(Stamina)
				if(0 to 100000)
					PB = 15
				if(100001 to 200000)
					PB = 13
				if(200001 to 300000)
					PB = 11
				if(300001 to 400000)
					PB = 9
				if(400001 to 500000)
					PB = 7
				if(500001 to 600000)
					PB = 5
				if(500001 to 900000)
					PB = 4
				else
					PB = 2
			if(prob(PB-(Luck*0.1))) MountainFall()
			Stamina-=Drain
			RefreshStats()

//------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------
	MountainFall()
		spawn()
			src<<"<i>You stumble and fall</i></font>"
			Falling=1;
			var/mountainfall=rand(1,4)
			while(onmountain)
				if(mountainfall<=0) break
				mountainfall--;
				step(src,SOUTH)
				sleep(1)
			Falling=0