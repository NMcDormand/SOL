var
	RankProtection = 0

mob/VerbHolder/Admin/Host2/verb
	Reset_Clan_Multis()
		WorldMultis = CLANMULTIS

	NPC_Multis()
		set category = "Host"
		switch(input("Which Multiplier would you like to change?","Permanent Death") as null|anything in list("Animals","Criminals","Villagers"))
			if("Criminals")
				CRREDO
				var/A = input("What multiplier would you like to set Criminals? (Currently: [CrimMulti])") as num
				if(!A || A<0)
					if(alert("You entered zero, would you like to cancel the change?",,"Yes","No") == "No")
						goto CRREDO
				else
					CrimMulti = A
					world << "Criminals Stat Multiplier is now set to [A]"
			if("Villagers")
				VRREDO
				var/A = input("What multiplier would you like to set Villagers? (Currently: [VilMulti])") as num
				if(!A || A<0)
					if(alert("You entered zero, would you like to cancel the change?",,"Yes","No") == "No")
						goto VRREDO
				else
					VilMulti = A
					world << "Villagers Stat Multiplier is now set to [A]"
			if("Animals")
				AREDO
				var/A = input("What multiplier would you like to set Animals? (Currently: [AniMulti])") as num
				if(!A || A<0)
					if(alert("You entered zero, would you like to cancel the change?",,"Yes","No") == "No")
						goto AREDO
				else
					AniMulti = A
					world << "Animals Stat Multiplier is now set to [A]"
		SaveGameSettings()

	Toggle_Rank_Protection()
		set category = "Host"
		if(RankProtection)
			RankProtection = 0
			world << "Protection from Ninja [RankProtection] Ranks higher than you has been disabled"
		else
			var/RP = input("How many Ranks Higher will a player need to be before they are frozen?","Rank Protection") as num
			if(RP<1)
				return
			if(RP > 7)
				RP = 7
			RankProtection = RP
			world << "Protection from Ninja [RP] Ranks higher than you has been enabled"
		SaveGameSettings()

	Move_Weight(A as num)
		set category = "Host"
		MoveWeight = A
		SaveGameSettings()

/*	DisableMultiKey()
		set category="Staff"
		set name="Disable Multikeying"
//		switch(MULTIKEYDISABLED)
//			if(TRUE) {usr<<"MultiKeys Enabled"; MULTIKEYDISABLED=0}
//			if(FALSE) {usr<<"MultiKeys Disabled"; MULTIKEYDISABLED=1}
*/
	Save_World_Settings()
		set category = "Host"
		SaveGameSettings()

	ChangeWorldStatus()
		set name="Change World Status"
		set category = "Host"
		set desc="Host: Change text on hub"
		world.status=input("What would you like to change the World Status to?","Change World Status",world.status)
		usr<<"<font color=red><b>World Status is now:</b></font> [world.status]"
		SaveGameSettings()

	Give_GM(mob/GM in world)
		set category="Host"
		set name="Give GM"
		set desc="Give a player GM status without coding it in."
		if(usr.ckey!="saucepanman"&&usr.ckey!="screwyparasite"&&ckey != ckey(world.host) && AdminLevel < 5) {usr<<"You do not have the authority."; return}
		var/list/GMLEVELS = list("Level One","Level Two","Level Three","Level Four")
		if(AdminLevel > 5)
			GMLEVELS +="Level Five"
			GMLEVELS +="Level Six"
		GMLEVELS+="Remove GM Status"
		var/Wut = input("What level GM do you wish to make [GM]?","Make GM") as null|anything in GMLEVELS
		if(Wut)
			switch(Wut)
				if("Level One")
					switch(alert("Are you sure you wish to make [GM] a Level 1 GM?","Make Level 1 GM","Yes","No"))
						if("Yes")
							ChangeGMLevel(Wut,GM)
						if("No")
							usr<<"They were not made a L1GM"
				if("Level Two")
					switch(alert("Are you sure you wish to make [GM] a Level 2 GM?","Make Level 2 GM","Yes","No"))
						if("Yes")
							ChangeGMLevel(Wut,GM)
						if("No")
							usr<<"They were not made a L2GM"
				if("Level Three")
					switch(alert("Are you sure you wish to make [GM] a Level 3 GM?","Make Level 3 GM","Yes","No"))
						if("Yes")
							ChangeGMLevel(Wut,GM)
						if("No")
							usr<<"They were not made a L3GM"
				if("Level Four")
					switch(alert("Are you sure you wish to make [GM] a Level 4 GM?","Make Level 4 GM","Yes","No"))
						if("Yes")
							ChangeGMLevel(Wut,GM)
						if("No")
							usr<<"They were not made a L4GM"
				if("Level Five")
					switch(alert("Are you sure you wish to make [GM] a Level 6 GM?","Make Level 5 GM","Yes","No"))
						if("Yes")
							ChangeGMLevel(Wut,GM)
						if("No")
							usr<<"They were not made a L5 GM"
				if("Level Six")
					switch(alert("Are you sure you wish to make [GM] a Level 6 GM?","Make Level 6 GM","Yes","No"))
						if("Yes")
							ChangeGMLevel(Wut,GM)
						if("No")
							usr<<"They were not made a L6 GM"
				if("Remove GM Status")
					switch(alert("Are you sure you wish to make [GM] a Level 6 GM?","Make Level 6 GM","Yes","No"))
						if("Yes")
							ChangeGMLevel(Wut,GM)
						if("No")
							usr<<"They were not stripped of their rank"
		SaveGameSettings()
