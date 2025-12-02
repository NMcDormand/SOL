/*
Sunnies
Specs
Mouth Mask
LS Shirt
T Shirt
Singlet
Pants
Shorts
Sandals
*/
 //"Tobi Robe","Tobi Mask","Madara Mask","Red Armour","Blue Armour",
var/list/ClothesList=list("Sunglasses","Spectacles","Mouth Mask",\
"Long Sleeve Shirt","Short Sleeve Shirt", "Bra", "Singlet",\
"Collared Shirt","Crop Top",\
"Long Robe Shirt","Short Robe Shirt","Red Vest",\
"Tank Top","Tied Shirt","V-Neck","Cloak","Cloak Hoodless",\
"Pants", "Panties", "Shorts","Sandals","Shoes",\
"Gauntlets","Weights","Extra Weights")
mob/NPC/Shopkeepers
	ClothesDealer
		name = "Clothes Dealer"
		icon = 'Base_Pale.dmi'
		CantHenge=1
		protect=1
		New()
			new/obj/Clothing/Face/Spectacles(src)
			new/obj/Clothing/Shirt/LongSleeveShirt(src)
			new/obj/Clothing/Pants/Pants(src)
			new/obj/Clothing/Feet/Sandals(src)
			for(var/obj/c in src)
				c.worn = 1
				overlays += c.icon
		Action(mob/user)
			if(get_dist(user,src)>2) return
			var
				p=120; purchase
			switch(input("What would you like?","Clothes Dealer")as null|anything in ClothesList)
				if("Spectacles")
					if(user.gold>=p) {new/obj/Clothing/Face/Spectacles(user); purchase="some spectacles"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Sunglasses")
					if(user.gold>=p) {new/obj/Clothing/Face/Sunglasses(user); purchase="some sunglasses"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Mouth Mask")
					if(user.gold>=p) {new/obj/Clothing/Face/KakashiMask(user); purchase="a mouth mask"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Long Sleeve Shirt")
					p=220
					if(user.gold>=p) {new/obj/Clothing/Shirt/LongSleeveShirt(user); purchase="a long sleeve shirt"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Short Sleeve Shirt")
					p=200
					if(user.gold>=p) {new/obj/Clothing/Shirt/ShortSleeveShirt(user); purchase="a short sleeve shirt"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Singlet")
					p=180
					if(user.gold>=p) {new/obj/Clothing/Shirt/Singlet(user); purchase="a singlet"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Cloak")
					p=380
					if(user.gold>=p) {new/obj/Clothing/Over/Cloak(user); purchase="a hooded cloak"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Cloak Hoodless")
					p=180
					if(user.gold>=p) {new/obj/Clothing/Over/CloakHoodless(user); purchase="a black Cloak"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Collared Shirt")
					p=180
					if(user.gold>=p) {new/obj/Clothing/Shirt/CollarShirt(user); purchase="a Collared Shirt"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Crop Top")
					p=180
					if(user.gold>=p) {new/obj/Clothing/Shirt/CroppedShirt(user); purchase="a Crop Top"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Gauntlets")
					p=80
					if(user.gold>=p) {new/obj/Clothing/Hands/Gauntlets(user); purchase="some Gauntlets"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Bra")
					p=180
					if(user.gold>=p) {new/obj/Clothing/Underwear/Bra(user); purchase="a Bra"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Panties")
					p=180
					if(user.gold>=p) {new/obj/Clothing/Underwear/Panties(user); purchase="some panties"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Boxers")
					p=180
					if(user.gold>=p) {new/obj/Clothing/Underwear/Boxers(user); purchase="some boxers"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Pants")
					p=200
					if(user.gold>=p) {new/obj/Clothing/Pants/Pants(user); purchase="some pants"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Shorts")
					p=180
					if(user.gold>=p) {new/obj/Clothing/Pants/Shorts(user); purchase="some shorts"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Sandals")
					if(user.gold>=p) {new/obj/Clothing/Feet/Sandals(user); purchase="some sandals"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Shoes")
					if(user.gold>=p) {new/obj/Clothing/Feet/Shoes(user); purchase="some shoes"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Long Robe Shirt")
					p=180
					if(user.gold>=p) {new/obj/Clothing/Shirt/LongRobeShirt(user); purchase="a Shirt"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Short Robe Shirt")
					p=180
					if(user.gold>=p) {new/obj/Clothing/Shirt/ShortRobeShirt(user); purchase="a Shirt"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Red Vest")
					p=80
					if(user.gold>=p) {new/obj/Clothing/Over/RedVest(user); purchase="a red Vest"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Tank Top")
					p=180
					if(user.gold>=p) {new/obj/Clothing/Shirt/Tanktop(user); purchase="a Tank-top"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Tied Shirt")
					p=180
					if(user.gold>=p) {new/obj/Clothing/Shirt/TiedShirt(user); purchase="a Tied Shirt"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("V-Neck")
					p=180
					if(user.gold>=p) {new/obj/Clothing/Shirt/VNeckShirt(user); purchase="a V-Neck"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Yondaime Cloak")
					p=50000
					if(user.gold>=p) {new/obj/Clothing/Over/YondaimeCloak(user); purchase="a replica of the fourth's clock"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Red Armour")
					p=50000
					if(user.gold>=p) {new/obj/Clothing/Armour/RedArmour(user); purchase="a set of red armour"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Blue Armour")
					p=50000
					if(user.gold>=p) {new/obj/Clothing/Armour/BlueArmour(user); purchase="a set of blue armour"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Tobi Robe")
					p=50000
					if(user.gold>=p) {new/obj/Clothing/Over/Tobi_Suit(user); purchase="a replica of Tobi's Robes"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Tobi Mask")
					p=30000
					if(user.gold>=p) {new/obj/Clothing/Face/Tobi_Mask(user); purchase="a replica of Tobi's Mask"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Madara Mask")
					p=60000
					if(user.gold>=p) {new/obj/Clothing/Face/Madara_Mask(user); purchase="a replica of Madara's Mask"}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"};..()
					user.gold-=p; user<<"<i>You bought [purchase]</i>."

				if("Weights")
					p=8000
					if(user.gold>=p) {new/obj/Item/AnkleWeight(user); purchase="some ankle weights"; user.gold-=p; user<<"<i>You bought [purchase]</i>."}
					else {user<<"<i>This item costs [p] gold; you are [p-user.gold] gold short.</i>"}

				if("Extra Weights")
					p=5000
					var/quantity=input("How many do you want?","Clothes Dealer")as num
					if(quantity<0) return
					var/goldneeded=quantity*p
					if(user.gold>=goldneeded)
						user.gold-=goldneeded
						var/counter=0
						for(var/obj/Item/ExtraWeights/E in user.contents) counter++
						if(!counter)
							var/obj/Item/ExtraWeights/E=new(user); E.amount=quantity; E.Checkamount()
						else
							for(var/obj/Item/ExtraWeights/E in user.contents)
								E.amount+=quantity; E.Checkamount()
						user.StatUpdate_gold(); user.UpdateInventory()
						user<<"<i>You bought [quantity] extra weights.</i>"
						return
					else {user<<"<i>[quantity] extra weights will cost [goldneeded] gold; you are [goldneeded-user.gold] gold short.</i>"};..()
			user.StatUpdate_gold(); user.UpdateInventory(); user.UpdateInventory()

//------------------------------------------------------------------------------------------------------------