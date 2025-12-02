mob/proc
	BeginSwimming()
		set waitfor = 0
		overlays-='WaterWalk.dmi'
		swimming=1;
		icon_state="swim";
		onwater = 0
		for(var/mob/player/p in MasterPlayerList)
			if(p.DynamicMarkingList[trueName])
				p.DynamicMarkingList-=trueName;
				p<<"You can no longer smell [trueName]"
				src<<"[p] can no longer smell you"

		while(swimming)
			if(WW && Chakra > 100)
				var/W=ChakraControl
				if(Village=="Mist") W+=15
				if(prob(W+Luck))
					overlays+='WaterWalk.dmi'
					swimming=0;
					icon_state="";
					onwater = 1
					src<<"<font color=#0290cc>You climbed out of the water!</font>"
					WaterWalk()
			else
				var/SW = 50 + (equippedweight*2)
				if(Stamina < SW)
					DamageMe(src,SW*100,"drowning",1)
				else
					Stamina -= SW

				ApplyEXP(rand(10+SW,100+SW),"Stamina")
				RefreshStats()

			sleep(8)

	WaterWalk()
		set waitfor = 0
		if(AlreadyOnWater)
			return
		AlreadyOnWater=1
		if(client)
			while(onwater)
				if(!WW)
					if(!swimming)
						src<<"<font color=#0290cc>You fell in the water!</font>"
						BeginSwimming()
				else
					var/W=(ChakraControl+rand(10,30))
					if(Village=="Mist") W+=15
					if(prob(W+Luck))
						var/c=5
						if(ChakraControl<100)
							c=rand(5,25)
						if(Chakra<c)
							if(!swimming)
								src<<"<font color=#0290cc>You fell in the water!</font>"
								BeginSwimming()
						else
							if(ChakraControl<100)
								src << "<font color=#0290cc>[c]/5 Chakra converted.</font>"
								CCGain(5)
							WaterGain();
							if(ChakraXP>=ChakraMXP)
								ChakraUp();
							Chakra-=c
					else
						Stamina-=40; DamageMe(src,0,,1)
						if(!swimming)
							src<<"<font color=#0290cc>You fell in the water!</font>"
							BeginSwimming()

				RefreshStats()
				sleep(8)
		else// if(onwater&&istype(src,/mob/Hittable/Command/Clones))
			while(onwater)
				WaterGain();
				sleep(8)

		AlreadyOnWater = 0

	OPWaterWalk()
		chakraWW=1
		spawn(20)
			chakraWW=0 // Remove chakra buff
//-------------------------------------------------------------------------------------------------------
	WaterGain()
		var/e=rand(12,66)
		if(chakraWW) {e*=40}
		if(ChakraTrue>=Cap_Chakra) e*=0.3
		ApplyEXP(e,"chakra")

	WaterfallGain(GAIN)
		if(ChakraTrue>=Cap_Chakra) GAIN*=0.3
		ApplyEXP(GAIN,"chakra")