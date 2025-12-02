mob/var
	tmp
		clicked_item
	TMulti = 1

obj/var
	KnifeSkill
	ThrowingSkill
	Durability
	MaxDurability
	atkspeed
	Explosive
	wielding
	NotSellable
	Weight=1
	collected
	BlockDrop = 0
	Material
	Multiplier = 1

obj/Weapon
	invisibility = 5
	layer=WEAPON_LAYER
	New()
		..()
		if(isturf(loc))
			layer = MOB_LAYER-1
			Dropped = WEAPON_LAYER
	verb
		Reset_Icon()
			if(Material && Material !="")
				icon = CreWeap(src)
			else
				icon = initial(icon)
			BlockDrop = 0

		Get()
			set src in oview(1)
			if(wielding)
				usr<<"You pick up the [name]"
				loc = usr
				worn = 0
				usr.UpdateInventory()
			else
				if(collected) return
				collected=1
				var/obj/Weapon/S
				for(var/obj/Weapon/WE in usr.contents)
					if(WE.type == type && WE.Creator == Creator && WE.trueName == trueName)
						S = WE
						break
				if(!S)
					Move(usr); usr.UpdateInventory()
				else
					S.amount+=amount; S.Checkamount(); usr.UpdateInventory(); del(src)
			if(Dropped)
				layer = Dropped
				Dropped = 0
			else
				layer = initial(layer)

	Wield
		Kunai
			name="Kunai"
			trueName="Kunai"
			icon='kunai.dmi'
			icon_state="inventory"
			price=200
			Durability=1000
			MaxDurability=1000
			atkspeed=4
			wielding="Kunai"
			ItemType="Weapon"
			amount=1
			Weight=20
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
					if(usr.KnifeSkill>500) atkspeed=3
					else atkspeed=4
					usr.EquipRemove_Weapon(src,icon)

				Drop()
					usr.DropWeapon(src,icon)

				ThrowKunai()
					set category="Taijutsu"
					set name="Throw Kunai"
					if(usr.ThrowAttackCheck(src)||Durability<=0) return
					if(worn)
						usr<<"You're using it!"; return
					else
						usr.throwing=1; spawn(10) usr.throwing=0
						usr.MoveUses["KunaiThrows"]++
						usr<<"<i>You throw the kunai</i>."
						loc=null; spawn(20) del(src)
						var/obj/Weapon/Thrown/Kunai/K=new(usr.loc)
						K.Taijutsu=usr.Taijutsu; K.ThrowingSkill=usr.ThrowingSkill; K.Explosive=Explosive
						K.dir=usr.dir; K.Owner=usr; K.icon = icon; walk(K,usr.dir); K.amount-=1

						IDCOPY(K, usr)
						spawn(11) del(K)
						usr.UpdateInventory()
						usr.ApplyEXP(15,"throwing")
		Katana
			name="Katana"
			trueName="Katana"
			icon='Katana.dmi'
			icon_state="inventory"
			price=500
			Durability=1600
			MaxDurability=1600
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
					if(usr.SwordSkill>500) atkspeed=4
					else atkspeed=5
					usr.EquipRemove_Weapon(src,icon)

				Drop()
					usr.DropWeapon(src,icon)

		FryKatana
			name="Fries Katana"
			trueName="Fries Katana"
			icon='FryKatana.dmi'
			icon_state="inventory"
			price=2000
			Durability=2600
			MaxDurability=2600
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
					if(usr.SwordSkill>2000) atkspeed=2
					else atkspeed=5
					usr.EquipRemove_Weapon(src,icon)

				Drop()
					usr.DropWeapon(src,icon)

	//-------------------------------------------------------------------------------------------------------------
		BroadSword
			name="Broad Sword"
			trueName="Broad Sword"
			icon='BroadSword.dmi'
			layer=WEAPON_LAYER
			icon_state="inventory"
			price=1100
			Durability=2400
			MaxDurability=2400
			atkspeed=7
			wielding="Broad Sword"
			Click()
				..()
				if(src in usr.contents)
					if(OnSpeedRail)
						Equip_Remove()
					else
						usr.ItemStats(src)
				else
					if(usr.clicked_item) return
					usr.clicked_item = 1
					spawn(10) usr.clicked_item = 0
					Get()
			verb
				Equip_Remove()
					set name="Equip/Remove"
					if(usr.SwordSkill>600) atkspeed=5
					else atkspeed=7
					usr.EquipRemove_Weapon(src,icon)

				Drop()
					usr.DropWeapon(src,icon)

		Scythe
			name="Scythe"
			trueName="Scythe"
			icon='ScytheLeft.dmi'
			layer=WEAPON_LAYER
			icon_state="Outside"
			price=1100
			Durability=1200
			MaxDurability=1200
			atkspeed=4
			wielding="Scythe"
			Click()
				..()
				if(src in usr.contents)
					if(OnSpeedRail)
						Equip_Remove()
					else
						usr.ItemStats(src)
				else
					if(usr.clicked_item) return
					usr.clicked_item = 1
					spawn(10) usr.clicked_item = 0
					Get()
			verb
				Equip_Remove()
					set name="Equip/Remove"
					if(usr.ScytheSkill>600) atkspeed=3
					else atkspeed=4
					usr.EquipRemove_Weapon(src,icon)

				Drop()
					usr.DropWeapon(src,icon)

	/*******************************************************************************************************/

		Staff
			name="Staff"
			trueName="Staff"
			icon='Staff.dmi'
			layer=WEAPON_LAYER
			icon_state="Outside"
			price=1100
			Durability=1800
			MaxDurability=1800
			atkspeed=6
			wielding="Staff"
			Click()
				..()
				if(src in usr.contents)
					if(OnSpeedRail)
						Equip_Remove()
					else
						usr.ItemStats(src)
				else
					if(usr.clicked_item) return
					usr.clicked_item = 1
					spawn(10) usr.clicked_item = 0
					Get()
			verb
				Equip_Remove()
					set name="Equip/Remove"
					if(usr.StaffSkill>600) atkspeed=4
					else atkspeed=6
					usr.EquipRemove_Weapon(src,icon)

				Drop()
					usr.DropWeapon(src,icon)
		SageStaff
			name="Sage Staff"
			trueName="Sage Staff"
			icon='Sage-Staff.dmi'
			layer=WEAPON_LAYER
			icon_state="Outside"
			price=1100
			Durability=1800
			MaxDurability=1800
			atkspeed=6
			wielding="Sage Staff"
			Click()
				..()
				if(src in usr.contents)
					if(OnSpeedRail)
						Equip_Remove()
					else
						usr.ItemStats(src)
				else
					if(usr.clicked_item) return
					usr.clicked_item = 1
					spawn(10) usr.clicked_item = 0
					Get()
			verb
				Equip_Remove()
					set name="Equip/Remove"
					if(usr.StaffSkill>600) atkspeed=4
					else atkspeed=6
					usr.EquipRemove_Weapon(src,icon)

				Drop()
					usr.DropWeapon(src,icon)

		Spear
			name="Spear"
			trueName="Spear"
			icon='Spear.dmi'
			layer=WEAPON_LAYER
			icon_state="Outside"
			price=1100
			Durability=1800
			MaxDurability=1800
			atkspeed=6
			wielding="Staff"
			Click()
				..()
				if(src in usr.contents)
					if(OnSpeedRail)
						Equip_Remove()
					else
						usr.ItemStats(src)
				else
					if(usr.clicked_item) return
					usr.clicked_item = 1
					spawn(10) usr.clicked_item = 0
					Get()
			verb
				Equip_Remove()
					set name="Equip/Remove"
					if(usr.StaffSkill>600) atkspeed=4
					else atkspeed=6
					usr.EquipRemove_Weapon(src,icon)

				Drop()
					usr.DropWeapon(src,icon)

	/*******************************************************************************************************/
		WoodAxe
			name="Wood Axe"
			trueName="Wood Axe"
			icon='WoodAxe.dmi'
			layer=WEAPON_LAYER
			icon_state="Outside"
			price=1100
			Durability=1800
			MaxDurability=1800
			atkspeed=8
			wielding="Axe"
			Click()
				..()
				if(src in usr.contents)
					if(OnSpeedRail)
						Equip_Remove()
					else
						usr.ItemStats(src)
				else
					if(usr.clicked_item) return
					usr.clicked_item = 1
					spawn(10) usr.clicked_item = 0
					Get()
			verb
				Equip_Remove()
					set name="Equip/Remove"
					if(usr.AxeSkill>600) atkspeed=6
					else atkspeed=8
					usr.EquipRemove_Weapon(src,icon)

				Drop()
					usr.DropWeapon(src,icon)

		PickAxe
			name="Pick Axe"
			trueName="Pick Axe"
			icon='PickAxe.dmi'
			layer=WEAPON_LAYER
			icon_state="Outside"
			price=1100
			Durability=1800
			MaxDurability=1800
			atkspeed=8
			wielding="Pick Axe"
			Click()
				..()
				if(src in usr.contents)
					if(OnSpeedRail)
						Equip_Remove()
					else
						usr.ItemStats(src)
				else
					if(usr.clicked_item) return
					usr.clicked_item = 1
					spawn(10) usr.clicked_item = 0
					Get()
			verb
				Equip_Remove()
					set name="Equip/Remove"
					if(usr.AxeSkill>600)
						atkspeed=6
					else
						atkspeed=8
					usr.EquipRemove_Weapon(src,icon)

				Drop()
					usr.DropWeapon(src,icon)

	/*******************************************************************************************************/
		Gunbai
			name="Gunbai"
			trueName="Gunbai"
			icon='Gunbai.dmi'
			layer=WEAPON_LAYER
			icon_state="Outside"
			NotSellable = 1
			price=1100
			Durability=1200
			MaxDurability=1200
			atkspeed=8
			wielding="Gunbai"
			Click()
				..()
				if(src in usr.contents)
					if(OnSpeedRail)
						Equip_Remove()
					else
						usr.ItemStats(src)
				else
					if(usr.clicked_item) return
					usr.clicked_item = 1
					spawn(10) usr.clicked_item = 0
					Get()
			verb
				Equip_Remove()
					set name="Equip/Remove"
					if(usr.H2HSkill>600) atkspeed=5
					else atkspeed=8
					usr.EquipRemove_Weapon(src,icon)

				Drop()
					usr.DropWeapon(src,icon)
	/*******************************************************************************************************/
	/*******************************************************************************************************/
	Thrown
		Kunai
			name="Kunai"
			icon='kunai.dmi'
			icon_state="Thrown"
			density=1
			Bump(atom/A)
				if(!Owner)
					del src
					return
				if(ismob(A))
					var/mob/M = A
					var/mob/O=Owner
					if(M.kaiten||M.MushiKabe||M.protect) del(src)
					if(istype(A,/mob/Hittable/Responsive/Boss/Minato))
						var/mob/A2 = A
						if(!O.HasHiraishin && O.GaveSpecialScroll)
							hearers(6,A2)<<output("<b><font face=verdana color=\"[M.VillageColour]\">Minato Namikaze</font> says:</b> Thats a good start, but this is how its done!", "Chat")

							var/turf/TU = get_step(O,turn(M.dir,-180))
							if(TU)
								var/turf/HL = loc
								HL.overlays += 'Hiraishin.dmi'
								spawn(4)
									HL.overlays -= 'Hiraishin.dmi'
								A2.loc.loc.Exited(A2)
								A2.loc = TU
								if(A2.loc.loc)
									A2.loc.loc.Entered(A)
							var/obj/SkillCards/Ninjutsu/Special/Hiraishin/J=locate() in O.contents
							if(!J)
								O<<"<h2><b>You've just learned the <i>Flying Thunder God Technique</i>, Hiraishin!</b></h2>"
								new/obj/SkillCards/Ninjutsu/Special/Hiraishin(O)
								O.HasHiraishin = 1
								O.verbs += new/mob/VerbHolder/Jutsu/Hiraishin/verb/Hiraishin_Mark()
							del src
							return
					var/damage = (Taijutsu*0.09)
					damage += (damage*Multiplier)
					if(Explosive) damage+=15000
					var/knifedmg=round((damage+1)+(ThrowingSkill*7))
					//DamageMessage(M,knifedmg,name)
					M.DamageMe(O,knifedmg,src); del(src)
				if(istype(A,/turf/))
					var/turf/T = A
					if(T.density) {spawn(2)del(src)}
				if(istype(A,/obj/)) del(src)

		HKunai
			name="Kunai"
			icon='kunaiM.dmi'
			icon_state = "Thrown"
			density=1
			New(LOC,O)
				Owner = O
				loc = LOC
				..
			Bump(atom/A)
				if(A == Owner)
					return
				if(ismob(A))
					var/mob/M = A
					var/mob/O=Owner
					if(M.kaiten||M.MushiKabe||M.protect||M.Creator == O)
						del(src)
					var/damage= Taijutsu*0.09
					var/knifedmg=round((damage+1)+(ThrowingSkill*7))
					//DamageMessage(M,knifedmg,name)
					M.DamageMe(O,knifedmg,src)
					if(!Owner.KO && Owner.HEvade)
						var/turf/HL = Owner.loc
						HL.overlays += 'Hiraishin.dmi'
						spawn(4)
							HL.overlays -= 'Hiraishin.dmi'
						Owner.loc = get_step(M,turn(M.dir,-180))
						M.DamageMe(O,O.Taijutsu,"Hiraishin")
						O.HEvade = 0
				else if(!isturf(A))
					if(!Owner.KO && Owner.HEvade)
						var/turf/HL = loc
						HL.overlays += 'Hiraishin.dmi'
						spawn(4)
							HL.overlays -= 'Hiraishin.dmi'
						Owner.loc = loc
						Owner.HEvade = 0
				del(src)

