
mob/player/verb
	BunshinLimitDown()
		set hidden=1
		if(BunshinLimit>0)
			BunshinLimit--
			winset(src,"Stats.B_Limit","text=[BunshinLimit]")
	BunshinLimitUp()
		set hidden=1
		if(BunshinLimit<BunshinLimitMax)
			BunshinLimit++
			winset(src,"Stats.B_Limit","text=[BunshinLimit]")
	StatsSkillsSwap()
		set hidden=1
		switch(winget(src,"Stats.Skills_Child","left"))
			if("Skills")
				winset(src,"Stats.Skills_Child","left=NinGenTai")
				if(Clan=="Inuzuka")
					winset(src,"Stats.SkillsButton","image=['Dog.png']")
				else
					winset(src,"Stats.SkillsButton","image=['Skills.png']")
			if("NinGenTai")
				if(Clan=="Inuzuka")
					winset(src,"Stats.Skills_Child","left=DogStats")
					winset(src,"Stats.SkillsButton","image=['Skills.png']")
				else
					winset(src,"Stats.Skills_Child","left=Skills")
					winset(src,"Stats.SkillsButton","image=['Stats.png']")
			if("DogStats")
				winset(src,"Stats.Skills_Child","left=Skills")
				winset(src,"Stats.SkillsButton","image=['Stats.png']")

