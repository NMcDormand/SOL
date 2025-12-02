mob/var
	list/Class = list("None"=1)

mob/NPC/ProfessionNin
	protect=1
	Stamina =10000; StaminaMax=10000; StaminaTrue=10000
	Chakra =5000; ChakraMax=5000; ChakraTrue=5000
	Taijutsu =1000; TaijutsuMax=1000; TaijutsuTrue=1000
	Genjutsu =1000; GenjutsuMax=1000; GenjutsuTrue=1000
	Ninjutsu =1000; NinjutsuMax=1000; NinjutsuTrue=1000

	SwordNin
		name = "Sword Ninja"
		icon = 'SwordNinja.dmi'
		Class=list("Sword-Nin" = 1)
		CantHenge=1
		protect=1

		Action(mob/user)
			if(get_dist(user,src)>2) return
			if(user.NinjaRank=="Academy Student") {user<<"Come back when you are Genin rank or higher."; return}
			if(user.TaijutsuTrue<1500) {user<<"You're not strong enough yet."; return}
			if(user.Class["Sword-Nin"])
				user<<"You're already a Sword-Nin but I'll teach you the basics again..."
				user.ReAssignProfession("Sword-Nin")
				return
			if(user.choosing) return
			user.choosing=1
			if(!user.Class["None"])
				if(user.gold<2000)
					user<<"You need at least 2000 gold to change professions!"; user.choosing=0
				else
					switch(input("You are already under a different Class, but would you like to change your class for 2000 gold?","Change Class")in list("Yes","No"))
						if("Yes") {user.gold-=2000; user.ReAssignProfession("Sword-Nin"); user.StatUpdate_gold()}
					user.choosing=0
			else
				switch(input("Would you like to become a Sword-Nin?","Select Class")in list("Yes","No"))
					if("Yes")
						user.ReAssignProfession("Sword-Nin")
				user.choosing=0

//-------------------------------------------------------------------------------------------------------------

	AssassinNin
		name = "Assassin Ninja"
		icon = 'Assassin.dmi'
		Class = list("Assassin-Nin" = 1)
		CantHenge=1
		protect=1

		Action(mob/user)
			if(get_dist(user,src)>2) return

			if(user.NinjaRank=="Academy Student"||user.NinjaRank=="Genin") {user<<"Come back when you are Chuunin rank or higher."; return}
			if(user.TaijutsuTrue<=1800||user.NinjutsuTrue<=2500||user.GenjutsuTrue<=2200) {user<<"You're not strong enough yet."; return}
			if(user.Class["Assassin-Nin"])
				user<<"You're already an Assassin-Nin but I'll teach you the basics again..."
				user.ReAssignProfession("Assassin-Nin")
				return
			if(user.choosing) return
			user.choosing=1
			if(!user.Class["None"])
				if(user.gold<2000)
					user<<"You need at least 2000 gold to change professions!"; user.choosing=0
				else
					switch(input("You are already under a different Class, but would you like to change your class for 2000 gold?","Change Class")in list("Yes","No"))
						if("Yes") {user.gold-=2000; user.ReAssignProfession("Assassin-Nin"); user.StatUpdate_gold()}
					user.choosing=0
			else
				if(alert("Would you like to become Assassin-Nin?","Select Class","Yes","No")=="Yes")
					user.ReAssignProfession("Assassin-Nin")
				user.choosing=0