//-------------------------------------------------------------------------------------------------------------
	SetEXPMultiplier()
		set name="Host: Set Experience Multiplier"
		set category = "Host"
		set desc="Change the exerience rates for each major skill"
		startAgain
		var/list/XPGainsList=list("Base", "Stamina","Chakra","Taijutsu","Ninjutsu","Genjutsu","Jutsu Level")
		switch(input("What would you like to change?","Experience Multiplier")as null|anything in XPGainsList)
			if("Base")
				EXP_BASE = input("Current Base Multiplier: [EXP_BASE]", "Base Gains (This changes reqs too)") as num
				goto startAgain
			if("Stamina")
				EXPGains_Stamina = input("Current Stamina Multiplier: [EXPGains_Stamina]","Stamina Multiplier") as num
				goto startAgain
			if("Chakra")
				EXPGains_Chakra = input("Current Chakra Multiplier: [EXPGains_Chakra]","Chakra Multiplier") as num
				goto startAgain
			if("Ninjutsu")
				EXPGains_Ninjutsu = input("Current Ninjutsu Multiplier: [EXPGains_Ninjutsu]","Ninjutsu Multiplier") as num
				goto startAgain
			if("Genjutsu")
				EXPGains_Genjutsu = input("Current Genjutsu Multiplier: [EXPGains_Genjutsu]","Genjutsu Multiplier") as num
				goto startAgain
			if("Taijutsu")
				EXPGains_Taijutsu = input("Current Taijutsu Multiplier: [EXPGains_Taijutsu]","Taijutsu Multiplier") as num
				goto startAgain
			if("Jutsu Level")
				EXPGains_JutsuLevel = input("Current Jutsu Level Multiplier: [EXPGains_JutsuLevel]","Jutsu Level Multiplier") as num
				goto startAgain
		SaveGameSettings()
//-------------------------------------------------------------------------------------------------------------
	setOroBiteMulti()
		set name="Host: Set Oro Bite Multiplier"
		set category = "Host"
		set desc="Change the multiplier of Oro Bite. Default 1x"
		Oro_Bite_Chance = input("Oro Bite Multiplier","Currently [Oro_Bite_Chance]",) as num
		SaveGameSettings()
//---------------------------------------------------------------------------------------------------------------------
	SetMOTD()
		set name="Host: Set MotD"
		set category = "Host"
		motd_custom=input("What would you like to change the motd to?")as message
		SaveGameSettings()

	viewMOTD()
		set name="Host: View MotD"
		set category = "Host"
		if(GM)
			GM=0
			QuestionMark()
			GM=1
		else
			QuestionMark()
		SaveGameSettings()
