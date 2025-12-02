obj/Item/Material
	icon='Materials.dmi'
	Stackable = 1

	Crossed(mob/O)
		if(collected||cantCollect)
			return
		if(ismob(O))
			if(O.client)
				spawn(0)
					collected = 1

					if(Stackable)
						var/obj/Item/F = locate(type) in O
						if(!F)
							loc = O
						else
							F.amount += amount
							amount = 0
							loc = null
					else
						loc = O

					O << "You pick up [amount] [trueName]"
					O.UpdateInventory()

	var
		FCost
		Stuff
		IsMetal

	Feather
		name="Feather"
		trueName="Feather"
		icon='FeatherNew.dmi'
		//icon_state="feather"
		amount=1
		Material = "Feather"
		New()
			flick("drop",src)
/*
	Rock
		name="Rocks"
		trueName="Rock"
		icon='Materials.dmi'
		icon_state="rock"
		amount=1
		Material = "Rock"*/

	Garbage
		name="Garbage"
		trueName="Garbage"
		icon='MissionItems.dmi'
		icon_state="Garbage"
		amount=1
		tradeable=0

	Ore//For Mining & Smelting
		IsMetal = 1
		Stone
			name = "Stone Ore"
			trueName = "Stone Ore"
			icon_state="StoneOre"
			Stuff="the stone ore"
			Material = "Stone"
			price = 2
			verb
				ThrowStone()
					set category="Taijutsu"
					set name="Throw Rock"
					if(usr.ThrowAttackCheck(src)) return
					else
						usr.throwing=1; spawn(3)usr.throwing=0
						amount--
						spawn(5)
							if(amount<1) {spawn(2)del(src)}
						Checkamount(); usr.UpdateInventory(); usr.RocksThrown++
						usr<<"You throw a Stone."
						var/obj/ThrownStone/R = new(usr.loc)
						R.Taijutsu=usr.Taijutsu; R.EarthElemental=usr.EarthElemental; R.ThrowingSkill=usr.ThrowingSkill
						R.dir=usr.dir; R.Owner=usr; walk(R,usr.dir)
						spawn(8)del(R)
		Copper
			name = "Copper Ore"
			trueName = "Copper Ore"
			icon_state="CopperOre"
			Stuff="the copper ore"
			Material = "Copper"
			FCost = 4
			price = 5
		Tin
			name = "Tin Ore"
			trueName = "Tin Ore"
			icon_state="TinOre"
			Stuff="the tin ore"
			Material = "Tin"
			FCost = 4
			price = 10
		Iron
			name = "Iron Ore"
			trueName = "Iron Ore"
			icon_state="IronOre"
			Stuff="the iron ore"
			Material = "Iron"
			FCost = 6
			price = 15
		Platinum
			name = "Platinum Ore"
			trueName = "Platinum Ore"
			icon_state="PlatinumOre"
			Stuff="the platinum ore"
			Material = "Platinum"
			FCost = 12
			price = 25
		Mithril
			name = "Mithril Ore"
			trueName = "Mithril Ore"
			icon_state="MithrilOre"
			Stuff="the mithril ore"
			Material = "Mithril"
			FCost = 18
			price = 35
		Obsidian
			name = "Obsidian Ore"
			trueName = "Obsidian Ore"
			icon_state="ObsidianOre"
			Stuff="the obsidian ore"
			Material = "Obsidian"
			FCost = 25
			price = 50
/*
	Ingot//For Blacksmith & smelting
		IsMetal = 1
		Copper
			name = "Copper Ingot"
			trueName = "Copper Ingot"
			icon_state="CopperIngot"
			Stuff="the copper ingot"
			Material = "Copper"
			price = 20

		Tin
			name = "Tin Ingot"
			trueName = "Tin Ingot"
			icon_state="TinIngot"
			Stuff="the tin ingot"
			Material = "Tin"
			price = 40

		Bronze
			name = "Bronze Ingot"
			trueName = "Bronze Ingot"
			icon_state="BronzeIngot"
			Stuff="the bronze ingot"
			Material = "Bronze"
			price = 60

		Iron
			name = "Iron Ingot"
			trueName = "Iron Ingot"
			icon_state="IronIngot"
			Stuff="the iron ingot"
			Material = "Iron"
			price = 60

		Steel
			name = "Steel Ingot"
			trueName = "Steel Ingot"
			icon_state="SteelIngot"
			Stuff="the steel ingot"
			Material = "Steel"
			price = 80

		Platinum
			name = "Platinum Ingot"
			trueName = "Platinum Ingot"
			icon_state="PlatinumIngot"
			Stuff="the platinum ingot"
			Material = "Platinum"
			price = 90

		Mithril
			name = "Mithril Ingot"
			trueName = "Mithril Ingot"
			icon_state="MithrilIngot"
			Stuff="the mithril ingot"
			Material = "Mithril"
			price = 130

		Obsidian
			name = "Obsidian Ingot"
			trueName = "Obsidian Ingot"
			icon_state="ObsidianIngot"
			Stuff="the obsidian"
			Material = "Obsidian"
			price = 190
*/
	Gem//For Selling and Elemental Infusion
		var/Element
		Material = "Gem"
		Stackable = 0
		Amber
			name = "Amber"
			trueName = "Amber"
			Material = "Amber"
			icon_state = "Amber"
			Stuff="the amber"
			Element = "Earth"
			price = 500

		Amethyst
			name = "Amethyst"
			trueName = "Amethyst"
			Material = "Amethyst"
			icon_state = "Amethyst"
			Stuff="the amethyst"
			Element = "Lightning"
			price = 500

		Emerald
			name = "Emerald"
			trueName = "Emerald"
			icon_state = "Emerald"
			Material = "Emerald"
			Stuff="the emerald"
			Element= "Wind"
			price = 500

		Ruby
			name = "Ruby"
			trueName = "Ruby"
			Material = "Ruby"
			icon_state = "Ruby"
			Stuff="the ruby"
			Element = "Fire"
			price = 500

		Sapphire
			name = "Sapphire"
			trueName = "Sapphire"
			Material = "Sapphire"
			icon_state = "Sapphire"
			Stuff="the sapphire"
			Element = "Water"
			price = 500

		Crystal
			name = "Crystal"
			trueName = "Crystal"
			Material = "Crystal"
			icon_state = "Crystal"
			Stuff="the crystal"
			Element = "Purity"
			price = 1000

		Diamond
			name = "Diamond"
			trueName = "Diamond"
			Material = "Diamond"
			icon_state = "Diamond"
			Stuff="the diamond"
			Element = "All"
			price = 2500

	Coal
		name = "Coal"
		trueName = "Coal"
		icon_state="Coal"
		Material = "Coal"
		Stuff="the coal"
		FCost = 2
		price = 10

	Wood
		name = "Wood"
		trueName = "Wood"
		Material = "Wood"
		icon_state="Branch"
		Stuff="the wood"
		price = 5

	Leather
		Material = "Leather"