/*-------------------------------------------------------------------------------------------------------------

	SandNin
		name = "Sand Ninja"
		icon = 'Assassin.dmi'
		Class = list("Sand-Nin" = 1)
		CantHenge=1
		protect=1

		Action(mob/user)
			if(get_dist(user,src)>2) return

			if(user.NinjaRank=="Academy Student") {user<<"Come back when you are Genin rank or higher."; return}
			if(user.TaijutsuTrue<=3000||user.NinjutsuTrue<=3400) {user<<"You're not strong enough yet."; return}
			if(user.Class["Sand-Nin"])
				user<<"You're already a Sand-Nin but I'll teach you the basics again..."
				user.ReAssignProfession("Sand-Nin")
				return
			if(user.choosing) return
			user.choosing=1
			if(!user.Class["None"])
				if(user.gold<2000)
					user<<"You need at least 2000 gold to change professions!"; user.choosing=0
				else
					switch(input("You are already under a different Class, but would you like to change your class for 2000 gold?","Change Class")in list("Yes","No"))
						if("Yes") {user.gold-=2000; user.ReAssignProfession("Sand-Nin"); user.StatUpdate_gold()}
					user.choosing=0
			else
				switch(input("Would you like to become a Sand-Nin?","Select Class")in list("Yes","No"))
					if("Yes")
						user.ReAssignProfession("Sand-Nin")
				user.choosing=0
*/
//-------------------------------------------------------------------------------------------------------------


	MedicalNin
		name = "Medical Ninja"
		icon = 'Kabuto.dmi'
		Class = list("Medical-Nin" = 1)
		CantHenge=1
		protect=1

		Action(mob/user)
			if(get_dist(user,src)>2) return
			if(!user.SpokeToKabuto)
				for(var/obj/Item/Scroll/S in user.contents)
					if(S.trueName == "Edo Tensei No Jutsu")
						user << "Where ever you found this, he wanted you to find it for a reason; im not one to say why"
						user.SpokeToKabuto = 1
						return

			if(user.sliced) {user<<"[src] has reattached your tendons!."; user.sliced=null; return}
			if(user.Nerves) {user<<"[src] has repaired your nerves!."; user.Nerves=null; return}
			if(user.Blasted) {user<<"[src] has repaired your inner ear!."; user.Blasted=null; return}
			if(user.Poisoned) {user<<"[src] has cured you!."; user.Poisoned=null; return}
			if(user.choosing) return
			if(user.NinjaRank=="Academy Student") {user<<"Come back when you are Genin rank or higher."; return}
			if(user.Class["Medical-Nin"])
				user<<"You're already a Medic-Nin but I'll teach you the basics again..."
				user.ReAssignProfession("Medical-Nin")
				return
			user.choosing=1
			if(!user.Class["None"])
				if(user.gold<2000)
					user<<"You need at least 2000 gold to change professions!"; user.choosing=0
				else
					switch(input("You are already under a different Class, but would you like to change your class for 2000 gold?","Change Class")in list("Yes","No"))
						if("Yes") {user.MedicalExam(src); user.gold-=2000; user.StatUpdate_gold()}
					user.choosing=0
			else
				switch(input("Would you like to become a Medic-Nin","Select Class")in list("Yes","No"))
					if("Yes")
						user.MedicalExam(src)
				user.choosing=0

//-------------------------------------------------------------------------------------------------------------

	HandtoHandNin
		name = "Hand2Hand Ninja"
		icon = 'Sakura.dmi'
		Class = list("Hand2Hand-Nin" = 1)
		CantHenge=1
		protect=1

		Action(mob/user)
			if(get_dist(user,src)>2) return

			if(user.NinjaRank=="Academy Student") {user<<"Come back when you are Genin rank or higher."; return}
			if(user.TaijutsuTrue<1400||user.ChakraControl<=90) {user<<"You're not yet qualified; you need strong Taijutsu as well as strong Chakra Control"; return}
			if(user.Class["Hand2Hand-Nin"])
				user<<"You're already a Hand 2 Hand Ninja but I'll teach you the basics again..."
				user.ReAssignProfession("Hand2Hand Ninja")
				return
			if(user.choosing) return
			user.choosing=1
			if(!user.Class["None"])
				if(user.gold<2000)
					user<<"You need at least 2000 gold to change professions!"; user.choosing=0
				else
					switch(input("You are already under a different Class, but would you like to change your class for 2000 gold?","Change Class")in list("Yes","No"))
						if("Yes") {user.gold-=2000; user.ReAssignProfession("Hand2Hand-Nin"); user.StatUpdate_gold()}
					user.choosing=0
			else
				switch(input("Would you like to become a Hand 2 Hand Ninja?","Select Class")in list("Yes","No"))
					if("Yes")
						user.ReAssignProfession("Hand2Hand-Nin")
				user.choosing=0

//-------------------------------------------------------------------------------------------------------------

	FanNin
		name = "Fan Ninja"
		icon = 'Assassin.dmi'
		Class = list("Fan-Nin" = 1)
		CantHenge=1
		protect=1

		Action(mob/user)
			if(get_dist(user,src)>2) return
			if(!user.WindElemental) {user<<"You are not aligned with the Wind Element."; return}
			if(user.NinjaRank=="Academy Student") {user<<"Come back when you are Genin rank or higher."; return}
			if(user.TaijutsuTrue<1600||user.NinjutsuTrue<2000) {user<<"You're not yet qualified."; return}
			if(user.Class["Fan-Nin"])
				user<<"You're already a Fan-Nin but I'll teach you the basics again..."
				user.ReAssignProfession("Fan-Nin")
				return
			if(user.choosing) return
			user.choosing=1
			if(!user.Class["None"])
				if(user.gold<2000)
					user<<"You need at least 2000 gold to change professions!"; usr.choosing=0
				else
					switch(input("You are already under a different Class, but would you like to change your class for 2000 gold?","Change Class")in list("Yes","No"))
						if("Yes") {user.gold-=2000; user.ReAssignProfession("Fan-Nin"); user.StatUpdate_gold()}
					user.choosing=0
			else
				switch(input("Would you like to become a Fan-Nin?","Select Class")in list("Yes","No"))
					if("Yes")
						user.ReAssignProfession("Fan-Nin")
				user.choosing=0

