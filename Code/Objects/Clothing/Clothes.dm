obj/KageHat
	invisibility = 5
	layer=HAT_LAYER
	rare=1
	verb
		Wear()
			usr.WearClothes(src)
		Get()
			set src in oview(1)
			usr.GetClothes(src)
	Rock
		name="Kage Hat"
		icon='RockHat.dmi'
	Cloud
		name="Kage Hat"
		icon='CloudHat.dmi'
	Leaf
		name="Kage Hat"
		icon='LeafHat.dmi'
	Mist
		name="Kage Hat"
		icon='MistHat.dmi'
	Sand
		name="Kage Hat"
		icon='SandHat.dmi'
	Grass
		name="Kage Hat"
		icon='GrassHat.dmi'
	Rain
		name="Kage Hat"
		icon='RainHat.dmi'
	Sound
		name="Kage Hat"
		icon='SoundHat.dmi'
	Waterfall
		name="Kage Hat"
		icon='WaterfallHat.dmi'

obj/Clothing
	invisibility = 5
	New()
		..()
		if(isturf(loc))
			layer = MOB_LAYER-1
	verb
		Wear()
			usr.WearClothes(src)
		Drop()
			usr.DropClothes(src)
			Dropped = layer
			layer = MOB_LAYER-1
		Get()
			set src in oview(1)
			usr.GetClothes(src)
			if(Dropped)
				layer = Dropped
				Dropped = 0
			else
				layer = initial(layer)
		Set_Layer()
			layer = input("Set the layer you would like this Clothing to be displayed, 0 will reset to default (Lower numbers appear on top, Current is [layer])","Layer") as num
			if(!layer)
				if(worn)
					overlays-=Overlay
				layer = initial(layer)
			Overlay = new/Overlay_Obj(icon,layer)
			if(worn)
				overlays+=Overlay
			usr.UpdateInventory()
	Custom
		layer=OVER_LAYER
		TestOutfit
			name="Tested Icon"
			price=0
			rare=1
			New(LOC,mob/O)
				loc = LOC
				..()
				spawn(3000)
					if(O)
						if(worn)
							O.overlays-=icon
						O<<"Your [name] has expired";
						del src
		UploadedOutfit
			name="Uploaded Outfit"
			price=0
			rare=1
			verb
				Apply_Icon()
					set src in usr.contents
					var/list/Weapons = list()
					for(var/obj/Weapon/Wield/W in usr)
						if(W.rare||W.bones||W.worn||BlockDrop||istype(W,/obj/Weapon/Thrown/Shuriken))
							continue
						else
							Weapons += W
					var/obj/Weapon/Wield/W = input("Which weapon will receive this icon?","Weapon") as null|anything in Weapons
					if(W)
						if(alert("Are you sure you would like to set the Uploaded Icon to the [W], this weapon will no longer be able to be dropped","Apply","Yes","No") == "Yes")
							W.icon = icon
							W.BlockDrop = 1
	Underwear
		layer=UNDER_LAYER
		Bra
			name="Bra"
			icon='Bra.dmi'
			price=10
			verb
				Customise()
					CustomiseClothes(usr,'Bra.dmi')
		Panties
			name="Panties"
			icon='Panties.dmi'
			price=10
			verb
				Customise()
					CustomiseClothes(usr,'Panties.dmi')
		Boxers
			name="Boxers"
			icon='Boxers.dmi'
			price=10
			verb
				Customise()
					CustomiseClothes(usr,'Boxers.dmi')
	Feet
		layer=SHOE_LAYER
		Sandals
			name="sandals"
			icon='Sandles.dmi'
			price=10
		Shoes
			name="shoes"
			icon='Shoes.dmi'
			price=10
			verb
				Customise()
					CustomiseClothes(usr,'Shoes.dmi')
	Pants
		layer=PANTS_LAYER
		Pants
			name="pants"
			icon='Pants.dmi'
			price=12
			verb
				Customise()
					CustomiseClothes(usr,'Pants.dmi')
		Shorts
			name="shorts"
			icon='Shorts.dmi'
			price=12
			verb
				Customise()
					CustomiseClothes(usr,'Shorts.dmi')
	Shirt
		layer=SHIRT_LAYER
		ShortSleeveShirt
			name="T Shirt"
			icon='SShirt.dmi'
			price=10
			verb
				Customise()
					CustomiseClothes(usr,'SShirt.dmi')
		LongSleeveShirt
			name="Long Sleeve Shirt"
			icon='LShirt.dmi'
			price=10
			verb
				Customise()
					CustomiseClothes(usr,'LongSleeveShirt.dmi')
		VNeckShirt
			name="V Neck Shirt"
			icon='VShirt.dmi'
			price=10
			verb
				Customise()
					CustomiseClothes(usr,'VShirt.dmi')
		CroppedShirt
			name="Cropped Top"
			icon='CShirt.dmi'
			price=10
			verb
				Customise()
					CustomiseClothes(usr,'CShirt.dmi')
		CollarShirt
			name="Collar shirt"
			icon='NejiShirt.dmi'
			price=10
			verb
				Customise()
					CustomiseClothes(usr,'NejiShirt.dmi')
		TiedShirt
			name="Tied Shirt"
			icon='TsunadeShirt.dmi'
			price=10
			verb
				Customise()
					CustomiseClothes(usr,'TsunadeShirt.dmi')
		ShortRobeShirt
			name="Short Robe shirt"
			icon='Jshirt_short.dmi'
			price=10
			verb
				Customise()
					CustomiseClothes(usr,'Jshirt_short.dmi')
		LongRobeShirt
			name="Long Robe shirt"
			icon='Jshirt_Long.dmi'
			price=10
			verb
				Customise()
					CustomiseClothes(usr,'Jshirt_short.dmi')
		Singlet
			name="Singlet"
			icon='Singlet.dmi'
			price=10
			verb
				Customise()
					CustomiseClothes(usr,'Singlet.dmi')
		Tanktop
			name="Tank Top"
			icon='WShirt.dmi'
			price=10
			verb
				Customise()
					CustomiseClothes(usr,'WShirt.dmi')
		LeafShirt
			name="Leaf Shirt"
			icon='CShirt_Fire.dmi'
			price=10

		GrassShirt
			name="Grass Shirt"
			icon='CShirt_Grass.dmi'
			price=10

		RockShirt
			name="Rock Shirt"
			icon='CShirt_Earth.dmi'
			price=10

		CloudShirt
			name="Cloud Shirt"
			icon='CShirt_Lightning.dmi'
			price=10

		RainShirt
			name="Rain Shirt"
			icon='CShirt_Rain.dmi'
			price=10

		SoundShirt
			name="Sound Shirt"
			icon='CShirt_Sound.dmi'
			price=10

		WaterfallShirt
			name="Waterfall Shirt"
			icon='CShirt_Waterfall.dmi'
			price=10

		MistShirt
			name="Mist Shirt"
			icon='CShirt_Water.dmi'
			price=10

		SandShirt
			name="Sand Shirt"
			icon='CShirt_Wind.dmi'
			price=10

	Over
		layer=OVER_LAYER
		Cloak
			name="Cloak"
			icon='Cloak.dmi'
			price=100
			tradeable=0

		CloakHoodless
			name="Hoodless Cloak"
			icon='Cloak-Hoodless.dmi'
			price=100
			tradeable=0

		Suit
			name="Fancy Suit"
			icon='MystTux.dmi'
			rare=1

		Temari_Suit
			name="Temari Suit"
			icon='Temari_Suit.dmi'
			price=100
			tradeable=0

		Akatsuki_Cloak
			name="Akatsuki Cloak"
			icon='AkatsukiCloak_AK.dmi'
			rare=0
			price=100
			tradeable=0
			Second
				icon='AkatCloak.dmi'
			Collar
				icon='AkatCloak-Collar.dmi'
			Open
				icon='AkatCloak-Open.dmi'
			Torn
				icon='AkatCloak-Torn.dmi'

		Baki_Suit
			name="Baki Suit"
			icon='Baki_Suit.dmi'
			price=100
			tradeable=0

		YondaimeCloak
			name="Yondaime Cloak"
			icon='Yondaime-Cloak.dmi'
			price=40000
			tradeable=0

		VioleRobe
			name="Viole's Robe"
			icon='Viole-Robe.dmi'
			price=40000
			tradeable=0

		Tobi_Suit
			name="Tobi Robe"
			icon='Tobi-Robe.dmi'
			price=100
			tradeable=0

		RedVest
			name="Red Vest"
			icon='Jiraiya_vest.dmi'
			price=10

		ANBUVest
			name="Anbu Vest"
			icon='ANBUArmor.dmi'
			price=10
			tradeable=0

		ChuuninVest
			name="Chuunin Vest"
			icon='ChuBase.dmi'
			price=10
			tradeable=0
			Cloud
				icon='ChuCloud.dmi'
			Grass
				icon='ChuLeaf.dmi'
			Leaf
				icon='ChuLeaf.dmi'
			Mist
				icon='ChuMist.dmi'
			Rain
				icon='ChuRain.dmi'
			Waterfall
				icon='ChuWaterfall.dmi'
			Rock
				icon='ChuRock.dmi'
			Sand
				icon='ChuSand.dmi'
			Sound
				icon='ChuSound.dmi'

		JouninVest
			name="Jounin Vest"
			price=10
			tradeable=0
			Cloud
				icon='Jounin_Cloud.dmi'
			Grass
				icon='Jounin_Grass.dmi'
			Leaf
				icon='Jounin_Leaf.dmi'
			Mist
				icon='Jounin_Mist.dmi'
			Rain
				icon='Jounin_Mist.dmi'
			Rock
				icon='Jounin_Sand.dmi'
			Sand
				icon='Jounin_Sand.dmi'
			Sound
				icon='Jounin_Sound.dmi'
			Waterfall
				icon='Jounin_Mist.dmi'

		V_Suit
			name="V Suit"
			rare=1
			tradeable=0
			icon='V.dmi'
			price=12
			verb
				Customise()
					CustomiseClothes(usr,'V.dmi')

	Armour
		BlueArmour
			name="Tobirama Armour"
			icon='Tobirama-Chest.dmi'
			price=5000
			New()
				..()
				var/icon/C = icon(icon)
				C.Blend(icon('Tobirama-Shoulders.dmi'),ICON_OVERLAY)
				icon = C
		RedArmour
			name="Senju Armour"
			icon='Hashi-Chest.dmi'
			price=5000
			New()
				..()
				var/icon/C = icon(icon)
				C.Blend(icon('Hashi-Shoulders.dmi'),ICON_OVERLAY)
				icon = C
		UchihaArmour
			name="Uchiha Armour"
			icon='Madara-Chest.dmi'
			price=5000

	Hands
		layer=GLOVE_LAYER
		Gauntlets
			name="Gauntlets"
			icon='JGauntlet.dmi'
			rare=1
		ANBUBracers
			name="Anbu Bracers"
			icon='ANBUGloves.dmi'
			price=10
			tradeable=0

	Face
		layer=FACE_LAYER
		KakashiMask
			name="Mouth Mask"
			icon='KakashiMask.dmi'
			price=10
			verb
				Customise()
					CustomiseClothes(usr,'KakashiMask.dmi')
		Sunglasses
			name="Sunglasses"
			icon='Sunnies.dmi'
			price=10
		Spectacles
			name="Spectacles"
			icon='Spectacles.dmi'
			price=10
		Tobi_Mask
			name="Tobi Mask"
			icon='TobiMask.dmi'
			mask=1
			price=1000
		Madara_Mask
			name="Madara Mask"
			icon='Madara-Mask.dmi'
			mask=1
			price=1000
			New()
				..()
				var/icon/C = icon(icon)
				C.Blend(icon('Madara-Mask-Sash.dmi'),ICON_OVERLAY)
				icon = C
		ANBUMask
			name="Anbu Mask"
			price=10
			mask=1
			tradeable=0
			New()
				icon=pick('ANBUMask01.dmi','ANBUMask02.dmi','ANBUMask03.dmi','ANBUMask04.dmi','ANBUMask05.dmi','ANBUMask06.dmi','ANBUMask07.dmi','ANBUMask08.dmi')
	Head
		layer=HAT_LAYER
		Hat
			name="hat"
			icon='Hat.dmi'
			price=10
			verb
				Customise()
					CustomiseClothes(usr,'Hat.dmi')
		KageHat
			layer=HAT_LAYER
			rare=1
			Rock
				name="Kage Hat"
				icon='RockHat.dmi'
			Cloud
				name="Kage Hat"
				icon='CloudHat.dmi'
			Leaf
				name="Kage Hat"
				icon='LeafHat.dmi'
			Mist
				name="Kage Hat"
				icon='MistHat.dmi'
			Sand
				name="Kage Hat"
				icon='SandHat.dmi'
			Grass
				name="Kage Hat"
				icon='GrassHat.dmi'
			Rain
				name="Kage Hat"
				icon='RainHat.dmi'
			Sound
				name="Kage Hat"
				icon='SoundHat.dmi'
			Waterfall
				name="Kage Hat"
				icon='WaterfallHat.dmi'
