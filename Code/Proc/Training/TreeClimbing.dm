mob/var/tmp
	climbing
	stillclimbing
	distance=0
mob/proc
	TreeClimb()
		if(stillclimbing)
			distance++
			if(prob(ChakraControl+rand(8,20)+Luck))
				src<<"5/5 chakra converted"; Chakra-=5
			else
				switch(pick(1,2,prob(125+Luck); 3))
					if(1)
						src<<"6/5 chakra converted; you're propelled off the tree!"; Chakra-=6
						stillclimbing=0; icon_state="TreeFall";
					else if(2)
						src<<"Only 4/5 chakra converted; you lose your footing!"; Chakra-=4
						stillclimbing=0; icon_state="TreeFall";
					else if(3)
						src<<"5/5 chakra converted."; Chakra-=5
			pixel_y+=7
			if(distance>9)
				src<<"You made it all the way up the tree!"
				CCGain(75)
				stillclimbing=0
				spawn(20)climbing=0
				icon_state="TreeFall"
				TreeFall()
			spawn(2)TreeClimb()
		else
			var/CCgain=rand(4,7)
			if(ChakraControl>=43)CCgain*=0.15
			CCGain(CCgain*distance)
			var/Gain=(rand(100,300)*0.005)
			if(ChakraTrue>=Cap_Chakra) Gain*=0.05
			ChakraMax+=Gain; ChakraTrue+=Gain
			stillclimbing=0; spawn(20)climbing=0
			if(distance<1) {src<<"You failed to find footing on the tree"; icon_state=null; overlays-='WaterWalk(Old).dmi'; return}
			else {icon_state="TreeFall"; TreeFall(); return}
		RefreshStats()

	TreeFall()
		if(StaminaTrue<1000)
			if(pixel_y>0)
				pixel_y-=7; spawn(1)TreeFall()
			else
				icon_state=null; pixel_y=0; overlays-='WaterWalk(Old).dmi'
				if(distance<10) DamageMe(src,(7*distance),,1)
				distance=0
			RefreshStats()
		else
			if(pixel_y>0)
				pixel_y-=7; spawn(1)TreeFall()
			else
				icon_state=null; pixel_y=0; overlays-='WaterWalk(Old).dmi'
				if(distance<10) DamageMe(src,(14*distance),,1)
				distance=0
			RefreshStats()