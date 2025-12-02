mob
	var
		GavePanties = 0
		GotSpecialScroll = 0
obj/Item/Scroll
	icon = 'scrolls.dmi'
	Special_Scroll
		icon_state = "Large2"
		Drop()
			return
mob/Hittable/Unresponsive/NPC/People/Jiraiya
	name="Jiraiya"
	NinjaRank="Kage Level"
	icon='Jiraiya.dmi'
	Village="Leaf"
	Taijutsu=24000
	Ninjutsu=22000
	Genjutsu=20000
	Stamina=650000
	StaminaMax=650000
	movespeed=2
	Reflex=130
	protect=1
	CantHenge=1
	Action(mob/user)
		if(get_dist(user,src)>2) return
		if(user.GMfrozen||user.choosing)
			return
		//else if(user.jiraiya>100)

		else

			if(!user.GavePanties)
				var/obj/Clothing/Underwear/TsunadePanties/OB = locate() in user.contents
				if(OB)
					user << "I see you have a delightful pair from my favourite senorita, care to trade one for a special scroll?"
					if(alert("Would you like to give Jiraiya a pair of Tsunade's Panties?","Panties","Yes","No") == "Yes")
						var/list/Choices = list()
						for(var/obj/Clothing/Underwear/TsunadePanties/TP in user.contents)
							Choices["[TP.Colour] Pair"] = TP
						var/obj/Choice = Choices[input("Which pair would you like to give him?","Panties") in Choices]
						del Choice
					new/obj/Item/Scroll/Special_Scroll(user)
					user << "<font size=2>You received a <b>Special Scroll</b>!"
					user.GavePanties = 1
					user.GotSpecialScroll = 1
					user.UpdateInventory()
					return
			if(!user.hasRasengan&&user.gender=="male"&&user.TaijutsuTrue>=4000&&user.NinjutsuTrue>=5200&&user.NinjaRank!="Academy Student"&&user.NinjaRank!="Genin"&&user.NinjaRank!="Chuunin")
				user.choosing=1
				switch(input("Would you like me to teach you the legendary Rasengan technique?","Jiraiya")in list("Sure","No Thanks"))
					if("Sure")
						var/obj/SkillCards/Ninjutsu/Rasengan/J=locate(/obj/SkillCards/Ninjutsu/Rasengan) in user.contents
						if(!(J in user.contents))
							user<<"<b><font size=2>You've just learned <i>Rasengan</i>!</b></font>"
							new/obj/SkillCards/Ninjutsu/Rasengan(user)
							user.hasRasengan=1
						user.choosing=0
					else user.choosing=0
			else if(!user.hasRasengan&&user.gender=="female"&&user.TaijutsuTrue>=1000&&user.NinjutsuTrue>=1000&&user.NinjaRank!="Academy Student")
				user.choosing=1
				switch(input("Hello there young lady!  Would you like me to teach you the legendary Rasengan technique?","Jiraiya")in list("Sure","No Thanks"))
					if("Sure")
						var/obj/SkillCards/Ninjutsu/Rasengan/J=locate(/obj/SkillCards/Ninjutsu/Rasengan) in user.contents
						if(!(J in user.contents))
							user<<"<b><font size=2>You've just learned <i>Rasengan</i>!</b></font>"
							new/obj/SkillCards/Ninjutsu/Rasengan(user)
							user.hasRasengan=1
						user.choosing=0
					else user.choosing=0
			else
				user.jiraiya++
				switch(pick(1,2,3,4,5))
					if(1) user<<"Hello."
					if(2) user<<"So many pretty ladies!"
					if(3) user<<"Akatsuki will be on the move again soon."
					if(4) user<<"Ssshhh! I'm doing my researh!  Oh wait, where'd she go?"
					if(5) user<<"I've just started writing my latest book!"