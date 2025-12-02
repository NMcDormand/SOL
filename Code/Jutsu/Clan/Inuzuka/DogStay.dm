obj/SkillCards/Clan/Inuzuka/Commands/DogStay
	icon_state="card_DogStay"
	cmdstring="DogStay"

	Description = list(
		"about"="Have your dog cease actions, and rest."
		,"title"="Dog: Stay"
		,"type"="Other"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='DogStay.png'
		)

	Activate(mob/U)
		if(CMDATKCHK(U)) return
		U.DogCommand++
		if(U.DogCommand==1)
			spawn(DOGDELAY)U.DogCommand=0
			var/mob/Hittable/Responsive/Animal/Pet/D=U.Familiar
			if(D && D.loc && !ismob(D.loc))
				if(D.Status==STATUS_STAY) return
				if(D.onwater) {U<<"Not while [D]'s on water."; return}
				if(D.resting) {U<<"[D] is already taking a nap."; return}
				if(get_dist(D,U) < 50)
					D.Status=STATUS_STAY
					flick("lay",D)
					D.icon_state="lay2"
					spawn(16)
						if(D && !D.resting && D.Stamina < D.StaminaMax  && D.Status==STATUS_STAY)
							D.icon_state="sleep"; D.DogRest(U)

mob/proc/DogRest(mob/Owner)
	set waitfor = 0, background=1
	if(Status!=STATUS_STAY)
		Status=STATUS_STAY
		while(Stamina < StaminaMax && Status==STATUS_STAY)
			Stamina += round(StaminaMax/12)
			Owner.StatUpdate_dogStuff()
			if(Stamina > StaminaMax)
				Stamina = StaminaMax
				Owner.StatUpdate_dogStuff()
			sleep(14)

		while(Status==STATUS_STAY)
			icon_state="lay2"
			resting=0
			sleep(25)

		icon_state=""
		resting=0