mob/proc
	Craft_Kunai()
		var/Finput=5
		var/Rinput=2
		for(var/obj/Item/Material/Feather/F in src.contents)
			if(F.amount<Finput)
				var/need=Finput-F.amount
				src<<"You need [need] more Feathers."
				return
		for(var/obj/Item/Material/Rock/R in src.contents)
			if(R.amount<Rinput)
				var/need=Rinput-R.amount
				src<<"You need [need] more rocks."
				return
		if(prob(src.ChakraControl))
			src.Chakra-=50; src<<"50/50 chakra converted"
			if(src.CraftingSkill>40) src<<"You successfully crafted 2 kunais"
			else src<<"You successfully crafted a kunai"

			for(var/obj/Item/Material/Rock/R in src.contents)
				R.amount-=Rinput; R.Checkamount()
				if(R.amount<=0) del(R)
			for(var/obj/Item/Material/Feather/F in src.contents)
				F.amount-=Finput; F.Checkamount()
				if(F.amount<=0) del(F)
			if(src.CraftingSkill>40)
				var/obj/Weapon/Wield/Kunai/k = new/obj/Weapon/Wield/Kunai(src)
				k.CraftedBy=Engrave(src)
			var/obj/Weapon/Wield/Kunai/K = new/obj/Weapon/Wield/Kunai(src)
			K.CraftedBy=Engrave(src)

			UpdateInventory()
			src.CraftingSkill_Exp+=rand(6,14)
			src.CraftUp()
			return
		else
			var/cuse=rand(10,49)

			for(var/obj/Item/Material/Rock/R in src.contents)
				R.amount-=Rinput; R.Checkamount()
				if(R.amount<=0) del(R)
			for(var/obj/Item/Material/Feather/F in src.contents)
				F.amount-=Finput; F.Checkamount()
				if(F.amount<=0) del(F)

			src<<"[cuse]/50 chakra converted. You failed to craft the kunai."
			UpdateInventory()
			src.Chakra-=cuse
			src.CraftingSkill_Exp+=3

//-------------------------------------------------------------------------------------------------------------

	Craft_Shuriken()
		var/Finput=12
		var/Rinput=4
		for(var/obj/Item/Material/Feather/F in src.contents)
			if(F.amount<Finput)
				var/need=Finput-F.amount
				src<<"You need [need] more Feathers."
				return
		for(var/obj/Item/Material/Rock/R in src.contents)
			if(R.amount<Rinput)
				var/need=Rinput-R.amount
				src<<"You need [need] more rocks."
				return

		if(prob(src.ChakraControl))
			src.Chakra-=50
			var/shurikenAmount=2;

			for(var/obj/Item/Material/Rock/R in src.contents)
				R.amount-=Rinput; R.Checkamount()
				if(R.amount<=0) del(R)
			for(var/obj/Item/Material/Feather/F in src.contents)
				F.amount-=Finput; F.Checkamount()
				if(F.amount<=0) del(F)

			src.GiveShuriken()
			if(usr.CraftingSkill>30) {src.GiveShuriken(); shurikenAmount+=2}
			if(usr.CraftingSkill>40) {src.GiveShuriken(); shurikenAmount+=2}
			if(usr.CraftingSkill>65) {src.GiveShuriken(); shurikenAmount+=2}
			if(usr.CraftingSkill>95) {src.GiveShuriken(); shurikenAmount+=2}
			src<<"50/50 chakra converted"; src<<"You successfully crafted [shurikenAmount] shuriken."
			UpdateInventory()
			src.CraftingSkill_Exp+=rand(10,20)
			src.CraftUp()
			return

		else
			var/cuse=rand(10,49)
			for(var/obj/Item/Material/Rock/R in src.contents)
				R.amount--; R.Checkamount()
				if(R.amount<=0) del(R)
			for(var/obj/Item/Material/Feather/F in src.contents)
				F.amount-=8; F.Checkamount()
				if(F.amount<=0) del(F)

			UpdateInventory()
			src<<"[cuse]/50 chakra converted. You failed to craft a shuriken."
			src.Chakra-=cuse
			src.CraftingSkill_Exp+=rand(3,5)
