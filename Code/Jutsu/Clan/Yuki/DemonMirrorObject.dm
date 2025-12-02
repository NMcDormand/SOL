mob
	Hittable/Unresponsive/Inanimate
		Break
			DemonMirror
				var/InDome = 0
				var/Used = 0
				var/CCost = 800
				name = "Demonic Ice Mirror"
				density = 1
				icon='JMMirrors.dmi'
				layer=MOB_LAYER-1

				DamageMe(mob/M,DAMAGE,METHOD,hidemessage)
					Health-=DAMAGE
					if(Health <= 0)
						del src

				New(turf/placement, mob/owner, DIR, MaxCheck = 0,Dur=30)
					if(placement.density)
						return
					loc = placement
					Owner = owner
					if(!DIR)
						if(Owner.Targeting)
							dir = get_dir(src,owner.Targeting)
						else
							dir = get_dir(src,owner)
					else
						dir = DIR
					if(dir == NORTH||dir==NORTHEAST||dir==NORTHWEST)
						layer=MOB_LAYER+1
					IceElemental = (owner.IceElemental) * 0.5
					Health = (owner.StaminaMax + IceElemental) * 0.2
					Taijutsu = owner.Taijutsu
					Ninjutsu = owner.Ninjutsu
					Genjutsu = owner.Genjutsu

					spawn(1)
						while(src && owner && owner.Chakra >= CCost)
							sleep(20)
							if(owner)
								owner.Chakra -= CCost
								owner.RefreshChakra()
						if(owner)
							owner.EndMirrors()
						else
							del src
					spawn(Dur)
						if(!owner)
							if(src)
								del src
						else
							if(MaxCheck)
								owner.MirrorCurrent--
							if(src)
								del src
				//	..()

				Del()
					if(Containing)
						Containing.InAMirror = 0
						Containing.invisibility -= 2
						Containing.EnteredOBJ = 0
					if(InDome < 2)
						var/mob/O = Owner
						if(O)
							if(InDome)
								if(O.MirrorDome)
									O.MirrorDome -= src
									if(!length(O.MirrorDome))
										O.MirrorDome = 0
							else
								if(O.AllMirrors)
									Owner.MirrorCurrent--
									O.AllMirrors -= src
									if(!length(O.AllMirrors))
										O.AllMirrors = 0
					..()

				Cross(var/atom/movable/U)
					if(Owner == U||!U.density)
						return 1
					else
						if(istype(U,/obj/Jutsu/Shinsu))
							return 1
						else
							return 0

				Crossed(mob/U)
					if(Owner == U)
						if(U.InAMirror)
							if(U.Targeting)
								var/obj/Yuki/Sensatsu/S=new()
								S.Power = 2
								CreateProjectile(U,S,"Ice",loc,get_dir(U,U.Targeting),1,7,0.9,1.9)
						else
							U.InAMirror=1
							U.invisibility += 2
							for(var/mob/M in range(U))
								if(M.Targeting == U)
									M.DeleteTarget()
						U.EnteredOBJ=src
						Containing=U
						U.dir = dir
					..()

				Uncrossed(mob/U)
					if(Owner == U)
						U.EnteredOBJ = 0
						Containing = 0
					..()

				Click()
					var/mob/U = usr
					if(GENERICATTACKCHECK(U)||U.Gokusamaisou)
						return
					if(Owner == U)
						if(U.InAMirror)
							if(U.Targeting)
								dir = get_dir(src,U.Targeting)
								var/obj/Yuki/Sensatsu/S=new/obj/Yuki/Sensatsu
								S.Power = 2
								CreateProjectile(U,S,"Ice",loc,get_dir(U,U.Targeting),1,7,0.9,1.9)
							U.InAMirror = 2
							for(var/i = 0 to 20)
								if(!step_towards(U,src))
								//if(loc == U.loc)
									break
							U.InAMirror = 1
							if(loc == U.loc)
								U.EnteredOBJ=src
								Containing=U
							else
								U.EnteredOBJ = null
								U.InAMirror = 0
								U.invisibility -=2

						else if(U.MirrorCreationMode)
							if(src in U.AllMirrors)
								U.AllMirrors -= src
								MirrorCurrent--
								del src

						else if(get_dist(src,U) < 2)
							U.InAMirror=1
							U.invisibility += 2
							for(var/mob/M in range(U))
								if(M.Targeting == U)
									M.DeleteTarget()
							U.loc = loc
							U.EnteredOBJ=src
							Containing=U
					..()