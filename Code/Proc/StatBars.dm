mob/var/tmp
	PreviousWounds
	PreviousStamina
	PreviousChakra
mob/proc/
	RefreshStats()
		if(client&&GuageOn)
			RefreshStamina(); RefreshWounds(); RefreshChakra()
		else if(client)
			for(var/obj/hudMeters/S in client.screen) S.invisibility=1
	RefreshStamina()
		if(client&&GuageOn)
			StatUpdate_stamina()
			var/percent=(round((Stamina/StaminaMax)*100,4))
			if(PreviousStamina!=percent)
				PreviousStamina=percent
				if(Stamina>=StaminaMax) percent=102
				else if(percent<1) percent=1
				for(var/obj/hudMeters/Stamina/S in client.screen) S.icon_state=num2text((percent-1))
	RefreshWounds()
		if(client&&GuageOn)
			StatUpdate_wounds()
			var/w=round(Wounds,17)
			if(PreviousWounds!=w)
				PreviousWounds=w
				if(Wounds>150) w=150
				if(Wounds<0) w=0
				for(var/obj/hudMeters/Wounds/wounds_01/W in client.screen)
					switch(w)
						if(0) W.icon=null
						if(17) W.icon='19_A.png'
						if(34) W.icon='38_A.png'
						if(51) W.icon='57_A.png'
						if(68) W.icon='76_A.png'
						if(85) W.icon='95_A.png'
						if(102) W.icon='114_A.png'
						if(119) W.icon='133_A.png'
						else W.icon='150_A.png'
				for(var/obj/hudMeters/Wounds/wounds_02/W in client.screen)
					switch(w)
						if(0) W.icon=null
						if(17) W.icon='19_B.png'
						if(34) W.icon='38_B.png'
						if(51) W.icon='57_B.png'
						if(68) W.icon='76_B.png'
						if(85) W.icon='95_B.png'
						if(102) W.icon='114_B.png'
						if(119) W.icon='133_B.png'
						else W.icon='150_B.png'
				for(var/obj/hudMeters/Wounds/wounds_03/W in client.screen)
					switch(w)
						if(51) W.icon='57_C.png'
						if(68) W.icon='76_C.png'
						if(85) W.icon='95_C.png'
						if(102) W.icon='114_C.png'
						if(119) W.icon='133_C.png'
						if(120 to 300) W.icon='150_C.png'
						else W.icon=null
				for(var/obj/hudMeters/Wounds/wounds_04/W in client.screen)
					switch(w)
						if(51) W.icon='57_D.png'
						if(68) W.icon='76_D.png'
						if(85) W.icon='95_D.png'
						if(102) W.icon='114_D.png'
						if(119) W.icon='133_D.png'
						if(120 to 300) W.icon='150_D.png'
						else W.icon=null

	RefreshChakra()
		if(client&&GuageOn)
			StatUpdate_chakra()
			if(Chakra<0)
				Chakra = 0
			var/percent=(round((Chakra/ChakraMax)*100,5))
			if(PreviousChakra!=percent)
				PreviousChakra=percent
				if(Chakra>=ChakraMax) percent=100
				else if(percent<1) percent=1
				for(var/obj/hudMeters/Chakra/C in client.screen) C.icon_state=num2text((percent))