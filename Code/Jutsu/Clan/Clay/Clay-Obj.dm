obj
	Clay
		var
			Exploding = 0
			Steps = 10
			MotionSet = 0
			Total = 1
			ExplosiveRange = 1
			OwnerName = 0

		Del()
			loc = null
			Owner.ClayBombs -= src
			Owner = null
			walk(src,0)
			sleep(10)
			..()

		proc
			ExplodeClay()
				if(!Exploding)
					overlays+='Explode.dmi'
					icon = null
					Exploding = 1
					spawn(5)
						overlays = null
					for(var/atom/movable/Y in range(ExplosiveRange,src))
						if(ismob(Y))
							if(Y != Owner)
								var/mob/O = Owner
								var/mob/M = Y
								var/CD = round((rand(O.EarthElemental*0.5,O.EarthElemental) + (O.Ninjutsu)) - (M.EarthElemental+(M.Ninjutsu*0.2)))
								M.DamageMe(Owner,CD*Total,"ClayBomb")
						else if(istype(Y,/obj/Clay))
							var/obj/Clay/C = Y
							if(!C.Exploding)
								C.ExplodeClay()
					spawn(5)
						del src

		Explosion
			//icon='explosion.dmi'
			icon_state=""
			pixel_y=-16
			pixel_x=-16
			layer=MOB_LAYER+1||OBJ_LAYER+1

		Spider

		Mine
			var/ClayThrow
			icon='c2novo.dmi'
			name = "Mine"
			New()
				..()
				/*
				spawn(30)
					if(!Exploding)
						if(ClayThrow)
							ExplodeClay(src)*/
			Bump()
				..()
				ExplodeClay()
			Move()
				if(!Steps)
					return
				Steps--
				..()
				if(Steps <= 0)
					walk(src,0)
					for(var/obj/Clay/Mine/C in loc)
						if(C.Owner == src)
							C.Total++
							del src
							break
					density = 0
					return
				if(MotionSet)
					for(var/mob/U in range(1,src))
						if(U!=Owner)
							walk(src,0)
							ExplodeClay()
							return

turf
	var
		CanClay = 0
		HasClay = 0

	terrain/Rock
		CanClay = 30
		HasClay = 30

	Entered(A)
		if(ismob(A))
			var/mob/M=A
			spawn(0)
				for(var/obj/Clay/Mine/U in range(1))
					if(M!=U.Owner)
						if(U.MotionSet)
							U.ExplodeClay()
			if(HasClay)
				if(!M)
					return
				if(M.ClayCur < M.ClayMax)
					if(prob(HasClay))
						var/CL = rand(1,HasClay)
						M.ClayCur += CL
						HasClay -= CL
						spawn(300)
							HasClay += CL
						if(M.ClayCur>M.ClayMax)
							M.ClayCur=M.ClayMax
						//M<<"You collected some Clay from the Ground."
		..()