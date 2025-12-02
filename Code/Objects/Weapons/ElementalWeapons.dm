mob/var/tmp/infused
obj/Weapon/Wield/Elemental
	NotCreatable=1
	Kunai
		name="Elemental Kunai"
		trueName="Elemental Kunai"
		icon='ElementalKunai.dmi'
		icon_state="inventory"
		price=4000
		Durability=3000
		MaxDurability=3000
		atkspeed=3
		wielding="Kunai"
		Click()
			..()
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
				if(usr.ChakraControl<100) usr<<"You cannot control your chakra well enough to wield this weapon."
				else if(!usr.throwing) usr.EquipRemove_Weapon(src,icon)

			Drop()
				usr.DropWeapon(src,icon)

			Charge_Primary()
				set name="Infuse: Primary"
				usr.PrimaryInfuse(src)

			Charge_Secondary()
				set name="Infuse: Secondary"
				usr.SecondaryInfuse(src)

	Katana
		name="Elemental Katana"
		trueName="Elemental Katana"
		icon='ElementalKatana.dmi'
		icon_state="inventory"
		price=6000
		Durability=5200
		MaxDurability=5200
		atkspeed=5
		wielding="Katana"
		Click()
			..()
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
				if(usr.ChakraControl<100) {usr<<"You cannot control your chakra well enough to wield this weapon."; return}
				if(usr.SwordSkill>550) atkspeed=4
				else atkspeed=5
				usr.EquipRemove_Weapon(src,icon)

			Drop()
				usr.DropWeapon(src,icon)

			Charge_Primary()
				set name="Infuse: Primary"
				usr.PrimaryInfuse(src)

			Charge_Secondary()
				set name="Infuse: Secondary"
				usr.SecondaryInfuse(src)


	BroadSword
		name="Elemental Broad Sword"
		trueName="Elemental Broad Sword"
		icon='ElementalBroadSword.dmi'
		layer=FLOAT_LAYER+6
		icon_state="inventory"
		price=12000
		Durability=6800
		MaxDurability=6800
		atkspeed=7
		wielding="Broad Sword"
		Click()
			..()
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
				if(usr.ChakraControl<100) {usr<<"You cannot control your chakra well enough to wield this weapon."; return}
				if(usr.SwordSkill>650) atkspeed=5
				else atkspeed=7
				usr.EquipRemove_Weapon(src,icon)

			Drop()
				usr.DropWeapon(src,icon)

			Charge_Primary()
				set name="Infuse: Primary"
				usr.PrimaryInfuse(src)

			Charge_Secondary()
				set name="Infuse: Secondary"
				usr.SecondaryInfuse(src)

mob/proc
	InfuseDrain(obj/w)
		while(infused)
			Chakra-=300
			if(Chakra<1||!w.worn||!w||w.Durability<1)
				src<<"You are no longer infusing your [w.name]."
				infused=null
			sleep(30)


	PrimaryInfuse(obj/o)
		if(infused==PE)
			src<<"You are no longer infusing your [o.name]."
			infused=null
		else
			src<<"You infuse your [o.name] with [PE] chakra."
			if(!infused)
				spawn(2) InfuseDrain(o)
			infused=PE

	SecondaryInfuse(obj/o)
		if(infused==SE)
			src<<"You are no longer infusing your [o.name]."
			infused=null
		else
			src<<"You infuse your [o.name] with [SE] chakra."
			if(!infused)
				spawn(2) InfuseDrain(o)
			infused=SE