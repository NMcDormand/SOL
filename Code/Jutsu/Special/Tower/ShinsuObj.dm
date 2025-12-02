obj/Jutsu/Shinsu
	var/Activated = 0
	Stream
		icon = 'ShinsuStream.dmi'
		icon_state = ""
		layer = MOB_LAYER + 1
		density = 0
		var
			Circle = 0

		New(LOC,mob/O, C = 0)
			loc = LOC
			Owner = O
			dir = Owner.dir
			Ninjutsu = O.Ninjutsu
			WaterElemental = O.WaterElemental*1.3
			if(C)
				Circle = 1
				Owner.ShinsuCircles++
			else
				spawn(20)
					del src
			..()

		Del()
			walk(src,0)
			loc=null
			if(Owner)
				if(Circle)
					Owner.ShinsuCircles--
			..()

		CrossedMe(A)
			if(A == Owner || isturf(A) || istype(A,/Map) || istype(A,/Effect))
				return
			if(ismob(A))
				var/mob/M=A
				if(M.Creator == Owner)
					return
				if(M.kaiten||M.MushiKabe||M.protect)
					return
				var/damage
				var/mob/O=Owner
				if(O.HitCheck(M))
					damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WaterElemental,M.WaterElemental,Power)
					M.DamageMe(O,damage,src)
				else
					O<<"[M] dodged your attack."
					M<<"You dodged [O]'s attack."
				if(!Circle)
					del src
			if(istype(A,/obj/Jutsu) && prob(20))
				var/obj/O = A
				if(O.Owner != Owner)
					del A

		Bump(A)
			if(A == Owner || isturf(A) || istype(A,/Map) || istype(A,/Effect))
				return
			if(istype(A,/mob/Hittable/Unresponsive/Inanimate))
				var/mob/M = A
				if(M.Creator == Owner)
					return
				var/damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WaterElemental,M.WaterElemental,Power)
				M.DamageMe(Owner,damage,src)
				if(!Circle)
					del src
			if(ismob(A))
				var/mob/M=A
				if(M.Creator == Owner)
					return
				var/damage
				var/mob/O=Owner
				if(M.kaiten||M.MushiKabe||M.protect)
					return
				if(O.HitCheck(M))
					damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WaterElemental,M.WaterElemental,Power)
					M.DamageMe(O,damage,src)
				else
					O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."
				if(!Circle)
					del src
			if(istype(A,/obj/Jutsu) && prob(20))
				var/obj/O = A
				if(O.Owner != Owner)
					del A

	Shinwonryu
		icon = 'Shinwonryu2.dmi'
		icon_state = "Thrown"
		var/Steps = 0
		density = 1
		New(LOC,mob/O)
			loc = LOC
			Owner = O
			dir = O.dir
			Ninjutsu=O.Ninjutsu

		Del()
			for(var/mob/A in range(src,5))
				if(A == Owner || A.Creator == Owner||A.TreeStump||A.Cactus||A.NinjaRank == "Academy Student")
					continue
				else
					if(istype(A,/mob/Hittable) || istype(A,/mob/player))
						A.ShinwonSlow = 0
			..()

		proc/Activate()
			set waitfor = 0
			if(!Activated)
				icon_state = "Blow"
				var/icon/F = icon(icon)
				F.Scale(96,96)
				pixel_x = -32
				pixel_y = -32
				icon = F
				spawn(4)
					F.Scale(160,160)
					pixel_x = -64
					pixel_y = -64
					icon = F
					overlays += 'AirBurst.dmi'
				density = 0
				while(src)
					if(!Owner)
						del src
						return
					for(var/mob/A in range(src,5))
						if(A == Owner || A.Creator == Owner||A.TreeStump||A.Cactus||A.NinjaRank == "Academy Student"||istype(A,/mob/Hittable/Command/Genjutsu)||istype(A,/mob/Hittable/Unresponsive/NPC)||istype(A,/mob/Hittable/Unresponsive/Training))
							continue
						else
							if(istype(A,/mob/Hittable) || istype(A,/mob/player))
								if(NINIGNORELIST(A))
									continue
								if(prob(80))
									step_towards(A,src)
								A.ShinwonSlow++
								var/GD = get_dist(A,src)
								if(GD<5)
									if(A.Chakra)
										A.Chakra -= (A.ChakraMax * 0.1)
										if(A.Chakra < 0)
											A.Chakra = 0
										A.RefreshChakra()
									if(GD<3)
										A.DamageMe(Owner,Ninjutsu*0.2,"Shinwonryu",0)
					sleep(5)
					CHECK_TICK

		Move()
			.=..()
			sleep(2)
			for(var/mob/A in range(src,4))
				if(NINIGNORELIST(A))
					continue
				if(A == Owner || A.Creator == Owner||A.TreeStump)
					continue
				else
					step_towards(A,src)
			if(.)
				Steps++
				if(Steps >= 5)
					walk(src,0)
					Activate()
			else
				walk(src,0)
				Activate()

		Bump()
			walk(src, 0)
			Activate()