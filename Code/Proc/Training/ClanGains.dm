mob/proc
	ClanStaminaUp()
		return (Multipliers["Stamina"]*0.5)
		switch(Clan)
			if("Inuzuka","Hyuuga") return 0.35
			if("Yuki","Uchiha","Clay") return 0.3
			if("Kaguya","Aburame") return 0.4
			if("Taijutsu Specialist","Senju","Otsutsuki") return 0.6
			if("Uzumaki") return 0.45
			else return 0.5

	ClanChakraUp()
		return (Multipliers["Chakra"]*0.5)
		switch(Clan)
			if("Aburame","Kaguya") return 0.25
			if("Aburame") return 0.35
			if("Nara") return 0.4
			if("Yuki","Uchiha","Sand","Clay","Otsutsuki") return 0.5
			if("Uzumaki") return 0.45
			else return 0

	ClanTaijutsuUp()
		return (Multipliers["Taijutsu"]*0.5)
		switch(Clan)
			if("Taijutsu Specialist","Otsutsuki")
				return 0.8
			if("Hyuuga","Kaguya","Akimichi","Senju")
				return 0.6
			if("Uchiha","Sand")
				return 0.3
			if("Inuzuka","Clay")
				return 0.1
			if("Aburame","Nara","Yuki")
				return 0
			else
				return 0.2

	ClanNinjutsuUp()
		return (Multipliers["Ninjutsu"]*0.5)
		switch(Clan)
			if("Uchiha")
				return 0.5
			if("Nara")
				return 0.4
			if("Aburame","Sand","Senju")
				return 0.6
			if("Yuki","Clay","Otsutsuki")
				return 0.75
			if("Taijutsu Specialist")
				return 0
			else
				return 0.1

	ClanGenjutsuUp()
		return (Multipliers["Genjutsu"]*0.5)
		switch(Clan)
			if("Uchiha","Otsutsuki") return 1.5
			if("Aburame","Nara") return 0.4
			if("Inuzuka","Clay") return 0.2
			if("Taijutsu Specialist","Kaguya","Sand") return 0.1
			else return 0.1

	ClanCC()
		switch(Clan)
			if("Hyuuga","Yuki","Nara","Sand","Otsutsuki") return 0.3
			if("Taijutsu Specialist","Uzumaki") return 0
			else return 0.1