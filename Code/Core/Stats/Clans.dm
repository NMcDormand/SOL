mob/var/list/Multipliers = list("Stamina" = 1,"Chakra"=1,"Taijutsu"=1,"Ninjutsu"=1,"Genjutsu"=1,"Jutsu"=1)

var/list/WorldMultis = CLANMULTIS

proc
	Repair_Start(mob/M)
		if(!WorldMultis || !WorldMultis.len)
			WorldMultis = CLANMULTIS

		for(var/A in M.Multipliers)
			M.Multipliers[A] = WorldMultis[M.Clan][A]

		switch(M.Clan)
			if("Aburame")
				M.Clan="Aburame"
				M.KonchuuLimit+=5
				M.ChakraControlMXP=100

			if("Akimichi")
				M.Clan="Akimichi"
				M.Calories+=50

			if("Hyuuga")
				M.Clan="Hyuuga"
				//M.PE="Earth"
				M.Eyes="Hyuuga"
				M.EyeIcon = new/Overlay_Obj('HyuugaEyes.dmi',EYE_LAYER)
				M.ChakraControlMXP=20

			if("Inuzuka")
				M.Clan="Inuzuka"
				new/obj/SkillCards/Clan/Inuzuka/Tame(M)

			if("Kaguya")
				M.Clan="Kaguya"
				M.SSMXP=20

			if("Nara")
				M.Clan="Nara"

			if("Taijutsu Specialist")
				M.Clan="Taijutsu Specialist"
				//M.Speciality="Taijutsu"
				M.Chakra+=10; M.ChakraMax+=10; M.ChakraTrue+=10;

			if("Uchiha")
				M.Clan="Uchiha"
				M.PE="Fire"
				M.FireElemental+=10
				M.SSMXP=10
				if(!M.SharType)
					M.SharType = pick(1,2,3,4,5)

			if("Uzumaki")
				M.Clan="Uzumaki"
				M.Stamina+=1600; M.StaminaMax+=1600; M.StaminaTrue+=1600;
				M.Chakra+=5000; M.ChakraMax+=5000; M.ChakraTrue+=5000

			if("Yuki")
				M.Clan="Yuki"
				M.PE="Water"
				M.SE="Wind"
				M.ChakraControlMXP=20
				M.SSMXP=20

			if("Sand")
				M.Clan="Sand"
				M.PE="Wind"
				M.WindElemental+=10
				M.ChakraControlMXP=20

				var/obj/Item/Clan/Gourd/G = locate() in M.contents
				if(!G)
					G = new(M)
					M<<"<i><b>Gourd</b> added to Items!</i>"

			if("Clay")
				M.Clan="Clay"
				M.PE="Earth"
				M.SE="Lightning"
				M.EarthElemental+=10
				M.LightningElemental+=10

			if("Sarutobi")
				M.Clan="Sarutobi"
				M.PE = pick("Wind","Water","Earth")
				M.SE = pick("Lightning","Fire")
				M.FireElemental+=10
				M.WindElemental+=10
				M.WaterElemental+=10
				M.EarthElemental+=10
				M.LightningElemental+=10

			if("Senju")
				M.Clan="Senju"
				M.ChakraControlMXP=10

			if("Otsutsuki")
				M.Clan="Otsutsuki"
		M.StartGamerepair()
		if(M.NinjaRank != "Academy Student")
			if(M.SyncMyRebirth())
				M.RebirthData.Birthed(M)
				M.ResetMyCaps()
		AdminActionLog("Repair Start",,,M.trueName)

	clan_Start(clan_name, mob/M)
		M.Stamina=100; M.StaminaMax=100; M.StaminaTrue=100
		M.StaminaXP=0; M.StaminaMXP=100

		M.Chakra=50; M.ChakraMax=50; M.ChakraTrue=50

		M.ChakraControl=20; M.ChakraControlTrue=20
		M.ChakraControlXP=0; M.ChakraControlMXP=60;

		M.Taijutsu=10; M.TaijutsuMax=10; M.TaijutsuTrue=10
		M.TaijutsuXP=0; M.TaijutsuMXP=50

		M.Genjutsu=10; M.GenjutsuMax=10; M.GenjutsuTrue=10
		M.GenjutsuXP=0; M.GenjutsuMXP=50

		M.Ninjutsu=10; M.NinjutsuMax=10; M.NinjutsuTrue=10
		M.NinjutsuXP=0; M.NinjutsuMXP=100

		if(!WorldMultis || !WorldMultis.len)
			WorldMultis = CLANMULTIS

		for(var/A in M.Multipliers)
			M.Multipliers[A] = WorldMultis[clan_name][A]

		switch(clan_name)
			if("Aburame")
				M.Clan="Aburame"
				M.KonchuuLimit=5
				M.ChakraControlMXP=100

			if("Akimichi")
				M.Clan="Akimichi"
				M.Calories=50

			if("Hyuuga")
				M.Clan="Hyuuga"
				//M.PE="Earth"
				M.Eyes="Hyuuga"
				M.EyeIcon = new/Overlay_Obj('HyuugaEyes.dmi',EYE_LAYER)
				M.ChakraControlMXP=20

			if("Inuzuka")
				M.Clan="Inuzuka"
				new/obj/SkillCards/Clan/Inuzuka/Tame(M)

			if("Kaguya")
				M.Clan="Kaguya"
				M.SSMXP=20

			if("Nara")
				M.Clan="Nara"
				M.ChakraControlMXP=20

			if("Taijutsu Specialist")
				M.Clan="Taijutsu Specialist"
				//M.Speciality="Taijutsu"
				M.Chakra=10; M.ChakraMax=10; M.ChakraTrue=10;

			if("Uchiha")
				M.Clan="Uchiha"
				M.PE="Fire"
				M.SSMXP=10
				M.SharType = pick(1,2,3,4,5)

			if("Uzumaki")
				M.Clan="Uzumaki"
				M.SS=22
				M.ChakraControl=5; M.ChakraControlTrue=5
				M.Stamina=1600; M.StaminaMax=1600; M.StaminaTrue=1600; M.StaminaMXP=50
				M.Chakra=5000; M.ChakraMax=5000; M.ChakraTrue=5000
				M.Taijutsu=1; M.TaijutsuMax=1; M.TaijutsuTrue=1
				M.Genjutsu=1;M.GenjutsuMax=1; M.GenjutsuTrue=1;
				M.Ninjutsu=1; M.NinjutsuMax=1; M.NinjutsuTrue=1

			if("Yuki")
				M.Clan="Yuki"
				M.PE="Water"
				M.SE="Wind"
				M.ChakraControlMXP=20
				M.SSMXP=20

			if("Sand")
				M.Clan="Sand"
				M.PE="Wind"
				M.ChakraControlMXP=20
				new/obj/Item/Clan/Gourd(M);
				src<<"<i><b>Gourd</b> added to Items!</i>"

			if("Clay")
				M.Clan="Clay"
				M.PE="Earth"
				M.SE="Lightning"
				M.ClayMax = 100

			if("Sarutobi")
				M.Clan="Sarutobi"

			if("Senju")
				M.Clan="Senju"
				M.PE = pick("Wind","Water","Earth")
				M.SE = pick("Lightning","Fire")
				M.FireElemental=10
				M.WindElemental=10
				M.WaterElemental=10
				M.EarthElemental=10
				M.LightningElemental=10
				M.ChakraControlMXP=10

			if("Otsutsuki")
				M.Clan="Otsutsuki"


