mob/NPC
	Vet
		name = "Vet"
		icon = 'Naruto Bases.dmi'
		icon_state = "spawnman"

		protect=1
		CantHenge=1

		Stamina =10000
		StaminaMax=10000
		StaminaTrue=10000

		Chakra =50
		ChakraMax=50
		ChakraTrue=50

		Taijutsu =10
		TaijutsuMax=10
		TaijutsuTrue=10

		Genjutsu =10
		GenjutsuMax=10
		GenjutsuTrue=10

		Ninjutsu =10
		NinjutsuMax=10
		NinjutsuTrue=10

		Action(mob/user)
			if(get_dist(user,src)>2) return
			if(!user.HasDog) {user<<"Vet: <i>You don't have a K-9.</i>"};..()
			var/mob/Hittable/Responsive/Animal/Pet/D=user.DogName
			var/mob/Hittable/Responsive/Animal/Pet/d=user.Familiar
			user.choosing=1
			switch(input("How can I help you?","Vet")in list("Revive/Return K-9","Rename K-9","K-9 Colour","Never mind"))
				if("Revive/Return K-9")
					if(user.DeadDog)
						user.DeadDog=0
						switch(alert("Would you like to revive [D]?","Vet","Yes","No"))
							if("Yes")
								if(!MobDistanceCheck(user,src,3)) {user.choosing=0; return}
								var/mob/Hittable/Responsive/Animal/Pet/Dog/P=new(user)
								P.name="[user.DogName]"; P.Master=user; user.Familiar=P
								P.Taijutsu=user.DogTaijutsu; P.TaijutsuXP=user.DogTaijutsuXP; P.TaijutsuMXP=user.DogTaijutsuMXP
								P.Stamina=user.DogStaminaMax; P.StaminaMax=user.DogStaminaMax; P.StaminaXP=user.DogStaminaExp; P.StaminaMXP=user.DogStaminaMXP
								user<<"Vet: <i>[P] is back to normal. Here you go!.</i>"
								spawn(40)user.choosing=0
								P.Status="follow"; P.DogFollow(user)
							else
								user.DeadDog=1
					else if(d&&d in user)
						spawn(20)user.choosing=0
						user<<{"Vet: <i>"[d] is with you!"</i>"}; return
					else if(d&&d.z==1)
						spawn(20)user.choosing=0
						user<<{"Vet: <i>"[d] is located at ([d.x],[d.y])"</i>"}; return
					else
						if(!MobDistanceCheck(user,src)) {user.choosing=0; return}
						if(d) del(d)
						var/mob/Hittable/Responsive/Animal/Pet/Dog/P=new(user.loc)
						user.DeadDog=0; P.name="[user.DogName]"; P.Master=user; user.Familiar=P
						P.Taijutsu=user.DogTaijutsu; P.TaijutsuXP=user.DogTaijutsuXP; P.TaijutsuMXP=user.DogTaijutsuMXP
						P.Stamina=user.DogStaminaMax; P.StaminaMax=user.DogStaminaMax; P.StaminaXP=user.DogStaminaExp; P.StaminaMXP=user.DogStaminaMXP
						spawn(20)user.choosing=0
						user<<"Vet: <i>Here's [P].</i>"
						P.Status="follow"; P.DogFollow(user)

				if("Rename K-9")
					switch(alert("Renaming [D] will cost you 1,000 gold...","Vet","That's fine","No thanks"))
						if("That's fine")
							if(!MobDistanceCheck(user,src,3)) {user.choosing=0; return}
							if(user.gold<1000) {user<<"Vet: <i>I'm afraid you don't have enough!</i>"};..()
							user.gold-=1000
							renamepet
							var/dogname = input("What will you call your new companion?","") as text
							var/list/T=list("<font","<font","<B>","<I>","<U>","<br")
							for(var/H in T)
								if(findtext(dogname,H)) {user<<"<font color=red>No HTML in names.</font>"; goto renamepet}
							if(length(dogname)>20||length(dogname)<2||isnull(dogname)||!dogname||dogname == "")
								alert("Name too long or short."); goto renamepet
							else
								user<<"Vet: <i>Done!</i>"; d.name=dogname; user.DogName=dogname; user.StatUpdate_gold()
				if("K-9 Colour")
					var/input = input("Select a new colour for your dog!","Dog Colour") in list("White","Black","Grey", "Blue", "Red")
					switch(input)
						if("white")
							user.DogColour="white"
						if("Red")
							user.DogColour="red"
						if("Black")
							user.DogColour="black"
						if("Grey")
							user.DogColour="grey"
						if("Blue")
							user.DogColour="blue"
					user<<"Your dog will change to [input] next time you summon them!"
			user.choosing=1