mob/var
	TipsDisabled
mob/verb
	ToggleTips()
		set name="Toggle Tips"
		set hidden=1
		if(!usr.TipsDisabled) {usr.TipsDisabled=1; usr<<"Tips turned <i>off</i>"}
		else {usr.TipsDisabled=0; usr<<"Tips turned <i>on</i>"; usr.TipsCheck()}
mob/proc
	TipsCheck()
		if(!TipsDisabled)
			switch(pick(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32))
				if(1)
					switch(alert(src,"Crafting is a nifty way to create weapons and other items out of feathers (found by killing chickens) and rocks (randomly found while walking outside).  It is a very useful ninja technique.","Crafting","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(2)
					switch(alert(src,{"Guilds are a great way to make online friends and allies.  You cannot found your own guild until you reach Chuunin rank, but you can join one at any time.  Some guilds also have the added bonus of 'Guild Houses': a great place to hang out, train, or plot an attack."},"Guilds","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(3)
					switch(alert(src,"There are extra verbs located in the 'Commands' drop-down menu at the top of your Dream Seeker window.  Browse through this menu to find a lot of handy options (e.g. find out when the next exam is being held).","Extra Options","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(4)
					switch(alert(src,"There are many ways to chat to people in SoM; the main way is through OOC as it will reach anyone who has it turned on.  What's more, we've incorporated a little OOC text box into the SoM interface so you don't have to open a window to use it everytime! Handy, eh?","Communication","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(5)
					switch(alert(src,"Want to know how long until the next Genin or Chuunin exam??  No problem!  Simply locate and use the 'Exam Check' verb in the 'Commands' drop-down menu.","When's the next exam?","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(6)
					switch(alert(src,"Chakra Control (CC) indicates the percent-chance of successfully performing a chakra-based jutsu.  CC can be trained through use of any technique that requires Chakra","Chakra Control","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(7)
					switch(alert(src,"Outside the gates of every Hidden Village is a Carriage Driver.  He's always travelling between the villages and is more than happy to take you too, provided you have enough gold...","Fast Travel","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(8)
					switch(alert(src,"The SoM skin features two amazing little buttons that mean you can keep other games' macro lists that you've created, and still have one for SoM.  Simply save macros as 'ALT+' or 'CTRL+' and then click the appropriate button on the SoM interface.  While toggled, you won't need to hold ALT/CTRL to perform the macro.  This means you can have up to 3 full macro lists!","Macros","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(9)
					switch(alert(src,"Effectively increase your Taijutsu by Sparring with a similarly skilled sparring partner at on of the many Sparring Arenas.  Such arenas are marked with a white 'S' flag.","Sparring","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(10)
					switch(alert(src,"Levelling up is a great way to improve your character.  Every time you level up you receive 5 Stat Points which you can spend on improving your character's stats or upgrading their attacks/skills.  Characters receive exerience points when fighting human or NPC opponents.","Levelling Up","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(11)
					switch(alert(src,"You don't have to be critically injured to make use of hospitals.  Go into one at any time and sleep off your wounds for free; or buy some more bandages from a Medic.","Hospital","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(12)
					switch(alert(src,"Creating a Bank Account is the perfect way to stop losing money upon death.  Bank Accounts are also useful for storing your money when your wallet gets full.","Banking","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(13)
					switch(alert(src,"When your character's Chakra Control is high enough, they will be endowed with the ability to walk on water.  But be careful, until your Chakra Control gets closer to 100%, you'll likely fall in and run the risk of drowning!","Water Walking","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(14)
					switch(alert(src,"After some glory?  Then	 challenge other players to a battle in one of the arenas.  While you're at it, why not bet some gold on the fight?  Choose from numerous arenas to get a strategic advantage, or make it even.","Arena Challenge","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(15)
					switch(alert(src,"If you can't find your way around, simply use the Toggle Minimap verb in the 'Commands' drop-down menu.  You can also look at the top of your 'Stats' tab to see your exact grid location.","Getting Lost?","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(16)
					switch(alert(src,{"If you attack other village members, you could find the entire village after your blood!  You will also be added that village's Bingo Book, and human and computer players alike will hunt you for the bounty on your head."},"Wanted; Dead or Alive","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(17)
					switch(alert(src,"Your walk/run speed is split into three tiers.  Your character begins life on Tier 3; the slowest.  By training your character's Stamina and Taijutsu to the required levels, as well as being of a high enough rank, your character will learn to move faster.","Walk/Run Speed","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(18)
					switch(alert(src,"SoM offers many ways to earn money.  Some of which include selling weapons to the Weapons Dealer; Fish you have caught to the Fisherman; Completing missions; Placing a bet on your Arena Challenges.","Earning Cash","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(19)
					switch(alert(src,"In order to advance as a ninja (and earn money doing it), your character will need to complete missions.  Missions vary from D to S rank; D being the easiest and S being the hardest.  Talk to a Mission Man from your village to find out more...","Missions","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(20)
					switch(alert(src,"One of the training methods on SoM is the 'learn by doing it' method.  If you want to train Ninjutsu, use a Ninjutsu-based attack.  Your Chakra Control?  Do something that relies on Chakra Control/Chakra usage.  Weapon skill? Use a weapon.  The list goes on...","Training - Just Do It","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(21)
					switch(alert(src,"Whenever your Character's Stamina falls below 1, they will fall unconcious for a time.  ANY unconcious player can be instantly killed by walking up to them and using the FINISH verb.  So be careful.","Knocked Out","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(22)
					switch(alert(src,"Climbing a mountain is a great way to increase your character's Stamina.  The main mountain is located roughly in the centre of the map.  Just be sure you have enough Stamina to survive the harsh mountain environment!","Climbing the Mountain","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(23)
					switch(alert(src,"You can buy fishing rods from the Fishermen located throughout the world.  Simply cast your line into water to catch a fish.  Chances are improved with higher fishing skill and better quality rods.  Be sure to take them to get repaired before the shatter!","Fishing","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(24)
					switch(alert(src,"Check up and see what your character has accomplished by using the 'View Profile' verb, located in the 'Commands' tab.  Similarly, you can check the number of times you have used each technique by using the 'Check Move Uses' verb.","player Profile","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(25)
					switch(alert(src,"Getting a Class is a great way to increase your chance of survival!  Professions can give you new techniques, passive abilities, and/or increased stats.  Class Nins are scattered around the world waiting to teach you new things, just look for the purple flag.","Professions","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(26)
					switch(alert(src,"When you take damage, your Wounds stat increases.  It will only decrease by using bandages, receiveing first aid from a Medical Ninja, or by sleeping in a bed.  Your character could die when Wounds reach 150 or when your Stamina is 0 and Wounds are above 100.","Wounds","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(27)
					switch(alert(src,"Located throughout the world are huge trees; you can use these trees to train your Chakra Control.  Simply stand to the South of the tree trunk and use the appropriate verb to run up the tree; training gets best results at lower Chakra Control levels.","Tree Climbing","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(28)
					switch(alert(src,"Check your Stamina, Chakra, and Wounds at a glance with the HUD Guage.  The green circle shrinks as you lose Stamina, the blue bar recedes as you use up your Chakra, and your guage will become blood-stained as your Wounds inreases.","Life Guage","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(29)
					switch(alert(src,"A combination of hand seals are used to perform most ninja techniques.  The faster your Seal Speed, the faster your character can complete the seals necessary for a particular technique.","Seal Speed","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(30)
					switch(alert(src,"Dotted around the world are various quests.  Quests are essentially a Co-Op mission; players gather at specifed areas around the world and are then sent into the quest when ready.  Quests are useful for finding rare items, earning money, getting new abilities, and various other things.","Quests","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(31)
					switch(alert(src,"If you find yourself under attack from a Village Ninja, you can yield to them.  This will mean paying a fine for the crimes you commited and a possible jail term.","Yielding","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()
				if(32)
					switch(alert(src,"Your reflexes control whether or not punches will land.  If your reflexes are higher than your opponents, you will always connect.  You can train your reflexes by sparring, and it takes a lot of time and effort.","Reflexes","OK","Next Tip >>","Disable Tips"))
						if("Disable Tips") TipsDisabled=1
						if("Next Tip >>") TipsCheck()