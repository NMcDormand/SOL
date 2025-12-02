obj/Item/Class/Fan
	name="Fan"
	trueName="Fan"
	icon='Fan.dmi'
	icon_state="inventory"
	price=0
	tradeable=0
	Unbreakable=1
	atkspeed=5
	wielding="Fan"
	Durability=9999999
	MaxDurability=9999999
	layer = WEAPON_LAYER
	Click()
		if(src in usr.contents)
			if(OnSpeedRail) Equip_Remove()
			else usr.ItemStats(src)
	Get()
		set src in oview(1)
		if(usr.Class["Fan-Nin"])
			var/obj/Item/Class/Fan/f=locate() in src
			if(!f)
				usr<<"You pick up the [name]"
				loc = usr
				worn = 0
				usr.UpdateInventory()
			else
				usr<<"You already have a fan!"
	verb
		DurabilityCheck()
			usr.DurabilityCheckProc(src)
		Equip_Remove()
			set name="Equip/Remove"
			usr.EquipRemove_Weapon(src,icon)

obj/Jutsu/Class/Fan
	layer = MOB_LAYER+1

	New(LOC, mob/O, WE, NIN)
		if(!O)
			return
		Owner = O
		loc = LOC
		if(!NIN)
			NIN = O.Ninjutsu
		Ninjutsu=O.Ninjutsu
		if(!WE)
			WE = O.WindElemental
		WindElemental=WE
		dir=O.dir
		spawn(30)
			del src
		..()
	Del()
		walk(src,0)
		Owner = null
		loc = null
		spawn(10)
			..()

	Kamaitachi
		name="Kamaitachi"
		icon='Kamaitachi.dmi'
		density=1
		Power=1
		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A))
				if(istype(A,/mob/Hittable/Command/Genjutsu/FakeView))
					density = 0
					spawn(1)
						density = 1
				else
					var/damage
					var/mob/O=Owner
					if(!O)
						del src
					var/mob/M=A
					loc=M.loc
					if(M.kaiten||M.MushiKabe||M.InMeatTank||M.protect||M.InGatsuuga||M.InTsuuga||M.InGarouga||M.Village=="Admin") del(src)
					if(O==M) return
					if(O.HitCheck(M))
						damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WindElemental,M.FireElemental,Power)
						//DamageMessage(M,damage,name)
						if(M.Blown!=O.name)
							M.DamageMe(O,damage,src)
							if(M)
								if(!M.TreeStump && !istype(M,/mob/Hittable/Unresponsive/Training))
									M.BlowAway(damage,src)
					else {O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."}
			else if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)
			else if(isobj(A))
				var/obj/o = A
				if(istype(o,/obj/Destructable))
					var/damage
					var/mob/O=Owner
					var/SE=0
					if(o.EarthElemental&&!o.FireElemental) SE=1
					damage=JutsuDamage(Ninjutsu,o.Ninjutsu,WindElemental,o.FireElemental,Power,SE)
					o.Destroy(damage,O); del(src)
				else if(istype(o,/obj/Jutsu/))
					if(!o.FireElemental) ObjBlowAway(o)
					else JutsuClash_Wind(src,o)
				else if(istype(o,/obj/Weapon/Wield/))
					ObjBlowAway(o)
				else
					del(src)

	Daikamaitachi
		name="Daikamaitachi"
		icon='Daikama.dmi'
		density=1
		Power=2
		Bump(A)
			if(!Owner)
				del src
				return
			if(istype(A,/mob/Hittable/Command/Genjutsu/FakeView))
				density = 0
				spawn(1)
					density = 1
			else if(ismob(A)||(isobj(A)&&istype(A,/obj/Destructable)))
				var/damage
				var/mob/O=Owner
				if(ismob(A))
					if(!O)
						del src
					var/mob/M=A
					loc=M.loc
					if(M.kaiten||M.MushiKabe||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga||M.Village=="Admin") del(src)
					if(O==M) return
					if(O.HitCheck(M))
						damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WindElemental,M.FireElemental,Power)
						//DamageMessage(M,damage,name)
						if(M.Blown!=O.name)
							M.Wounds+=2;M.DamageMe(O,damage,src)
							if(M)
								if(!M.TreeStump && !istype(M,/mob/Hittable/Unresponsive/Training))
									M.BlowAway(damage,src)
					else {O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."}
				else
					var/obj/M=A
					var/SE=0
					if(M.EarthElemental&&!M.FireElemental) SE=1
					damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WindElemental,M.FireElemental,Power,SE)
					M.Destroy(damage,O); del(src)

			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)
			if(istype(A,/obj/))
				if(isobj(A))
					var/obj/o = A
					if(istype(o,/obj/Jutsu/))
						if(!o.FireElemental) ObjBlowAway(o)
						else JutsuClash_Wind(src,o)
					if(istype(o,/obj/Weapon/Wield/))  ObjBlowAway(o)
					else del(src)

	Ookamaitachi
		name="Ookamaitachi"
		icon='Daikama.dmi'
		pixel_x=-8
		density=1
		Power=3
		New()
			..()
			var/icon/F = icon(icon,icon_state)
			F.Scale(48,48)
			icon = F
		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A))
				if(istype(A,/mob/Hittable/Command/Genjutsu/FakeView))
					density = 0
					spawn(1)
						if(src)
							density = 1
				else
					var/mob/O=Owner
					if(O)
						var/damage
						var/mob/M=A
						loc=M.loc
						if(M.kaiten||M.MushiKabe||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
						if(O==M) return
						if(O.HitCheck(M))
							damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WindElemental,M.FireElemental,Power)
							//DamageMessage(M,damage,name)
							if(!M)
								return
							if(M.Blown!=O.name)
								M.Wounds+=10;M.DamageMe(O,damage,src)
								if(M)
									if(!M.TreeStump && !istype(M,/mob/Hittable/Unresponsive/Training))
										M.BlowAway(damage,src)
							for(var/obj/Jutsu/Class/Fan/Ookamaitachi/OK in orange(5,src))
								if(OK==src)
									continue
								if(OK.Owner == O)
									walk_towards(OK,M)
						else {O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."}
					del src
			else if(isturf(A))
				var/turf/T = A
				if(T.density) del(src)
			else if(isobj(A))
				if(istype(A,/obj/Destructable))
					var/obj/M=A
					var/mob/O=Owner
					var/SE=0
					if(M.EarthElemental&&!M.FireElemental) SE=1
					var/damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WindElemental,M.FireElemental,Power,SE)
					M.Destroy(damage,O); del(src)
				else
					var/obj/o = A
					if(istype(o,/obj/Jutsu/)) JutsuClash_Wind(src,o)
					if(istype(o,/obj/Weapon/Wield/)) del(o)
					else del(src)

	Ooshigoto
		name="Ooshigoto"
		icon='Tornado.dmi'
		icon_state="Flipped"
		density=0
		layer=MOB_LAYER+1
		Power=5
		New()
			..()
			var/icon/F = icon(icon,icon_state)
			F.Scale(96,96)
			icon = F
			pixel_x=-32
		Cross(A)
			if(istype(A,/mob/Hittable/Command/Genjutsu/FakeView))
				..()
			else if(ismob(A))
				var/damage
				var/mob
					M=A; O=Owner
				if(M.kaiten||M.MushiKabe||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
				if(O==M) return
				if(O.HitCheck(M))
					damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WindElemental,M.FireElemental,Power)
					//DamageMessage(M,damage,name); M.Wounds+=10
					M.DamageMe(O,damage,src)
					walk_towards(src,M)
					spawn(20)
						del(src)
				else {O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."}
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)
			if(istype(A,/obj/))
				if(isobj(A))
					var/obj/o = A
					if(istype(o,/obj/Jutsu/)) del(o)
					if(istype(o,/obj/Weapon/Wield/)) del(o)
					else del(src)
			..()
		Bump(A)
			if(!Owner)
				del src
				return
			if(istype(A,/mob/Hittable/Command/Genjutsu/FakeView))
				..()
			else if(ismob(A))
				var/damage
				var/mob
					M=A; O=Owner
				if(O)
					if(M.kaiten||M.MushiKabe||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
					if(O==M) return
					if(O.HitCheck(M))
						damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WindElemental,M.FireElemental,Power)
						//DamageMessage(M,damage,name); M.Wounds+=10
						M.DamageMe(O,damage,src)
						walk_towards(src,M)
					else {O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."}
				spawn(20)
					del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)
			if(istype(A,/obj/))
				if(isobj(A))
					var/obj/o = A
					if(istype(o,/obj/Jutsu/)) del(o)
					if(istype(o,/obj/Weapon/Wield/)) del(o)
					else del(src)
			..()


//--------------------------------------------------------------------------------------------------------
obj/var/notblowable
mob/var/tmp/Blown

mob/proc/BlowAway(var/d,obj/o)
	var/dist
	var/mob/O=o.Owner
	Blown=O.name
	if(d>StaminaMax*0.12) dist=rand(7,15)
	else if(d>StaminaMax*0.05) dist=rand(5,12)
	else dist=rand(3,7)
	spawn(dist) Blown=null
	spawn()
		while(Blown==O.name)
			dir=get_dir(src,O); step_away(src,O); dir=get_dir(src,O)
			sleep(pick(1,2))


obj/proc
	ObjBlowAway(obj/O)
		if(O.notblowable) return
		step_away(O,src)
		spawn(2)if(O)ObjBlowAway(O)