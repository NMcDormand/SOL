obj/SkillCards/Clan/Inuzuka/Commands/DogCall
	icon_state="card_CallDog"
	cmdstring="CallDog"
	Description = list(
		"about"="Have your dog return to you and follow you."
		,"title"="Dog: Call"
		,"type"="Other"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='CallDog.png'
	)

	Activate(mob/U)
		U.DogCommand++
		if(U.DogCommand==1)
			spawn(DOGDELAY)
				U.DogCommand=0
			var/mob/Hittable/Responsive/Animal/Pet/D=U.Familiar
			if(D && D.loc == U)
				var/obj/SkillCards/Clan/Inuzuka/Commands/DogDrop/DD = locate() in U
				spawn(-1)
					DD.Activate(U)
				return
			else
				if(get_dist(U,D) < 32)
					D.DogFollow(U)

mob/proc/DogFollow(mob/M)
	set waitfor = 0, background=1
	if(Status==STATUS_FOLLOW)
		return
	Status=STATUS_FOLLOW;
	resting=0;
	var/STOPME=0
	while(Status==STATUS_FOLLOW && M)
		if(M.KO || M.dead)
			Status=STATUS_STAY
			break
		var/D = get_dist(M,src)
		if(D < 50)
			if(D>1)
				if(!step_to(src,M))
					if(STOPME > 5)
						Status=STATUS_STAY
						break
					else
						STOPME++
				if(M.movespeed < 1)
					sleep(1)
				else
					sleep(M.movespeed)
			else
				sleep(3)
		else
			Status=STATUS_STAY
			break