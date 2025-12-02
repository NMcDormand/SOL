mob
	Hittable/Unresponsive/NPC/Panda
		protect=1; CantHenge=1

		Stamina =10000; StaminaMax=10000; StaminaTrue=10000

		Chakra =5000; ChakraMax=5000; ChakraTrue=5000

		Taijutsu =1000; TaijutsuMax=1000; TaijutsuTrue=1000

		Genjutsu =1000; GenjutsuMax=1000; GenjutsuTrue=1000

		Ninjutsu =1000; NinjutsuMax=1000; NinjutsuTrue=1000

		name = "Panda"; icon = 'Dr.Panda.dmi'; Clan="RIP Buddy"; Village="You will be missed!";
		Speciality="Crashing the server with mass clones"; NinjaRank="Godlike"; Class = list("Medic-Nin"=1);
		Action(mob/user)
			if(get_dist(user,src)>2) return
			if(!user.Emoji)
				switch(alert("Wow you found my Hospital! Want to know a secret?",,"Yes","No"))
					if("Yes")
						alert("You can use Emoji in this game! Try typing !Panda in the OOC"); user.Emoji=1;
					if("No")
						user << "Well ok then..."
			else
				switch(pick(1,2,3))
					if(1) user<<"There are more than just \"!Panda\""
					if(2) user<<"This is my Hospital!"
					if(3) user<<"You should use 'Look' on me!"
	NPC
		protect=1; CantHenge=1

		Stamina =10000; StaminaMax=10000; StaminaTrue=10000

		Chakra =5000; ChakraMax=5000; ChakraTrue=5000

		Taijutsu =1000; TaijutsuMax=1000; TaijutsuTrue=1000

		Genjutsu =1000; GenjutsuMax=1000; GenjutsuTrue=1000

		Ninjutsu =1000; NinjutsuMax=1000; NinjutsuTrue=1000

		GeninExamInstructor1
			name = "Genin Exam Instructor"; icon = 'Examinor.dmi'; NinjaRank="Chuunin"
			SPM
				name = "Saucepan Man"; icon = 'Examinor.dmi'; NinjaRank="Previous God"
				Action(mob/user)
					if(get_dist(user,src)>2) return
					switch(pick(1,2))
						if(1) user<<"Our lives would make for a great game..."
						if(2) user<<"Make sure you don't speak while taking the exam! I'll be watching..."
		ChuuninExamInstructor1
			name = "Chuunin Exam Instructor"; icon = 'Examinor.dmi'; NinjaRank="Jounin"
			Action(mob/user)
				if(get_dist(user,src)>2) return
				if(chuuninClock > 1) {user<<"Please wait patiently for [chuuninClock] minutes";}
				else if(chuuninClock > 1 && chuuninClock < 0) {user<<"This part of the Chuunin will end in under 60 seconds!";}
				else user<<"You shouldn't be in here. Please use the Stuck Command in ? or try to relog."