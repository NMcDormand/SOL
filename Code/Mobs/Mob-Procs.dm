mob
	Hittable/Unresponsive
		NinjaRank = "NA"
	proc
		EleGrant(A,B=1)
			set background=1
			if(Elements >= 5)
				return
			if(A)
				if(vars["[A]Elemental"] > 0)
					return
				else
					vars["[A]Elemental"] = B
					var/msg="You learned how to use the [A] Element"
					src << msg
					AdvancedElements++
			else
				var/list/Li=list("Earth","Fire","Lightning","Wind","Water")
				Redo
				if(Li.len > 0)
					A = pick(Li)
					if(vars["[A]Elemental"] > 0)
						Li-=A
						goto Redo
					else
						vars["[A]Elemental"] = B
						var/msg="You learned how to use the [A] Element"
						src << msg
						Elements++
				else
					return

		AdvEleGrant()
			set background=1
			set waitfor=0
			if(prob(0.1)&&!YinElemental)
				YinElemental = 1
				if(client)
					var/msg="You learned how to use the Yin Element"
					src << msg
				return
			else if(prob(0.1)&&!YangElemental)
				YangElemental = 1
				if(client)
					var/msg="You learned how to use the Yang Element"
					src << msg
					//src << "You learned how to use the Yang Element"
				return
			else
				var/list/EC = list()
				if(EarthElemental)
					if(FireElemental)
						if(!LavaElemental)
							EC += "Lava"
						if(WaterElemental && WindElemental && !ParticleElemental)
							EC += "Particle"
					if(LightningElemental)
						if(!ExplosionElemental)
							EC += "Explosion"
					if(WaterElemental )
						if(!WoodElemental)
							EC += "Wood"
					if(WindElemental)
						if(!MagnetElemental)
							EC += "Magnet"
				if(FireElemental)
					if(LightningElemental)
						if(!BlazeElemental)
							EC += "Blaze"
					if(WaterElemental)
						if(!BoilElemental)
							EC += "Boil"
					if(WindElemental)
						if(!ScorchElemental)
							EC += "Scorch"
				if(LightningElemental)
					if(WaterElemental)
						if(!StormElemental)
							EC += "Storm"
					if(WindElemental)
						if(!SwiftElemental)
							EC += "Swift"
				if(WaterElemental && WindElemental && !GaleElemental)
					EC += "Gale"
				if(EC.len>0)
					var/A=pick(EC)
					EleGrant(A)
				else
					if(client)
						var/msg="There are no Advanced Elements you can get"
						src << msg
					return

		NinStat(L,S,C,T,N,G,MS=1,Multi=1)
			set waitfor=0,background=1
			if(!S||!C||!T||!N||!G||!MS)
				if(istype(src,/mob/Hittable/Responsive/Animal/Wild))
					var/mob/Hittable/Responsive/Animal/Wild/M=src
					if(M.Size>1)
						Multi+=20

					Multi *= AniMulti

					if(!S)S=pick(1500,3000,4000)*Multi
					if(!C)C=pick(1500,3000,4000)*Multi
					if(!T)T=pick(250,500,750)*Multi
					if(!N)N=pick(250,500,750)*Multi
					if(!G)G=pick(250,500,750)*Multi
					MS=pick(1,2,3)
				else//if(!istype(src,/mob/Hittable/Responive/Animal))
					var/Age=pick("Young","Adult","Senior")
					EleGrant(,1000)
					if(!NinjaRank)
						NinjaRank = pick("Genin","Chuunin","Special Jounin","Anbu","Jounin")
					if(!Clan)
						Clan = pick("Aburame","Akimichi","Hyuuga","Inuzuka","Kaguya","Lee","Nara","Uchiha","Uzumaki","Yuki")
					switch(NinjaRank)
						if("Academy Student")
							//Multi+=5
							MS = 3
						if("Genin")
							Multi+=3
							MS = 2.5
						if("Chuunin")
							Multi+=6
							MS = 2
						if("Special Jounin")
							Multi+=20
							MS = 2
						if("Anbu", "Unknown")
							Multi+=50
							MS = 1.5
						if("Jounin")
							Multi+=90
							MS = 1.5
							EleGrant(,3000)
							EleGrant(,3000)
						if("Kage", "Villain")
							Multi+=150
							MS = 1
							EleGrant(,10000)
							EleGrant(,10000)
							EleGrant(,10000)

					if(istype(src,/mob/Hittable/Responsive/VillageNinjas))
						Multi *= 5

					if(istype(src,/mob/Hittable/Responsive/NPC/Criminal))
						Multi *= CrimMulti
					else
						Multi *= VilMulti

					switch(Age)
						if("Adult")
							Multi+=2
						if("Young")
							Multi+=1
							MS+=0.2
						else
							MS+=2

					if(!S)S=pick(3500,5500,7500)*Multi
					if(!C)C=pick(3500,5500,7500)*Multi
					if(!T)T=pick(750,1000,1250)*Multi
					if(!N)N=pick(750,1000,1250)*Multi
					if(!G)G=pick(750,1000,1250)*Multi
			if(!L)
				L=round((S+C+T+N+G+MS)*0.01,1)
			if(!MS)
				MS = pick(1,2,3)

			Level = L
			Stamina = (S * EXPGains_Stamina) * EXP_BASE
			StaminaMax = Stamina
			StaminaTrue = Stamina
			Chakra = (C * EXPGains_Chakra) * EXP_BASE
			ChakraMax = Chakra
			ChakraTrue = Chakra
			Taijutsu = (T * EXPGains_Taijutsu) * EXP_BASE
			TaijutsuMax = Taijutsu
			TaijutsuTrue = Taijutsu
			Ninjutsu = (N * EXPGains_Ninjutsu) * EXP_BASE
			NinjutsuMax = Ninjutsu
			NinjutsuTrue = Ninjutsu
			Genjutsu = (G * EXPGains_Genjutsu) * EXP_BASE
			GenjutsuMax = Genjutsu
			GenjutsuTrue = Genjutsu
			movespeed = MS
			SS = rand(1,12)
			WW = 1

		DressNin()
			set waitfor=0,background=1
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

			/*vis_contents = null
			if(!CMarker)
				CMarker = new/Overlay_Obj(icon('BunshinMarker.dmi'),MOB_LAYER+9)
				CMarker.name = "Marker"
				CMarker.invisibility = 9
			if(!CPaths)
				CPaths = new/Overlay_Obj(icon('PlayerMarker.dmi'),MOB_LAYER+10)
				CPaths.name = "Paths"
				CPaths.invisibility = 10
			vis_contents += CMarker
			vis_contents += CPaths*/

			var/icon/E = icon('Eyes_White.dmi')
			var/icon/iris = icon('Eyes_Base.dmi')

			if(!IrisColour)
				IrisColour = rgb(rand(20,100),rand(20,100),rand(20,100))
			iris += IrisColour

			E.Blend(iris,ICON_OVERLAY)
			EyeIcon = new/Overlay_Obj(E,EYE_LAYER)
			overlays += EyeIcon
			AssignRandomHair()

			var/CreateMe
			var/obj/Clothing/JV
			if(prob(20))
				CreateMe = text2path("/obj/Clothing/Face/[pick("Sunglasses","Spectacles")]")
				JV = new CreateMe(src)
				WearClothes(JV)

			var/A=rand(40,160),B=rand(40,160),C=rand(40,160)
			var/CA = rgb(A,B,C)
			var/CB = rgb(A*0.5,B*0.5,C*0.5)
			if(istype(src,/mob/Hittable/Responsive/NPC/Criminal/Ravager))//istype(src,/mob/Living/Villager)||
				CreateMe = text2path("/obj/Clothing/Shirt/[pick("Singlet","CroppedShirt", "Tanktop")]")
				JV = new CreateMe(src)
				var/icon/I=icon(JV.icon); I+=CA; JV.icon = I
				WearClothes(JV)

				CreateMe = text2path("/obj/Clothing/Underwear/[pick("Boxers","Panties")]")
				JV = new CreateMe(src)
				I=icon(JV.icon); I+=CB; JV.icon = I
				WearClothes(JV)

			else if(istype(src,/mob/Hittable/Responsive/VillageNinjas))//istype(src,/mob/Living/Villager)||
				CreateMe = text2path("/obj/Clothing/Shirt/[pick("[Village]Shirt","CollarShirt","ShortSleeveShirt","TiedShirt","VNeckShirt")]")
				JV = new CreateMe(src)
				var/icon/I=icon(JV.icon); JV.icon = I
				WearClothes(JV)

				CreateMe = text2path("/obj/Clothing/Pants/[pick("Pants","Shorts")]")
				JV = new CreateMe(src)
				I=icon(JV.icon); JV.icon = I
				WearClothes(JV)

				CreateMe = text2path("/obj/Clothing/Feet/[pick("Shoes","Sandals")]")
				JV = new CreateMe(src)
				I=icon(JV.icon);JV.icon = I
				WearClothes(JV)

				if(NinjaRank == "Jounin")
					CreateMe = text2path("/obj/Clothing/Over/JouninVest/[Village]")
					JV = new CreateMe(src)
					WearClothes(JV)
				else if(NinjaRank == "Chuunin")
					CreateMe = text2path("/obj/Clothing/Over/ChuuninVest/[Village]")
					JV = new CreateMe(src)
					WearClothes(JV)
				else if(NinjaRank == "Anbu")
					switch(pick(1,2))
						if(1)
							CreateMe = text2path("/obj/Clothing/Over/ANBUVest")
						if(2)
							CreateMe = text2path("/obj/Clothing/Over/Cloak")
					JV = new CreateMe(src)
					WearClothes(JV)

					CreateMe = text2path("/obj/Clothing/Face/ANBUMask")
					JV = new CreateMe(src)
					WearClothes(JV)

				if(NinjaRank != "Anbu")
					CreateMe = text2path("/obj/Clothing/Head/Headband")
					JV = new CreateMe(src)
					WearClothes(JV)

			else if(istype(src,/mob/Hittable/Responsive/NPC/Criminal/Prisoner))

				CreateMe = text2path("/obj/Clothing/Shirt/VNeckShirt")
				JV = new CreateMe(src)
				var/icon/I=icon(JV.icon); I+=rgb(255,100,0); JV.icon = I
				WearClothes(JV)

				CreateMe = text2path("/obj/Clothing/Pants/Pants")
				JV = new CreateMe(src)
				I=icon(JV.icon); I+=rgb(255,80,0); JV.icon = I
				WearClothes(JV)
			else //if(istype(src,/mob/Hittable/Responsive/NPC/Criminal))
				A*=0.5
				B*=0.5
				C*=0.5
				CA=rgb(A,B,C)
				CB=rgb(A*0.5,B*0.5,C*0.5)
				if(istype(src,/mob/Hittable/Responsive/NPC/Criminal/Murderer))

					CreateMe = text2path("/obj/Clothing/Over/[pick("CloakHoodless","Cloak","Tobi_Suit")]")
					JV = new CreateMe(src)
					if(istype(JV,/obj/Clothing/Over/Cloak))
						overlays -= HairIcon
					var/icon/I=icon(JV.icon); I+=CA; JV.icon = I
					WearClothes(JV)
					if(prob(60))
						CreateMe = text2path("/obj/Clothing/Face/KakashiMask")
						JV = new CreateMe(src)
						I=icon(JV.icon); I+=CB; JV.icon = I
						WearClothes(JV)
				else if(istype(src,/mob/Hittable/Responsive/NPC/Criminal/Thief))
					CreateMe = text2path("/obj/Clothing/Over/ANBUVest")
					JV = new CreateMe(src)
					var/icon/I=icon(JV.icon); I+=CA; JV.icon = I
					WearClothes(JV)

					if(prob(50))
						CreateMe = text2path("/obj/Clothing/Hands/[pick("ANBUBracers","Gauntlets")]")
						JV = new CreateMe(src)
						I=icon(JV.icon); I+=CA; JV.icon = I
						WearClothes(JV)

					CreateMe = text2path("/obj/Clothing/Pants/[pick("Pants","Shorts")]")
					JV = new CreateMe(src)
					I=icon(JV.icon); I+=CB; JV.icon = I
					WearClothes(JV)

					CreateMe = text2path("/obj/Clothing/Feet/[pick("Shoes","Sandals")]")
					JV = new CreateMe(src)
					I=icon(JV.icon); I+=CA; JV.icon = I
					WearClothes(JV)

		March()
			while(!dead)
				for(var/mob/player/M in MasterPlayerList)
					if(get_dist(src,M)<15)
						var/d = pick(WEST, EAST, NORTH, SOUTH)
						walk(src,d,3)
						sleep(rand(3,16))
						walk(src,0)
						break
				sleep(rand(45,120))