//-------------------------------------------------------------------------------------------------------------
	Sub_Shop()
		set name="Host: Enable SubShop"
		set category = "Host"
		switch(alert("The sub shop is currently [Sub_Shop_Available]!","Clan Settings","Enable","Disable"))
			if("Enable") Sub_Shop_Available=1
			if("Disable") Sub_Shop_Available=0
		SaveGameSettings()
//-------------------------------------------------------------------------------------------------------------
	Clan_Settings()
		set name="Host: Clan Availability"
		set category = "Host"
		startAgain
		var/msg="disabled"
		var/ClanList=list("Aburame","Akimichi","Clay","Haku","Hyuuga","Inuzuka","Kaguya","Nara","Otsutsuki","Sand","Sarutobi","Senju","Taispec","Uchiha","Uzumaki","Cancel");
		switch(input("What would you like to change?","Clan Settings")as null|anything in ClanList)
			if("Aburame") {if(Clan_Aburame_Enabled) msg="enabled"; clan_settings_proc("Aburame", msg); goto startAgain}
			if("Haku") {if(Clan_Haku_Enabled) msg="enabled"; clan_settings_proc("Haku", msg); goto startAgain}
			if("Hyuuga") {if(Clan_Hyuuga_Enabled) msg="enabled"; clan_settings_proc("Hyuuga", msg); goto startAgain}
			if("Inuzuka") {if(Clan_Inuzuka_Enabled) msg="enabled"; clan_settings_proc("Inuzuka", msg); goto startAgain}
			if("Kaguya") {if(Clan_Kaguya_Enabled) msg="enabled"; clan_settings_proc("Kaguya", msg); goto startAgain}
			if("Nara") {if(Clan_Nara_Enabled) msg="enabled"; clan_settings_proc("Nara", msg); goto startAgain}
			if("Uchiha") {if(Clan_Uchiha_Enabled) msg="enabled"; clan_settings_proc("Uchiha", msg); goto startAgain}
			if("Taispec") {if(Clan_TaiSpec_Enabled) msg="enabled"; clan_settings_proc("Taispec", msg); goto startAgain}
			if("Akimichi") {if(Clan_Akimichi_Enabled) msg="enabled"; clan_settings_proc("Akimichi", msg); goto startAgain}
			if("Uzumaki") {if(Clan_Uzumaki_Enabled) msg="enabled"; clan_settings_proc("Uzumaki", msg); goto startAgain}
			if("Clay") {if(Clan_Clay_Enabled) msg="enabled"; clan_settings_proc("Clay", msg); goto startAgain}
			if("Sand") {if(Clan_Sand_Enabled) msg="enabled"; clan_settings_proc("Sand", msg); goto startAgain}
			if("Sarutobi") {if(Clan_Sarutobi_Enabled) msg="enabled"; clan_settings_proc("Sarutobi", msg); goto startAgain}
			if("Senju") {if(Clan_Senju_Enabled) msg="enabled"; clan_settings_proc("Senju", msg); goto startAgain}
			if("Otsutsuki") {if(Clan_Otsutsuki_Enabled) msg="enabled"; clan_settings_proc("Otsutsuki", msg); goto startAgain}
		SaveGameSettings()

//-------------------------------------------------------------------------------------------------------------
	Stat_Boost()
		set name="Host: Starting Boost"
		set category = "Host"
		var/list/XPGainsList=list("Status","Stamina","Chakra","Ninjutsu","Genjutsu","Taijutsu")
		switch(input("What would you like to change?","Starting Stats")as null|anything in XPGainsList)
			if("Status") {
				switch(alert("Would you like to turn the stat boost on/off?","Stat Boost","Enable","Disable"))
					if("Enable") {Player_Boost_Enabled=1; Player_Boost_Times++}
					if("Disable") {Player_Boost_Enabled=0}
			}
			if("Stamina")
				Player_Boost_Stamina = input("Current Stamina Multiplier: [Player_Boost_Stamina]","Starting Stamina",) as num
			if("Chakra")
				Player_Boost_Chakra = input("Current Chakra Multiplier: [Player_Boost_Chakra]","Starting Chakra",) as num
			if("Ninjutsu")
				Player_Boost_Ninjutsu = input("Current Ninjutsu Multiplier: [Player_Boost_Ninjutsu]","Starting Ninjutsu",) as num
			if("Genjutsu")
				Player_Boost_Genjutsu = input("Current Genjutsu Multiplier: [Player_Boost_Genjutsu]","Starting Genjutsu",) as num
			if("Taijutsu")
				Player_Boost_Taijutsu = input("Current Taijutsu Multiplier: [Player_Boost_Taijutsu]","Starting Taijutsu",) as num
		SaveGameSettings()
