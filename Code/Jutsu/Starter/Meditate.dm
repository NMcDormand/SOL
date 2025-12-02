mob/var
	MeditationComplete
	MeditationPoints=0
	tmp
		meditating
		meditatetime

obj/SkillCards/Starter/Meditate
	icon='Card_Icons.dmi'
	icon_state="card_meditate"
	cmdstring="Meditate"
	JutsuType = "Other"
	CanLevel=0

	Description = list(
		"about"="Use this to slowly raise your chakra over time. This technique requires no prescence from the player, but it is very slow."
		,"title"="Meditate"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="E"
		,"pic"='Meditate.png'
		)

	Activate(mob/U)
		if(U.meditating)
			spawn(40)
				if(U)
					U.meditatetime=0
			U.firing=0; U.attacking=0
			U.icon_state=null; U<<"You stop meditating."; U.meditating=0
		else
			if(U.Gate||U.ReverseFlow||U.ShadowCaptured||U.RaitonCurrent||U.ShibariHit||U.InFakeView||U.InSPS||U.BlockedTenketsu||U.Drugged||U.Dispelling||U.AFK||U.JubakuBound||U.Kanashibari||U.InNarakumi||U.dead||U.MushiKabe||U.mirroring||U.UsingWaterPrison||U.InMesu||U.InCloak||U.Coffin||U.DeathSee||U.EventLock||U.Webbed||U.fishing||U.healingself||U.firing||U.KO||U.Blocking||U.throwing||U.Sleeping||U.waterprisoned||U.IceBlasted||U.resting||U.jailed||U.frozen||U.GMfrozen||U.InTsukuyomi||U.Tsukuyomi||U.swimming||U.kaiten||U.climbing||U.InSoutourou||U.InKageArashi) return
			if(U.meditatetime||U.resting) return
			U.meditatetime=1
			U.icon_state="rest"
			U<<"You sit down and meditate."
			U.meditating=10
			if(U.ZCoord == "Revolution" && !SpecialMobs["Viole"] && !VioleDisabled)
				spawn()
					/*var/obj/SkillCards/Ninjutsu/Special/Tower/ShinsuStream/J=locate() in U.contents
					if(!J)*/
					var/A = 0
					while(U.meditating)
						if(SpecialMobs["Viole"] || VioleDisabled)
							break
						sleep(600)
						A++
						if(!SpecialMobs["Viole"] && !VioleDisabled)
							if(A >= 10)
								U<<"<b>The Light suddenly went out and you feel an immense pressure build in the cave!</font></Y>"
								for(var/Map/Darkness/D in range(30))
									if(!D.Checking)
										//D.invisibility = 0
										D.LightCheck()
								new/mob/Hittable/Responsive/Boss/Viole(locate(23,503,2))
								break
						CHECK_TICK
			spawn(20)
				if(U)
					U.meditate()
			U.firing=1; U.attacking=1

mob/proc/meditate()
	set waitfor = 0
	var/C
	if(cheater) return
	var/TIMEINCREASE = 1
	var/TIME = 0
	while(meditating)
		var/multi=(round(abs(ChakraTrue/50000)))+1 //Grab the amount of 10k numbers in this
		if(ChakraTrue<200) C=rand(1,3)
		else if(ChakraTrue>=200&&ChakraTrue<500) C=rand(2,4)
		else if(ChakraTrue>=500&&ChakraTrue<1000) C=rand(3,5)
		else if(ChakraTrue>=1000&&ChakraTrue<5000) C=rand(4,6)
		else if(ChakraTrue>=5000) C=rand(1,10)
		if(multi) C*=multi

		if(TIME)
			C += C*TIME

		ChakraMax+=C; ChakraTrue+=C; StatUpdate_chakra()
		//Cap_Chakra += C;

		if(Clan=="Akimichi"&&Calories<CALORIEMAX)
			Calories(8)

		TIMEINCREASE++
		if(TIMEINCREASE >= 60)
			TIMEINCREASE = 0
			TIME += 0.02
			switch(pick(1,2,3,4,5))
				if(1)
					MXP *= 0.9
					src<<"<i>You have achieved a higher state of self awareness.</i>"
				if(2)
					ChakraMXP *= 0.95
					src<<"<i>You have achieved a higher state of enrichment.</i>"
				if(3)
					StaminaMXP *= 0.95
					src<<"<i>You have achieved a higher state of internal growth.</i>"
				if(4)
					TaijutsuMXP *= 0.97
					src<<"<i>You have achieved a higher state of stability.</i>"
				if(5)
					NinjutsuMXP *= 0.97
					src<<"<i>You have achieved a higher state of understanding.</i>"
				if(6)
					GenjutsuMXP *= 0.97
					src<<"<i>You have achieved a higher state of calm.</i>"

		sleep(rand(80,160))

		CHECK_TICK
