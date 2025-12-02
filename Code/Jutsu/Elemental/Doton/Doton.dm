/***********************************************************************************
**********************************[ Doton ]*****************************************
************************************************************************************/
var/DotonOnWaterCheck = 4000
obj/Jutsu
	DoryuuDango
		name="Doryuu Dango"
		icon = 'DoryuuDango.dmi'
		density = 1
		notblowable=0
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
					if(M.kaiten||M.InMeatTank||M.protect||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
					if(M==O) {loc=M.loc; return}
					if(O.HitCheck(M))
						damage=JutsuDamage(Ninjutsu,M.Ninjutsu,EarthElemental,M.WindElemental,Power)
						//DamageMessage(M,damage,name)
						M.DamageMe(O,damage,src)
					else {O<<"[M] dodged your attack"; M<<"You dodged [O]'s attack"}
					del(src)
				else
					var/obj/M=A
					if(M.LightningElemental&&!M.WindElemental) damage=JutsuDamage(Ninjutsu,M.Ninjutsu,EarthElemental,M.WindElemental,Power,1)
					else damage=JutsuDamage(Ninjutsu,M.Ninjutsu,EarthElemental,M.WindElemental,Power)
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
							JutsuClash_Earth(src,o)
					else if(istype(o,/obj/Weapon/Wield)) del(o)
					else del(src)


	Doryuudan
		name="Doryuudan"
		icon = 'Doryuudan.dmi'
		icon_state="ball"
		density = 1
		movespeed=1
		Power=2
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
						damage=JutsuDamage(Ninjutsu,M.Ninjutsu,EarthElemental,M.WindElemental,Power)
						//DamageMessage(M,damage,name)
						M.DamageMe(O,damage,src)
					else
						O<<"[M] dodged your attack"; M<<"You dodged [O]'s attack"
					del(src)
				else
					var/obj/M=A
					if(M.LightningElemental&&!M.WindElemental) damage=JutsuDamage(Ninjutsu,M.Ninjutsu,EarthElemental,M.WindElemental,Power,1)
					else damage=JutsuDamage(Ninjutsu,M.Ninjutsu,EarthElemental,M.WindElemental,Power)
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
							JutsuClash_Earth(src,o)
					else if(istype(o,/obj/Weapon/Wield)) del(o)
					else del(src)

	DoryuuHeki
		notblowable=0
		icon = 'DoryuuHeki.dmi'
		density = 1

obj/var
	HEALTH
	CantDamage

obj/Destructable/Doton
	DorouWall
		icon='DotonDorouDoumu.dmi'
		layer=MOB_LAYER+1
		notblowable=1
		Wall
			icon_state="wall"
			density=1
			Cross()
				if(IDCHECK(src,usr))
					return 1
				else
					.=..()
		Corner
			icon_state="corner"
			density=1
		Middle
			icon_state="middle"
			density=0