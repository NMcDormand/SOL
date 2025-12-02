var/LegendarySwordsList[] = list("One", "Two", "Three", "Four", "Five", "Six", "Seven")

mob/proc
	FoundLegendarySword(sword)
		switch(sword)
			if("Samehada")
				if(isnull(LegendarySwordsList["Four"]))
					LegendarySwordsList["Four"]=ckey
					world<<"<b><font size=2 color=#14DBFF>[name] has just found the <i>Samehada</i></b></font>"

	CheckLegendarySword(sword)
		switch(sword)
			if("Samehada")
				if(ckey == LegendarySwordsList["Four"]) {return 1}


proc
	LoadSwords()
		if(fexists("Data/Wipe/SevenSwords.sav"))
			var/savefile/F = new ("Data/Wipe/SevenSwords.sav")
			F["LSwords"]>>LegendarySwordsList

	SaveSwords()
		if(TotalSavePrevention) return
		var/savefile/F = new("Data/Wipe/SevenSwords.sav")
		F["LSwords"]<<LegendarySwordsList

obj/Weapon/Wield/
	Samehada
		name="Samehada"
		trueName="Samehada"
		icon='Samehada.dmi'
		icon_state="Outside"
		layer=WEAPON_LAYER
		NotCreatable=1
		NotSellable = 1
		price=2000
		rare=1
		tradeable=0
		Durability=8000
		MaxDurability=8000
		Unbreakable = 1
		atkspeed=10
		wielding="Samehada"
		Click()
			if(src in usr.contents)
				if(OnSpeedRail) Equip_Remove()
				else usr.ItemStats(src)
			else
				if(usr.clicked_item) return
				usr.clicked_item = 1
				spawn(10) usr.clicked_item = 0
				Get()
		proc
			SamehadaDrain(mob/M)
				set waitfor = 0
				while(wielding == "Samehada(Unwrapped)")
					if(M)
						if(M.KO||M.dead)
							if(worn)
								M.overlays -= Overlay
							icon = 'Samehada.dmi'
							wielding = "Samehada"
							Overlay = new/Overlay_Obj(icon,layer)
							if(worn)
								M.overlays += Overlay
								M.wielding = wielding
							break
						else
							if(M.Chakra >= 2000)
								M.Chakra -= 2000
								M.StatUpdate_chakra()
							else
								M.DamageMe(M,pick(3000,4000,5000),"Samehada Self")
					else
						return
					sleep(20)
		verb
			ClearOverlay()
				Overlay = 0
			Wrap()
				set name="Un/Wrap"
				set src in usr
				if(worn)
					usr.overlays -= Overlay
				if(wielding == "Samehada")
					icon = 'Samehada-Out.dmi'
					wielding = "Samehada(Unwrapped)"
					usr << "Unwrapped the Samehada, it begins to eat away at your chakra"
					Overlay = null
					Overlay = new/Overlay_Obj('Samehada-Out.dmi',layer)
					if(worn)
						usr.overlays += Overlay
						usr.wielding = wielding
					SamehadaDrain(usr)
				else
					icon = 'Samehada.dmi'
					wielding = "Samehada"
					usr << "Wrapped the Samehada, it stops eating away at your chakra"
					Overlay = null
					Overlay = new/Overlay_Obj('Samehada.dmi',layer)
					if(worn)
						usr.overlays += Overlay

			Equip_Remove()
				set src in usr
				set name="Equip/Remove"
				if(usr.SwordSkill>1500)
					atkspeed=5
				else
					atkspeed=10
				usr.EquipRemove_Weapon(src,icon)

			Drop()
				usr.DropWeapon(src,icon)

		Get()
			set src in oview(1)
			if(usr.Chakra<55000||usr.SwordSkill<2050)
				usr<<"The sword rejects you as it's wielder!";
				usr.DamageMe(,500,"slices",1);
			else
				usr<<"The sword embraces you as it's wielder.";
				loc = usr
				worn = 0
				usr.FoundLegendarySword("Samehada")
				usr.UpdateInventory()
				if(Dropped)
					layer = Dropped
					Dropped = 0
				else
					layer = WEAPON_LAYER

	ExecutionerBlade
		name="Executioner Blade"
		trueName="Executioner Blade"
		icon='ExecutionerBlade.dmi'
		icon_state="Outside"
		layer=WEAPON_LAYER
		NotCreatable=1
		NotSellable = 1
		rare=1
		tradeable=0
		price=1000
		Durability=6000
		MaxDurability=6000
		Unbreakable = 1
		atkspeed=9
		wielding="Executioner Blade"
		Click()
			if(src in usr.contents)
				if(OnSpeedRail) Equip_Remove()
				else usr.ItemStats(src)
			else
				if(usr.clicked_item) return
				usr.clicked_item = 1
				spawn(10) usr.clicked_item = 0
				Get()
		verb
			Equip_Remove()
				set name="Equip/Remove"
				if(usr.SwordSkill>8050)
					atkspeed=3
				else if (usr.SwordSkill>3050)
					atkspeed=6
				else atkspeed=9
				usr.EquipRemove_Weapon(src,icon)

			Drop()
				usr.DropWeapon(src,icon)

		Get()
			set src in oview(1)
			if(usr.Taijutsu<50000||usr.SwordSkill<2000)
				usr<<"It's too heavy to lift!"
			else
				usr<<"You take the Executioner Blade.";
				loc = usr
				worn = 0
				if(Dropped)
					layer = Dropped
					Dropped = 0
				else
					layer = WEAPON_LAYER

	Shibuki
		name="Shibuki"
		trueName="Shibuki"
		icon='Shibuki.dmi'
		icon_state="Outside"
		layer=WEAPON_LAYER
		NotCreatable=1
		NotSellable = 1
		rare=1
		tradeable=0
		price=1000
		Durability=6000
		MaxDurability=6000
		Unbreakable = 1
		atkspeed=9
		wielding="Shibuki"
		Click()
			if(src in usr.contents)
				if(OnSpeedRail) Equip_Remove()
				else usr.ItemStats(src)
			else
				if(usr.clicked_item) return
				usr.clicked_item = 1
				spawn(10) usr.clicked_item = 0
				Get()
		verb
			Equip_Remove()
				set name="Equip/Remove"
				if(usr.SwordSkill>8050)
					atkspeed=3
				else if (usr.SwordSkill>3050)
					atkspeed=6
				else atkspeed=9
				usr.EquipRemove_Weapon(src,icon)

			Drop()
				usr.DropWeapon(src,icon)

		Get()
			set src in oview(1)
			if(usr.Taijutsu<40000||usr.Ninjutsu<50000||usr.SwordSkill<1500)
				usr<<"It's too heavy to lift!"
			else
				usr<<"You embrace the power of Shibuki.";
				loc = usr
				worn = 0
				if(Dropped)
					layer = Dropped
					Dropped = 0
				else
					layer = WEAPON_LAYER

	Nuibari
		name="Nuibari"
		trueName="Nuibari"
		icon='Nuibari.dmi'
		icon_state="Outside"
		layer=WEAPON_LAYER
		NotCreatable=1
		rare=1
		tradeable=0
		price=1000
		NotSellable = 1
		Durability=6000
		MaxDurability=6000
		Unbreakable = 1
		atkspeed=2
		wielding="Nuibari"
		Click()
			if(src in usr.contents)
				if(OnSpeedRail) Equip_Remove()
				else usr.ItemStats(src)
			else
				if(usr.clicked_item) return
				usr.clicked_item = 1
				spawn(10) usr.clicked_item = 0
				Get()
		verb
			Equip_Remove()
				set name="Equip/Remove"
				if(usr.SwordSkill>8050)
					atkspeed=3
				else if (usr.SwordSkill>3050)
					atkspeed=6
				else atkspeed=9
				usr.EquipRemove_Weapon(src,icon)

			Drop()
				usr.DropWeapon(src,icon)

		Get()
			set src in oview(1)
			if(usr.movespeed > 0.9||usr.SwordSkill<3000)
				usr<<"It's too Nimble to lift!"
			else
				usr<<"You feel the elegance of Nuibari.";
				loc = usr
				worn = 0
				if(Dropped)
					layer = Dropped
					Dropped = 0
				else
					layer = WEAPON_LAYER

	Samehada2
		name="Samehada"
		trueName="Samehada"
		icon='Samehada.dmi'
		icon_state="inventory"
		layer=WEAPON_LAYER
		NotCreatable=1
		price=0
		rare=1
		Durability=1
		MaxDurability=1
		atkspeed=10
		tradeable=0
		wielding="Samehada"
		Click()
			if(src in usr.contents)
				if(OnSpeedRail) Equip_Remove()
				else usr.ItemStats(src)
			else
				if(usr.clicked_item) return
				usr.clicked_item = 1
				spawn(10) usr.clicked_item = 0
				Get()
		verb
			Equip_Remove()
				set name="Equip/Remove"
				usr<<"<b>It was just an imitation and disintegrates as you touch it, hunt is still on for the real one!</b>"
				del(src); usr.UpdateInventory()

			Drop()
				usr.DropWeapon(src,icon)

		Get()
			set src in oview(1)
			usr<<"<b>Your heart beats faster as you feel the raw chakra emanating from this object! Could it be...</b>";
			loc = usr
			worn = 0
			usr.FoundLegendarySword("Samehada")
			if(Dropped)
				layer = Dropped
				Dropped = 0
			else
				layer = WEAPON_LAYER