//------------------------------------------------------------------------------------------------------------

		Shuriken
			name="Shuriken"
			trueName="Shuriken"
			amount=1
			Stackable = 1
			icon='shuriken.dmi'
			price=10
			New()
				Checkamount()
				..()
			Click()
				..()
				if(src in usr.contents)
					if(OnSpeedRail) ThrowShuriken()
					else usr.ItemStats(src)
				else
					if(usr.clicked_item) return
					usr.clicked_item = 1
					spawn(10) usr.clicked_item = 0
					Get()
			verb
				Drop()
					set src in usr.contents
					var/dropno = input("Drop how many [trueName]?","Drop") as num
					if(dropno<=0) return
					if(dropno>amount)
						usr<<"You don't have that many [trueName]."; return
					else
						var/obj/O = new type(usr.loc)
						O.amount = dropno
						O.collected = 0
						O.icon = icon
						O.price = price
						O.trueName = trueName
						O.Creator = Creator
						O.Multiplier = Multiplier
						O.Material = Material
						O.desc = desc
						amount -= dropno
						usr<<"You drop [dropno] [trueName]."
						Checkamount()
						O.Checkamount()
						if(amount<=0) del src
						usr.UpdateInventory()

				ThrowShuriken()
					set category="Taijutsu"
					set name="Throw Shuriken"
					set src in usr.contents
					if(usr.ThrowAttackCheck(src)) return
					usr.throwing=1; spawn(4) usr.throwing=0
					amount--
					if(amount<1) {spawn(6) del(src)}
					else Checkamount()
					usr.MoveUses["ShurikenThrows"]++
					usr<<"<i>You throw the shuriken</i>"
					var/obj/Weapon/Thrown/ThrownShuriken/S = new(usr.loc)
					S.icon = icon
					S.Taijutsu=usr.Taijutsu; S.ThrowingSkill=usr.ThrowingSkill; S.Multiplier = Multiplier
					S.dir=usr.dir; S.Owner=usr; walk(S,usr.dir)
					IDCOPY(S,usr)
					spawn(11)del(S)
					usr.UpdateInventory()
					usr.ApplyEXP(4,"throwing")

		ThrownShuriken
			name="Shuriken"
			icon='shuriken.dmi'
			density=1
			NotSellable = 1
			var/bumpDelay=0
			Bump(A)
				if(!Owner)
					del src
					return
				if(ismob(A))
					var/mob/M = A
					var/mob/O=Owner
					if(istype(M, /mob/Hittable/Unresponsive/Training/Stump)) {if(prob(40+O.Luck)) M.storedShuriken++}
					if(M.kaiten||M.MushiKabe||M.protect) del(src)
					if(M!=O) // avoid hitting yourself
						var/damage = (Taijutsu*0.06)
						damage += (damage*Multiplier)
						var/Shurikendmg=round((damage+1)+(ThrowingSkill*5))
						//DamageMessage(M,Shurikendmg,name)
						M.DamageMe(O,Shurikendmg,src); del(src)
				if(istype(A,/turf/))
					var/turf/T = A
					if(T.density) {spawn(2)del(src)}
				if(istype(A,/obj/))
					if(istype(A,/obj/Weapon/Thrown/ThrownShuriken)&&!bumpDelay)
						bumpDelay=1; spawn(10) {bumpDelay=0}
						var/obj/O = A
						if(Owner!=O.Owner)
							O.dir = turn(dir, 90); walk(O,O.dir)
							dir = turn(dir, -90); walk(src,dir)
					else
						var/obj/O = A
						if(Owner!=O.Owner) del(src)
						else loc=O.loc
			Bunshin
				pixel_x=-6
				pixel_y=-6
				New()
					pixel_x+=rand(0,12)
					pixel_y+=rand(0,12)
					flick("bunshin",src)

