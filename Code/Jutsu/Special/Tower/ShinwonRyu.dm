#if DEBUGGING
mob/verb
	SelfLearnShinWonRyu()
		var/obj/SkillCards/Ninjutsu/Special/Tower/Shinwonryu/J=locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Shinwonryu</i>!</font></b>"
			new/obj/SkillCards/Ninjutsu/Special/Tower/Shinwonryu(src)

#endif
obj/SkillCards/Ninjutsu/Special/Tower/Shinwonryu
	icon_state="card_Shinwonryu"
	cmdstring="Shinwonryu"
	Range=4
	VerbIt=1
	CanLevel=0
	Description = list(
		"about"="Create a ball of shinsu that nullifies all energy within range doing damage in the process, it takes a short time to charge before being ready"
		,"title"="Shinwonryu"
		,"type"="Kinjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
		//,"pic"='Chidori.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U))
			return
		var/icon/Shi = 'Shinwonryu.dmi'
		switch(U.InShinwon)
			if(1)
				U << "You release the immense energy in your hand"
				U.overlays-=Shi
				U.InShinwon = 0
			if(2)
				U << "You threw the Black Hole Sphere!"
				U.ShinwonThrow()
			else
				if(U.CooldownCheck("Shinwonryu",(3600*U.cooldownmultiplier),0)) return
				U.InShinwon = 1
				U.overlays+= Shi
				U<< "You begin to form the black hole sphere"
				sleep(50)
				if(U.InShinwon)
					U.overlays+='AirBurst32.dmi'
					spawn(4)
						U.overlays-='AirBurst32.dmi'
					U<< "You can feel the Sphere is ready"
					U.InShinwon = 2

mob
	var
		tmp/InShinwon = 0
		tmp/ShinwonSlow = 0

	proc
		ShinwonThrow()
			InShinwon = 0
			if(client)
				MoveUses["Shinwonryu"]++
				if(PracticeMode)
					return
			overlays-=icon('Shinwonryu.dmi')
			var/obj/Jutsu/Shinsu/Shinwonryu/S = new(loc,src)
			walk(S,S.dir,1.4)
			spawn(100)
				if(S)
					del S

		ShinwonPunch(mob/M)
			InShinwon = 0
			if(client)
				MoveUses["Shinwonryu"]++
				if(PracticeMode)
					return
			overlays-=icon('Shinwonryu.dmi')
			var/turf/LOC
			if(M)
				LOC = M.loc
			else
				LOC = loc
			var/obj/Jutsu/Shinsu/Shinwonryu/S = new(LOC,src)
			S.Activate()
			spawn(80)
				if(S)
					del S