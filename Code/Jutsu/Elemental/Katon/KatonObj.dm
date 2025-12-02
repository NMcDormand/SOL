obj/var/TailList=list()
mob/var/tmp/CentralJutsu
obj/Jutsu/Katon
	Goukakyuu
		name="Goukakyuu"
		//icon='Goukakyuu.dmi'
		icon='Katons96.dmi'
		icon_state="Goukakyuu"
		Power=2
		bound_width = 96
		bound_height = 96
		density = 0
		layer = MOB_LAYER+1
		CrossedMe(A)
			if(!Owner)
				del src
				return
			//world << "crossed [A]"
			if(ismob(A))
				var/mob/M=A
				if(A==Owner||M.Creator == Owner)
					return
				var/damage
				var/mob/O=Owner
				if(M.kaiten||M.MushiKabe||M.InMeatTank||M.protect||M.InGatsuuga||M.InTsuuga||M.InGarouga)
					del src
				if(O.HitCheck(M))
					damage=JutsuDamage(Ninjutsu,M.Ninjutsu,FireElemental,M.WaterElemental,Power)
					//DamageMessage(M,damage,name)
					M.DamageMe(O,damage,src)
					Ninjutsu*=0.5; FireElemental*=0.5
				else
					O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."
			/*else if(isturf(A))
				var/turf/T = A
				if(T.density)
					del src*/
			else if(istype(A,/obj/Destructable))
				var/damage
				var/mob/O=Owner
				var/obj/M=A
				var/SE=0
				if(M.IceElemental||(M.WindElemental&&!M.WaterElemental)) SE=1
				damage=JutsuDamage(Ninjutsu,M.Ninjutsu,FireElemental,M.WaterElemental,Power,SE)
				M.Destroy(damage,O)
			else if(istype(A,/obj/Weapon/Wield))
				del A
			else if(isobj(A))
				var/obj/o = A
				if(istype(o,/obj/Jutsu))
					if(istype(o,type) && o.Owner == Owner)
						return
					else
						JutsuClash_Fire(src,o,0)
				//else if(istype(o,/obj/Weapon/Wield))
				//else
				//	del(src)
		New(LOC,mob/O)
			loc = LOC
			Owner = O
			dir = Owner.dir
			Ninjutsu=O.Ninjutsu
			..()
		Del()
			walk(src,0)
			loc = null
			Owner = null
			spawn(10)
				..()

//------------------------------------------------------------------------------------------------------------

	Housenka
		name="Housenka"
		icon='KatonHousenka.dmi'
		density=1
		Power=0
		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A)||istype(A,/obj/Destructable))
				var/damage
				var/mob/O=Owner
				if(ismob(A))
					if(O)
						var/mob/M=A
						if(M.kaiten||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga||M.MushiKabe) del(src)
						if(M==O) {loc=M.loc; return}
						if(O.HitCheck(M))
							damage=JutsuDamage(Ninjutsu,M.Ninjutsu,FireElemental,M.WaterElemental,Power)
							M.DamageMe(O,damage,src)
							if(M && M.loc)
								for(var/obj/Jutsu/Katon/Housenka/K in range(10,src))
									if(!K.Targeting && M && M.loc)
										K.Targeting = M
										K.BetterHoming(M,M.loc)
						else {O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."}
					del(src)
				else
					var/obj/M=A
					var/SE=0
					if(M.IceElemental||(M.WindElemental&&!M.WaterElemental)) SE=1
					damage=JutsuDamage(Ninjutsu,M.Ninjutsu,FireElemental,M.WaterElemental,Power,SE)
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
							JutsuClash_Fire(src,o)
					else if(istype(o,/obj/Weapon/Wield)) del(o)
					else del(src)

//------------------------------------------------------------------------------------------------------------

	KaryuuEndan
		name="Karyuu Endan"
		icon='KatonKaryuuEndan.dmi'
		density=1
		Power=3
		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A)||(isobj(A)&&istype(A,/obj/Destructable)))
				var/damage
				var/mob/O=Owner
				if(ismob(A))
					if(O)
						var/mob/M=A
						if(M.kaiten||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga||M.MushiKabe) del(src)
						if(O==M) {loc=M.loc; return}
						if(O.HitCheck(M))
							damage=JutsuDamage(Ninjutsu,M.Ninjutsu,FireElemental,M.WaterElemental,Power)
							//DamageMessage(M,damage,name)
							M.DamageMe(O,damage,src)
						else {O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."}
					del(src)
				else
					var/obj/M=A
					var/SE=0
					if(M.IceElemental||(M.WindElemental&&!M.WaterElemental)) SE=1
					damage=JutsuDamage(Ninjutsu,M.Ninjutsu,FireElemental,M.WaterElemental,Power,SE)
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
							JutsuClash_Fire(src,o)
					else if(istype(o,/obj/Weapon/Wield)) del(o)
					else del(src)


	Ryuuka
		name="Ryuuka"
		icon='KatonKaryuuEndan.dmi'
		density=1
		Power=4
		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A)||(isobj(A)&&istype(A,/obj/Destructable)))
				var/damage
				var/mob/O=Owner
				if(ismob(A))
					if(O)
						var/mob/M=A
						if(M.kaiten||M.MushiKabe||M.InMeatTank||M.protect||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
						if(O==M) {loc=M.loc; return}
						if(O.HitCheck(M))
							damage=JutsuDamage(Ninjutsu,M.Ninjutsu,FireElemental,M.WaterElemental,Power)
							//DamageMessage(M,damage,name)
							M.DamageMe(O,damage,src)
						else {O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."}
					del(src)
				else
					var/obj/M=A
					var/SE=0
					if(M.IceElemental||(M.WindElemental&&!M.WaterElemental)) SE=1
					damage=JutsuDamage(Ninjutsu,M.Ninjutsu,FireElemental,M.WaterElemental,Power,SE)
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
							JutsuClash_Fire(src,o)
					else if(istype(o,/obj/Weapon/Wield)) del(o)
					else del(src)