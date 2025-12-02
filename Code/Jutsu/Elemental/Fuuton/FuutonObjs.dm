obj/Jutsu/Fuuton
	Renkoudan
		name="Renkoudan"
		icon = 'Renkoudan.dmi'
		density = 0
		movespeed=2
		Power=4
		icon_state="main"
		bound_width = 96
		bound_height = 96
		layer = MOB_LAYER+1
		CrossedMe(var/atom/A)
			if(istype(A,/turf))
				var/turf/T = A
				if(T.density)
					del src
			else if(ismob(A))
				var/mob/M=A
				if(A==Owner||M.Creator == Owner)
					return
				if(!(M.kaiten||M.MushiKabe||M.InMeatTank||M.protect||M.InGatsuuga||M.InTsuuga||M.InGarouga))
					var/mob/O=Owner
					if(O.HitCheck(M))
						var/damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WindElemental,M.FireElemental,Power)
						//DamageMessage(M,damage,name)
						M.DamageMe(O,damage,src)
						Ninjutsu*=0.5; WindElemental*=0.5
					else
						O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."
			else if(istype(A,/obj/Destructable))
				var/obj/M=A
				var/SE=0
				if(M.EarthElemental&&!M.FireElemental) SE=1
				var/damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WindElemental,M.FireElemental,Power,SE)
				var/mob/O=Owner
				M.Destroy(damage,O)
				//del(src)
			else if(istype(A,/obj/Jutsu))
				var/obj/o=A
				if(istype(o,type) && o.Owner == Owner)
					return
				else
					JutsuClash_Wind(src,A)
			else if(istype(A,/obj/Weapon/Wield))
				del A
				//else if(o.Owner!=Owner) del(src)
			if(src)
				if(Targeting == A)
					del src

	Daitoppa
		name="Daitoppa"
		icon = 'Daitoppa.dmi'
		density = 1
		Power=2
		Bump(A)
			if(!Owner)
				del src
				return
			if(Targeting != A)
				density = 0
				spawn(2)
					if(src)
						density = 1
			if(A==Owner)
				return
			if(ismob(A)||(isobj(A)&&istype(A,/obj/Destructable)))
				var/damage
				var/mob/O=Owner
				if(ismob(A))
					var/mob/M=A
					if(M.kaiten||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
					if(M==O) {loc=M.loc; return}
					if(O.HitCheck(M))
						damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WindElemental,M.FireElemental,Power)
						M.DamageMe(O,damage,src)	//called up to 4 times
					else
						O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."
					//del(src)
				else
					var/obj/M=A
					var/SE=0
					if(M.EarthElemental&&!M.FireElemental) SE=1
					damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WindElemental,M.FireElemental,Power,SE)
					M.Destroy(damage,O)
					//del(src)

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
							JutsuClash_Wind(src,o)
					else if(istype(o,/obj/Weapon/Wield)) del(o)
					//else del(src)
			if(src)
				if(Targeting == A)
					del src