//-------------------------------------------------------------------------------------------------------------

	Craft_Katana()
		var/Finput=25
		var/Rinput=3
		for(var/obj/Item/Material/Feather/F in src.contents)
			if(F.amount<Finput)
				var/need=Finput-F.amount
				src<<"You need [need] more Feathers."
				return
		for(var/obj/Item/Material/Rock/R in src.contents)
			if(R.amount<Rinput)
				var/need=Rinput-R.amount
				src<<"You need [need] more rocks."
				return

		if(prob(src.ChakraControl))
			src.Chakra-=50; src<<"50/50 chakra converted"; src<<"You successfully crafted a katana."

			for(var/obj/Item/Material/Rock/R in src.contents)
				R.amount-=Rinput; R.Checkamount()
				if(R.amount<=0) del(R)
			for(var/obj/Item/Material/Feather/F in src.contents)
				F.amount-=Finput; F.Checkamount()
				if(F.amount<=0) del(F)
			var/obj/Weapon/Wield/Katana/K = new/obj/Weapon/Wield/Katana(src)
			K.CraftedBy=Engrave(src)
			if(src.CraftingSkill>60)
				var/obj/Weapon/Wield/Katana/k = new/obj/Weapon/Wield/Katana(src)
				k.CraftedBy=Engrave(src)

			UpdateInventory()
			src.CraftingSkill_Exp+=rand(14,32)
			src.CraftUp()
			return
		else
			var/cuse=rand(10,49)
			for(var/obj/Item/Material/Rock/R in src.contents)
				R.amount-=Rinput; R.Checkamount()
				if(R.amount<=0) del(R)
			for(var/obj/Item/Material/Feather/F in src.contents)
				F.amount-=Finput; F.Checkamount()
				if(F.amount<=0) del(F)

			src<<"[cuse]/50 chakra converted. You failed to craft the katana."
			UpdateInventory()
			src.Chakra-=cuse
			src.CraftingSkill_Exp+=5

//-------------------------------------------------------------------------------------------------------------

	Craft_BroadSword()
		var/Finput=50
		var/Rinput=6
		for(var/obj/Item/Material/Feather/F in src.contents)
			if(F.amount<Finput)
				var/need=Finput-F.amount
				src<<"You need [need] more Feathers."
				return
		for(var/obj/Item/Material/Rock/R in src.contents)
			if(R.amount<Rinput)
				var/need=Rinput-R.amount
				src<<"You need [need] more rocks."
				return

		if(prob(src.ChakraControl))
			src.Chakra-=50; src<<"50/50 chakra converted."; src<<"You successfully crafted a Broad Sword."

			for(var/obj/Item/Material/Rock/R in src.contents)
				R.amount-=Rinput; R.Checkamount()
				if(R.amount<=0) del(R)
			for(var/obj/Item/Material/Feather/F in src.contents)
				F.amount-=Finput; F.Checkamount()
				if(F.amount<=0) del(F)
			var/obj/Weapon/Wield/BroadSword/B = new/obj/Weapon/Wield/BroadSword(src)
			if(src.CraftingSkill>82)
				var/obj/Weapon/Wield/BroadSword/b = new/obj/Weapon/Wield/BroadSword(src)
				b.CraftedBy=Engrave(src)
			B.CraftedBy=Engrave(src)

			UpdateInventory()
			src.CraftingSkill_Exp+=rand(18,40)
			src.CraftUp()
			return
		else
			var/cuse=rand(10,49)
			for(var/obj/Item/Material/Rock/R in src.contents)
				R.amount-=Rinput; R.Checkamount()
				if(R.amount<=0) del(R)
			for(var/obj/Item/Material/Feather/F in src.contents)
				F.amount-=Finput; F.Checkamount()
				if(F.amount<=0) del(F)

			src<<"[cuse]/50 chakra converted. You failed to craft the Broad Sword."
			UpdateInventory()
			src.Chakra-=cuse
			src.CraftingSkill_Exp+=5

