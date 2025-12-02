/*mob/var/tmp
	Bonked = 0
	GiftedSaito = 0

mob/verb
	BonkSaito()
		if(ckey == "silvershodow")
			usr << "Sorry this isnt for you either"
			return
		var/mob/S
		for(var/mob/M in MasterPlayerList)
			if(M.ckey == "silvershodow")
				S = M
				break
		if(S)
			if(!S.Bonked)
				S.Bonked = 1
				if(get_dist(usr,S)>4)
					usr << "[usr] Bonked you with a rolled up newspaper"
					usr << "[usr] says: Bad [S.trueName]!"
					usr << "[usr] says: Petty [S.trueName]!"

				hearers(4,S) << "[usr] Bonked you with a rolled up newspaper"
				hearers(4,S) << "[usr] says: Bad [S.trueName]!"
				hearers(4,S) << "[usr] says: Petty [S.trueName]!"
				spawn(600)
					S.Bonked = 0
			else
				usr << "He is already sore from the last beating"
		else
			usr << "Seems he's not on right now, try again later"
	GiftedSaito()
		if(ckey == "silvershodow")
			usr << "Sorry this isnt for you"
			return
		var/mob/S
		for(var/mob/M in MasterPlayerList)
			if(M.ckey == "silvershodow")
				S = M
				break
		if(S)
			if(!S.GiftedSaito)
				S.GiftedSaito = 1
				usr << "[S.trueName] has given you a wonderful gift! Dont forget to thank them!"
				S << "[usr] just got a gift your gift!"
				var/obj/Clothing/Underwear/Boxers/B = new(usr)
				B.name = "[S.trueName]'s Stained Boxers"
				B.trueName = B.name
				B.price = 0
				usr.UpdateInventory()
				spawn(6000)
					S.GiftedSaito = 0
			else
				usr << "Someone has already received his beautiful splendor!"
		else
			usr << "Seems he's not on right now, try again later"
*/
mob
	var
		UsedDebug = 0
#if DEBUGGING
	verb
		Check_Skill_Seeds()
			var/msg = "Skill Seed"
			for(var/A in SkillSeeds)
				msg += "[A] = [SkillSeeds[A]]"
			msg += "<br>RB Data"
			for(var/A in RebirthData.JL)
				msg += "[A] = [RebirthData.JL[A]]"
			src << msg
		Check_Rand_Dir(var/mob/M in view())
			var/turf/T = Get_Rand_DirStep(M)
			if(T)
				loc.loc.Exited(src)
				loc = T
				loc.loc.Entered(src)
