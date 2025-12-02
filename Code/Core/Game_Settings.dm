var
//World Settings
	WORLD_FPS=30
	ForcedRebirth = 0
	RebirthOffer = 5
	CurrentRebirthVersion = 1
	RebirthCap = 0
	RebirthPercentage = 0.1 // 1 is 100% How much of the stats to transfer
	CatchUP = 0.1 //0 is off, 0.1 is 1% of the percentage taken for individual rebirth data
	list/GlobalRebirthTotal //Accumulated Rebirth Totals
	KageDeathEject = 5
	KageKillEject = 3
	MultiBuffs = 0
	RFXMax = 600

//Stat Experience Multipliers (Found in Skill Experience.dm)
	EXP_BASE=1
	EXPGains_Stamina=1
	EXPGains_Chakra=1
	EXPGains_Taijutsu=1
	EXPGains_Ninjutsu=1
	EXPGains_Genjutsu=1
	EXPGains_JutsuLevel=1

//Clans
	Clan_Aburame_Enabled=1
	Clan_Haku_Enabled=1
	Clan_Hyuuga_Enabled=1
	Clan_Inuzuka_Enabled=0
	Clan_Kaguya_Enabled=1
	Clan_Nara_Enabled=1
	Clan_Uchiha_Enabled=1
	Clan_TaiSpec_Enabled=1
	Clan_Akimichi_Enabled=1
	Clan_Uzumaki_Enabled=1
	Clan_Sand_Enabled=1
	Clan_Clay_Enabled=1
	Clan_Sarutobi_Enabled=1
	Clan_Senju_Enabled=1
	Clan_Otsutsuki_Enabled=1

//player Start Stats
	Player_Boost_Enabled=0
	Player_Boost_Times=0
	Player_Boost_Stamina=10000
	Player_Boost_Chakra=1000
	Player_Boost_Ninjutsu=500
	Player_Boost_Taijutsu=500
	Player_Boost_Genjutsu=500
	Player_Boost_Gold=10000

//World Effects
	show_waterwalk_effects=0
//Sub Stuff
	Sub_Shop_Available=1
//Exam Stuff
	chuuninDelay=30000 //Used to be 66k, number excludes 10 minutes of countdown

//NPC Changes
	//Orochimaru
	Oro_Bite_Chance=1
	//Itachi
	Itachi_Stamina
	Itachi_Taijutsu
	Itachi_Ninjutsu
	Itachi_Reflex
	//Gaara
	Gaara_Stamina
	Gaara_Taijutsu
	Gaara_Ninjutsu
	Gaara_Reflex
	//Proc
	CrimMulti = 1
	VilMulti = 1
	AniMulti = 1

//Information window HTML (Non official servers only)
	motd_custom = "Welcome to the server! Enjoy your stay!"