mob/proc
	StartGamerepair()
		if(!MasterPlayerList) MasterPlayerList=new()
		if(!(src in MasterPlayerList)) MasterPlayerList+=src
		NameArchive()
		gold+=500
		new/obj/Clothing/Feet/Sandals(src);
		new/obj/Clothing/Pants/Pants(src)
		switch(Village)
			if("Rock") new/obj/Clothing/Shirt/RockShirt(src)
			if("Leaf") new/obj/Clothing/Shirt/LeafShirt(src)
			if("Grass") new/obj/Clothing/Shirt/GrassShirt(src)
			if("Cloud") new/obj/Clothing/Shirt/CloudShirt(src)
			if("Rain") new/obj/Clothing/Shirt/RainShirt(src)
			if("Sound") new/obj/Clothing/Shirt/SoundShirt(src)
			if("Mist") new/obj/Clothing/Shirt/MistShirt(src)
			if("Waterfall") new/obj/Clothing/Shirt/WaterfallShirt(src)
			if("Sand") new/obj/Clothing/Shirt/SandShirt(src)

		var/firstletter=copytext(ckey, 1, 2)
		if(fexists("Saves/[firstletter]/[ckey]/[Slot]/Rebirth.sav"))
			var/savefile/RB = new("Saves/[firstletter]/[ckey]/[Slot]/Rebirth.sav")
			RB["REData"] >> RebirthData
			src<<"Rebirth Amount: [RebirthData.Total]";
			spawn(10)
				RebirthData.Birthed(src)
			if(RB["CSBites"])
				RB["CSBites"] >> OroBittenTimes
			if(RB["PlayerKills"])
				RB["PlayerKills"] >> PlayerKills
			if(RB["VillageKills"])
				RB["VillageKills"] >> VillageKills
			if(RB["CriminalKills"])
				RB["CriminalKills"] >> CriminalKills
			if(RB["AnimalKills"])
				RB["AnimalKills"] >> AnimalKills
			if(RB["LargeAnimalKills"])
				RB["LargeAnimalKills"] >> LargeAnimalKills
			if(RB["TotalKills"])
				RB["TotalKills"] >> TotalKills
			if(prob(0.1))
				src<<"You feel an overwhelming amount of chakra build inside you, it's here. How do you use it though?";
				ChakraTrue=999999;
			world<<"<font color=green><b>[src]</b> is restarting in [Village]. Amount restarted: [RebirthData.Total]"

		UpdateInventory();
		StatUpdate_SelfImage()
		WipeVersion=WorldVersion

		spawn(600) PlayerOnlineTime()
		//FriendlyFire["village"]=1
		LoadSkin()
		loggedin=1
		RefreshPlayerStats()
		PreLoadHotBar()
		CheckToggles()
		//gift()
		statboost() // Give a stat boost to the player on creation!
		RefreshStats()
		GMList()
		Set_Float()
		SV = WorldSaveVersion
		spawn(100) LoadHUD()