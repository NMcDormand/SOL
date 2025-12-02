obj/Yuki
	Sensatsu
		icon = 'needles.dmi'
		density = 1
		Power=1
		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A)||istype(A,/obj/Destructable))
				var/damage
				var/mob/O=Owner
				if(ismob(A))
					var/mob/M=A
					if(M.kaiten||M.MushiKabe||M.InMeatTank||M.protect||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
					if(O==M) {loc=M.loc; return}
					if(O.HitCheck(M))
						damage=JutsuDamage(Ninjutsu,M.Ninjutsu,IceElemental,M.FireElemental,Power)
						//DamageMessage(M,damage,name)
						M.DamageMe(O,damage,src)
					else {O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."}
					del(src)
				else
					var/obj/M=A
					var/SE=0
					if(M.EarthElemental&&!M.FireElemental) SE=1
					damage=JutsuDamage(Ninjutsu,M.Ninjutsu,IceElemental,M.FireElemental,Power,SE)
					M.Destroy(damage,O); del(src)

			else if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)
			else if(istype(A,/obj/))
				if(isobj(A))
					var/obj/o = A
					if(istype(o,/obj/Jutsu))
						if(istype(o,type) && o.Owner == Owner)
							return
						else
							JutsuClash_Ice(src,o)
					else if(istype(o,/obj/Weapon/Wield)) del(o)
					else del(src)

//------------------------------------------------------------------------------------------------------------
	IceBlast
		icon = 'Haku.dmi'
		icon_state="snowball"
		density=1
		layer=MOB_LAYER+1

		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A))
				var/mob/M=A
				var/mob/O=Owner
				if(IDCHECK(O,M))
					del src
					return
				if(M.kaiten||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
				if(M==O) loc=M
				else
					if(O.HitCheck(M))
						if(istype(O,/mob/Hittable/Responsive)&&!(O in M.HitList)) M.HitList+=O
						M.overlays+='iceblastcover.dmi'; loc=locate(0,0,0); M.IceBlasted=1
						if((M.PE=="Fire"||M.SE=="Fire")&&M.FireElemental>=((IceElemental)*0.6))
							spawn(12)
								if(M) {M.IceBlasted=0; M.overlays-='iceblastcover.dmi'; del(src)}
						else if((M.PE=="Fire"||M.SE=="Fire")&&M.FireElemental>=((IceElemental)*0.3))
							spawn(50)
								if(M) {M.IceBlasted=0; M.overlays-='iceblastcover.dmi'; del(src)}
						else
							spawn(100)
								if(M) {M.IceBlasted=0; M.overlays-='iceblastcover.dmi'; del(src)}
					else {O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."; del(src)}

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
							JutsuClash_Ice(src,o)
					else del(src)

//------------------------------------------------------------------------------------------------------------
	Kirigakure
		notblowable=1
		icon = 'Haku.dmi'
		icon_state="mist"
		density = 0
		layer=MOB_LAYER+1