mob/proc
	RefreshPlayerStats()
		src<<output("[PE]:","NinGenTai.PrimaryElement_Title")
		src<<output("[SE]:","NinGenTai.SecondaryElement_Title")
		StatUpdate_SelfImage()
		StatUpdate_equipped()
		UpdateDurabilityMeter()
		StatUpdate_playername()
		StatUpdate_level()
		StatUpdate_gold()
		StatUpdate_statpoints()
		StatUpdate_taijutsu()
		StatUpdate_ninjutsu()
		StatUpdate_genjutsu()
		StatUpdate_chakra()
		StatUpdate_stamina()
		StatUpdate_dogStuff()
		StatUpdate_reflexes()
		StatUpdate_sealspeed()
		StatUpdate_primaryelement()
		StatUpdate_secondaryelement()
		StatUpdate_chakracontrol()
		StatUpdate_Unarmed()
		StatUpdate_Kunai()
		StatUpdate_Sword()
		StatUpdate_Throwing()
		StatUpdate_Crafting()
		StatUpdate_Time()
		StatUpdate_FirstAid()
		StatUpdate_Fishing()
		StatUpdate_village()
		StatUpdate_rank()
		StatUpdate_profession()
		StatUpdate_bunshinlimit()
		StatUpdate_movespeed()
		StatUpdate_wounds()

		StatUpdate_InitialBugs()
		StatUpdate_bugs()

		StatUpdate_InitialCalories()
		StatUpdate_Calories()


	StatUpdate_dogStuff()
		var/mob/Hittable/Responsive/Animal/Pet/D=Familiar
		if(!D) return
		if(client)
			src<<output("[D.name]'s Information","DogStats.dogName")
			src<<output("[num2text(round(D.Stamina,1),9)] / [num2text(round(D.StaminaMax,1),9)]","DogStats.dogStamina")
			src<<output("[num2text(round(D.Taijutsu,1),9)]","DogStats.dogTaijutsu")

	StatUpdate_SelfImage()
		if(client) src<<output("\icon [AcquireSelfImage(src)]","Stats.PlayerDisplay")

	StatUpdate_playername()
		if(client) src<<output(name,"Stats.PlayerName")

	StatUpdate_level()
		if(client)
			if(!wearingMask && !InHenge)
				Set_Float()
			src<<output(Level,"Stats.level")

	StatUpdate_gold()
		if(client) src<<output(round(gold),"Stats.Gold")

	StatUpdate_statpoints()
		if(client) src<<output(StatPoints,"Stats.StatPoints")

	StatUpdate_village()
		if(client) src<<output(Village,"Stats.Village")

	StatUpdate_rank()
		if(client) src<<output(NinjaRank,"Stats.NinjaRank")

	StatUpdate_profession()
		if(client) src<<output(Class,"Stats.Class")

	StatUpdate_equipped()
		if(client)
			if(wielding) src<<output(wielding,"Stats.Wielding")
			else  src<<output("Unarmed","Stats.Wielding")

	UpdateDurabilityMeter()
		if(client)
			var/D=0
			for(var/obj/Weapon/Wield/w in contents)
				if(w.worn)
					if(w.MaxDurability)
						D=round((w.Durability/w.MaxDurability)*100)
			winset(src, "Stats.durability", "value='[D]'")

	StatUpdate_bunshinlimit()
		if(client) src<<output(BunshinLimit,"Stats.B_Limit")

	StatUpdate_taijutsu()
		if(client) src<<output("[num2text(round(Taijutsu,1),7)]","NinGenTai.Taijutsu")

	StatUpdate_ninjutsu()
		if(client) src<<output("[num2text(round(Ninjutsu,1),7)]","NinGenTai.Ninjutsu")

	StatUpdate_genjutsu()
		if(client) src<<output("[num2text(round(Genjutsu,1),7)]","NinGenTai.Genjutsu")

	StatUpdate_sealspeed()
		if(client) src<<output("[round(SS)*0.1]","NinGenTai.SealSpeed")

	StatUpdate_reflexes()
		if(client) src<<output("[abs((Reflex))]","NinGenTai.Reflexes")

	StatUpdate_movespeed()
		if(client) src<<output("[abs(setspeed-4)]","NinGenTai.MoveSpeed")

	StatUpdate_chakra()
		if(client)
			if(HasSeal=="Genesis Seal")
				src<<output("[num2text(round(Chakra,1),9)] / [num2text(round(ChakraMax,1),9)] ([StoredChakra])","Stats.Chakra")
			else
				src<<output("[num2text(round(Chakra,1),9)] / [num2text(round(ChakraMax,1),9)]","Stats.Chakra")

	StatUpdate_stamina()
		if(client)
			src<<output("[num2text(round(Stamina,1),9)] / [num2text(round(StaminaMax,1),9)]","Stats.Stamina")

	StatUpdate_wounds()
		if(client) src<<output("[num2text(round(Wounds,1),7)]%","Stats.Wounds")

	StatUpdate_primaryelement()
		if(client)
			switch(PE)
				if("Fire") src<<output("[num2text(round(FireElemental,1),7)]","NinGenTai.PrimaryElement")
				if("Water") src<<output("[num2text(round(WaterElemental,1),7)]","NinGenTai.PrimaryElement")
				if("Wind") src<<output("[num2text(round(WindElemental,1),7)]","NinGenTai.PrimaryElement")
				if("Earth") src<<output("[num2text(round(EarthElemental,1),7)]","NinGenTai.PrimaryElement")
				if("Lightning") src<<output("[num2text(round(LightningElemental,1),7)]","NinGenTai.PrimaryElement")

	StatUpdate_secondaryelement()
		if(client)
			switch(SE)
				if("Fire") src<<output("[num2text(round(FireElemental,1),7)]","NinGenTai.SecondaryElement")
				if("Water") src<<output("[num2text(round(WaterElemental,1),7)]","NinGenTai.SecondaryElement")
				if("Wind") src<<output("[num2text(round(WindElemental,1),7)]","NinGenTai.SecondaryElement")
				if("Earth") src<<output("[num2text(round(EarthElemental,1),7)]","NinGenTai.SecondaryElement")
				if("Lightning") src<<output("[num2text(round(LightningElemental,1),7)]","NinGenTai.SecondaryElement")
	StatUpdate_chakracontrol()
		if(client) src<<output("[round(ChakraControl)]%","Stats.CC")

	StatUpdate_Unarmed()
		if(client) src<<output(round(H2HSkill),"Skills.Unarmed")

	StatUpdate_Kunai()
		if(client) src<<output(round(KnifeSkill),"Skills.Kunai")

	StatUpdate_Sword()
		if(client) src<<output(round(SwordSkill),"Skills.Sword")

	StatUpdate_Throwing()
		if(client) src<<output(round(ThrowingSkill),"Skills.Throwing")

	StatUpdate_Crafting()
		if(client) src<<output(round(CraftingSkill),"Skills.Crafting")

	StatUpdate_FirstAid()
		if(client) src<<output(round(FirstAidSkill),"Skills.FirstAid")

	StatUpdate_Fishing()
		if(client) src<<output(round(FishingSkill),"Skills.Fishing")
	StatUpdate_bugs()
		if(client&&Clan=="Aburame")
			src<<output("[Konchuuamount]/[KonchuuLimit]","NinGenTai.NGT_ExtraStat")
	StatUpdate_InitialBugs()
		if(client&&Clan=="Aburame")
			src<<output("Insects:","NinGenTai.NGT_ExtraStatTitle")
	StatUpdate_Calories()
		if(client&&Clan=="Akimichi")
			src<<output("[Calories]","NinGenTai.NGT_ExtraStat")
	StatUpdate_InitialCalories()
		if(client&&Clan=="Akimichi")
			src<<output("Calories:","NinGenTai.NGT_ExtraStatTitle")
//	StatUpdate_Repair()
//		if(client) src<<output(RepairSkill,"Skills.Repair")

	StatUpdate_Time()
		if(client) src<<output(time2text(world.timeofday,"hh:mm"),"ButtonArray.Clock")
proc/ClockRefresher()
	set waitfor = 0
	spawn(600) ClockRefresher()
	for(var/mob/m in MasterPlayerList) {m.StatUpdate_Time(); sleep(1)}