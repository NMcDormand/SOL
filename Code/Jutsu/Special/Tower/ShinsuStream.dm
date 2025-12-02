#if DEBUGGING
mob/verb
	SelfLearnShinStream()
		var/obj/SkillCards/Ninjutsu/Special/Tower/ShinsuStream/J=locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Shinsu Stream</i>!</font></b>"
			new/obj/SkillCards/Ninjutsu/Special/Tower/ShinsuStream(src)
	SelfLearnShinCircle()
		var/obj/SkillCards/Ninjutsu/Special/Tower/ShinsuCircle/J=locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Shinsu Circle</i>!</font></b>"
			new/obj/SkillCards/Ninjutsu/Special/Tower/ShinsuCircle(src)

#endif
obj/SkillCards/Ninjutsu/Special/Tower/ShinsuStream
	icon_state="card_ShinsuStream"
	cmdstring="ShinsuStream"
	Range=4
	CCost=2000
	VerbIt=1
	CanLevel=0

	Description = list(
		"about"="Balls of Shinsu that track the target"
		,"title"="Shinsu Stream"
		,"type"="Kinjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
		//,"pic"='Chidori.png'
		)

	Activate(mob/U)
		if(U.choosingHoming) return
		var/dist=8;
		var/mob/M
		if(ismob(U.Targeting)&&get_dist(U.Targeting,U)<= dist)
			M = U.Targeting
		else
			M = U.TargetSelect(dist)
		if(M)
			spawn(10)if(U)U.choosingHoming=0
			if(GENERICATTACKCHECK(U)||InvisibilityCheck(U,M)) return
			var
				c=2000; mx=c; s=0
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("ShinsuStream",(500*U.cooldownmultiplier)+s,1)) return
			if(U.CooldownCheck("Homing",(100*U.cooldownmultiplier)+s,1)) return
			U.firing=1
			spawn(s)
				spawn(3)U.firing=0
				if(prob(U.ChakraControl))
					U.JutsuSeals(s); U.JutsuNin(c);
					U.MoveUses[name]++
					U.JutsuUseChakra(c)
					U << "You unleashed your Shinsu towards [M]"
					if(U.PracticeMode)
						return
					U.ShinsuStream(M)
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

obj/SkillCards/Ninjutsu/Special/Tower/ShinsuCircle
	icon_state="card_ShinsuCircle"
	cmdstring="ShinsuCircle"
	Range=4
	CCost=4000
	VerbIt=1
	CanLevel=0

	Description = list(
		"about"="Balls of Shinsu circle the user in an attempt to protect them, they cannot be dispelled until time is up"
		,"title"="Shinsu Circle"
		,"type"="Kinjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
		//,"pic"='Chidori.png'
		)

	Activate(mob/U)
		if(U.choosingHoming) return
		if(GENERICATTACKCHECK(U)) return
		if(U.ShinsuCircles >= U.MaxBangs)
			U << "You cant control any more bangs right now"
			return
		var
			c=4000; mx=c; s=0
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("ShinsuCircle",(600*U.cooldownmultiplier)+s,0)) return
		spawn(s)
			if(prob(U.ChakraControl))
				if(U.ChakraControl<100) {c+=rand(0,mx/2); U.CCGain(c)}
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c)
				U << "You unleashed your shinsu to create a form of protection"
				if(U.PracticeMode) return ..()
				U.ShinsuCircle(pick(1,2,3), pick(90,-90))
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()
mob
	proc
		ShinsuStream(mob/M)
			set waitfor = 0
			set background = 1
			var/obj/Jutsu/Shinsu/Stream/S = new(loc,src)
			firing = 1
			spawn(10)
				if(src)
					firing = 0
			spawn(30)
				if(S)
					del S
			while(get_dist(M,S))
				if(get_dist(M,S) >1)
					step_to(S,M)
					sleep(1)
				else
					walk_towards(S,M,0,1)
					break

		ShinsuCircle(MD = 3, ND = 90)
			var/obj/Jutsu/Shinsu/Stream/S = new(loc,src,1)
			S.Circle=1
			firing = 1
			spawn(10)
				if(src)
					firing = 0
			spawn(600)
				if(S)
					del S
			//walk_to(S,src,MD)
			spawn(1)
				while(S)
					while(get_dist(S,src) > MD)
						step_to(S,src)
						sleep(1)
					switch(S.dir)
						if(NORTHEAST)
							S.dir = pick(NORTH)
						if(NORTHWEST)
							S.dir = pick(WEST)
						if(SOUTHEAST)
							S.dir = pick(EAST)
						if(SOUTHWEST)
							S.dir = pick(SOUTH)
					var/turf/A = get_step(S,S.dir)
					if(get_dist(A,src) > MD||!A)
						S.dir = turn(S.dir,ND)
					if(!step(S, S.dir))
						S.dir = turn(S.dir,ND)
					//world << "[get_dist(S,src)]"
					sleep(1)
