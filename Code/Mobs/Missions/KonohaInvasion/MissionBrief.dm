mob/Hittable/Responsive/NPC/KonohaInvasion
	MissionNinja
		name="Mission Ninja"
		icon='MissionMan.dmi'
		protect=1
		NinjaRank="Anbu"
		Village="Leaf"
		Clan="Yamanaka"
		Class = list("Sensory-Nin" = 1)
		Speciality="Genjutsu"
		Chakra=100000; ChakraMax=100000
		Stamina=800000; StaminaMax=800000
		Action(mob/user)
			if(!(user in range(3, src))) return
			switch(input("","Konoha Invasion Quest") as null|anything in list("Mission Brief","Scoring"))
				if("Mission Brief")
					user<<{"<b>Mission Ninja: <i>"The villages of Sound and Sand have collaborated against Konoha, and have invaded Leaf Village in large numbers.\
					In order to complete this quest, you must work as a team to dispatch every last invader within the alotted time.</i>"</b>"}
				if("Scoring")
					user<<{"<b><i>"Points are awarded for:</b><p>* Being ready for the mission<br>* Damaging the enemies<br>* Knocking Out the enemies<br>* Killing the enemies<br>* Speed<br><b>Note:</b> You will lose points for <i>Finishing</i>, Killing</i> and <i>KO'ing allies</i>."}