obj/Weapon/Wield/InscribedKunai
	name="Inscribed Kunai"
	icon='KunaiM.dmi'
	icon_state = "Thrown"
	var/mob/Marker
	density = 1
	New()
		..()
		spawn(20)
			del src
	Del()
		Marker = null
		Owner = null
		walk(src,0)
		loc = null
		spawn(10)
			..()
	Cross(A)
		if(A == Owner)
			return 1
		if(isobj(A))
			var/obj/O = A
			if(O.Owner == Owner)
				return 1
		if(ismob(A))
			var/mob/M = A
			if(M.Creator == Owner)
				del src
				return 122
		..()
	Bump(A)
		if(!Owner)
			del src
			return
		var/mob/U = Marker
		if(!Marker)
			del src
			return
		else if(ismob(A))
			var/mob/M = A
			var/mob/O=Owner
			if(O == A)
				del src
				return
			if(M.kaiten||M.MushiKabe||M.protect)
				del src
			var/damage = Taijutsu
			var/knifedmg=round((damage+1)+(ThrowingSkill*11))
			//DamageMessage(M,knifedmg,name)
			var/LOC = Get_Rand_DirStep(M)
			if(LOC)
				var/turf/HL = U.loc
				HL.overlays += 'Hiraishin.dmi'
				spawn(4)
					HL.overlays -= 'Hiraishin.dmi'
				U.loc.loc.Exited(U)
				U.loc = LOC
				U.loc.loc.Entered(U)
				if(M)
					U.dir = get_dir(U, M)
				M.DamageMe(O,knifedmg,src); del(src)
			else
				M.DamageMe(O,knifedmg*0.1,src); del(src)
		else if(istype(A,/turf/))
			var/turf/T = A
			if(T.density)
				spawn(2)
					del(src)
		else if(istype(A,/obj/))
			del src