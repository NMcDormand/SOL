obj/SkillCards/Country/Sound
	JutsuType = "Ninjutsu"

obj/Jutsu
	Zankouha
		name="Zankouha"
		icon = 'Zankouha.dmi'
		density = 1
		movespeed=2
		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A))
				var/mob/M = A
				var/mob/O=Owner
				if(M.kaiten||M.protect||M.InGatsuuga||M.InMeatTank||M.InTsuuga||M.InGarouga) del(src)
				var/E=1000
				var/nindamage=Ninjutsu-(M.Ninjutsu*0.10)
				var/damage = round(nindamage+E)*1.2
				M.DamageMe(O,damage,"Sound")
				del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)
			if(istype(A,/obj/))
				if(isobj(A))
					var/obj/o = A
					if(istype(o,/obj/Jutsu)) JutsuClash_Wind(src,o)
					else if(istype(o,/obj/Weapon/Wield)) del(o)
					else if(o.Owner!=Owner) del(src)
	Zankoukyokuha
		name="Zankoukyokuha"
		icon = 'Zankoukyokuha.dmi'
		density = 1
		movespeed=2
		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A))
				var/mob/M = A
				var/mob/O=Owner
				if(M.kaiten||M.protect||M.InGatsuuga||M.InMeatTank||M.InTsuuga||M.InGarouga) del(src)
				var/E=WindElemental*1.1
				var/nindamage=Ninjutsu-(M.Ninjutsu*0.10)
				var/damage = round(nindamage+E)*2.5
				if(damage<1) damage=1
				//DamageMessage(M,damage,name)
				M.DamageMe(O,damage,"Sound")
				del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)
			if(istype(A,/obj/))
				if(isobj(A))
					var/obj/o = A
					if(istype(o,/obj/Jutsu)) JutsuClash_Wind(src,o)
					else if(istype(o,/obj/Weapon/Wield)) del(o)
					else if(o.Owner!=Owner) del(src)