/*-------------------------------------------------------------------------------------------------------------

	ClayNin
		name = "Deidara"
		icon = 'Base_Pale.dmi'
		Class = list("Clay-Nin" = 1)
		CantHenge=1
		protect=1

		New()
			overlays += icon('Headband.dmi')
			var/icon/A = icon('Hair_Deidara.dmi')
			A += rgb(204,204,102)
			overlays += A
			A = icon('Eyes_Base.dmi')
			A += rgb(102,102,255)
			overlays += A
			overlays += icon('Pants.dmi')
			overlays += icon('LShirt.dmi')
			overlays += icon('AkatCloak.dmi')
			respawn=loc

		Action(mob/user)
			if(get_dist(user,src)>2) return

			if(!user.EarthElemental) {user<<"You are not aligned with the Earth Element."; return}
			if(user.NinjaRank=="Academy Student") {user<<"Come back when you are Genin rank or higher."; return}
			if(user.NinjutsuTrue<4000) {user<<"You're not yet qualified."; return}
			if(user.Class["Clay-Nin"])
				user<<"You're already a Clay-Nin but I'll teach you the basics again..."
				user.ReAssignProfession("Clay-Nin")
				return
			if(user.choosing) return
			user.choosing=1
			if(!user.Class["None"])
				if(user.gold<2000)
					user<<"You need at least 2000 gold to change professions!"; usr.choosing=0
				else
					switch(input("You are already under a different Class, but would you like to change your class for 2000 gold?","Change Class")in list("Yes","No"))
						if("Yes") {user.gold-=2000; user.ReAssignProfession("Clay-Nin"); user.StatUpdate_gold()}
					user.choosing=0
			else
				switch(input("Would you like to become a Clay-Nin?","Select Class")in list("Yes","No"))
					if("Yes")
						user.ReAssignProfession("Clay-Nin")
				user.choosing=0
*/
//------------------------------------------------------------------------------------------------------------

	SensoryNin
		name = "Sensory Ninja"
		icon = 'Assassin.dmi'
		Class = list("Sensory-Nin" = 1)
		CantHenge=1
		protect=1

		Action(mob/user)
			if(get_dist(user,src)>2) return
			if(user.NinjaRank=="Academy Student") {user<<"Come back when you are Genin rank or higher."; return}
			if(user.GenjutsuTrue<4000) {user<<"You're not strong enough yet."; return}
			if(user.Class["Sensory-Nin"])
				user<<"You're already a Sensory-Nin but I'll teach you the basics again..."
				user.ReAssignProfession("Sensory-Nin")
				return
			if(user.choosing) return
			user.choosing=1
			if(!user.Class["None"])
				if(user.gold<2000)
					user<<"You need at least 2000 gold to change professions!"; user.choosing=0
				else
					switch(input("You are already under a different Class, but would you like to change your class for 2000 gold?","Change Class")in list("Yes","No"))
						if("Yes") {user.gold-=2000; user.ReAssignProfession("Sensory-Nin"); user.StatUpdate_gold()}
					user.choosing=0
			else
				switch(input("Would you like to become a Sensory-Nin?","Select Class")in list("Yes","No"))
					if("Yes")
						user.ReAssignProfession("Sensory-Nin")
				user.choosing=0

//------------------------------------------------------------------------------------------------------------

	Hidan
		name = "Hidan"
		icon = 'Assassin.dmi'
		icon_state = "hidan"
		Class = list("Jashin" = 1)
		CantHenge=1
		protect=1

		Action(mob/user)
			if(get_dist(user,src)>2) return
			if(user.choosing) return
			if(user.NinjaRank=="Academy Student"||user.NinjaRank=="Genin") {user<<"Come back when you are Chuunin rank or higher."; return}
			if(user.StaminaTrue<150000) {user<<"Are you even close to immortal? Come back when you have more Stamina..."; return}
			if(user.Class["Jashin"])
				user<<"You already walk in the footsteps of Jashin. Go and cause chaos!"
				user.ReAssignProfession("Jashin")
				return
			user.choosing=1
			if(!user.Class["None"])
				if(user.gold<2000)
					user<<"You need at least 2000 gold to change professions!"; user.choosing=0
				else
					switch(input("You are already under a different Class, but would you like to change your class for 2000 gold?","Change Class")in list("Yes","No"))
						if("Yes") {user.gold-=2000; user.ReAssignProfession("Jashin"); user.StatUpdate_gold()}
					user.choosing=0
			else
				switch(input("Would you like to follow Jashin and cause true chaos?","Select Class")in list("Yes","No"))
					if("Yes")
						user.ReAssignProfession("Jashin")
				user.choosing=0