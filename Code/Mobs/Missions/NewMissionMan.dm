var
	DropAnimal = 2
	DropChicken = 0.5
	DropPrisoner = 20
	DropRavager = 20
	DropLargeAnimal = 20
	DropThief = 70
	DropMissing = 60
	DropMurderer = 100
	DropVillain = 100
	MISSIONGOLDMULTI = 0.3
	GOLDMULTI = 0.1


obj/Item/Material/Mission
	icon = 'Materials.dmi'
	Stackable = 1
	BlockDrop = 1
	var
		MissionType
		MissionRank = "D"
	New()
		..()
		name = trueName
	BingoCard
		icon_state = "Bingo"
		Prisoner
			trueName = "Prisoner's Bingo Card"
			MissionRank = "C"
		Ravager
			trueName = "Ravager's Bingo Card"
			MissionRank = "C"
		Thief
			trueName = "Thief's Bingo Card"
			MissionRank = "B"
		Missing
			trueName = "Missing Shinobi's Bingo Card"
			MissionRank = "B"
		Murderer
			trueName = "Murderer's Bingo Card"
			MissionRank = "A"
		Villain
			trueName = "Villain's Bingo Card"
			MissionRank = "S"
	Animal
		MissionRank = "D"
		DrumStick
			trueName = "Drum Stick"
			icon_state = "DrumStick"
		FrogLeg
			trueName = "Frog Leg"
			icon_state = "FrogLeg"
		Whiskers
			trueName = "Whiskers"
			icon_state = "Whiskers"
		RabbitMeat
			trueName = "Rabbit Meat"
			icon_state = "RabbitMeat"
		DogFur
			trueName = "Canine Fur"
			icon_state = "DogFur"
		BatWing
			trueName = "Bat Wing"
			icon_state = "BatWing"
		SnakeFang
			trueName = "Snake Fang"
			icon_state = "Fang"
		LargeRemains
			trueName = "Beast Remains"
			icon_state = "LargeRemains"
			MissionRank = "C"

