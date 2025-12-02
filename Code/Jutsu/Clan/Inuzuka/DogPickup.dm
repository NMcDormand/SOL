obj/SkillCards/Clan/Inuzuka/Commands/DogPickup
	icon_state="card_DogPickup"
	cmdstring="DogPickup"
	Description = list(
		"about"="Pick up your dog and keep it safe on you."
		,"title"="Dog: Pickup"
		,"type"="Other"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='DogPickup.png'
		)
	Activate(mob/U)
		var/mob/Hittable/Responsive/Animal/Pet/P=U.Familiar
		if(P && P.loc && !ismob(P.loc))
			var/GD = get_dist(P,U)
			if(GD > 1 && GD < 50)
				var/failed = 0
				while(get_dist(P,U) > 1)
					if(!step_to(P,U))
						failed++
						if(failed>5)
							break
					else
						failed--
					if(P.movespeed)
						sleep(P.movespeed)
					else
						sleep(1)
			P.Status = STATUS_BLANK
			P.DogPack(U)

mob/proc/DogPack(mob/Owner)
	set waitfor = 0, background=1
	onmountain=0;
	loc=Owner;
	CantWalk++;
	swimming=0;
	TheoreticalUp()

	sleep(20)
	var/DMessage = 0
	Status=STATUS_PACK
	if(Wounds>0||Stamina<StaminaMax)
		DMessage = 1
		while(Status==STATUS_PACK && (Wounds>0||Stamina<StaminaMax))
			if(!Master)
				return
			Stamina+=StaminaMax*0.11
			Wounds -= rand(3,8)
			if(Stamina>=StaminaMax) Stamina=StaminaMax
			if(Wounds<=0) Wounds=0
			Owner.StatUpdate_dogStuff()
			sleep(20)
	if(DMessage)
		if(Owner)
			Owner << "[name] is has fully rested"
	spawn(100) TakenDamage=0