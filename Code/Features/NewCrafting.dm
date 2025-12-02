var/CraftedValueMulti = 5

obj/SkillCards/Starter/Craft
	icon_state="card_Craft"
	JutsuType = "Other"
	cmdstring="Craft"
	CCost=50
	Seals=1
	Description = list(
		"about"="Craft weapons and items using feathers and rocks."
		,"title"="Craft"
		,"type"="Other"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="E"
//		,"pic"='Craft.png'
	)
	Activate(mob/U)
		if(U.firing||U.frozen||U.GMfrozen||U.fishing||U.waterprisoned||U.Coffin||U.dead||U.attacking||U.throwing) return
		if(U.Chakra<50) {U<<"Not enough chakra"; return}

		U.firing=1
		U.CraftMe()
		spawn(8)U.firing=0

mob
	var
		CraftingSkill=1
		CraftingSkillTrue = 1
		CraftingSkillXP=0
		CraftingSkillMXP=5
		Crafting_Level = 1
		list
			Crafted = list()
			Craftable = list("Shuriken")
	proc
		CraftSkills()
			if(Crafting_Level==1 && CraftingSkill>=15)
				Craftable += "Kunai"
				Crafting_Level++
			if(Crafting_Level==2 && CraftingSkill>=30)
				Craftable += "Katana"
				Craftable += "Pick Axe"
				Craftable += "Staff"
				Crafting_Level++
			if(Crafting_Level==3 && CraftingSkill>=50)
				Craftable += "Windmill Shuriken"
				Craftable += "Broad Sword"
				Craftable += "Wood Axe"
				Craftable += "Fishing Rod"
				Crafting_Level++
			if(Crafting_Level==4 && CraftingSkill>=70)
				Craftable += "Scythe"
				Craftable += "Spear"
				Crafting_Level++
			if(Crafting_Level==5 && CraftingSkill>=85)
				Craftable += "Bandages"
				Crafting_Level++
			if(Crafting_Level==6 && CraftingSkill>=100)
				Craftable += "Parchment"
				Crafting_Level++

		CraftMe()
			//var/PLAYER(M)=src
			var/A=input("What would you like to craft?","Crafting Skill") as null|anything in Craftable
			if(A)
				var/T=1//Created per Craft
				var/N=0//Maximum Experience Gained
				var/Ty//Type of creation

				var/list/Need = list()

				var/Def//Created Weapon
				switch(A)
					if("Kunai")
						Def = /obj/Weapon/Wield/Kunai
						N=6
						Ty = 1
						Need = list("Metal" = 2)

					if("Shuriken")
						Def = /obj/Weapon/Thrown/Shuriken
						T=2
						N=2
						Ty = 1
						Need = list("Metal" = 2)

					if("Windmill Shuriken")
						Def = /obj/Weapon/Thrown/WindmillShuriken
						N=10
						Ty = 1
						Need = list("Metal" = 2)

					if("Staff")
						Def = /obj/Weapon/Wield/Staff
						N=12
						Ty = 1
						Need = list("Metal" = 2)

					if("Katana")
						Def = /obj/Weapon/Wield/Katana
						N=16
						Ty = 1
						Need = list("Metal" = 4)

					if("Pick Axe")
						Def = /obj/Weapon/Wield/PickAxe
						N=19
						Ty = 1
						Need = list("Metal" = 4,"Wood" = 2)

					if("Wood Axe")
						Def = /obj/Weapon/Wield/WoodAxe
						N=19
						Ty = 1
						Need = list("Metal" = 2,"Wood" = 2)

					if("Spear")
						Def = /obj/Weapon/Wield/Spear
						N=19
						Ty = 1
						Need = list("Metal" = 6)

					if("Broad Sword")
						Def = /obj/Weapon/Wield/BroadSword
						N=22
						Ty = 1
						Need = list("Metal" = 8)

					if("Scythe")
						Def = /obj/Weapon/Wield/Scythe
						N=24
						Ty = 1
						Need = list("Metal" = 4)

					if("Fishing Rod")
						switch(Crafting_Level)
							if(4)
								Def = /obj/Item/rod/Rod0
							if(5)
								Def = /obj/Item/rod/Rod1
							if(6)
								Def = /obj/Item/rod/Rod2
							if(7)
								Def = /obj/Item/rod/Rod3
						N=16
						Ty = 0
						Need = list("Wood" = 4,"Rock" = 1)

					if("Parchment")
						Def = /obj/Scrolls/Parchment
						N=12
						Ty = 0
						Need = list("Wood" = 2)

					if("Bandages")
						Def = /obj/Item/Bandages
						Ty = 0
						Need = list("Feather" = 10,"Wood" = 1)

				var/list/MatList = list()
				var/list/Metals = list()
				var/MaxCreation = 0
				var/msg

				for(var/AN in Need)
					var/CM = Need[AN]
					switch(AN)
						if("Metal")
							for(var/obj/Item/Material/Ore/I in contents)
								if(I.amount > CM)
									Metals += I
							if(!Metals.len)
								msg += "<br>[CM] - Metal"
						else
							for(var/obj/Item/Material/I in contents)
								if(I.Material == AN)
									if(I.amount >= CM)
										var/MC = round(I.amount/CM)
										if(!MaxCreation||MC < MaxCreation)
											MaxCreation = MC
										MatList += I
										break
									else
										msg += "<br>[CM] - [AN]. You have [I.amount]."

				if(msg)
					usr << "<br>You lack the necessary Materials to create the [A], you need: [msg]"
					return

				var/MetalMat
				if(Metals.len)
					var/obj/Item/Material/ThisMetal = input("What type of metal would you like to use?") as null|anything in Metals
					if(ThisMetal)
						var/MC = round(ThisMetal.amount/Need["Metal"])
						if(!MaxCreation||MC < MaxCreation)
							MaxCreation = MC
						MatList += ThisMetal
						MetalMat = ThisMetal.Material
					else
						return

				var/ThisMany = 1 //Total Created
				var/Price = 0
				if(!MaxCreation)
					return
				else
					if(MaxCreation>1)
						ThisMany=input("How many [A] would you like to craft?(Max: [MaxCreation])") as num
						if(ThisMany<1)
							return
						else if(ThisMany > MaxCreation)
							src << "You do not have enough materials to create [ThisMany] you will instead create the maximum([MaxCreation])"
							ThisMany = MaxCreation

					for(var/obj/Item/Material/Mat in MatList)
						var/Bah = 0
						if(istype(Mat,/obj/Item/Material/Ore))
							Bah = (Need["Metal"]*ThisMany)
						else
							Bah = (Need[Mat.Material]*ThisMany)
						Mat.amount -= Bah
						Price += (Mat.price * Bah)
						if(Mat.amount <= 0)
							del Mat

					ThisMany *= T

					switch(Ty)
						if(0)//Items
							var/obj/Item/WE = locate(Def) in contents
							if(!WE)
								WE = new Def()
							if(WE.Stackable)
								if(WE.loc == usr)
									WE.amount += ThisMany
								else
									WE.amount = ThisMany
									WE.loc = usr
									WE.layer = 3
							else
								for(var/Created=1 to ThisMany)
									WE = new(usr)
									WE.layer = 3
									break
						if(1)//Weapons
							var/DE = "A [A] created by [trueName] using [MetalMat]"
							var/TN = "[MetalMat] [A]"
							var/TMult = (Price*0.0025) + (CraftingSkill*0.007)
							if(CraftingSkill > 150)
								TMult *= 2
								if(A=="Kunai"||A=="Shuriken"||A=="Senbon"||A=="Windmill Shuriken"||A=="Parchment"||A=="Bandages")
									T *= 2
								if(MetalMat)
									TN = "Refined [TN]"
							ThisMany *= T

							var/obj/Weapon/WE = new Def()
							var/icon/WI
							if(WE.Stackable)
								for(var/obj/Weapon/W in usr.contents)
									if(W.type == WE.type && W.Creator == trueName && W.trueName == TN)
										WE = W
										break
								WE.price = round(Price/T) * CraftedValueMulti
								WE.Multiplier = TMult
								WE.Durability = WE.MaxDurability
								if(WE.loc != usr)
									WE.desc = DE
									WE.trueName = TN
									WE.name = TN
									WE.amount = ThisMany
									if(MetalMat)
										WE.Material = "[MetalMat]"
										if(!WI)
											WI = CreWeap(WE)
										WE.icon = WI
									else
										WE.Material = "Mixed"
									WE.loc = usr
									WE.Creator = trueName
								else
									WE.amount += ThisMany

							else
								for(var/Created=1 to ThisMany)
									WE = new Def()
									WE.desc = DE
									WE.trueName = TN
									WE.name = TN
									WE.Creator = trueName
									WE.Multiplier = TMult
									WE.MaxDurability *= TMult
									WE.Durability = WE.MaxDurability
									if(MetalMat)
										WE.Material = "[MetalMat]"
										if(!WI)
											WI = CreWeap(WE)
										WE.icon = WI
									else
										WE.Material = "Mixed"
									WE.price += Price * CraftedValueMulti
									WE.loc = usr
									Created++
							src << "You successfully created [ThisMany] [TN]"
					if(!Crafted)
						Crafted=list("[A]" = ThisMany)
					else
						Crafted["[A]"]+=ThisMany

					CraftingSkillXP += N*ThisMany
					if(CraftingSkillXP>=CraftingSkillMXP && CraftingSkill<200)
						CraftUp()
					UpdateInventory()

		CraftUp()
			var/ThisMany = CraftingSkill
			while(CraftingSkillXP>=CraftingSkillMXP && CraftingSkill<200)
				CraftingSkillXP-=CraftingSkillMXP
				CraftingSkillMXP+=4
				CraftingSkill++

			ThisMany = CraftingSkill - ThisMany

			StatUpdate_Crafting()
			CraftSkills()
			if(ThisMany > 1)
				src<<"Your crafting skill increased by [ThisMany] to [CraftingSkill]"
			else
				src<<"Your crafting skill increased to [CraftingSkill]"
			if(CraftingSkill==200)
				Medal_CraftingGuru()


proc
	CreWeap(obj/Weapon/W)
		var/icon/A=icon(W.icon)
		if(W.Material=="Rock")
			A.Blend("#965a32")
		if(W.Material=="Copper")
			A.Blend("#965a32")
		if(W.Material=="Tin")
			A.Blend("#a0a0b9")
		if(W.Material=="Bronze")
			A.Blend("#dcaa78")
		if(W.Material=="Iron")
			A.Blend("#646464")
		if(W.Material=="Steel")
			A.Blend("#50505a")
		if(W.Material=="Platinum")
			A.Blend("#99998d")
		if(W.Material=="Mithril")
			A.Blend("#64c8e6")
		if(W.Material=="Obsidian")
			A.Blend("#1e0a0a")
		return A