//-------------------------------------------------------------------------------------------------------------

mob/proc
	DurabilityCheckProc(obj/O)
		var/D = 100
		if(O.MaxDurability)
			D=round((O.Durability/O.MaxDurability)*100)
		src<<"[O.name]'s Durability: <i>[D]%</i>"

	EquipRemove_Weapon(obj/O)
		if(throwing) return
		if(O.worn)
			O.name="[O.trueName]"; src<<"You remove the [O.trueName]."
			overlays-=O.Overlay
			wielding=null; atkspeed=3
			O.worn=0
			TMulti -= O.Multiplier
			UpdateInventory()
			StatUpdate_SelfImage()
			StatUpdate_equipped()
			UpdateDurabilityMeter()
		else
			if(wielding)
				for(var/obj/Weapon/W in src)
					if(W.worn && W.wielding == wielding)
						EquipRemove_Weapon(W)
				src<<"You unequip the [wielding] first."
				//return
			if(!wielding)
				if(O.layer > -1)
					O.layer = initial(O.layer)
				if(O.Durability<=0 && !O.Unbreakable)
					return
				src<<"You equip the [O.name]";
				O.name="[O.trueName] (E)"
				if(!O.Overlay)
					O.Overlay = new/Overlay_Obj(O.icon,O.layer)
				overlays+=O.Overlay
				wielding="[O.wielding]"
				atkspeed=O.atkspeed
				O.worn=1
				UpdateInventory()
				StatUpdate_SelfImage()
				StatUpdate_equipped()
				UpdateDurabilityMeter()
				TMulti += O.Multiplier

	DropWeapon(obj/O,icon/i)
		if(O.BlockDrop)
			src << "You can't drop this weapon"
			return
		if(O.worn)
			EquipRemove_Weapon(O)
		src<<"You drop the [O.name]."
		O.loc=loc
		O.OnSpeedRail=null; SpeedRailSlotsUsed[O.ItemSlot]=0
		UpdateInventory()
		O.Dropped = O.layer
		O.layer = MOB_LAYER-1