/**********************************************************************************************************/

mob/proc
	WearClothes(obj/O)
		if(O.worn)
			src<<"You remove the [O.name]"
			overlays -= O.Overlay
			O.worn=0
			O.suffix=null
			if(O.mask)
				name = trueName
				wearingMask=0
				Set_Float()
		else if(!O.worn)
			src<<"You wear the [O.name]"
			if(O.name=="Akatsuki Outfit")
				if(isZetsu)
					O.icon='zetsu_suit.dmi'
			if(!O.Overlay)
				O.Overlay = new/Overlay_Obj(O.icon,O.layer)
			overlays+=O.Overlay
			O.worn=1
			O.suffix="Equipped"
			if(O.mask)
				//name = "???"
				wearingMask=1
				//maptext = "<center><B>???</B></center>"
		StatUpdate_SelfImage()
		UpdateInventory()

	DropClothes(obj/O)
		O.OnSpeedRail=null
		SpeedRailSlotsUsed[O.ItemSlot]=0
		if(O.worn)
			overlays-=O.Overlay
			O.worn=0
			O.suffix=null
			if(O.mask)
				name = trueName
				wearingMask=0
		if(O.rare)
			switch(input("This item can not be dropped, do you want to delete it?","Rare Item")in list("Yes","No"))
				if("Yes")
					src<<"The [O.name] withers away..."; del(O)
		else
			src<<"You drop the [O.name]"; O.loc=loc;
		UpdateInventory()

	GetClothes(obj/O)
		src<<"You pick up the [O.name]"; O.loc=src; O.worn=0; O.suffix=null; UpdateInventory()

obj/proc
	CustomiseClothes(mob/U, var/icon/garment)
		var/clr=input(U,"What colour would you like your [name] to be?","Customise") as color
		if(clr)
			if(worn)
				U.overlays-=Overlay
			var/newgarment=garment
			newgarment += clr
			icon = newgarment
			Overlay = new/Overlay_Obj(icon,layer)
			if(worn)
				U.overlays+=Overlay
			U.UpdateInventory()