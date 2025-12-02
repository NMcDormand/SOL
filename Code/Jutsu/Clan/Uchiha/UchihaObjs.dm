obj/Jutsu/Uchiha
	Tsukuyomi
		icon = 'redworld.dmi'
		T1
			icon_state="ground"
			layer=9
		T2
			icon_state="dark"
			layer=9
		Totem
			icon_state="totem"
			layer=10
			pixel_y=-16

	AmaterasuBurn
		name="Amaterasu"
		icon='Amaterasu.dmi'
		icon_state="Burn1"
		notblowable=1
		New(Loc,mob/U,D=100)
			loc=Loc
			Ninjutsu=U.Ninjutsu;
			FireElemental=U.FireElemental
			dir=U.dir;
			Owner=U
			IDCOPY(src,U)
			spawn(D)
				loc=null
			while(loc && Owner)
				for(var/mob/M in loc)
					if(istype(M,/mob/Hittable)||M.client)
						if(IDCHECK(M,src))
							continue
						if(istype(M,/mob/Hittable/Unresponsive/NPC)||istype(M,/mob/Hittable/Unresponsive/Training)||istype(M,/mob/Hittable/Command/Genjutsu))
							continue
						var/damage=JutsuDamage(Ninjutsu*0.2,M.Ninjutsu*1,FireElemental*5,M.WaterElemental*0.7,Power)
						M.DamageMe(U,damage,src)
				sleep(10)

	Amaterasu
		name="Amaterasu"
		icon='Amaterasu.dmi'
		density=1
		notblowable=1
		movespeed=2
		Power=6

		Move()
			.=..()
			if(.)
				var/turf/A = loc
				if(A.loc && (istype(A.loc,/area/Water)||istype(A.loc,/area/Waterfall)))
					return
				new/obj/Jutsu/Uchiha/AmaterasuBurn(A,Owner,Durability)

		New(mob/U,D = 100,S=2)
			Ninjutsu=U.Ninjutsu;
			FireElemental=U.FireElemental
			loc=U.loc;
			dir=U.dir;
			Owner=U
			Durability = D
			movespeed = S
			IDCOPY(src,U)
			walk(src,dir)

		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A))
				var/damage
				var/mob/O=Owner
				var/mob/M=A
				if(!istype(A,/mob/Hittable/Unresponsive/Inanimate))
					loc=M.loc
				if(M.kaiten||M.MushiKabe||M.protect) del(src)
				if(O==M) return
				if(istype(A,/mob/Hittable/Responsive/Boss))
					if(O.HitCheck(M))
						damage=JutsuDamage(Ninjutsu*0.5,M.Ninjutsu*2,FireElemental*10,M.WaterElemental*0.5,Power)
						M.DamageMe(O,damage,src)
					else {O<<"[M] dodged your attack"; M<<"You dodged [O]'s attack"}
				else
					if(O.HitCheck(M))
						damage=JutsuDamage(Ninjutsu,M.Ninjutsu*0.8,FireElemental*20,M.WaterElemental*0.5,Power)
						M.DamageMe(O,damage,src)
					else {O<<"[M] dodged your attack"; M<<"You dodged [O]'s attack"}
			else if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)
			else if(isobj(A))
				if(istype(A,/obj/Destructable))
					var/damage
					var/mob/O=Owner
					var/obj/M=A
					var/SE=0
					if(M.IceElemental||(M.WindElemental&&!M.WaterElemental)) SE=1
					damage=JutsuDamage(Ninjutsu,M.Ninjutsu,FireElemental*4,M.WaterElemental,Power,SE)
					M.Destroy(damage,O); del(src)
				else
					var/obj/o = A
					if(istype(o,/obj/Jutsu/Fuuton/Renkoudan)) JutsuClash_Fire(src,o,0)
					else if(istype(o,/obj/Jutsu)) JutsuClash_Fire(src,o)
					else if(istype(o,/obj/Weapon/Wield)) del(o)
					else del(src)