#if DEBUGGING
mob/verb
	SelfLearnRasenShuriken()
		var/obj/SkillCards/Ninjutsu/Special/RasenShuriken/J=locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Fuuton Rasen Shuriken</i>!</font></b>"
			new/obj/SkillCards/Ninjutsu/Special/RasenShuriken(src)

#endif
obj/SkillCards/Ninjutsu/Special/RasenShuriken
	icon_state="card_RasenShuriken"
	cmdstring="RasenShuriken"
	JutsuType = "S-Rank"
	Range=8
	CCost=30000
	Cooldown = 9000
	XPLGain = 30
	UpgradeMax = 0

	Description = list(
		"about"="Create a ball of pure chaotic chakra infused with Wind nature"
		,"title"="Fuuton: Rasen Shuriken"
		,"type"="Kinjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
		//,"pic"='Chidori.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U))
			return
		switch(U.InRasenShuriken)
			if(1)
				var/icon/Shi = 'Rasengan_SOL.dmi'
				U << "You release the immense energy in your hand"
				U.overlays-=Shi
				U.InRasenShuriken = 0
			if(2)
				U << "You threw the Rasen Shuriken!"
				U.RasenShurikenThrow()
			else
				if(U.CooldownCheck("RasenShuriken",(CooldownCur*U.cooldownmultiplier))) return
				var
					c=CCost
				if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
				U.JutsuChakra(1000); U.JutsuNin(3000);
				if(U.WindElemental)
					U.ElementalUp("Wind")
				U.JutsuUseChakra(c,0.01)
				if(U.PracticeMode || ControlCheck(U)) return ..()
				U.InRasenShuriken = 1
				var/icon/Shi = 'Rasengan_SOL.dmi'
				U.overlays+= Shi
				U<< "You begin to form the Rasen Shuriken"
				spawn(50)
					if(U.InRasenShuriken)
						U.overlays+='AirBurst32.dmi'
						spawn(4)
							U.overlays-='AirBurst32.dmi'
						U<< "You can feel the Shuriken is ready"
						U.InRasenShuriken = 2
				..()

mob
	var
		tmp/InRasenShuriken = 0
		tmp/RasenStuck

	proc
		RasenShurikenThrow()
			InRasenShuriken = 0
			if(client)
				MoveUses["RasenShuriken"]++
				if(PracticeMode)
					return
			overlays-=icon('Rasengan_SOL.dmi')
			hearers(4,src) << "<b>[src]: Fuuton: Rasen Shuriken!</b>"
			var/obj/Jutsu/RasenShuriken/S = new(loc,src)
			spawn(80)
				if(S)
					del S
			walk(S,S.dir,1.4)

		RasenShurikenPunch(mob/M)
			InRasenShuriken = 0
			if(client)
				var/obj/SkillCards/Ninjutsu/Special/RasenShuriken/RS = locate() in src
				if(RS)
					MoveUses["RasenShuriken"]++
				if(PracticeMode)
					return
			overlays-=icon('Rasengan_SOL.dmi')
			hearers(4,src) << "<b>[src]: Fuuton: Rasen Shuriken!</b>"
			var/turf/LOC
			if(M)
				LOC = M.loc
			else
				LOC = loc
			var/obj/Jutsu/RasenShuriken/S = new(LOC,src)
			S.Activate()
			spawn(80)
				if(S)
					del S

obj/Jutsu

	RasenShuriken
		icon = 'RasenShuriken.dmi'
		icon_state = "T"
		var/Steps = 0
		var/Activated = 0
		layer = MOB_LAYER+4
		density = 1
		New(LOC,mob/O)
			loc = LOC
			Owner = O
			dir = O.dir
			Ninjutsu=O.Ninjutsu
			WindElemental = O.WindElemental
			IDCOPY(src,O)
			..()

		proc/Activate()
			set waitfor = 0
			if(!Activated)
				icon_state = "G"
				var/icon/F = icon(icon)

				F.Scale(96,96)
				pixel_x = -32
				pixel_y = -32
				icon = F
				density = 0
				spawn()
					for(var/i = 1 to 10)
						new/Effect/Visual/KuchuNejire(loc)
						sleep(10)

				while(src)
					if(!Owner)
						del src
						return
					for(var/mob/A in range(src,2))
						if(IDCHECK(src,A))
							continue
						else if(A.NinjaRank == "Academy Student")
							continue
						else
							if(istype(A,/mob/Hittable) || istype(A,/mob/player))
								A.RasenStuck = 1
								A.Wounds += 0.5
								A.DamageMe(Owner,Ninjutsu*0.03+WindElemental*0.5,"RasenShuriken")
					sleep(1)
					CHECK_TICK

		Del()
			for(var/mob/A in range(src,2))
				A.RasenStuck = 0
				A.Wounds = round(A.Wounds)
			..()

		Move()
			.=..()
			sleep(2)
			if(.)
				for(var/mob/A in range(src,1))
					if(IDCHECK(src,A))
						continue
					else if(A.TreeStump)
						continue
					else
						walk(src,0)
						Activate()
						return
				Steps++
				if(Steps >= 8)
					walk(src,0)
					Activate()
			else
				walk(src,0)
				Activate()

		Bump()
			walk(src, 0)
			Activate()