//-------------------------------------------------------------------------------------------------------------

	ToggleBoosts()
		set name="Host: Toggle Buff Stacking"
		set category = "Host"
		if(MultiBuffs)
			MultiBuffs = 0
			world << "[trueName] has <b>enabled</b> Buff Stacking, Techniques that primarily boost your stats can now be used together"
		else
			MultiBuffs = 1
			world << "[trueName] has <b>disabled</b> Buff Stacking, Techniques that primarily boost your stats can no longer be used together"


//-------------------------------------------------------------------------------------------------------------
	Rebirth_Settings()
		set name="Host: Set Rebirth Settings"
		set category = "Host"
		var/list/Choices=list("Permanent Death","Rebirth Offer","Catch Up Rate","Catch Up Reset","Rebirth Percentage","Rebirth Cap")
		FROMTOP
		switch(input("What would you like to change?","Starting Stats")as null|anything in Choices)
			if("Catch Up Reset")
				if(alert("Are you sure?","Catch Up Reset","Yes","No") == "Yes")
					GlobalRebirthTotal = null
					CurrentRebirthVersion++
					for(var/mob/A in MasterPlayerList)
						A.ResetRebirth()
					SaveGameSettings()
			if("Permanent Death")
				if(!ForcedRebirth)
					if(alert("Would you like to enable Permanent Deaths?","Permanent Death","Yes","No") == "Yes")
						FRREDO
						var/A = input("How many times can a player die before it is permanent?") as num
						if(!A)
							if(alert("You entered zero, would you like to cancel the change?",,"Yes","No") == "No")
								goto FRREDO
						else
							if(A<1)
								A = 1
							ForcedRebirth = round(A)
							if(ForcedRebirth > 1)
								world << "Deaths are now permanent after [ForcedRebirth] deaths"
							else
								world << "Deaths are now permanent after 1 death"
				else
					if(alert("Would you like to disable Permanent Deaths?","Permanent Death","Yes","No") == "No")
						FRREDO2
						if(alert("Would you like to change the amount of deaths allowed?","Permanent Death","Yes","No") == "Yes")
							var/A = input("How many times can a player die before it is permanent?") as num
							if(!A)
								if(alert("You entered zero, would you like to cancel the change?",,"Yes","No") == "No")
									goto FRREDO2
							else
								if(A<1)
									A = 1
								ForcedRebirth = round(A)
								if(ForcedRebirth > 1)
									world << "Deaths are now permanent after [ForcedRebirth] deaths"
								else
									world << "Deaths are now permanent after 1 death"
					else
						ForcedRebirth = 0
						world << "Permanent Deaths have now been disabled"

			if("Rebirth Offer")
				ROREDO
				var/A = input("How many deaths until a player is offered a rebirth?") as num
				if(!A)
					if(alert("You entered zero, would you like to cancel the change?",,"Yes","No") == "No")
						goto ROREDO
				else
					RebirthOffer = round(A)

			if("Rebirth Cap")
				var/A = input("How many Rebirth's will player be allowed?") as num
				if(!A)
					if(alert("You entered zero, would you like to disable rebirths?","Its Zero","Yes","No") == "Yes")
						RebirthCap = 0
				else
					RebirthCap = round(A)
					world << "The Rebirth Cap is now [RebirthCap]"

			if("Catch Up Rate")
				if(!CatchUP)
					if(alert("Would you like to enable the Catch up Rate?","Catch Up","Yes","No") == "Yes")
						CURREDO
						var/A = input("What percentage of the rebirth will go towards the Catch up? (0 - 100)") as num
						if(!A)
							if(alert("You entered zero, would you like to cancel the change?",,"Yes","No") == "No")
								goto CURREDO
						else
							if(A>100)
								A = 100
							else if(A<0)
								A = 1
							CatchUP = A*0.01
							world << "[A]% from every player's rebirth will now contribute to the catch up rate"
				else
					if(alert("Would you like to disable the Catch Up Rate?","Catch Up","Yes","No") == "No")
						CURREDO2
						var/A = input("What percentage of the rebirth will go towards the Catch Up? (0 - 100)") as num
						if(!A)
							if(alert("You entered zero, would you like to cancel the change?",,"Yes","No") == "No")
								goto CURREDO2
						else
							if(A>100)
								A = 100
							else if(A<1)
								A = 1
							CatchUP = A*0.01
							world << "[A]% from every player's rebirth will now contribute to the Catch Up Rate"
					else
						CatchUP = 0
						world << "The Catch Up Rate has been disabled"

			if("Rebirth Percentage")
				RPREDO
				var/A = input("What percentage of your stats contribute to the Rebirth?") as num
				if(!A)
					if(alert("You entered zero, would you like to cancel the change?",,"Yes","No") == "No")
						goto RPREDO
				else
					if(A>100)
						A = 100
					else if(A<1)
						A = 1
					RebirthPercentage = A*0.01
					world << "[A]% of your gained stats will be added to your next life's limits"

		if(alert("Are you done?","Done","Yes","No") == "No")
			goto FROMTOP
		SaveGameSettings()