//-------------------------------------------------------------------------------------------------------------

	Craft_FishingRod()
		var/Finput=40
		var/Rinput=5
		for(var/obj/Item/Material/Feather/F in src.contents)
			if(F.amount<Finput)
				var/need=Finput-F.amount; src<<"You need [need] more Feathers."; return
		for(var/obj/Item/Material/Rock/R in src.contents)
			if(R.amount<Rinput)
				var/need=Rinput-R.amount; src<<"You need [need] more rocks."; return

		if(prob(src.ChakraControl))
			src.Chakra-=50; src<<"50/50 chakra converted."; src<<"You successfully crafted a Fishing Rod."

			for(var/obj/Item/Material/Rock/R in src.contents)
				R.amount-=Rinput; R.Checkamount()
				if(R.amount<=0) del(R)
			for(var/obj/Item/Material/Feather/F in src.contents)
				F.amount-=Finput; F.Checkamount()
				if(F.amount<=0) del(F)
			if(usr.CraftingSkill<85) {var/obj/Item/rod/Rod2/R = new/obj/Item/rod/Rod2(src); R.CraftedBy=Engrave(src)}
			else {var/obj/Item/rod/Rod3/R = new/obj/Item/rod/Rod3(src); R.CraftedBy=Engrave(src)}

			UpdateInventory()
			src.CraftingSkill_Exp+=rand(22,48)
			src.CraftUp()
			return
		else
			var/cuse=rand(10,49)

			for(var/obj/Item/Material/Rock/R in src.contents)
				R.amount-=Rinput; R.Checkamount(); if(R.amount<=0) del(R)
			for(var/obj/Item/Material/Feather/F in src.contents)
				F.amount-=Finput; F.Checkamount(); if(F.amount<=0) del(F)

			src<<"[cuse]/50 chakra converted. You failed to craft a Fishing Rod."
			UpdateInventory(); src.Chakra-=cuse; src.CraftingSkill_Exp+=5

//-------------------------------------------------------------------------------------------------------------

	Craft_Parchment()
		var/Finput=100
		var/Rinput=5
		for(var/obj/Item/Material/Feather/F in src.contents)
			if(F.amount<Finput)
				var/need=Finput-F.amount; src<<"You need [need] more Feathers."; return
		for(var/obj/Item/Material/Rock/R in src.contents)
			if(R.amount<Rinput)
				var/need=Rinput-R.amount; src<<"You need [need] more rocks."; return

		if(prob(src.ChakraControl))
			src.Chakra-=50; src<<"50/50 chakra converted."; src<<"You successfully crafted some Parchment."

			for(var/obj/Item/Material/Rock/R in src.contents)
				R.amount-=Rinput; R.Checkamount(); if(R.amount<=0) del(R)
			for(var/obj/Item/Material/Feather/F in src.contents)
				F.amount-=Finput; F.Checkamount(); if(F.amount<=0) del(F)
			new/obj/Scrolls/Parchment(src)
			UpdateInventory(); src.CraftingSkill_Exp+=rand(40,60); src.CraftUp()
		else
			var/cuse=rand(10,49)

			for(var/obj/Item/Material/Rock/R in src.contents)
				R.amount-=Rinput; R.Checkamount(); if(R.amount<=0) del(R)
			for(var/obj/Item/Material/Feather/F in src.contents)
				F.amount-=Finput; F.Checkamount(); if(F.amount<=0) del(F)

			src<<"[cuse]/50 chakra converted. You failed to craft some Parchment."
			UpdateInventory(); src.Chakra-=cuse; src.CraftingSkill_Exp+=5

	Craft_Bandages()
		var
			Finput=10; Rinput=2
		for(var/obj/Item/Material/Feather/F in src.contents)
			if(F.amount<Finput) {var/need=Finput-F.amount; src<<"You need [need] more Feathers."; return}
		for(var/obj/Item/Material/Rock/R in src.contents)
			if(R.amount<Rinput) {var/need=Rinput-R.amount; src<<"You need [need] more rocks."; return}

		if(prob(src.ChakraControl))
			src.Chakra-=50
			src<<"50/50 chakra converted"; src<<"You successfully crafted some bandages."

			for(var/obj/Item/Material/Rock/R in src.contents)
				R.amount--; R.Checkamount()
				if(R.amount<=0) del(R)
			for(var/obj/Item/Material/Feather/F in src.contents)
				F.amount-=8; F.Checkamount()
				if(F.amount<=0) del(F)

			src.GiveBandages()
			UpdateInventory()

		else
			var/cuse=rand(10,49)
			for(var/obj/Item/Material/Rock/R in src.contents)
				R.amount--; R.Checkamount(); if(R.amount<=0) del(R)
			for(var/obj/Item/Material/Feather/F in src.contents)
				F.amount-=8; F.Checkamount(); if(F.amount<=0) del(F)
			UpdateInventory(); src<<"[cuse]/50 chakra converted. You failed to craft a shuriken."; src.Chakra-=cuse