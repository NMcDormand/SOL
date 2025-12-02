mob
	var
		GaveBook = 0
		GotSake = 0

obj/Item/DeluxeSake
	name = "Deluxe Sake"
	icon = 'Sake.dmi'
	Drop()
		return

mob/Hittable/Unresponsive/NPC/People/
	Kakashi
		name="Kakashi Hatake"
		NinjaRank="Jounin"
		icon='kakashi.dmi'
		Village="Leaf"
		Clan="Hatake"
		Taijutsu=18000
		Ninjutsu=20000
		Genjutsu=25000
		Stamina=300000
		StaminaMax=650000
		ChakraControl=100
		movespeed=2
		Reflex=100
		protect=1
		CantHenge=1
		Action(mob/user)
			if(get_dist(user,src)>2) return
			if(user.GMfrozen|choosing)
				return
			else
				if(!user.GaveBook)
					var/obj/Item/Books/OldBook/OB = locate() in user.contents
					if(OB)
						if(OB.Dirty)
							user << "Thats quite the filthy book you have there"
						else
							user << "Where did you find this? This is the first in the series!"
							user << "Im sorry but i have to take this, you can have this Sake in it splace!"
							del OB
							new/obj/Item/DeluxeSake(user)
							user << "Deluxe Sake obtained in exchange for the Make Out Tactics"
							user.GaveBook = 1
							user.GotSake = 1
							user.UpdateInventory()
							return
				var/obj/SkillCards/Ninjutsu/Chidori/J=locate() in user.contents
				if(!J)
					if((user.PE=="Lightning"||user.SE=="Lightning")&&user.TaijutsuTrue>=2500&&user.NinjutsuTrue>=4200&&user.NinjaRank!="Academy Student"&&user.NinjaRank!="Genin")
						user.choosing=1
						switch(input("Would you like to learn Chidori?","Kakashi Hatake")in list("Yes please","No thanks"))
							if("Yes please")
								user<<"<b><font size=2>You've just learned <i>Chidori</i>!</b></font>"
								new/obj/SkillCards/Ninjutsu/Chidori(user)
						user.choosing=null
				else
					switch(pick(1,2))
						if(1) user<<"Greetings."
						if(2) user<<"Have you ever found yourself lost, on the <i>Path of Life</i>?"