//-------------------------------------------------------------------------------------------------------------

proc
	clan_settings_proc(clan, msg)
		switch(alert("The [clan] clan is currently [msg]!","Clan Settings","Enable","Disable"))
			if("Enable")
				switch(clan)
					if("Aburame") {Clan_Aburame_Enabled=1}
					if("Haku") {Clan_Haku_Enabled=1}
					if("Hyuuga") {Clan_Hyuuga_Enabled=1}
					if("Inuzuka") {Clan_Inuzuka_Enabled=1}
					if("Kaguya") {Clan_Kaguya_Enabled=1}
					if("Nara") {Clan_Nara_Enabled=1}
					if("Uchiha") {Clan_Uchiha_Enabled=1}
					if("Taispec") {Clan_TaiSpec_Enabled=1}
					if("Akimichi") {Clan_Akimichi_Enabled=1}
					if("Uzumaki") {Clan_Uzumaki_Enabled=1}
					if("Clay") {Clan_Clay_Enabled=1}
					if("Sand") {Clan_Sand_Enabled=1}
					if("Sarutobi") {Clan_Sarutobi_Enabled=1}
					if("Senju") {Clan_Senju_Enabled=1}
					if("Otsutsuki") {Clan_Otsutsuki_Enabled=1}
				world << "The [clan] is now enabled"
			if("Disable")
				switch(clan)
					if("Aburame") {Clan_Aburame_Enabled=0}
					if("Haku") {Clan_Haku_Enabled=0}
					if("Hyuuga") {Clan_Hyuuga_Enabled=0}
					if("Inuzuka") {Clan_Inuzuka_Enabled=0}
					if("Kaguya") {Clan_Kaguya_Enabled=0}
					if("Nara") {Clan_Nara_Enabled=0}
					if("Uchiha") {Clan_Uchiha_Enabled=0}
					if("Taispec") {Clan_TaiSpec_Enabled=0}
					if("Akimichi") {Clan_Akimichi_Enabled=0}
					if("Uzumaki") {Clan_Uzumaki_Enabled=0}
					if("Clay") {Clan_Clay_Enabled=0}
					if("Sand") {Clan_Sand_Enabled=0}
					if("Sarutobi") {Clan_Sarutobi_Enabled=0}
					if("Senju") {Clan_Senju_Enabled=0}
					if("Otsutsuki") {Clan_Otsutsuki_Enabled=0}
				world << "The [clan] is now disabled"