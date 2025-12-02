obj/Yuki
	Sensatsu
		icon = 'needles.dmi'
		density = 1
		Power=1
		Bump(A)
			if(ismob(A)||(isobj(A)&&istype(A,/obj/Destructable)))
				var/damage
				var/mob/O=src.Owner
				if(ismob(A))
					var/mob/M=A
					if(M.kaiten||M.MushiKabe||M.InMeatTank||M.protect||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
					if(O==M) {src.loc=M.loc; return}
					if(O.HitCheck(M))
						damage=JutsuDamage(src.Ninjutsu,M.Ninjutsu,src.IceElemental,M.FireElemental,src.Power)
						//DamageMessage(M,damage,src.name)
						M.Death(O,damage,src)
					else {O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."}
					del(src)
				else
					var/obj/M=A
					var/SE=0
					if(M.EarthElemental&&!M.FireElemental) SE=1
					damage=JutsuDamage(src.Ninjutsu,M.Ninjutsu,src.IceElemental,M.FireElemental,src.Power,SE)
					M.Destroy(damage,O); del(src)

			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)
			if(istype(A,/obj/))
				if(isobj(A))
					var/obj/o = A
					if(istype(o,/obj/Jutsu)) JutsuClash_Ice(src,o)
					else if(istype(o,/obj/weapon)) del(o)
					else del(src)

//------------------------------------------------------------------------------------------------------------
	IceBlast
		icon = 'Haku.dmi'
		icon_state="snowball"
		density=1
		layer=MOB_LAYER+1

		Bump(A)
			if(ismob(A))
				var/mob/M=A
				var/mob/O=src.Owner
				if(M.kaiten||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
				if(M==O) src.loc=M
				else
					if(O.HitCheck(M))
						if(istype(O,/mob/NPC)&&!(O in M.HitList)) M.HitList+=O
						M.overlays+='iceblastcover.dmi'; src.loc=locate(0,0,0); M.IceBlasted=1
						if((M.PE=="Fire"||M.SE=="Fire")&&M.FireElemental>=((src.IceElemental)*0.6))
							spawn(12)
								if(M) {M.IceBlasted=0; M.overlays-='iceblastcover.dmi'; del(src)}
						if((M.PE=="Fire"||M.SE=="Fire")&&M.FireElemental>=((src.IceElemental)*0.3))
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
					if(istype(o,/obj/Jutsu)) JutsuClash_Ice(src,o)
					else del(src)

//------------------------------------------------------------------------------------------------------------
	Kirigakure
		notblowable=1
		icon = 'Haku.dmi'
		icon_state="mist"
		density = 0
		layer=MOB_LAYER+1

//------------------------------------------------------------------------------------------------------------
obj/Destructable
	DemonMirror
		icon='DemonMirrors.dmi'
		layer=MOB_LAYER+1
		notblowable=1
		Wall
			icon_state="wall"
			density=1
		Corner
			icon_state="corner"
			density=1
		Middle
			icon_state="middle"
			density=0

	DemonMirrorMyst
		icon='DemonMirrors_SOL.dmi'
		layer=MOB_LAYER-1
		notblowable=1
		Wall
			icon_state="front"
			density=1
		WallSide
			icon_state="side"
			density=1
		Corner
			icon_state="corner"
			density=1

