mob
	var
		Bon_Stamina = 0
		Bon_Chakra = 0
		Bon_Taijutsu = 0
		Bon_Ninjutsu = 0
		Bon_Genjutsu = 0

	VerbHolder/Admin/Level4
		verb
			Calibrate_Rebirth(mob/M in MasterPlayerList)
				if(M.SyncMyRebirth())
					if(alert("Would you like to give them the Skills Totals, Example Kunai Skill, from the Rebirth Profile?","Skills Total","Yes","No") == "Yes")
						M.RebirthData.Birthed(M)
					if(alert("Would you like to ReSync their Stat Caps?","Skills Total","Yes","No") == "Yes")
						M.ResetMyCaps()
						AdminActionLog("Reset Caps",,,M.trueName)
					AdminActionLog("Synced Rebirth",,,M.trueName)

			ResetCaps(mob/M in MasterPlayerList)
				if(alert(usr,"Are you sure you would like to reset [M.trueName]'s Stat Caps?","Reset Caps","Yes","No") == "Yes")
					M.ResetMyCaps()
					AdminActionLog("Reset Caps",,,M.trueName)

			GiveCaps(mob/M in MasterPlayerList)
				var/A = input("Which Rank Caps to Grant?","Missing Rank") as null|anything in list("Genin","Chuunin","Special Jounin","Anbu","Jounin","Kage Level","Kage")
				if(A && M)
					var/B = M.NinjaRank
					M.NinjaRank = A
					M.AddCaps()
					M.NinjaRank = B
				AdminActionLog("Add Caps",,,M.trueName)

mob/proc
	SyncMyRebirth()
		var/firstletter=copytext(ckey, 1, 2)
		if(fexists("Saves/[firstletter]/[ckey]/[Slot]/Rebirth.sav"))
			var/savefile/RB = new("Saves/[firstletter]/[ckey]/[Slot]/Rebirth.sav")
			var/NRB
			RB["REData"] >> NRB
			if(NRB)
				RebirthData = NRB
			return 1

	ResetMyCaps()
		Cap_Stamina=2000; Cap_Chakra=400; Cap_Genjutsu=1000; Cap_Ninjutsu=1000; Cap_Taijutsu=1000
		var/A = NinjaRank
		var/Stop = 0
		switch(A)
			if("Academy Student")
				Stop = 0
			if("Genin")
				Stop = 1
			if("Chuunin")
				Stop = 2
			if("Special Jounin")
				Stop = 3
			if("Anbu")
				Stop = 4
			if("Jounin")
				Stop = 5
			if("Kage Level")
				Stop = 6
			else
				Stop = 7

		for(var/i = 1 to Stop)
			switch(i)
				if(1)
					NinjaRank = "Genin"
					AddCaps()
				if(2)
					NinjaRank = "Chuunin"
					AddCaps()
					RebirthData.Initialize(src)
				if(3)
					NinjaRank = "Special Jounin"
					AddCaps()
				if(4)
					NinjaRank = "Anbu"
					AddCaps()
				if(5)
					NinjaRank = "Jounin"
					AddCaps()
				if(6)
					NinjaRank = "Kage Level"
					AddCaps()
				if(7)
					NinjaRank = A
					AddCaps()
		NinjaRank = A
		StatUpdate_rank();

	AddCaps()
		var
			CS = 0
			CC = 0
			CT = 0
			CN = 0
			CG = 0

		switch(NinjaRank)
			if("Genin")
				CS = 40000
				CC = 2000
				CT = 4000
				CN = 3000
				CG = 3000
			if("Chuunin")
				CS = 60000
				CC = 4000
				CT = 6000
				CN = 5000
				CG = 5000
				MXP= ceil(MXP*0.9)
			if("Special Jounin")
				CS = 100000
				CC = 10000
				CT = 14000
				CN = 12000
				CG = 12000
				ChakraMXP*=0.5
				MXP = ceil(MXP*0.7)
				LevelBonus+=10
			if("Anbu")
				CS = 100000
				CC = 6000
				CT = 7000
				CN = 6000
				CG = 6000
				LevelBonus+=10
				MXP = ceil(MXP*0.65)
			if("Jounin")
				CS = 300000
				CC = 10000
				CT = 20000
				CN = 20000
				CG = 20000
				TaijutsuMXP*=0.48
				NinjutsuMXP*=0.48
				GenjutsuMXP*=0.35
				ChakraMXP*=0.5
				LevelBonus+=20
				MXP = ceil(MXP*0.6)
			if("Kage Level")
				CS = 450000
				CC = 20000
				CT = 30000
				CN = 30000
				CG = 30000
				TaijutsuMXP*=0.5
				NinjutsuMXP*=0.5
				GenjutsuMXP*=0.3
				ChakraMXP*=0.4
				LevelBonus+=30
				MXP = ceil(MXP*0.5)
			else //if("Mizukage","Hokage","Raikage","Tsuchikage","Kazekage","Kage")
				CS = 2000000
				CC = 100000
				CT = 60000
				CN = 60000
				CG = 60000
				TaijutsuMXP*=0.3
				NinjutsuMXP*=0.3
				GenjutsuMXP*=0.25
				ChakraMXP*=0.2
				StaminaMXP*=0.2
				LevelBonus+=100
				MXP = ceil(MXP*0.2)

		switch(Speciality)
			if("Genjutsu")
				CS *= 1
				CC *= 1
				CT *= 0.9
				CN *= 0.9
				CG *= 1.2
			if("Ninjutsu")
				CS *= 0.8
				CC *= 1.2
				CT *= 0.9
				CN *= 1.2
				CG *= 0.9
			if("Taijutsu")
				CS *= 1.2
				CC *= 0.8
				CT *= 1.2
				CN *= 0.9
				CG *= 0.9
			if("GenNin")
				CS *= 1.2
				CC *= 0.8
				CT *= 0.8
				CN *= 1.1
				CG *= 1.1
			if("GenTai")
				CS *= 1
				CC *= 1
				CT *= 1.1
				CN *= 0.8
				CG *= 1.1
			if("NinTai")
				CS *= 1
				CC *= 1
				CT *= 1.1
				CN *= 1.1
				CG *= 0.8
		var/list/MP = Multipliers
		CS *= MP["Stamina"]
		CC *= MP["Chakra"]
		CT *= MP["Taijutsu"]
		CN *= MP["Ninjutsu"]
		CG *= MP["Genjutsu"]

		if(Clan == "Uzumaki")
			if(!BeenKage)
				CS *= 0.5
				CC *= 0.5
				CT *= 0.5
				CN *= 0.5
				CG *= 0.5

				Bon_Stamina += CS
				Bon_Chakra += CC
				Bon_Taijutsu += CT
				Bon_Ninjutsu += CN
				Bon_Genjutsu += CG
			else
				CS += Bon_Stamina
				CC += Bon_Chakra
				CT += Bon_Taijutsu
				CN += Bon_Ninjutsu
				CG += Bon_Genjutsu

		Cap_Stamina += CS * EXPGains_Stamina
		Cap_Chakra += CC * EXPGains_Chakra
		Cap_Taijutsu += CT * EXPGains_Taijutsu
		Cap_Ninjutsu += CN * EXPGains_Ninjutsu
		Cap_Genjutsu += CG * EXPGains_Genjutsu

		TaijutsuMXP=ceil(TaijutsuMXP)
		NinjutsuMXP=ceil(NinjutsuMXP)
		GenjutsuMXP=ceil(GenjutsuMXP)
		ChakraMXP=ceil(ChakraMXP)
		StaminaMXP=ceil(StaminaMXP)