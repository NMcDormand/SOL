obj/SkillCards/Clan/Inuzuka/Commands/DogAttack
	icon_state="card_DogAttack"
	cmdstring="DogAttack"

	Description = list(
		"about"="Send your dog out to attack."
		,"title"="Dog Attack"
		,"type"="Other"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='DogAttack.png'
		)

	Activate(mob/U)
		if(U.choosingHoming||CMDATKCHK(U)) return
		U.DogCommand++
		if(U.DogCommand==1)
			spawn(DOGDELAY)
				U.DogCommand=0
			var/mob/Hittable/Responsive/Animal/Pet/D=U.Familiar
			if(D && D.loc && !ismob(D.loc))
				var/dist=16;
				var/mob/T
				if(ismob(U.Targeting)&&get_dist(U.Targeting,U)<= dist)
					T = U.Targeting
				else
					T = U.TargetSelect(dist)
				if(D.Targeting == T && D.Status==STATUS_ATTACK)
					return
				if(T && D && get_dist(D,U) < dist)
					D.icon_state=null
					D.Status=STATUS_ATTACK
					D.Targeting = T
					D.dogattack()

mob/proc/dogattack()
	set waitfor = 0, background=1
	var/STOPME = 0
	var/mob/O = Master
	while(Status==STATUS_ATTACK && Master)
		if(KO||dead)
			break
		else
			if(protect)
				DogFollow(O)
				break
			var/mob/M = Targeting
			if(M)
				if(M.dead||M.protect)
					break
				else
					var/mob/t
					if(InvisibilityCheck(O,M))
						for(var/mob/T in orange(16,src))
							if(IDCHECK(M,T))
								t=T
								break
					else
						t=M

					var/GD = get_dist(t,src)
					if(GD < 32)
						STOPME = 0
						if(GD<=1)
							step_towards(src,t)
							sleep(atkspeed)
						else
							step_to(src,t)
							sleep(movespeed)
					else
						if(STOPME > 5)
							break
						else
							STOPME++
							sleep(5)
			else
				break
	if(O)
		if(!O.dead)
			DogFollow(O)
		else
			DogPack(O)
	else //if(!Master)
		del src