proc
	SaveBank()
		var/savefile/B = new("Data/Wipe/CitiBank.sav")
		B["Bank"] << CitiBank

	LoadGameSettings()
		if(fexists("Data/NoWipe/GameSettings.sav"))
			var/savefile/F = new ("Data/NoWipe/GameSettings.sav")
			F["motd"]>>motd_custom
			F["World_FPS"]>>WORLD_FPS
			F["Base_Exp"]>>EXP_BASE
			F["Stamina_Exp"]>>EXPGains_Stamina
			F["Chakra_Exp"]>>EXPGains_Chakra
			F["Taijutsu_Exp"]>>EXPGains_Taijutsu
			F["Ninjutsu_Exp"]>>EXPGains_Ninjutsu
			F["Genjutsu_Exp"]>>EXPGains_Genjutsu
			F["JutsuLevel_Exp"]>>EXPGains_JutsuLevel
			F["MultiBuffs"] >> MultiBuffs
			F["ClanMultis"] >> WorldMultis
			if(!WorldMultis || !WorldMultis.len)
				WorldMultis = list(
					"Aburame" = list("Stamina" = 1,"Chakra" = 1.2,"Taijutsu" = 0.3,"Ninjutsu" = 1.6,"Genjutsu" = 1.3,"Jutsu" = 1.2),
					"Akimichi" = list("Stamina" = 1.4,"Chakra" = 1.1,"Taijutsu" = 1.2,"Ninjutsu" = 0.5,"Genjutsu" = 0.5,"Jutsu" = 0.6),
					"Hyuuga" = list("Stamina" = 1.2,"Chakra" = 0.5,"Taijutsu" = 1.5,"Ninjutsu" = 0.5,"Genjutsu" = 0.8,"Jutsu" = 1.1),
					"Inuzuka" = list("Stamina" = 1.2,"Chakra" = 1,"Taijutsu" = 1.2,"Ninjutsu" = 0.8,"Genjutsu" = 0.8,"Jutsu" = 1),
					"Kaguya" = list("Stamina" = 1.4,"Chakra" = 1.2,"Taijutsu" = 0.7,"Ninjutsu" = 1.6,"Genjutsu" = 0.1,"Jutsu" = 0.7),
					"Nara" = list("Stamina" = 1.2,"Chakra" = 1.3,"Taijutsu" = 0.3,"Ninjutsu" = 1,"Genjutsu" = 1.2,"Jutsu" = 1.2),
					"Taijutsu Specialist" = list("Stamina" = 2,"Chakra" = 0.5,"Taijutsu" = 2.2,"Ninjutsu" = 0.1,"Genjutsu" = 0.1,"Jutsu" = 0.5),
					"Uchiha" = list("Stamina" = 1,"Chakra" = 1,"Taijutsu" = 1,"Ninjutsu" = 1,"Genjutsu" = 1,"Jutsu" = 2),
					"Uzumaki" = list("Stamina" = 2.5,"Chakra" = 3,"Taijutsu" = 1.2,"Ninjutsu" = 1.2,"Genjutsu" = 0.2,"Jutsu" = 0.7),
					"Yuki" = list("Stamina" = 1,"Chakra" = 1.4,"Taijutsu" = 0.7,"Ninjutsu" = 1.6,"Genjutsu" = 0.7,"Jutsu" = 1.6),
					"Sand" = list("Stamina" = 1,"Chakra" = 1.7,"Taijutsu" = 0.9,"Ninjutsu" = 1.6,"Genjutsu" = 0.2,"Jutsu" = 1.2),
					"Clay" = list("Stamina" = 1,"Chakra" = 1.4,"Taijutsu" = 0.7,"Ninjutsu" = 1.6,"Genjutsu" = 0.7,"Jutsu" = 1.2),
					"Sarutobi" = list("Stamina" = 1,"Chakra" = 1,"Taijutsu" = 1,"Ninjutsu" = 1,"Genjutsu" = 1,"Jutsu" = 1.8),
					"Senju" = list("Stamina" = 1.8,"Chakra" = 1.6,"Taijutsu" = 1.3,"Ninjutsu" = 1.3,"Genjutsu" = 1.3,"Jutsu" = 3),
					"Otsutsuki" = list("Stamina" = 0.3,"Chakra" = 0.3,"Taijutsu" = 0.3,"Ninjutsu" = 0.3,"Genjutsu" = 0.3,"Jutsu" = 3)
				)

		//Kage
			F["KageDeathEject"] >> KageDeathEject
			F["KageKillEject"] >> KageKillEject

		//NPC
			F["AniMulti"] >> AniMulti
			if(!AniMulti)
				AniMulti = initial(AniMulti)
			F["CrimMulti"] >> CrimMulti
			if(!CrimMulti)
				CrimMulti = initial(CrimMulti)
			F["VilMulti"] >> VilMulti
			if(!VilMulti)
				VilMulti = initial(VilMulti)

		//Rebirth
			F["ForcedRebirth"]>>ForcedRebirth
			F["RebirthOffer"]>>RebirthOffer
			F["RebirthPercentage"]>>RebirthPercentage
			F["RebirthCap"]>>RebirthCap
			F["CatchUP"]>>CatchUP

		//Other Stats
			F["Oro_Bite_Chance"]>>Oro_Bite_Chance
			F["MinatoDisabled"] >> MinatoDisabled
			F["VioleDisabled"] >> VioleDisabled
		//Sub Stuff
			F["Sub_Shop_Available"]>>Sub_Shop_Available
		//Clans
			F["Aburame_Enabled"]>>Clan_Aburame_Enabled
			F["Haku_Enabled"]>>Clan_Haku_Enabled
			F["Hyuuga_Enabled"]>>Clan_Hyuuga_Enabled
			F["Inuzuka_Enabled"]>>Clan_Inuzuka_Enabled
			F["Kaguya_Enabled"]>>Clan_Kaguya_Enabled
			F["Nara_Enabled"]>>Clan_Nara_Enabled
			F["Uchiha_Enabled"]>>Clan_Uchiha_Enabled
			F["TaiSpec_Enabled"]>>Clan_TaiSpec_Enabled
			F["Akimichi_Enabled"]>>Clan_Akimichi_Enabled
			F["Uzumaki_Enabled"]>>Clan_Uzumaki_Enabled
			F["Clay_Enabled"]>>Clan_Clay_Enabled
			F["Sand_Enabled"]>>Clan_Sand_Enabled
			F["Sarutobi_Enabled"]>>Clan_Sarutobi_Enabled
			F["Senju_Enabled"]>>Clan_Senju_Enabled
			F["Otsutsuki_Enabled"]>>Clan_Otsutsuki_Enabled
		//World Effects
			F["Show_waterwalk_effect"]>>show_waterwalk_effects
			F["RankProtection"] >> RankProtection
		//player Start Stats
			F["StartBoost"]>>Player_Boost_Enabled
			F["StartBoostTimes"]>>Player_Boost_Times
			F["BoostStamina"]>>Player_Boost_Stamina
			F["BoostCahkra"]>>Player_Boost_Chakra
			F["BoostNin"]>>Player_Boost_Ninjutsu
			F["BoostTai"]>>Player_Boost_Taijutsu
			F["BoostGen"]>>Player_Boost_Genjutsu
			F["WorldStatus"]>>world.status

		if(fexists("Data/Wipe/PlayerLists.sav"))
			var/savefile/C = new("Data/Wipe/PlayerLists.sav")
			C["Player_IDs"] >> PID
			C["CID"] >> CID
			C["SurveyList"] >> SurveyList
			if(!SurveyList)
				SurveyList = initial(SurveyList)

		if(fexists("Data/Wipe/GlobalReset.sav"))
			var/savefile/F2 = new("Data/Wipe/GlobalReset.sav")
			F2["GlobalRebirthTotal"] >> GlobalRebirthTotal
			F2["CurrentRebirth"] >> CurrentRebirthVersion
			if(!CurrentRebirthVersion)
				CurrentRebirthVersion = 1

		if(fexists("Data/Wipe/CitiBank.sav"))
			var/savefile/B = new("Data/Wipe/CitiBank.sav")
			B["Bank"] >> CitiBank
		else
			CitiBank = list()

		if(fexists("Data/Wipe/Skills.sav"))
			var/savefile/B = new("Data/Wipe/Skills.sav")
			B["ReadySkills"] >> ReadySkills
			B["GlobalSkills"] >> GlobalSkills
		else
			ReadySkills = list()
			GlobalSkills = list()
			for(var/Card in typesof(/obj/SkillCards))
				var/obj/SkillCards/A = new Card(null)
				if(A)
					if(istype(A,/obj/SkillCards/Ninjutsu/Special/EdoTensei/Commands)||istype(A,/obj/SkillCards/ClimbTree)||istype(A,/obj/SkillCards/ActionButton))
						continue
					if(istype(A,/obj/SkillCards/Clan/Lee/HachimonClose)||istype(A,/obj/SkillCards/Ninjutsu/Doton/YomiNumaRelease)||istype(A,/obj/SkillCards/Clan/Nara/KagemaneRelease)||istype(A,/obj/SkillCards/Ninjutsu/Fuuton/FujinHekiRelease)||istype(A,/obj/SkillCards/Clan/Kaguya/SawarabiNoMaiRelease))
						continue
					if(istype(A,/obj/SkillCards/Starter)||istype(A,/obj/SkillCards/Taijutsu/Starter)||istype(A,/obj/SkillCards/Ninjutsu/Starter)||istype(A,/obj/SkillCards/Genjutsu/Starter)||istype(A,/obj/SkillCards/CS/CS_Basic))
						continue
					if(istype(A,/obj/SkillCards/Clan/Uchiha/MS))
						continue
					ReadySkills[A.name] = A.type
					GlobalSkills[A.name] = 0
			SaveSkills()


	SaveGameSettings()
		var/savefile/F2 = new("Data/Wipe/GlobalReset.sav")
		F2["GlobalRebirthTotal"]<<GlobalRebirthTotal
		if(!CurrentRebirthVersion)
			CurrentRebirthVersion = 1
		F2["CurrentRebirth"] << CurrentRebirthVersion

		var/savefile/B = new("Data/Wipe/CitiBank.sav")
		B["Bank"] << CitiBank

		var/savefile/F = new("Data/NoWipe/GameSettings.sav")
		F["motd"]<<motd_custom
		F["World_FPS"]<<WORLD_FPS
		F["Base_Exp"]<<EXP_BASE

		if(EXPGains_Stamina<=0.1) EXPGains_Stamina=0.1; F["Stamina_Exp"]<<EXPGains_Stamina;
		if(EXPGains_Chakra<=0.1) EXPGains_Chakra=0.1; F["Chakra_Exp"]<<EXPGains_Chakra;
		if(EXPGains_Taijutsu<=0.1) EXPGains_Taijutsu=0.1; F["Taijutsu_Exp"]<<EXPGains_Taijutsu
		if(EXPGains_Ninjutsu<=0.1) EXPGains_Ninjutsu=0.1; F["Ninjutsu_Exp"]<<EXPGains_Ninjutsu
		if(EXPGains_Genjutsu<=0.1) EXPGains_Genjutsu=0.1; F["Genjutsu_Exp"]<<EXPGains_Genjutsu
		if(EXPGains_JutsuLevel<=0.1) EXPGains_JutsuLevel=0.1; F["JutsuLevel_Exp"]<<EXPGains_JutsuLevel
		F["MultiBuffs"] << MultiBuffs
		F["ClanMultis"] << WorldMultis

	//Kage
		F["KageDeathEject"] << KageDeathEject
		F["KageKillEject"] << KageKillEject
	//NPC
		F["AniMulti"] << AniMulti
		F["CrimMulti"] << CrimMulti
		F["VilMulti"] << VilMulti

	//Rebirth
		F["ForcedRebirth"]<<ForcedRebirth
		F["RebirthOffer"]<<RebirthOffer
		F["RebirthPercentage"]<<RebirthPercentage
		F["RebirthCap"]<<RebirthCap
		F["CatchUP"]<<CatchUP

	//Other Stats
		F["Oro_Bite_Chance"]<<Oro_Bite_Chance
		F["MinatoDisabled"] << MinatoDisabled
		F["VioleDisabled"] << VioleDisabled

	//Sub Stuff
		F["Sub_Shop_Available"]<<Sub_Shop_Available

	//Clans
		F["Aburame_Enabled"]<<Clan_Aburame_Enabled
		F["Haku_Enabled"]<<Clan_Haku_Enabled
		F["Hyuuga_Enabled"]<<Clan_Hyuuga_Enabled
		F["Inuzuka_Enabled"]<<Clan_Inuzuka_Enabled
		F["Kaguya_Enabled"]<<Clan_Kaguya_Enabled
		F["Nara_Enabled"]<<Clan_Nara_Enabled
		F["Uchiha_Enabled"]<<Clan_Uchiha_Enabled
		F["TaiSpec_Enabled"]<<Clan_TaiSpec_Enabled
		F["Akimichi_Enabled"]<<Clan_Akimichi_Enabled
		F["Uzumaki_Enabled"]<<Clan_Uzumaki_Enabled
		F["Clay_Enabled"]<<Clan_Clay_Enabled
		F["Sand_Enabled"]<<Clan_Sand_Enabled
		F["Sarutobi_Enabled"]<<Clan_Sarutobi_Enabled
		F["Senju_Enabled"]<<Clan_Senju_Enabled
		F["Otsutsuki_Enabled"]<<Clan_Otsutsuki_Enabled

	//World Effects
		F["Show_waterwalk_effect"]<<show_waterwalk_effects
		F["RankProtection"] << RankProtection

	//player Start Stats
		F["StartBoost"]<<Player_Boost_Enabled
		F["StartBoostTimes"]<<Player_Boost_Times
		F["BoostStamina"]<<Player_Boost_Stamina
		F["BoostCahkra"]<<Player_Boost_Chakra
		F["BoostNin"]<<Player_Boost_Ninjutsu
		F["BoostTai"]<<Player_Boost_Taijutsu
		F["BoostGen"]<<Player_Boost_Genjutsu

		F["WorldStatus"]<<world.status

		var/savefile/C = new("Data/Wipe/PlayerLists.sav")
		C["Player_IDs"] << PID
		C["CID"] << CID
		C["SurveyList"] << SurveyList