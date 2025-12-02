mob
	var
		ListenToJutsu="all"
		ChakraMessages = 1

	proc
		JutsuMessage(MSG,RANGE=4)
			var/tell=list()
			for(var/mob/player/m in hearers(RANGE,src))
				if((m.ListenToJutsu=="others"&&m!=src)||(m.ListenToJutsu=="all")||(src==m && ListenToJutsu=="self"))
					tell+=m
			tell<<"<b>[src]: [MSG]!</b>"

		JutsuUseStamina(c,b=0.4)
			if(!client) return
			Stamina-=c
			var/EXPGAINED = (c*b)*2
			ApplyEXP(EXPGAINED,"stamina")
			RefreshStamina()

		JutsuUseChakra(c,b=0.4)
			if(!client) return
			var/mx=round(c)
			if(ChakraControl<100) {c+=rand(0,mx/2); CCGain(c)}
			Chakra -= c
			var/EXPGAINED = (c*b)*10
			ApplyEXP(EXPGAINED,"chakra")
			if(ChakraMessages) src<< "<i>[c]/[mx] converted.</i>"
			RefreshChakra()