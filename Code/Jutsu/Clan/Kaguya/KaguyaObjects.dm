obj/var/bones
obj/Weapon/Wield/
	DualBoneKunai
		name="Dual Bone Kunai"
		trueName="Dual Bone Kunai"
		icon='DualBoneKunai.dmi'
		icon_state="inventory"
		Durability=200
		MaxDurability=200
		atkspeed=3
		tradeable=0
		NotSellable=1
		wielding="Dual Bone Kunais"
		bones=1
		Click()
			if(src in usr.contents)
				if(OnSpeedRail) Equip_Remove()
				else usr.ItemStats(src)
		verb
			Equip_Remove()
				set name="Equip/Remove"
				usr.EquipRemove_Weapon(src,icon)
			Discard()
				if(worn) {usr << "Unequip the [name] first."; return}
				else {loc=null; usr.UpdateInventory(); del(src)}

	BoneSword
		name="Bone Sword"
		trueName="Bone Sword"
		icon='BoneSword.dmi'
		NotSellable=1
		Durability=400
		MaxDurability=400
		atkspeed=3
		tradeable=0
		wielding="Bone Sword"
		bones=1
		Click()
			if(src in usr.contents)
				if(OnSpeedRail) Equip_Remove()
				else usr.ItemStats(src)
		verb
			Equip_Remove()
				set name="Equip/Remove"
				usr.EquipRemove_Weapon(src,icon)
			Discard()
				if(worn) {usr << "Unequip the [name] first."; return}
				else {loc=null; usr.UpdateInventory(); del(src)}

//------------------------------------------------------------------------------------------------------------

	SpineWhip
		name="Spine Whip"
		trueName="Spine Whip"
		icon='SpineWhip.dmi'
		Durability=800
		MaxDurability=800
		atkspeed=5
		NotSellable=1
		tradeable=0
		wielding="Spine Whip"
		bones=1
		Click()
			if(src in usr.contents)
				if(OnSpeedRail) Equip_Remove()
				else usr.ItemStats(src)
		verb
			Equip_Remove()
				set name="Equip/Remove"
				usr.EquipRemove_Weapon(src,icon)

			Discard()
				if(worn) {usr << "Unequip the [name] first."; return}
				else {loc=null; usr.UpdateInventory(); del(src)}

//------------------------------------------------------------------------------------------------------------
obj/Jutsu/Kaguya
	TeshiSendan
		name="Teshi Sendan"
		icon = 'Hessendan.dmi'
		density = 1
		notblowable=1
		Power=5
		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A)||(isobj(A)&&istype(A,/obj/Destructable)))
				var/damage
				var/mob/O=Owner
				if(ismob(A))
					var/mob/M=A
					if(M.kaiten||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
					if(M==O) {loc=M.loc; return}
					if(O.HitCheck(M))
						damage=JutsuDamage(Taijutsu,M.Taijutsu,,,Power)
						M.DamageMe(O,damage,src)
					else {O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."}
					del(src)
				else
					var/obj/M=A
					damage=JutsuDamage(Taijutsu,M.Taijutsu,,,Power)
					M.Destroy(damage,O); del(src)

			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)
			if(istype(A,/obj/)) del(src)

//------------------------------------------------------------------------------------------------------------

obj/Jutsu/Kaguya
	Sawarabi
		notblowable=1
		icon = 'SawarabiNew.dmi'
		density = 1
		layer = MOB_LAYER+1

//------------------------------------------------------------------------------------------------------------

mob/Hittable/Unresponsive/Inanimate
	Break
		CantHenge = 1
		Bone
			DamageMe(mob/M,DAMAGE,METHOD,hidemessage)
				Health-=DAMAGE
				if(Health <= 0)
					del src

			icon='Sawarabi2.dmi'
			icon_state="1"
			layer=MOB_LAYER+1
			New(turf/A,mob/M,F,T)
				loc = A
				Owner = M
				if(Owner)
					Owner.Bones += src
				Force = F
				Health = T
				..()
				spawn(4)
					icon_state="1b"
					for(var/mob/M2 in loc)
						if(M!=Owner && M!=src)
							//range(3,src)<<"[M] was hit by Sawarabi no Mai for [Health]"
							M.DamageMe(usr,Health,src)
							del src
			Del()
				icon_state="1c"
				sleep(4)
				if(Containing)
					var/mob/U = Containing
					U.InBone = 0
					U.invisibility -= 2
					U.EnteredOBJ = 0
				..()

			Cross(var/atom/movable/U)
				if(Owner == U||!U.density)
					return 1
				else
					if(istype(U,/obj/Jutsu/Shinsu))
						return 1
					else
						return 0

			Crossed(mob/U)
				if(Owner == U)
					if(!U.InBone)
						U.InBone=1
						U.invisibility += 2
						for(var/mob/M in range())
							if(M.Targeting == src)
								M.DeleteTarget()
					U.EnteredOBJ = src
					Containing = U
				..()

			Uncrossed(mob/U)
				if(Owner == U)
					U.EnteredOBJ = null
					Containing = null
				..()

			Click()
				var/mob/U = usr
				if(GENERICATTACKCHECK(U) ||U.Gokusamaisou)
					return
				if(Owner == U)
					if(U.InBone)
						U.loc = loc
						U.EnteredOBJ.Containing = null
						U.EnteredOBJ = src
						Containing = U
						for(var/mob/M in range())
							if(M.Targeting == src)
								M.DeleteTarget()
					else if(get_dist(src, U) < 2)
						U.InBone=1
						U.loc = loc
						U.EnteredOBJ=src
						Containing=U
						U.invisibility += 2
						for(var/mob/M in range())
							if(M.Targeting == src)
								M.DeleteTarget()
				..()