mob/var
	onwaterfall
mob/proc
	WaterfallWalk()
		if(dir==NORTH)
			var/dmg=rand(400,1500)
			if(prob(ChakraControl+Luck))
				var
					Gain=200; Drain=30
				if(Chakra>=30)
					if(equippedweight) {Gain*=(1+(equippedweight/15)); Drain+=(Drain*(equippedweight/10))}
					Chakra-=Drain;
					if(client)
						WaterfallGain(Gain)
					else
						ChakraXP += Gain*0.2
				else {Chakra=1; onwater=0; WaterFALL(); DamageMe(src,dmg,,1)}
			else
				var/cuse=rand(9,29)
				src<<"<font color=#0290cc>Only [cuse]/30 chakra converted. You stumble and fall!</font>"
				Chakra-=cuse; WaterFALL(); onwater=0
		else
			var/dmg=rand(400,1500)
			if((Village=="Waterfall"&&prob(ChakraControl+60+Luck))||prob(ChakraControl+Luck))
				if(Chakra>=10)
					Chakra-=10
					WaterGain()
					if(ChakraXP>=ChakraMXP)
						ChakraUp()
				else {Chakra=1; WaterFALL(); DamageMe(src,dmg,,1); onwater=0}
			else
				var/cuse=rand(1,9)
				src<<"<font color=#0290cc>Only [cuse]/10 chakra converted. You stumble and fall!</font>"
				Chakra-=cuse; onwater=0; WaterFALL()
		RefreshChakra()

	WaterFALL(var/counter, var/D)
		if((!onwater&&onwaterfall))//||counter<10)
			step(src,SOUTH); dir=NORTH; counter++
			spawn(rand(0,1))
				WaterFALL(counter,D)
		else
			D*=(1+(equippedweight/10))
			if(counter>=60) {D=round(counter*99999); DamageMe(src,D,,1)}
			if(counter>=10) {D=round(counter*1000); DamageMe(src,D,,1)}
			if(onwater) {D=round(counter*100); DamageMe(src,D,,1)}


mob/proc/WaterfallWalkSpeed()
	if(onwaterfall)
		if(dir==SOUTH)
			waterfallspeed=movespeed-1; return
		if(dir==NORTH)
			waterfallspeed=movespeed+2; return
		spawn(6)WaterfallWalkSpeed()