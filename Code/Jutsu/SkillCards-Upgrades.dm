mob
	verb
		UpgradeJutsu()
			if(HighlightedCard && istype(HighlightedCard,/obj/SkillCards))
				var/obj/SkillCards/S = HighlightedCard
				if(S.Upgraded < S.UpgradeAvailable)
					S.PassUp(src)
			else
				var/list/UList = list()
				for(var/obj/SkillCards/S in contents)
					if(S.Upgraded < S.UpgradeAvailable)
						UList[S.Description["title"]] =  S
				if(UList.len)
					var/obj/SkillCards/S = UList[input("Which Skill would you like to upgrade?","Upgrade") as null|anything in UList]
					if(S)
						S.PassUp(src)
				else
					src << "You don't have any Skills that can be upgraded"

obj/SkillCards
	proc
		PassUp(mob/U)
			if(Upgraded >= UpgradeAvailable)
				return
			var/A
			if(UpgradeChoices.len>1)
				A = alert(U,"Which upgrade would you like?","Upgrade","[UpgradeChoices[1]]","[UpgradeChoices[2]]","Cancel")
			else
				A = alert(U,"Which upgrade would you like?","Upgrade","[UpgradeChoices[1]]","Cancel")
			if(Upgraded >= UpgradeAvailable)
				return
			switch(A)
				if("Cancel")
					return

				if("Allow Water Tiles")
					WaterUsage = 1
					UpgradeChoices -= A

				if("Create Area Effect")
					AOE = 1
					UpgradeChoices -= A
					if(istype(src,/obj/SkillCards/Clan/Uchiha/MS/Tsukuyomi))
						UpgradeChoices += "Increase Range"

				if("Purify")
					if(U.ByakuganLevel < 3)
						U.ByakuganLevel++

				if("Add Tomoe")
					if(U.SharinganLevel < 3)
						U.SharinganLevel++
						var/obj/SkillCards/Clan/Uchiha/Sharingan/SH = locate() in U
						SH.icon_state="card_S[U.SharinganLevel]"
					if(U.SharinganLevel >= 3)
						UpgradeChoices -= A

				if("Eternal Upgrade")
					U.EternalSharingan = 1
					UpgradeChoices -= A

				if("Improve Tracking")
					Tracker = 2
					UpgradeChoices -= A

				if("Increase Buff")
					if(istype(src,/obj/SkillCards/Clan/Akimichi/Baika))
						DM += 0.5
					else if(istype(src,/obj/SkillCards/Clan/Inuzuka/Soutourou))
						DM += 0.2
					else if(istype(src,/obj/SkillCards/Ninjutsu/Raiton/RaitonYoroi))
						DM += 0.05

				if("Increase Gathering Speed")
					CCost *= 2

				if("Increase Damage")
					if(istype(src,/obj/SkillCards/Clan/Aburame/BakuhatsuMushikui))
						DM+=10000
					else if(istype(src,/obj/SkillCards/Clan/Sarutobi/Hien)||istype(src,/obj/SkillCards/Class/Assassin/MuonSatsujin)||istype(src,/obj/SkillCards/Ninjutsu/Chidori)||istype(src,/obj/SkillCards/Ninjutsu/Rasengan)||istype(src,/obj/SkillCards/Clan/Clay/KyukyokuGeijutsu))
						DM += 0.3
					else if(istype(src,/obj/SkillCards/Ninjutsu/Fuuton/Renkoudan)||istype(src,/obj/SkillCards/Ninjutsu/Suiton/Suikoudan)||istype(src,/obj/SkillCards/Clan/Sand/SabakuSoso))
						DM += 10
					else if(istype(src,/obj/SkillCards/Ninjutsu/Raiton/Raikyuu))
						DM += 2
					else if(istype(src,/obj/SkillCards/Clan/Yuki/SensatsuSuishou))
						DM += 3
					else if(istype(src,/obj/SkillCards/Clan/Yuki/MakyouHyoushouKogeki)||istype(src,/obj/SkillCards/Ninjutsu/Katon/Ryuuka))
						DM += 4
					else if(istype(src,/obj/SkillCards/Ninjutsu/BunshinDaibakuha)||istype(src,/obj/SkillCards/Clan/Kaguya/WarabiNoMai)||istype(src,/obj/SkillCards/Clan/Lee/GourikiSenpuu)||istype(src,/obj/SkillCards/Ninjutsu/Raiton/RaijuTsuiga))
						DM += 0.5
					else
						DM++

				if("Increase Depth","More Shuriken Clones")
					DM++

				if("Increase Push Distance","Increase Shadows")
					DM += 2

				if("Increase Range")
					if(istype(src,/obj/SkillCards/Class/Sensory))
						Range *=2
					else
						Range++
						if(istype(src,/obj/SkillCards/Clan/Nara/Kagearashi))
							if(Range>=3)
								UpgradeChoices -= A

				if("Increase Size")
					Size++

				if("Increase Speed")
					Speed -= 1
					if(Speed<=1)
						Speed = 1
						UpgradeChoices -= A

				if("Increase Strength")
					if(IsBunshin)
						DM += 5

				if("Increase Training")
					XPMulti += 0.5

				if("Increase Skill")
					DM += 5

				if("Increase Wounds")
					DM+=10

				if("Lower Cooldown")
					if(istype(src,/obj/SkillCards/Clan/Uchiha/Sharingan))
						U.SharinganCooldown = ceil(Cooldown*0.6)
					else if(istype(src,/obj/SkillCards/Clan/Uchiha/MangekyouSharingan))
						U.MangekyouCooldown = ceil(Cooldown*0.6)
					else
						Cooldown = ceil(Cooldown*0.6)
						CooldownCur = Cooldown - ((Cooldown*0.005)*Level)

				if("Lower Cost")
					if(CCost)
						CCost = round(CCost*0.70)
					if(SCost)
						SCost = round(SCost*0.70)
					if(ECost)
						ECost = round(ECost*0.70)

				if("More Bones")
					Shots += 15

				if("More Clones")
					Shots += 10

				if("More Hits")
					Shots += 1

				if("More Needles")
					Shots += 4

				if("More Sharks")
					Shots += 2

				if("More Shots")
					if(istype(src,/obj/SkillCards/Clan/Kaguya/TeshiSendan)||istype(src,/obj/SkillCards/Ninjutsu/Fuuton/MugenSajinDaitoppa)||istype(src,/obj/SkillCards/Ninjutsu/ShurikenKageBunshin))
						Shots++
					else
						Shots += 2
					//UpgradeChoices -= A

				if("Remove Cost")
					CCost = 0
					SCost = 0
					ECost = 0
					UpgradeChoices -= A

				if("Track Target")
					Tracker = 1
					UpgradeChoices -= A

				if("Upgrade Bind")
					DM += 25
					Duration *= 2

				if("Increase Duration")
					Duration *= 2

			Upgraded++
			if(Upgraded >= UpgradeAvailable)
				winset(U,"JutsuWindow.UpgradeButton", "is-visible = false")
			if(UpgradeChoices.len>2)
				UpgradeChoices -= A