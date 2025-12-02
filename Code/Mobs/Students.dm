mob/NPC/Academy
	Student
		icon='Student.dmi'
		name="School boy"
		NinjaRank="Academy Student"
		protect=1
		New()
			spawn(35) Wander()
		Action(mob/user)
			if(get_dist(user,src)>2) return
			switch(pick(1,2,3,4))
				if(1) user<<"Hello!"
				if(2) user<<"One day, I'm going to be a kage!"
				if(3) user<<"Excuse me, I need to get back to my studies."
				if(4) user<<"Ever wonder if all this is real?"
	Student_Screwy
		icon='Student.dmi'
		name="Student Fry"
		Clan="Canada"
		NinjaRank="Failed Student"
		Speciality="Ninjutsu"
		Village="Admin"
		protect=1
		New()
			spawn(35) Wander()
		Action(mob/user)
			if(get_dist(user,src)>2) return
			switch(pick(1,2,3))
				if(1) user<<"'eh?"
				if(2) user<<"Sorry!"
				if(3) user<<"Don't turn off the lights! I'm scared of the dark!"
	Student_Jamie
		icon='Student.dmi'
		name="Student SomeGuy"
		NinjaRank="Academy Student"
		Clan="Haku. What else?"
		Speciality="Cat"
		Village="Admin"
		protect=1
		New()
			spawn(35) Wander()
		Action(mob/user)
			if(get_dist(user,src)>2) return
			switch(pick(1,2,3))
				if(1) user<<"I guess I'm just some guy you met..."
				if(2) user<<"I got kicked out because my grades are too low!"
				if(3) user<<"I wish I was a cat..."
	Student_Verm
		icon='Student.dmi'
		name="Student Vermiere"
		NinjaRank="Academy Student"
		Clan="Inuzuka. He likes dogs... too much"
		Village="Admin"
		Speciality="None"
		protect=1
		New()
			spawn(35) Wander()
		Action(mob/user)
			if(get_dist(user,src)>2) return
			switch(pick(1,2))
				if(1) user<<"Do dogs lay eggs?"
				if(2) user<<"I'm going to tame and train the best dog ever!"
	Student_Renshi
		icon='Student.dmi'
		name="Student Georm"
		Village="Murica! Fuck yeee!"
		NinjaRank="Guns"
		Clan="Guns"
		wielding="Gun"
		Speciality="Guns"
		protect=1
		New()
			spawn(35) Wander()
		Action(mob/user)
			if(get_dist(user,src)>2) return
			switch(pick(1,2))
				if(1) user<<"Hello!"
				if(2) user<<"Give a man a fish and he can eat for a day, teach a man to fish and you lose a great business opportunity."