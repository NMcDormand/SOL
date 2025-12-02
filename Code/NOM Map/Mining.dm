//Mining
mob/Hittable/Unresponsive/Training
	Mining
		BlockTarget = 1
		icon='Materials.dmi'
		var
			Quality
			MType
			Size
		//DropRates Overall
			DrOre=99
			DrGem=1
		//Ore
			DrSto=100
			DrCop=80
			DrTin=70
			DrIro=50
			DrPla=20
			DrMit=10
			DrObs=5
		//Gems
			DrAmb = 20
			DrAme = 20
			DrEme = 20
			DrRub = 20
			DrSap = 20
			DrCry = 5
			DrDia = 1

		New()
			..()
			if(!Size)
				Size = rand(1, Quality)

		density=1
		proc
			ResDep(A)
				set background=1
				set waitfor=0
				name = null
				density = 0
				icon_state = "Blank"
				sleep(rand(6,18)*1000)//Increments of 600 = Minute
				name = "Mineral Deposit"
				MType = A;
				density=1
				icon_state = "StoneVein"

		DamageMe(mob/M,DAMAGE,METHOD,hidemessage)
			if(!dead && !KO)
				var/D = MType //Mineral type is locked
				//var/DMType = MType // for precreated deposit type
				var/Chance = M.MiningSkill*0.4
				if(Chance < 5)
					Chance = 5
				if(M.wielding == "Pick Axe")
					Chance += 10
				if(prob(Chance+M.Luck))
					M.MiningSkillXP+=rand(2,5)
					M.Miningup()
					if(Size&&D)
						icon_state="[D]Vein"
					var/A = pick(prob(DrOre);"Ore",prob(DrGem);"Gem")//Drop Rate Between Ore and Gems
					switch(A)
						if("Gem")//Drop Rate Between different Gems
							MType = pick (
								prob(DrAmb);"Amber",
								prob(DrAme);"Amethyst",
								prob(DrEme);"Emerald",
								prob(DrRub);"Ruby",
								prob(DrSap);"Sapphire",
								prob(DrDia);"Diamond",
								prob(DrCry);"Crystal"
								)
							M << "and uncovered \an [MType]"
						if("Ore")//Drop Rate Between different Ore
							if(!MType)
								MType = pick(
									prob(DrSto);"Stone",
									prob(DrCop);"Copper",
									prob(DrCop);"Tin",
									prob(DrIro);"Iron",
									prob(DrPla);"Platinum",
									prob(DrMit);"Mithril",
									prob(DrObs);"Obsidian"
									)
								D = MType //Lock In Mineral Remove to have random each round
							usr << "and knocked some [MType] Ore loose"

					var/C = text2path("/obj/Item/Material/[A]/[MType]")
					var/obj/Item/Material/O=locate(C) in loc
					if(O)
						O.amount++
						O.Checkamount()
					else
						new C(loc)

					if(prob(30+M.Luck))
						var/obj/Item/Material/Coal/O2=locate() in loc.contents
						if(O2)
							O2.amount++
						else
							new/obj/Item/Material/Coal(loc)
					MType = D
				else
					M << "You failed to find anything in this deposit"
					spawn()
						M.MiningSkillXP+=rand(1,2)
						M.Miningup()
				Size--
				if(Size < 1)
					var/obj/Spawner/Spn=Creator
					if(Spn)
						Spn.SpLim--
						Spn.SpCur--
						//world<<"spawner lowered"
						Spn.SpnDthCheck()
					M<<pick(
						prob(2000);"You depleted the [name]",
						prob(1);"You drained the main vein")
					//ResDep(DMType)//Removes Name, Blanks, and resets necessary variables
					loc=null
					name=null
					dead = 1
					KO = 1
				spawn(10)
					if(M)
						M.IsMining = 0

		Deposit
			name = "Mineral Deposit"
			icon_state="StoneVein"

			Common
				Quality=1
				DrSto=40
				DrCop=30
				DrTin=20
				DrIro=10
				DrPla=5
				DrMit=3
				DrObs=1

			Uncommon
				Quality=2
				DrOre=95
				DrGem=5

			Rare
				Quality=3
				DrOre=95
				DrGem=10
				DrSto=50
				DrCop=50
				DrTin=30
				DrIro=80
				DrPla=40
				DrMit=20
				DrObs=10

			SuperRare
				Quality=4
				DrOre=90
				DrGem=10
				DrSto=0
				DrCop=20
				DrTin=20
				DrIro=60
				DrPla=50
				DrMit=30
				DrObs=20

			Legendary
				Quality=5
				DrOre=80
				DrGem=20
				DrSto=0
				DrCop=0
				DrTin=0
				DrIro=0
				DrPla=50
				DrMit=30
				DrObs=20

			Stone
				name="Stone Deposit"
				icon_state="StoneVein"
				MType="Stone"
				Quality=5
			Copper
				name="Copper Deposit"
				icon_state="CopperVein"
				MType="Copper"
				Quality=5
			Tin
				name="Tin Deposit"
				icon_state="StoneVein"
				MType="Tin"
				Quality=5
			Iron
				name="Iron Deposit"
				icon_state="IronVein"
				MType="Iron"
				Quality=5
			Platinum
				name="Platinum Deposit"
				icon_state="PlatinumVein"
				MType="Platinum"
				Quality=5
			Mithril
				name="Mithril Deposit"
				icon_state="MithrilVein"
				MType="Mithril"
				Quality=5
			Obsidian
				name="Obsidian Deposit"
				icon_state="ObsidianVein"
				MType="Obsidian"
				Quality=5