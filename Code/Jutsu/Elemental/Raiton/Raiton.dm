mob
	var/tmp
		RaitonArmour = 0
		RaitonCurrent = 0
	proc
		RaitonStun(A=10)
			set waitfor = 0
			RaitonCurrent++
			sleep(A)
			if(src)
				RaitonCurrent--

obj/Jutsu/Raiton
	notblowable=1
	Raikyuu
		name="Raikyuu"
		icon='Raitons.dmi'
		icon_state="Raikyuu"
		density=1
		movespeed=0
		Power=4
		Bump(A)
			if(!Owner)
				del src
				return
			if(isturf(A))
				var/turf/T = A
				if(T.density)
					del(src)
			else if(ismob(A))
				var/damage
				var/mob/O=Owner
				if(ismob(A))
					var/mob/M=A
					if(M.kaiten||M.MushiKabe||M.InMeatTank||M.protect||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
					if(O==M) {loc=M.loc; return}
					if(O.HitCheck(M))
						damage=JutsuDamage(Ninjutsu,M.Ninjutsu,LightningElemental,M.EarthElemental,Power)
						M.DamageMe(O,damage,src)
						if(M)
							M.RaitonStun()
					else {O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."}
					del(src)
			else if(istype(A,/obj/Destructable))
				var/damage
				var/mob/O=Owner
				var/obj/M=A
				var/SE=0
				if(M.WaterElemental&&!M.EarthElemental) SE=1
				damage=JutsuDamage(Ninjutsu,M.Ninjutsu,LightningElemental,M.EarthElemental,Power,SE)
				M.Destroy(damage,O); del(src)
			else if(isobj(A))
				var/obj/o = A
				if(istype(o,/obj/Jutsu))
					if(istype(o,type) && o.Owner == Owner)
						return
					else
						JutsuClash_Lightning(src,o)
				else if(istype(o,/obj/Weapon/Wield)) del(o)
				else del(src)

	RairyuunoTatsumaki
		name="Rairyuuno Tatsumaki"
		icon='Raitons.dmi'
		icon_state="RairyuunoTatsumaki"
		density=1
		movespeed=1
		Power=3
		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A)||(isobj(A)&&istype(A,/obj/Destructable)))
				var/damage
				var/mob/O=Owner
				if(ismob(A))
					var/mob/M=A
					if(target!=M) {loc=M.loc; return}
					if(M.kaiten||M.MushiKabe||M.InMeatTank||M.protect||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
					if(O.HitCheck(M))
						damage=JutsuDamage(Ninjutsu,M.Ninjutsu,LightningElemental,M.EarthElemental,Power)
						M.DamageMe(O,damage,src)
						if(M)
							M.RaitonStun()
					else {O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."}
					del(src)
				else
					var/obj/M=A
					var/SE=0
					if(M.WaterElemental&&!M.EarthElemental) SE=1
					damage=JutsuDamage(Ninjutsu,M.Ninjutsu,LightningElemental,M.EarthElemental,Power,SE)
					M.Destroy(damage,O); del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)
			if(istype(A,/obj/))
				if(isobj(A))
					var/obj/o = A
					if(istype(o,/obj/Jutsu))
						if(istype(o,type) && o.Owner == Owner)
							return
						else
							JutsuClash_Lightning(src,o)
					else if(istype(o,/obj/Weapon/Wield)) del(o)
					else del(src)