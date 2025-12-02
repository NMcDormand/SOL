obj/Weapon/Wield/ANBUKatana
	name="Anbu Katana"
	trueName="Anbu Katana"
	icon='ANBUKatana2.dmi'
	icon_state="inventory"
	Unbreakable=1
	price=0
	tradeable=0
	atkspeed=5
	wielding="Katana"
	NotSellable=1
	Durability=19999
	Click()
		if(!(src in usr.contents)) Get()
		else
			if(OnSpeedRail) Equip_Remove()
			else usr.ItemStats(src)
	verb
		DurabilityCheck()
			usr.DurabilityCheckProc(src)
		Equip_Remove()
			set name="Equip/Remove"
			if(usr.SwordSkill>500) atkspeed=4
			else atkspeed=5
			usr.EquipRemove_Weapon(src,icon)
		Drop()
			usr.DropWeapon(src,icon)