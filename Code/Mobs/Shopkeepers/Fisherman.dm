mob/NPC/Shopkeepers
	Fisherman
		name = "Fisherman"
		icon = 'Fisherman.dmi'

		CantHenge=1
		protect=1

		Stamina =10000
		StaminaMax=10000
		StaminaTrue=10000

		Chakra =500
		ChakraMax=500
		ChakraTrue=500

		Taijutsu =10
		TaijutsuMax=10
		TaijutsuTrue=10

		Genjutsu =10
		GenjutsuMax=10
		GenjutsuTrue=10

		Ninjutsu =10
		NinjutsuMax=10
		NinjutsuTrue=10

		Action(mob/user)
			if(get_dist(user,src)>2) return
			switch(input("What do you want?","Fisherman")in list("Buy Rod","Buy Fish","Sell Fish","Repair Rod","Learn About Fishing","Never mind"))
				if("Buy Rod")
					if(!MobDistanceCheck(user,src)) return
					var/FISHINGLIST=list()
					FISHINGLIST+="Regular Fishing Rod {1500}"
					FISHINGLIST+="Quality Fishing Rod {4000}"
					FISHINGLIST+="Premium Fishing Rod {18000}"
					if(user.FishingSkill>=100) FISHINGLIST+="Fishing Box {200000}"
					FISHINGLIST+="Never mind"

					switch(input("Which rod would you like?","Fisherman")as null|anything in FISHINGLIST)

						if("Regular Fishing Rod {1500}")
							if(user.gold<1500) user<<"Not enough gold</font>"
							else {user.gold-=1500; new/obj/Item/rod/Rod1(user); user<<"<i>You get the Fishing Rod.</i>"}

						if("Quality Fishing Rod {4000}")
							if(user.gold<4000) user<<"Not enough gold"
							else {user.gold-=4000; new/obj/Item/rod/Rod2(user); user<<"<i>You get the Quality Fishing Rod.</i>"}

						if("Premium Fishing Rod {18000}")
							if(user.gold<18000) user<<"Not enough gold."
							else {user.gold-=18000; new/obj/Item/rod/Rod3(user); user<<"<i>You get the Premium Fishing Rod.</i>"}

						if("Fishing Box {200000}")
							if(user.FishingBox) {user<<"You already have one"; return}
							if(user.gold<200000) user<<"Not enough gold."
							else
								user.gold-=200000
								new/obj/Item/rod/FishingBox(user)
								user.FishingBox=1; user<<"<i>You obtain a Fishing Box.</i>"

				if("Buy Fish")
					if(!MobDistanceCheck(user,src)) return
					var/amount=0
					var/reqGold=0
					var/FISHLIST=list()
					FISHLIST+="Small {40}"
					FISHLIST+="Medium {60}"
					if(!(user.NinjaRank=="Academy Student"||user.NinjaRank=="Genin"))
						FISHLIST+="Large {100}"
						FISHLIST+="Lava {250}"
						FISHLIST+="Shadow {250}"
					switch(input("Glad no one taught you how to fish, What can I get you?","Fisherman")as null|anything in FISHLIST)

						if("Small {40}")
							amount = input("How many would you like?", "Small Fish") as num
							var/decimal = amount - round(amount)
							if(decimal!=0) amount -= decimal // Remove decimal place
							if(amount < 1) return //Check if they still have at least 1
							reqGold=40*amount
							if(user.gold<reqGold) user<<"Something is fishy... you need gold!</font>"
							else
								user.gold-=reqGold;
								user<<"<i>You purchase Small fish!</i>"
								if(locate(/obj/Fish/Small) in user.contents)
									for(var/obj/Fish/Small/F in user.contents)
										F.amount+=amount; F.Checkamount()
								else
									new/obj/Fish/Small/(user);
									if(amount > 1)
										for(var/obj/Fish/Small/F in user.contents)
											F.amount=amount; F.Checkamount()

						if("Medium {60}")
							amount = input("How many would you like?", "Medium Fish") as num
							var/decimal = amount - round(amount)
							if(decimal!=0) amount -= decimal // Remove decimal place
							if(amount < 1) return //Check if they still have at least 1
							reqGold=60*amount
							if(user.gold<reqGold) user<<"Something is fishy... you need gold!</font>"
							else
								user.gold-=reqGold;
								user<<"<i>You purchase Medium fish!</i>"
								if(locate(/obj/Fish/Medium) in user.contents)
									for(var/obj/Fish/Medium/F in user.contents)
										F.amount+=amount; F.Checkamount()
								else
									new/obj/Fish/Medium/(user);
									if(amount > 1)
										for(var/obj/Fish/Medium/F in user.contents)
											F.amount=amount; F.Checkamount()
						if("Large {100}")
							amount = input("How many would you like?", "Large Fish") as num
							var/decimal = amount - round(amount)
							if(decimal!=0) amount -= decimal // Remove decimal place
							if(amount < 1) return //Check if they still have at least 1
							reqGold=100*amount
							if(user.gold<reqGold) user<<"Something is fishy... you need gold!</font>"
							else
								user.gold-=reqGold;
								user<<"<i>You purchase Large fish!</i>"
								if(locate(/obj/Fish/Large) in user.contents)
									for(var/obj/Fish/Large/F in user.contents)
										F.amount+=amount; F.Checkamount()
								else
									new/obj/Fish/Large/(user);
									if(amount > 1)
										for(var/obj/Fish/Large/F in user.contents)
											F.amount=amount; F.Checkamount()
						if("Lava {250}")
							amount = input("How many would you like?", "Lava Fish") as num
							var/decimal = amount - round(amount)
							if(decimal!=0) amount -= decimal // Remove decimal place
							if(amount < 1) return //Check if they still have at least 1
							reqGold=250*amount
							if(user.gold<reqGold) user<<"Something is fishy... you need gold!</font>"
							else
								user.gold-=reqGold;
								user<<"<i>You purchase Lava Fish!</i>"
								if(locate(/obj/Fish/Lava) in user.contents)
									for(var/obj/Fish/Lava/F in user.contents)
										F.amount+=amount; F.Checkamount()
								else
									new/obj/Fish/Lava/(user);
									if(amount > 1)
										for(var/obj/Fish/Lava/F in user.contents)
											F.amount=amount; F.Checkamount()
						if("Shadow {250}")
							amount = input("How many would you like?", "Shadow Fish") as num
							var/decimal = amount - round(amount)
							if(decimal!=0) amount -= decimal // Remove decimal place
							if(amount < 1) return //Check if they still have at least 1
							reqGold=250*amount
							if(user.gold<reqGold) user<<"Something is fishy... you need gold!</font>"
							else
								user.gold-=reqGold;
								user<<"<i>You purchase Shadow Fish!</i>"
								if(locate(/obj/Fish/Shadow) in user.contents)
									for(var/obj/Fish/Shadow/F in user.contents)
										F.amount+=amount; F.Checkamount()
								else
									new/obj/Fish/Shadow/(user);
									if(amount > 1)
										for(var/obj/Fish/Shadow/F in user.contents)
											F.amount=amount; F.Checkamount()

				if("Sell Fish")
					var/list/FiLi = list()
					for(var/obj/Fish/Fi in user)
						FiLi += Fi
					if(!length(FiLi))
						user << "You do not have any fish"
					var/obj/Fish/FType = input("What would you like to sell?","Fisherman") as null|anything in FiLi
					if(FType)
						if(!MobDistanceCheck(user,src))
							return
						var/SellN=input("How many [FType.trueName] do you want to sell? (Max: [FType.amount])","Fisherman") as num
						if(SellN>0)
							if(SellN > FType.amount)
								SellN=FType.amount
							FType.amount-=SellN; user.gold+=(SellN*FType.price)
							FType.Checkamount()
							if(FType.amount<=0)
								del FType
							user.UpdateInventory()

				if("Learn About Fishing")
					switch(input("What would you like to know?","Fisherman")in list("Fishing Skill","Fishing Rods","The Fish","Never mind"))
						if("Fishing Skill")
							alert("Fishing Skill governs players' chance of catching fish, and their chance of catching better fish. You can never guarantee you'll catch a fish, but you can increase your chances as your Fishing Skill increases.  And as it increases, the size and quality of the fish you catch will improve.  You can only train your fishing skill by fishing.","Fishing Skill")
						if("Fishing Rods")
							alert("Fishing Skill alone will not ensure you catch the biggest or best fish.  There are three qualities of fishing rods, and only the better qualities can/will catch the rarer kinds.","Fishing Rods")
						if("The Fish")
							alert("Fish, predictably, can be found in water, and can only be caught with a fishing rod.  There is not just one kind of fish, and there is not just one size; and as your fishing skill increases, you will come to realise this.","The Fish")
				if("Repair Rod")
					if(!MobDistanceCheck(user,src)) return
					if(get_dist(user,src)>2) return
					var/obj/Item/rod/X=locate(/obj/Item/rod) in user.contents
					if(!(X in user.contents))
						user<<"<i>You've got no rods on for me to repair."
					else
						var/R=list()
						for(var/obj/Item/rod/r in user.contents) R+=r
						var/obj/Z=input("What would you like me to repair, stranger?","Fisherman") as null|anything in R
						//var/cost=round(((Z.MaxDurability-Z.Durability)/2)*1.3)
						if(Z)
							var/cost=round(Z.repairCost - ((Z.Durability/Z.MaxDurability)*Z.repairCost))
							var/message="Shall I repair the [Z.name] for [cost] gold?"
							var/yesMessage="<i>There you are, good as new!</i>"
							if(Z.Durability<1) {cost = Z.repairCost; message = "This rod is in poor shape! I can repair it for [cost] gold. Would you like to proceed?"; yesMessage="<i>All fixed, next time bring it to me before it breaks!</i>"}
							if(Z.Durability == Z.MaxDurability) {alert("There isn't a scratch on this rod!"); return}
							var/lastKnownDurability = Z.Durability;
							switch(input(message,"Fisherman") in list ("Yes","No"))
								if("Yes")
									if(Z.Durability != lastKnownDurability) {alert("mmmm try again."); return;}
									if(user.gold>=cost) {user.gold-=cost; Z.Durability=Z.MaxDurability; Z.icon_state="inventory"; user<<yesMessage}
									else user<<"<i>You're a bit short on funds!</i>"
								if("No") user<<"<i>Alright then.</i>"
			user.UpdateInventory(); user.StatUpdate_gold()