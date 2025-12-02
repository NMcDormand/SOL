mob/NPC/Helpers
	protect=1
	Stamina =100; StaminaMax=100
	Chakra =10; ChakraMax=10
	Taijutsu =10; Genjutsu =10; Ninjutsu =10
	name = "Helper"
	icon = 'SpawnMan.dmi'
	Helper1
		Action(mob/user)
			if(get_dist(user,src)>2) return
			start
			switch(input("What would you like to learn about?","Helper 1")as null|anything in list("Stamina","Chakra","Chakra Control"))
				if("Stamina")
					alert("Your Stamina is your health. You can train this with climbing Stamina Mountain, and restore it to full by resting","Stamina")
					goto start
				if("Chakra")
					alert("Your Chakra is basically your magic power,and needed to use most Ninjutsu and Genjutsu and even some Taijutsu. Rest in order to restore it. Chakra can be trained by walking on water and/or using jutsus(that require Chakra). Not all jutsus train Chakra at the same rate.","Chakra")
					goto start
				if("Chakra Control")
					alert("Your amount of Chakra Control (CC) governs the chance that jutsus you perform wil be successful. The % of control directly relates to your chance of success.  When your CC is 100%, some jutsus will gain more power, longjevity, and/or range. Train CC the same way you train Chakra, by Water Walking and/or using jutsus (that require Chakra).","Chakra Control")
					goto start

	Helper2
		Action(mob/user)
			if(get_dist(user,src)>2) return
			start
			switch(input("What would you like to learn about?","Helper 2")as null|anything in list("Taijutsu","Genjutsu","Ninjutsu","Skills"))
				if("Taijutsu")
					alert("Taijutsu attacks are attacks that use your body. All ninjas have basic abilities in Taijutsu, and some clans (like Hyuuga) have extra abilities.  Very few Taijutsu attacks require much chakra, if any. Can be trained by using Taijutsu-based attacks, hitting logs, and climbing Stamina Mountain.","Taijutsu")
					goto start
				if("Genjutsu")
					alert("Genjutsu is used to confuse or distract the opponent. This can include, illusions, switching places, teleporting, and other things. Usually requires Chakra to use and can be trained by using Genjutsu-based attacks","Genjutsu")
					goto start
				if("Ninjutsu")
					alert("Ninjutsu is used for long-ranged attacks to inflict damage on the opponent.  These often require more chakra than Genjutsu attacks. Can be trained by using Ninjutsu-based attacks.","Ninjutsu")
					goto start
				if("Skills")
					alert("The higher players' skills with weaponary, the more damage that will be done when the player attacks and has a weapon of that type equipped.  The same principle applies to fishing: increasing the chance of catching a fish and improving its size/quality.  As with crafting, the higher your skill, the better the items crafted.","Skills")
					goto start

	Helper3
		Action(mob/user)
			if(get_dist(user,src)>2) return
			switch(input("Would you like to learn about earning gold?","Helper 3")in list("Yes","No"))
				if("Yes")
					alert("Obtained by killing a player and picking up what they drop.","Earning Gold")
					alert("Completing missions.","Earning Gold")
					alert("Selling things to the relevant shopkeepers.","Earning Gold")