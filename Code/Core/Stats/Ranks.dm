var
	ANBUReq=26000
	JouninReq=57000
	KageReq=90000
mob
	var
		ANBUDeclined
		ChoseANBU
		tmp
			RankUp; ANBUOffer
	verb
		CheckCaps()
			usr <<"These are your current Stat Caps<br>Stamina: [usr.Cap_Stamina]<br>Chakra: [usr.Cap_Chakra]<br>Taijutsu: [usr.Cap_Taijutsu]<br>Ninjutsu: [usr.Cap_Ninjutsu]<br>Genjutsu: [usr.Cap_Genjutsu]"

mob
	proc
		Ranks()
			var
				N=NinjutsuTrue
				G=GenjutsuTrue
				T=TaijutsuTrue
				total = N+G+T

			switch(NinjaRank)
				if("Chuunin")
					if((N>=(10000*EXP_BASE) || G >= (10000*EXP_BASE) || T >= (10000*EXP_BASE)) && MissionsComplete["Total"] >= 40 && MissionsComplete["C"] >= 10)
						RankSpecialJounin()

					else if(total >= (JouninReq*EXP_BASE) && G >= (10000*EXP_BASE) && N >= (10000*EXP_BASE) && T >= (10000*EXP_BASE) && MissionsComplete["C"] >= 30 && MissionsComplete["B"] >= 80 && MissionsComplete["A"]>=40)
						RankJounin()

				if("Special Jounin")
					if(!ANBUOffer && !ANBUDeclined && MissionsComplete["B"]>=20 && MissionsComplete["C"]>=15)
						if(((N>=(8000*EXP_BASE)&&G>=(8000*EXP_BASE)&&T>=(8000*EXP_BASE)) || (N>=15000*EXP_BASE||G>=15000*EXP_BASE||T>=15000*EXP_BASE)) && total >= (ANBUReq*EXP_BASE))
							ANBUOffer=1
							switch(input("Congratulations [name]! Your hard work, skills, and commitment to your village have been noticed; and you have been invited to join the Anbu Squad. Anbu Squad members receive special training but have a tougher time becoming a Jounin ranked ninja.","Invitation to Anbu")in list("Join Anbu","Decide later","Decline invitation into Anbu"))
								if("Join Anbu")
									RankAnbu()
								if("Decide later")
									src<<"<i>You have declined the offer to join Anbu for now, but will be asked again next time you level up.</i>"; ANBUOffer=0
								if("Decline invitation into Anbu")
									ANBUDeclined=1
									src<<"<i>You declined the invitation to join Anbu Squad.If you change your mind please contact the Village Leader</i>"

					else if(total >= (JouninReq*EXP_BASE) && MissionsComplete["C"] >= 20 && MissionsComplete["B"] >= 40 && MissionsComplete["A"]>=20)
						if((N>=25000*EXP_BASE||G>=25000*EXP_BASE||T>=25000*EXP_BASE) || G >= (10000*EXP_BASE) && N >= (10000*EXP_BASE) && T >= (10000*EXP_BASE))
							RankJounin()

				if("Anbu")
					if(total>=(JouninReq*EXP_BASE) && MissionsComplete["C"] >=10 && MissionsComplete["B"] >=20 && MissionsComplete["A"]>=10)
						if( N>=25000*EXP_BASE || G>=25000*EXP_BASE || T>=25000*EXP_BASE || G>=(12000*EXP_BASE) && N>=(12000*EXP_BASE) && T>=(12000*EXP_BASE) )
							RankJounin()

				if("Jounin")
					if(MissionsComplete["Total"]>=180&&MissionsComplete["A"]>=30&&MissionsComplete["S"]>=5&&total>=(KageReq*EXP_BASE))
						if((N>=55000*EXP_BASE||G>=55000*EXP_BASE||T>=55000*EXP_BASE) ||(G>=(30000*EXP_BASE)&&N>=(30000*EXP_BASE)&&T>=(30000*EXP_BASE)))
							RankKageLevel()

		RankGenin()
			NinjaRank="Genin"
			LevelUp_notification(NinjaRank,client)

			var/obj/Clothing/Head/Headband/B = new(src)
			B.name="Headband ([Village])"
			src<< "Clothing added:<br><i>* Headband received.</i>"
			UpdateInventory();

			AddCaps()
			StatUpdate_rank();
			Save()

		RankChuunin()
			NinjaRank="Chuunin"
			LevelUp_notification(NinjaRank,client)

			src<<"Congratulations, you are the newest Chuunin!"
			src<<"Clothing added:<br><i>* Chuunin Vest</i>"
			var/JVT = "/obj/Clothing/Over/ChuuninVest/[Village]"
			new JVT(src)
			UpdateInventory()

			AddCaps();
			RebirthData.Initialize(src)
			StatUpdate_rank()
			Save()

		RankSpecialJounin()
			NinjaRank="Special Jounin"
			LevelUp_notification(NinjaRank,client)
			src<<"<b><font size=2>Congratulations you have just been promoted to the rank of <i>[NinjaRank]!<i></b></font>"

			AddCaps()
			StatUpdate_rank()
			Save()

		RankAnbu()
			NinjaRank="Anbu"
			LevelUp_notification(NinjaRank,client)
			ChoseANBU=1
			src<<"<b><font size=2>Congratulations you have just been promoted to the rank of <i>[NinjaRank]!<i></b></font>"

			src<<"Clothes Added:<i><br />* Anbu Katana<br />* Anbu Armor<br />* Anbu Bracers<br />* Anbu Mask</i>"
			new/obj/Weapon/Wield/ANBUKatana(src)
			new/obj/Clothing/Over/ANBUVest(src)
			new/obj/Clothing/Hands/ANBUBracers(src)
			new/obj/Clothing/Face/ANBUMask(src)
			//LearnKanashibari()
			UpdateInventory()

			AddCaps()
			StatUpdate_rank()

			Save()

		RankJounin()
			NinjaRank="Jounin"
			LevelUp_notification(NinjaRank,client)

			src<<"<b><font size=2>Congratulations you have just been promoted to the rank of <i>[NinjaRank]!<i></b></font>"
			var/JVT = "/obj/Clothing/Over/JouninVest/[Village]"
			new JVT(src)
			src<<"Clothing added: <i>Jounin Vest</i>"
			UpdateInventory()

			AddCaps()
			StatUpdate_rank()
			Save()

		RankKageLevel()
			NinjaRank="Kage Level"
			LevelUp_notification(NinjaRank,client)
			switch(Village)
				if("Grass","Rain","Waterfall","Sound")
					src<<"<b><font size=2>Congratulations you have just been promoted to the rank of <i>[NinjaRank]!</i>  You are now eligible to compete for the title of 'Leader'.</b></font>"
				else
					src<<"<b><font size=2>Congratulations you have just been promoted to the rank of <i>[NinjaRank]!</i>  You are now eligible to compete for the title of 'Kage'.</b></font>"

			AddCaps()
			StatUpdate_rank()
			Save()

		AssignKageRank()
			switch(Village)
				if("Leaf") NinjaRank="Hokage"
				if("Mist") NinjaRank="Mizukage"
				if("Cloud") NinjaRank="Raikage"
				if("Rock") NinjaRank="Tsuchikage"
				if("Sand") NinjaRank="Kazekage"
				if("Grass") NinjaRank="Grass Leader"
				if("Rain") NinjaRank="Rain Leader"
				if("Waterfall") NinjaRank="Waterfall Leader"
				if("Sound") NinjaRank="Sound Leader"

			LevelUp_notification(NinjaRank,client)

			src<<"<b><font size=2>Congratulations!! The huge effort you've put into training and doing missions for the village have finally been acknowledged!  You are now the [NinjaRank] of [Village]</b></font>"

			StatPoints+=50;
			AddCaps()
			LevelBonus+=50

			KageList[Village] += trueName
			var/list/VKL = KageList[Village]
			KageList[Village][trueName] = VKL.len
			KageTemp[Village] = 0

			KageCurrent[Village]=trueName
			KageMob[Village] = src

			ElligibleKageList[Village] -= trueName
			BeenKage = 1
			Kage = 1

			for(var/mob/player/v in MasterPlayerList)
				if(v!=src) v<<"<b>The [DaimeCheck()], [src], has just been appointed the [NinjaRank] of [Village]!</b>"

			//give robes
			Setup_VP_Screen()
			//verbs+=new/mob/VerbHolder/Kage/verb/ModifyBingoBook()
			verbs += typesof(/mob/VerbHolder/Kage/verb)
			verbs += typesof(/mob/VerbHolder/Kage2/verb)


			var/NH = text2path("/obj/Clothing/Head/KageHat/[Village]")
			new NH(src)

			Skills()
			StatUpdate_rank()
			Popup("gain kage",,,10)
			SaveKages()
			spawn(30)
				if(client) Save()