mob/NPC
	Mission
		icon = 'Base_Tan.dmi'
		var/CraftMis
		var/CraftType
		var/GemMis
		var/FishMis
		Leaf
		Grass
		Mist
		Rock
		Rain
		Sound
		Cloud
		Sand
		Waterfall
		New()
			..()
			if(!basename)
				basename = pick(list("Pale","Medium","Tan","Dark","Blue","Red","Lilac","Green","Yellow","Pink","Pallid"))

			switch(basename)
				if("Very Dark") {icon = 'Base_Black.dmi'}
				if("Blue") {icon = 'Base_Blue.dmi'}
				if("Dark") {icon = 'Base_Dark.dmi'}
				if("Green") {icon = 'Base_Green.dmi'}
				if("Lilac") {icon = 'Base_Lilac.dmi'}
				if("Medium") {icon = 'Base_Medium.dmi'}
				if("Pale") {icon = 'Base_Pale.dmi'}
				if("Pallid") {icon = 'Base_Pallid.dmi'}
				if("Pink") {icon = 'Base_Pink.dmi'}
				if("Red") {icon = 'Base_Red.dmi'}
				if("Tan") {icon = 'Base_Tan.dmi'}
				if("Very Pale") {icon = 'Base_White.dmi'}
				if("Yellow") {icon = 'Base_Yellow.dmi'}
				if("Zetsu") {icon = 'Base_Zetsu.dmi';isZetsu=1}

			var/icon/E = icon('Eyes_White.dmi')
			var/icon/iris = icon('Eyes_Base.dmi')

			if(!IrisColour)
				IrisColour = rgb(rand(20,100),rand(20,100),rand(20,100))
			iris += IrisColour

			E.Blend(iris,ICON_OVERLAY)
			EyeIcon = new/Overlay_Obj(E,EYE_LAYER)
			overlays += EyeIcon
			AssignRandomHair()

			Village = name
			name="[Village] Mission Man"
			var/CreateMe = text2path("/obj/Clothing/Shirt/[Village]Shirt")
			var/obj/Clothing/JV = new CreateMe(src)
			var/icon/I=icon(JV.icon); JV.icon = I
			WearClothes(JV)

			CreateMe = text2path("/obj/Clothing/Pants/Pants")
			JV = new CreateMe(src)
			I=icon(JV.icon); JV.icon = I
			WearClothes(JV)

			CreateMe = text2path("/obj/Clothing/Feet/Shoes")
			JV = new CreateMe(src)
			I=icon(JV.icon);JV.icon = I
			WearClothes(JV)

			CreateMe = text2path("/obj/Clothing/Over/ChuuninVest/[Village]")
			JV = new CreateMe(src)
			WearClothes(JV)

			CraftMis=pick("BroadSword","FryKatana","PickAxe","WoodAxe","SageStaff","Katana","Kunai","Scythe","Spear","Staff")
			CraftType=pick(prob(10);"Bronze",prob(20);"Copper",prob(20);"Iron",prob(5);"Mithril",prob(1);"Obsidian",prob(5);"Platinum",prob(10);"Steel",prob(10);"Tin",)
			FishMis=pick("Small","Medium","Large","Lava","Shadow","Angel")//,"Rainbow")

		Action(mob/user)
			if(get_dist(user,src)>2) return
			if(user.Talking) return
			if(user.KI_Banned)
				user.RemoveBanFromKI()
			if(user.DeliverTo)
				if(user.Village==Village)
					switch(input("Do you want to abandon the Delivery?","Mission Man")as null|anything in list("Yes","No"))
						if("Yes")
							for(var/obj/Item/parcel/P in user.contents)
								if(P) {del(P)}
							user.DeliverWait=2; user.DeliverTo=null;

							user<<{"Mission Man: "<i>I'll take that parcel and get someone else to do the job.</i>""}; return
				if(user.DeliverTo==Village)
					user.Delivery_Mission_Complete(src)
					user.Talking=0
					return
				else
					user<<{"Mission Man: "<i>That's not <u>my</u> parcel. You need to give it to the Mission Man in [user.DeliverTo].</i>""}
					user.Talking=0
					return

			var/mob/player/P=user
			if(P.MissionsComplete["Total"] >= 600 && !P.MissionMedal)
				P.MissionMedal++
				P.Medal_MissionPossible()
			if(Village==P.Village)
				var/B
				var/MRank
				var/MPR
				switch(input("Select Dificulty","MissionsComplete Man") as null|anything in list("D Rank Missions","C Rank Missions","B Rank Missions","A Rank Missions","S Rank Missions","Cancel"))
					if("D Rank Missions")
						B=input("Select a mission","Mission Man") as null|anything in list("Feather Collection Mission","Fish Collection Mission","Garbage Collection Mission","Log Collection Mission","Ore Collection Mission","Cancel")
						MRank="D"
						MPR = DMPREWARD
					if("C Rank Missions")
						B=input("Select a mission","Mission Man") as null|anything in list("Weapon Collection Mission","Thrown Weapon Collection Mission","Delivery Mission","Find the Feudal Lady's cat","Fish Collection Mission","Cancel")
						MRank="C"
						MPR = CMPREWARD
					if("B Rank Missions")
						B=input("Select a mission","Mission Man") as null|anything in list("Special Weapon Collection","Cancel")
						MRank="B"
						MPR = BMPREWARD
					if("A Rank Missions")
						B=input("Select a mission","Mission Man") as null|anything in list("Sound 5 Mission","Fish Collection Mission","Gem Collection Mission","Cancel")
						if(B=="Sound 5 Mission")
							user<<"Mission Man says: Sorry, there is little known about this mission, speak to my companion located just North of Leaf Village for more"
							P.Talking=0
							return
						MRank="A"
						MPR = AMPREWARD
					if("S Rank Missions")
						user<<"Mission Man says: Visit the Side Room to the Mission house in the Leaf Village"
						P.Talking=0
						return
					if("Cancel")
						P.Talking=0
						return
					else
						P.Talking=0
						return
				if(!B || B=="Cancel")
					P.Talking=0
					return
				else if(B=="Delivery Mission")
					P.DeliveryMission()
					P.Talking=0
					return
				else
					var/Collect=0
					mischo
					var/C=input("How can I help?","Mission Man") in list("I've completed this mission","What do I have to do?","Cancel")
					if(C=="Cancel")
						P.Talking=0
						return
					else if(C=="I've completed this mission")
						var/Reward
						if(B=="Find the Feudal Lady's cat")
							var/count = 0
							for(var/obj/Item/Cat/D in user.contents)
								count++
								D.loc=null
							if(count)
								user<<"Mission Man says: Well done! The Feudal Lady will be most pleased! Here's [12*count] Gold"
								P.MissionsComplete["Cur[B]"]+= 1 * count
								P.Fame+=5 * count
								/*if(P.Guild1!=null)
									for(var/Guilds/G in Guild)
										if(G.trueName==P.Guild1)
											G.Fame+=5
											G.GuildC()*/
								Reward = 120 * count
							else
								user<<"Mission Man says: Where is the cat? you dont seem to have it"
								P.Talking=0
								return
						else
							var/obj/Item/G
							var/Need=1
							var/msg
							var/XP = 150
							var/Amt=1
							var/list/Z=list()
							Need=1
							switch(B)
								if("Feather Collection Mission")
									G = locate(/obj/Item/Material/Feather) in user.contents
									if(!G)
										user<<"Mission Man says: You dont have any Feathers"
										P.Talking=0
										return
									Need=50
									msg="Thank you!, the village will put these to good use!"
									XP = 100
								if("Garbage Collection Mission")
									G = locate(/obj/Item/Material/Garbage) in user.contents
									if(!G)
										user<<"Mission Man says: You didnt collect any Garbage"
										P.Talking=0
										return
									Need=30
									msg="Thank you!, the village will be cleaner thanks to you!"
									XP=100
								if("Log Collection Mission")
									G = locate(/obj/Item/Material/Wood) in user.contents
									if(!G)
										user<<"Mission Man says: You dont seem to have any Wood"
										P.Talking=0
										return
									Need=10+P.MissionsComplete[B]
									msg="Thank you!, the client has received the Wood"
									XP=150
								if("Weapon Collection Mission")
									Collect=1
									for(var/obj/Weapon/F in P.contents)
										if(!F.bones && !F.rare && F.Material != "Stone")
											if(F.Creator==P.trueName)
												if(!F.worn)
													Z+=F
								if("Thrown Weapon Collection Mission")
									Collect=1
									for(var/obj/Weapon/Thrown/F in P.contents)
										if(F.Creator==P.trueName)
											if(!F.worn)
												Z+=F
								if("Ore Collection Mission")
									Collect=1
									for(var/obj/Item/Material/Ore/F in P.contents)
										if(istype(F,/obj/Item/Material/Ore/Stone))
											continue
										Z+=F
								if("Gem Collection Mission")
									Collect=1
									for(var/obj/Item/Material/Gem/F in P.contents)
										Z+=F
								if("Special Weapon Collection")
									G = locate(text2path("/obj/Weapon/Wield/[CraftMis]")) in P.contents
									if(!G||G.Creator!=P.trueName||G.Material!=CraftType)
										user<<"Mission Man says: You dont seem to have any self created [CraftType] [CraftMis]"
										P.Talking=0
										return
									Need=1
									XP=400
									msg="Thank you!, the village thanks you for the [G.trueName]"
									CraftMis=pick("BroadSword","Katana","Kunai","Scythe","Spear","Staff")
									CraftType=pick(prob(10);"Bronze",prob(20);"Copper",prob(20);"Iron",prob(5);"Mithril",prob(1);"Obsidian",prob(5);"Platinum",prob(10);"Steel",prob(10);"Tin",)
								if("Fish Collection Mission")
									var/FName
									if(MRank!="A")
										FName=FishMis
										G = locate(text2path("/obj/Fish/[FName]")) in P.contents
									else
										FName="Rainbow"
										G = locate(/obj/Fish/Rainbow) in P.contents
									if(!G)
										user<<"Mission Man says: You dont seem to have any [FName] Fish"
										P.Talking=0
										return
									else
										if(FName=="Rainbow")
											Need=5
											msg="Thank you!, some villagers will treasure the Rainbow Fish"
											XP=300
										else
											if(MRank=="D")
												Need=1+P.MissionsComplete[B]
												msg="Thank you!, some villagers will feast on [Need] [FName] Fish"
												XP=100
											else if(MRank=="C")
												Need=5+(P.MissionsComplete[B]*2)
												XP=200
												msg="Thank you!, some villagers will feast on [Need] [FName] Fish"
											FishMis=pick("Small","Medium","Large","Lava","Shadow","Angel")//,"Rainbow")
							if(!Collect)
								if(G.Stackable && G.amount/Need>1)
									redoamt1
									if(B!="Fish Collection Mission"&&B!="Special Weapon Collection")
										Amt=input("How many are you here to complete? you can do [round(G.amount/Need)]") as num
										if(!G)
											return
										if(Amt<1||Amt>999999)
											P.Talking=0
											return
										else if (Amt*Need>G.amount)
											switch(input("Mission Man says: You dont have that many, would you like to give all that you can?") in list("Yes","No","Cancel"))
												if("Cancel")
													P.Talking=0
													return
												if("Yes")
													var/CNeed=Need
													Need=Need*round(G.amount/Need,1)
													Amt=Need/CNeed
												if("No")
													goto redoamt1
										else
											Need=Amt*Need

								if(!G)
									return
								if(G.amount<Need)
									user<<"Mission Man says: You only have [G.amount] [G.trueName], we are looking for [Need]"
									P.Talking=0
									return
								G.amount -= Need
							else
								if(!Z.len)
									user<<"Mission Man says: You dont seem to have any"
									P.Talking=0
									return
								repick
								G=input("Which would you like to give?","Mission Man") in Z+list("Cancel")
								if(G=="Cancel")
									P.Talking=0
									return
								if(G.amount>1)
									redoamt
									Amt=input("How many would you like to give? you have [G.amount]") as num
									if(!G)
										return
									if(Amt<1||Amt>999999)
										P.Talking=0
										return
									else if(G)
										if(Amt>G.amount)
											switch(alert(user,"Mission Man says: You dont have that many, would you like to contribute all that you have?([G.amount])","All?","Yes","No","Cancel"))
												if("Cancel")
													P.Talking=0
													return
												if("Yes")
													Need=G.amount
													Amt=Need
												if("No")
													goto redoamt
										else
											Need=Amt
								switch(alert(user,"Are you sure?","Sure?","Yes","No","Cancel"))
									if("Cancel")
										P.Talking=0
										return
									if("No")
										goto repick
								if(!G)
									return
								if(G && G.amount<Need)
									user<<"Mission Man says: Oh, where did they go? are you a magician?"
									P.Talking=0
									return
								G.amount -= Need

							if(!istype(G,/obj/Item/Material/Gem))
								if(istype(G,/obj/Weapon/Thrown))
									if(istype(G,/obj/Weapon/Thrown/WindmillShuriken)||istype(G,/obj/Weapon/Thrown/DoubleEdgedKunai))
										if(G.Material!="Iron" && G.Material!="Copper" && G.Material!="Tin" && G.Material!="Bronze")
											XP=150
										else
											Amt *= 2
											XP=300
									else
										if(G.Material!="Iron" && G.Material!="Copper" && G.Material!="Tin" && G.Material!="Bronze")
											Amt *= 0.5
											XP=75
										else
											Amt *= 0.25
											XP=40
								else if(istype(G,/obj/Weapon/Wield))
									XP = 300
									if(istype(G,/obj/Weapon/Wield/Spear)||istype(G,/obj/Weapon/Wield/BroadSword)||istype(G,/obj/Weapon/Wield/Scythe)||istype(G,/obj/Weapon/Wield/PickAxe)||istype(G,/obj/Weapon/Wield/Staff))
										Amt *= 2
										XP *= 2
										user<<"Mission Man says: Thats pretty rare, ill credit you a little extra"
									else if(istype(G,/obj/Weapon/Wield/Gunbai))
										Amt *= 7
										XP *= 7
										user<<"Mission Man says: Woah, This is really nice"
									if(G.Material!="Iron" && G.Material!="Copper" && G.Material!="Tin" && G.Material!="Bronze")
										Amt *= 2
										XP *= 2
										user << "Mission Man says: I'll mark you for more because it's made out of [G.Material]"
								else if(istype(G,/obj/Item/Material/Ore))
									if(istype(G,/obj/Item/Material/Ore/Platinum)||istype(G,/obj/Item/Material/Ore/Mithril)||istype(G,/obj/Item/Material/Ore/Obsidian))
										Amt *= 2
										XP *= 2

							else if(istype(G,/obj/Item/Material/Gem))
								if(istype(G,/obj/Item/Material/Gem/Diamond)||istype(G,/obj/Item/Material/Gem/Crystal))
									Amt *= 4
									XP *= 4
								else
									Amt *= 2
									XP *= 2

							if(!G)
								return

							if(Amt==1)
								msg="Thank you!, the village thanks you for the [G.trueName]"
							else
								msg="Thank you!, the village thanks you for everything!"

							P.UpdateInventory()
							P.MissionsComplete["Cur[B]"]+=Amt
							P.Exp += XP*Amt
							winset(P,"ExpBar","value=[round((P.Exp/P.MXP)*100)]")
							user<<"Mission Man says: [msg]"

							if(P.Level<600)
								P.LevelUpCheck()
							Reward+=round(G.price*Amt)
							P.Fame += 2*Amt

							/*if(P.Guild1!=null)
								for(var/Guilds/Gi in Guild)
									if(Gi.trueName==P.Guild1)
										Gi.Fame+=2*Amt
										Gi.GuildC()
										break*/
							if(G.amount < 1)
								del G
						var/RM = round(P.MissionsComplete["Cur[B]"])
						if(RM)
							P.MissionsComplete["Cur[B]"] -= RM
							P.MissionsComplete[B] += RM
							P.MissionsComplete["Cur"] += RM
							P.MissionsComplete[MRank] += RM
							P.MissionsComplete["Total"] += RM
							P.MissionPoints += MPR * RM
						P.gold += Reward * MISSIONGOLDMULTI
						P.StatUpdate_gold()

					else if(C=="What do I have to do?")
						if(B=="Find the Feudal Lady's cat")
							while(CatsSpawned.len < 8)
								var/area/A=pick(AreaList)
								var/R=list()
								for(var/turf/T in A)
									if(!istype(T,/turf/terrain/Water)&&!T.density)
										R+=T
								var/turf/Z=pick(R)
								new/obj/Item/Cat(Z)

							var/DC = 0
							var/turf/VL
							switch(user.Village)
								if("Rain")
									VL = locate(73,314,1)
								if("Rock")
									VL = locate(196,483,1)
								if("Grass")
									VL = locate(268,336,1)
								if("Leaf")
									VL = locate(473,187,1)
								if("Sound")
									VL = locate(508,487,1)
								if("Cloud")
									VL = locate(806,493,1)
								if("Mist")
									VL = locate(878,143,1)
								if("Leaf")
									VL = locate(289,472,1)
								if("Sand")
									VL = locate(56,37,1)
							var/obj/Item/Cat/G
							for(var/obj/Item/CA in CatsSpawned)
								if(!DC)
									DC = get_dist(CA,VL)
									G = CA
								else
									if(get_dist(CA,VL) < DC )
										G = CA
							if(G)
								var/X = G.Coord
								if(X=="Uncharted")
									X="an uncharted island"
								user<<"Mission Man says: The Feudal Lady said her cat slipped out of it's collar while taking a trip near [X]. She would greatly appreciate our help finding [pick("him","her")], Use the Cat Collar, find the cat, and bring it back here.."

							var/obj/Item/CatCollar/CC=locate() in P.contents
							if(!CC)
								P<<"Cat Collar added to <i>Items</i>"
								new/obj/Item/CatCollar(P)
								P.UpdateInventory()
						else if(B=="Feather Collection Mission")
							user<<"Mission Man: Collect 50 Feathers and bring them back to me"
						else if(B=="Garbage Collection Mission")
							user<<"Mission Man: Collect 30 items of garbage from local streams and waterways then come see me"
							var/obj/Item/GarbageNet/o=locate() in P.contents
							if(!o)
								P<<"Garbage collection device added to <i>Items</i>"
								new/obj/Item/GarbageNet(P)
								UpdateInventory()
								P.Talking=0
						else if(B=="Log Collection Mission")
							user<<"Mission Man: Collect [10+P.MissionsComplete["[B]"]] pieces of wood"
						else if(B=="Weapon Collection Mission"||B=="Thrown Weapon Collection Mission")
							user<<"Mission Man: Collect weapons, every 5 donated will reward you one mission, some are worth more than others"
						else if(B=="Ore Collection Mission")
							user<<"Mission Man: Collect Ore, every 5 will reward you a mission, some are worth more than others"
						else if(B=="Gem Collection Mission")
							user<<"Mission Man: Collect a Gem, Diamonds and Crystals are worth double"
						else if(B=="Special Weapon Collection")
							user<<"Mission Man: Collect a [CraftType] [CraftMis]"
						else if(B=="Fish Collection Mission")
							if(MRank=="A")
								user<<"Mission Man: Collect 5 Rainbow Fish for an A Rank Mission"
							else if(MRank=="D")
								user<<"Mission Man: Collect [1+P.MissionsComplete["[B]"]] [FishMis] Fish"
							else //if(MRank=="C")
								user<<"Mission Man: Collect [5+(P.MissionsComplete["[B]"]*5)] [FishMis] Fish"
						goto mischo

				var/Comped=0
				while(P.MissionsComplete["Cur"]>=5)
					P.MissionsComplete["Cur"]-=5
					Comped++
				if(Comped)
					P.AwardVP(1 * Comped)
					Comped *= 2
					P.StatPoints += Comped
					P.StatPointsObtained["MisReward"] += Comped
					P.StatPointsObtained["Total"] += Comped
					P.StatUpdate_statpoints()
					user<<"<center><b>* You have been rewarded [Comped] Stat Points *</b></center>"
			else
				user<<"Mission Man says: I cannot assign a mission to a foreign ninja"
			P.Talking=0

	Bounty
		icon = 'Base_Tan.dmi'
		Leaf
		Grass
		Mist
		Rock
		Rain
		Sound
		Cloud
		Sand
		Waterfall
		New()
			..()
			if(!basename)
				basename = pick(list("Pale","Medium","Tan","Dark","Blue","Red","Lilac","Green","Yellow","Pink","Pallid"))

			switch(basename)
				if("Very Dark") {icon = 'Base_Black.dmi'}
				if("Blue") {icon = 'Base_Blue.dmi'}
				if("Dark") {icon = 'Base_Dark.dmi'}
				if("Green") {icon = 'Base_Green.dmi'}
				if("Lilac") {icon = 'Base_Lilac.dmi'}
				if("Medium") {icon = 'Base_Medium.dmi'}
				if("Pale") {icon = 'Base_Pale.dmi'}
				if("Pallid") {icon = 'Base_Pallid.dmi'}
				if("Pink") {icon = 'Base_Pink.dmi'}
				if("Red") {icon = 'Base_Red.dmi'}
				if("Tan") {icon = 'Base_Tan.dmi'}
				if("Very Pale") {icon = 'Base_White.dmi'}
				if("Yellow") {icon = 'Base_Yellow.dmi'}
				if("Zetsu") {icon = 'Base_Zetsu.dmi';isZetsu=1}

			var/icon/E = icon('Eyes_White.dmi')
			var/icon/iris = icon('Eyes_Base.dmi')

			if(!IrisColour)
				IrisColour = rgb(rand(20,100),rand(20,100),rand(20,100))
			iris += IrisColour

			E.Blend(iris,ICON_OVERLAY)
			EyeIcon = new/Overlay_Obj(E,EYE_LAYER)
			overlays += EyeIcon
			AssignRandomHair()
			Village = name
			name="[Village] Bounty Captain"
			var/CreateMe = text2path("/obj/Clothing/Shirt/CollarShirt")
			var/obj/Clothing/JV = new CreateMe(src)
			var/icon/I=icon(JV.icon); JV.icon = I
			WearClothes(JV)

			CreateMe = text2path("/obj/Clothing/Pants/Pants")
			JV = new CreateMe(src)
			I=icon(JV.icon); JV.icon = I
			WearClothes(JV)

			CreateMe = text2path("/obj/Clothing/Feet/Shoes")
			JV = new CreateMe(src)
			I=icon(JV.icon);JV.icon = I
			WearClothes(JV)

			CreateMe = text2path("/obj/Clothing/Over/JouninVest/[Village]")
			JV = new CreateMe(src)
			WearClothes(JV)

			CreateMe = text2path("/obj/Clothing/Head/Headband")
			JV = new CreateMe(src)
			WearClothes(JV)

			if(prob(50))
				CreateMe = text2path("/obj/Clothing/Hands/[pick("ANBUBracers","Gauntlets")]")
				JV = new CreateMe(src)
				I=icon(JV.icon); JV.icon = I
				WearClothes(JV)

		var/list/MisList=list(
		"(D) Finger Lickin Good","(D) Yummy Frog Legs","(D) Population Control","(D) Rabbit Stew","(D) Thin the Pack","(D) Whiskers Tickle","(D) Locate the Batcave","(D) Snake Pit",
		"(C) Round them up","(C) Predator Hunt","(C) Dangerous Beasts", "(C) Creature Feature",
		"(B) Thieves Den","(B) Missing Threat", "(B) Criminal Clearing", "(B) Beastly Ventures",
		"(A) Killing Spree")//,
		//"(S) Villainous Tides")

		Action(mob/user)
			if(get_dist(user,src)>2) return
			if(user.Talking) return
			var/mob/player/P=user
			if(Village==P.Village)
				var/B
				var/C
				var/D
				var/Fin
				switch(input("How can I help you","[name]") as null|anything in list("What Bounties are there?","Claim Bounties"))
					if("What Bounties are there?")
						switch(input("Select a bounty","[name]") in MisList)
							if("(D) Finger Lickin Good")
								C=100
								Start
								switch(input("What would you like?",name) in list("What do I do?","Cancel"))//list("What do I do?", "I have finished this","Cancel"))
									if("I have finished this")
										B="Chicken"
										D="D"
										Fin=1
									if("What do I do?")
										P<<"the Captain says: We need to settle our chicken overlords, we need to kill them. Remember those from the coops are used for the colonel, bring me their delicious Drum Sticks as proof"
										goto Start
							if("(D) Yummy Frog Legs")
								C=30
								Start
								switch(input("What would you like?",name) in list("What do I do?","Cancel"))//list("What do I do?", "I have finished this","Cancel"))
									if("I have finished this")
										B="Toad"
										D="D"
										Fin=1
									if("What do I do?")
										P<<"the Captain says: Locals have been complaining about the toads in the village, lets help by wiping out some of them, bring me their legs to verify"
										goto Start
							if("(D) Population Control")
								C=30
								Start
								switch(input("What would you like?",name) in list("What do I do?","Cancel"))//list("What do I do?", "I have finished this","Cancel"))
									if("I have finished this")
										B="Animals"
										D="D"
										Fin=1
									if("What do I do?")
										P<<"the Captain says: The animal population is out of control, we need someone to clear out some of them"
										goto Start
							if("(D) Rabbit Stew")
								C=30
								Start
								switch(input("What would you like?",name) in list("What do I do?","Cancel"))//list("What do I do?", "I have finished this","Cancel"))
									if("I have finished this")
										B="Rabbit"
										D="D"
										Fin=1
									if("What do I do?")
										P<<"the Captain says: Rabbit is tasty, we need some meat, help us by killing some of them, don't forget to bring me a paw as proof!"
										goto Start
							if("(D) Thin the Pack")
								C=30
								Start
								switch(input("What would you like?",name) in list("What do I do?","Cancel"))//list("What do I do?", "I have finished this","Cancel"))
									if("I have finished this")
										B="Dog"
										D="D"
										Fin=1
									if("What do I do?")
										P<<"the Captain says: A pack of wild dogs has been seen nearby, lets prevent it getting out of hand by killing some of them, don't forget to bring me some Fur as proof"
										goto Start
							if("(D) Whiskers Tickle")
								C=30
								Start
								switch(input("What would you like?",name) in list("What do I do?","Cancel"))//list("What do I do?", "I have finished this","Cancel"))
									if("I have finished this")
										B="Mouse"
										D="D"
										Fin=1
									if("What do I do?")
										P<<"the Captain says: we've noticed an influx of Mice, lets stop it by clearing them out, don't forget to bring me Whiskers as proof"
										goto Start
							if("(D) Locate the Batcave")
								C=30
								Start
								switch(input("What would you like?",name) in list("What do I do?","Cancel"))//list("What do I do?", "I have finished this","Cancel"))
									if("I have finished this")
										B="Bat"
										D="D"
										Fin=1
									if("What do I do?")
										P<<"the Captain says: We have heard rumors of a shinobi disguised as a bat, in order to find him crush some of their cute little bat heads, don't forget to bring me their Wings to help track him"
										goto Start
							if("(D) Snake Pit")
								C=30
								Start
								switch(input("What would you like?",name) in list("What do I do?","Cancel"))//list("What do I do?", "I have finished this","Cancel"))
									if("I have finished this")
										B="Snake"
										D="D"
										Fin=1
									if("What do I do?")
										P<<"the Captain says: A travelling merchant complained about all the snakes outside of our walls, I am tired of all the snakes in this Mother F... I mean kill them all, I'll make it worth it for every Fang you bring me"
										goto Start
							if("(C) Predator Hunt")
								C=3
								Start
								switch(input("What would you like?",name) in list("What do I do?","Cancel"))//list("What do I do?", "I have finished this","Cancel"))
									if("I have finished this")
										B="Ravager"
										D="C"
										Fin=1
									if("What do I do?")
										P<<"the Captain says: Assault crimes are on the rise, the village is looking to catch notable predators hiding nearby, make sure to grab their Bingo Card before sending them to their grave"
										goto Start
							if("(C) Round them up")
								C=3
								Start
								switch(input("What would you like?",name) in list("What do I do?","Cancel"))//list("What do I do?", "I have finished this","Cancel"))
									if("I have finished this")
										B="Prisoner"
										D="C"
										Fin=1
									if("What do I do?")
										P<<"the Captain says: A group of prisoners have escaped and need to be found. Dead or alive, if you manage to kill any try to take their Bingo Card to get the Bounty"
										goto Start
							if("(C) Dangerous Beasts")
								C=5
								Start
								switch(input("What would you like?",name) in list("What do I do?","Cancel"))//list("What do I do?", "I have finished this","Cancel"))
									if("I have finished this")
										B="LargeAnimal"
										D="C"
										Fin=1
									if("What do I do?")
										P<<"the Captain says: Some abnormally large animals have been reported, we are looking for someone to confirm and bring back proof. Kill them and return, don't forget to bring me their remains for research"
										goto Start
							if("(C) Creature Feature")
								C=50
								Start
								switch(input("What would you like?",name) in list("What do I do?","Cancel"))//list("What do I do?", "I have finished this","Cancel"))
									if("I have finished this")
										B="Animal"
										D="C"
										Fin=1
									if("What do I do?")
										P<<"the Captain says: We need you to help clear all the cute creatures around the village. try your best not to feel the guilt of what you are about to do"
										goto Start
							if("(B) Beastly Ventures")
								C=10
								Start
								switch(input("What would you like?",name) in list("What do I do?","Cancel"))//list("What do I do?", "I have finished this","Cancel"))
									if("I have finished this")
										B="Large Animal"
										D="B"
										Fin=1
									if("What do I do?")
										P<<"the Captain says: Those Large Beasts you've been hunting are starting to overrun us. Put everything aside and end their lives!"
										goto Start
							if("(B) Criminal Clearing")
								C=10
								Start
								switch(input("What would you like?",name) in list("What do I do?","Cancel"))//list("What do I do?", "I have finished this","Cancel"))
									if("I have finished this")
										B="Large Animal"
										D="B"
										Fin=1
									if("What do I do?")
										P<<"the Captain says: Wow the area the Village has been getting out of hand, kill every Criminal you find!"
										goto Start
							if("(B) Thieves Den")
								C=2
								Start
								switch(input("What would you like?",name) in list("What do I do?","Cancel"))//list("What do I do?", "I have finished this","Cancel"))
									if("I have finished this")
										B="Thief"
										D="B"
										Fin=1
									if("What do I do?")
										P<<"the Captain says: A group of theives have taken residence nearby, lets show them what we are made of. Clear out all of them and bring me their Bingo Cards"
										goto Start
							if("(B) Missing Threat")
								C=5
								Start
								switch(input("What would you like?",name) in list("What do I do?","Cancel"))//list("What do I do?", "I have finished this","Cancel"))
									if("I have finished this")
										B="MissingNin"
										D="B"
										Fin=1
									if("What do I do?")
										P<<"the Captain says: A traitorus shinobi is harassing our nation, locate and Kill them and bring my their credentials"
										goto Start
							if("(A) Killing Spree")
								C=1
								Start
								switch(input("What would you like?",name) in list("What do I do?","Cancel"))//list("What do I do?", "I have finished this","Cancel"))
									if("I have finished this")
										B="Murderer"
										D="A"
										Fin=1
									if("What do I do?")
										P<<"the Captain says: We have a serial killer on the loose, locate and Kill them, if you can ge them down then you can get their Bingo Card"
										goto Start
							if("(S) Villainous Tides")
								C=1
								Start
								switch(input("What would you like?",name) in list("What do I do?","Cancel"))//list("What do I do?", "I have finished this","Cancel"))
									if("I have finished this")
										B="Villain"
										D="S"
										Fin=1
									if("What do I do?")
										P<<"the Captain says: An S rank criminal has been spotted, see what you can learn and end his threat to our village but be careful this will not be easy, if you somehow pull it off make sure to take their Bingo Card as a sign of conquest!"
										goto Start
						if(Fin)
							if(D||B||C)//REMOVEME
								src << "[Fin], [D], [B]"
						/*if(Fin)
							if(P.Kills["Cur[B]"] >= C)
								var/F=round(P.Kills["Cur[B]"]/C,1)
								var/F2
								for(var/i=1 to F)
									F2++
									P.Kills["Cur[B]"]-=C
									P.MissionsComplete["Cur[B]"]++

								var/MPR
								switch(D)
									if("D")
										F2 +=F*250
										MPR = DMPREWARD
									if("C")
										F2 +=F*500
										MPR = CMPREWARD
									if("B")
										F2 +=F*1000
										MPR = BMPREWARD
									if("A")
										F2 +=F*2000
										MPR = AMPREWARD
									if("S")
										F2 +=F*4000
										MPR = SMPREWARD

								F2 *= 0.3
								P.gold += F2

								P.StatUpdate_gold()
								var/RM = round(P.MissionsComplete["Cur[B]"])
								if(RM)
									P.MissionsComplete["Cur[B]"] -= RM
									P.MissionsComplete[B] += RM
									P.MissionsComplete["Cur"] += RM
									P.MissionsComplete[D] += RM
									P.MissionsComplete["Total"] += RM
									P.MissionPoints += MPR * RM

								P<<"The village thanks you, you earned this reward of [F2] Gold"
								/*MisList-=Di
								spawn(60)MisList+=Di*/
							else
								if(P.Kills["Cur[B]"]>1)
									P<<"the Captain says: You have only killed [P.Kills["Cur[B]"]] [B]s, we need [C]"
								else if(P.Kills["Cur[B]"])
									P<<"the Captain says: You have only killed 1 [B], we need [C]"
								else
									P<<"the Captain says: You havent killed any [B], we need [C]"*/
					if("Claim Bounties")
						var
							F2 = 0
							MPR = 0
							MT = 0
							MD = 0
							MC = 0
							MB = 0
							MA = 0
							MS = 0

						for(var/obj/Item/Material/Mission/CM in P.contents)
							var/F = CM.amount
							MT += F
							switch(CM.MissionRank)
								if("D")
									F2 += F*250
									MPR += DMPREWARD * F
									MD+=F
								if("C")
									F2 +=F*500
									MPR += CMPREWARD * F
									MC+=F
								if("B")
									F2 +=F*1000
									MPR += BMPREWARD * F
									MB+=F
								if("A")
									F2 +=F*2000
									MPR += AMPREWARD * F
									MA+=F
								if("S")
									F2 +=F*4000
									MPR += SMPREWARD * F
									MS += F
							del CM

						if(P.CurAnimKills >= 50)
							var/NM = round(P.CurAnimKills/50)
							F2 += (500 * NM)
							MPR += (CMPREWARD * NM)
							MC +=  NM
							MT += NM
							P.CurAnimKills -= (50 * NM)

						if(P.CurLAnimKills >= 10)
							var/NM = round(P.CurLAnimKills/10)
							F2 += (1000 * NM)
							MPR += (BMPREWARD * NM)
							MB +=  NM
							MT += NM
							P.CurLAnimKills -= (10 * NM)

						if(P.CurCrimKills >= 5)
							var/NM = round(P.CurCrimKills/5)
							F2 += (1000 * NM)
							MPR += (BMPREWARD * NM)
							MB +=  NM
							MT += NM
							P.CurCrimKills -= (5 * NM)

						F2 *= MISSIONGOLDMULTI
						P.gold += F2
						P.StatUpdate_gold()

						P.MissionsComplete["Cur"] += MT
						P.MissionsComplete["Total"] += MT
						P.MissionPoints += MPR
						P.UpdateInventory()
						if(MT || F2)
							var/msg = "[name] says: the [Village] thanks you for you efforts"
							if(MD)
								msg += "<br>+[MD] D Missions"
								P.MissionsComplete["D"] += MD
								P.AwardVP(0.1 * MD)
							if(MC)
								msg += "<br>+[MC] C Missions"
								P.MissionsComplete["C"] += MC
								P.AwardVP(0.2 * MC)
							if(MB)
								msg += "<br>+[MB] B Missions"
								P.MissionsComplete["B"] += MB
								P.AwardVP(0.25 * MB)
							if(MA)
								msg += "<br>+[MA] A Missions"
								P.MissionsComplete["A"] += MA
								P.AwardVP(0.5 * MA)
							if(MS)
								msg += "<br>+[MS] S Missions"
								P.MissionsComplete["S"] += MS
								P.AwardVP(2 * MS)
							if(F2)
								msg += "<br>+[F2] Gold"
							P << msg
						else
							P<<"[name] says: I dont see any proof of your Success"
				var/Comped=0
				while(P.MissionsComplete["Cur"]>=5)
					P.MissionsComplete["Cur"]-=5
					Comped++
				if(Comped)
					P.AwardVP(1 * Comped)
					Comped *=2
					P.StatPoints += Comped
					P.StatPointsObtained["MisReward"] += Comped
					P.StatPointsObtained["Total"] += Comped
					P.StatUpdate_statpoints()
					user<<"<center><b>* You have been rewarded [Comped] Stat Points *</b></center>"
			else
				user<<"[name] says: I can't give out [Village] matters to a foreign ninja"
			P.Talking=0