mob/verb
	VillageChange(mob/M in MasterPlayerList)
		set category="Special"
		set desc="Change a player's village."
		var/V = input("Transfer them to which village?","")as null|anything in list("Leaf", "Mist", "Cloud", "Rock", "Sand", "Sound", "Waterfall", "Grass", "Rain")
		if(V)
			M.Village = V
			usr.UsedDebug++

	RankUp(mob/M in MasterPlayerList)
		set category="Special"
		set desc="Rank up a user."
		//world << "RankUp called on [M.trueName] who is a [M.NinjaRank] from [M.Village]."
		if(M.NinjaRank == "Academy Student")
			M.RankGenin()
		else if(M.NinjaRank == "Genin")
			M.RankChuunin()
		else if(M.NinjaRank == "Chuunin")
			M.RankSpecialJounin()
		else if(M.NinjaRank == "Special Jounin")
			M.RankAnbu()
		else if(M.NinjaRank == "Anbu")
			M.RankJounin()
		else if(M.NinjaRank == "Jounin")
			M.RankKageLevel()
		/*else if(M.NinjaRank == "Kage Level")
			switch(M.Village)
				if("Leaf") M.NinjaRank="Hokage"
				if("Mist") M.NinjaRank="Mizukage"
				if("Cloud") M.NinjaRank="Raikage"
				if("Rock") M.NinjaRank="Tsuchikage"
				if("Sand") M.NinjaRank="Kazekage"
				if("Grass") NinjaRank="Grass Leader"
				if("Rain") NinjaRank="Rain Leader"
				if("Waterfall") NinjaRank="Waterfall Leader"
				if("Sound") NinjaRank="Sound Leader"

			if(!M.BeenKage)
				M<<"<b><font size=2>Congratulations!! The huge effort you've put into training and doing missions for the village have finally been acknowledged!  You are now the [M.NinjaRank] of [M.Village]</b></font>"

				M.StatPoints+=50;
				M.AddCaps()
				M.LevelBonus+=50

				M.BeenKage = 1*/

		M <<"These are your current Stat Caps<br>Stamina: [M.Cap_Stamina]<br>Chakra: [M.Cap_Chakra]<br>Taijutsu: [M.Cap_Taijutsu]<br>Ninjutsu: [M.Cap_Ninjutsu]<br>Genjutsu: [M.Cap_Genjutsu]"

		usr.UsedDebug++
		if(M!=usr)
			usr<<"These are [M]'s current Stat Caps<br>Stamina: [M.Cap_Stamina]<br>Chakra: [M.Cap_Chakra]<br>Taijutsu: [M.Cap_Taijutsu]<br>Ninjutsu: [M.Cap_Ninjutsu]<br>Genjutsu: [M.Cap_Genjutsu]"

	RankDown(mob/M in MasterPlayerList)
		set category="Special"
		set desc="Rank down a user."
		//world << "RankDown called on [M.trueName] who is a [M.NinjaRank] from [M.Village]."
		if(M.NinjaRank == "Kage Level")
			M.RankJounin()
		else if(M.NinjaRank == "Jounin")
			M.RankAnbu()
		else if(M.NinjaRank == "Anbu")
			M.RankSpecialJounin()
		else if(M.NinjaRank == "Special Jounin")
			M.RankChuunin()
		else if(M.NinjaRank == "Chuunin")
			M.RankGenin()
		//else
		//	M.RankKageLevel()
		M <<"These are your current Stat Caps<br>Stamina: [M.Cap_Stamina]<br>Chakra: [M.Cap_Chakra]<br>Taijutsu: [M.Cap_Taijutsu]<br>Ninjutsu: [M.Cap_Ninjutsu]<br>Genjutsu: [M.Cap_Genjutsu]"
		usr.UsedDebug++
		if(M!=usr)
			usr <<"These are [M]'s current Stat Caps<br>Stamina: [M.Cap_Stamina]<br>Chakra: [M.Cap_Chakra]<br>Taijutsu: [M.Cap_Taijutsu]<br>Ninjutsu: [M.Cap_Ninjutsu]<br>Genjutsu: [M.Cap_Genjutsu]"

	Give_Speed(mob/M in MasterPlayerList)
		M.movespeed = 1
		usr.UsedDebug++

	Give_Cap_Stats(mob/M in MasterPlayerList)
		M.TaijutsuTrue += Cap_Taijutsu
		M.NinjutsuTrue += Cap_Ninjutsu
		M.GenjutsuTrue += Cap_Genjutsu
		M.ChakraTrue += Cap_Chakra
		M.StaminaTrue += Cap_Stamina
		M.LightningElemental = 5000
		M.EarthElemental = 5000
		M.FireElemental = 5000
		M.WindElemental = 5000
		M.WaterElemental = 5000
		usr.UsedDebug++


	Give_Gift(var/mob/player/M in MasterPlayerList)
		switch(input("What kind of reward would you like to give?","Reward") as null|anything in list("Gold","Feather","Stones","Village Colour","Icon Scroll","Stat Points"))
			if("Gold")
				var/G = input("How much Gold would you like to give [M.trueName]","Gold Reward") as num
				if(G>0)
					M.gold += G
					M.StatUpdate_gold()
					if(M!=usr)
						M << "[usr] has given you [G] Gold as a reward"
					usr << "You have given [M] [G] Gold as a reward"

			if("Feather")
				var/G = input("How man Feathers would you like to give [M.trueName]","Feather Reward") as num
				if(G>0)
					var/obj/Item/Material/Feather/F = locate() in M
					if(F)
						F.amount += G
					else
						F = new(M)
						F.amount = G
					F.Checkamount()
					M.UpdateInventory()
					if(G>1)
						if(M!=usr)
							M << "[usr] has given you [G] Feathers as a reward"
						usr << "You have given [M] [G] Feathers as a reward"
					else
						M << "[usr] has given you a Feather as a reward"
						usr << "You have given [M] a Feather as a reward"

			if("Stones")
				var/G = input("How man Rocks would you like to give [M.trueName]","Feather Reward") as num
				if(G>0)
					var/obj/Item/Material/Ore/Stone/R = locate() in M
					if(R)
						R.amount += G
					else
						R = new(M)
						R.amount = G
					R.Checkamount()
					M.UpdateInventory()
					if(G>1)
						if(M!=usr)
							M << "[usr] has given you [G] Stones as a reward"
						usr << "You have given [M] [G] Stones as a reward"
					else
						if(M!=usr)
							M << "[usr] has given you a Stone as a reward"
						usr << "You have given [M] a Stone as a reward"

			if("Village Colour")
				usr << "You have given [M.trueName] the option to select a new colur"
				if(M.PickSayColour())
					usr << "[M.trueName] ha successfully chosen a new colour"

			if("Icon Scroll")
				var/obj/Item/Icon_Scroll/I = locate() in M
				if(!I)
					new/obj/Item/Icon_Scroll(M)
				else
					I.amount++
					I.Checkamount()
				M.UpdateInventory()
				usr << "You gave [M] 1 Icon Scroll"
				if(M!=usr)
					M << "[usr.trueName] gave you 1 Icon Scroll"

			if("Stat Points")
				var/A = input("How many would you like to give?") as num
				if(M && A)
					M.StatPoints += A
					M.StatUpdate_statpoints()
					usr << "You gave [M] [A] SPS"
					if(M!=usr)
						M << "[usr.trueName] gave you [A] SPS"

#endif