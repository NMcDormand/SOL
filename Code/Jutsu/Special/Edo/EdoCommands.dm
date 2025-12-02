mob/Hittable/Command/EdoClone
	proc
		EdoAttack()
			set waitfor = 0
			Status = STATUS_ATTACK
			return
			var/mob/t=Targeting
			var/m=movespeed
			if(m<0.5)
				m=0.5

			while(Status == STATUS_ATTACK)
				//get_dist(t,src)<17&&!t.dead
				t=target
				if(!t||t.dead)
					break

				if(protect)
					Status = STATUS_FOLLOW
					EdoFollow(Creator)
					return
				if(KO || t.z != z)
					sleep(10)
					continue
				if(t.Kawarimi)
					t=t.Kawarimi
				if(get_dist(t,src)<=1)
					dir = get_dir(src,t)
					if(HitCheck(t))
						BunshinAttack(t)
					else
						t<<"You dodged [src]'s attack"
					sleep(atkspeed)
				else
					step_to(src,t)
					sleep(m)
			Status=null

		EdoFollow(mob/M)
			set waitfor = 0
			Status = STATUS_FOLLOW
			while(Status == STATUS_FOLLOW)
				var/cloneSpeed=movespeed
				if(movespeed<=0.5)
					cloneSpeed=0.5
				if(get_dist(src,M)<=1 && !M.moving)
					sleep(cloneSpeed+5)
				else
					step_to(src,M,1)
					sleep(cloneSpeed)

obj/SkillCards/Ninjutsu/Special/EdoTensei/Commands
	Edo_Attack
		name="Edo Control: Attack"
		icon_state="card_EdoAttack"
		cmdstring="EdoSendToAttack"
		CanLevel = 0


		Description = list(
			"about"="Order all resurrected clones to attack a specific target."
			,"title"="Edo Controls: Attack"
			,"type"="Other"
			,"strong"="N/A"
			,"weak"="N/A"
			,"rank"="E"
	//		,"pic"='Block.png'
		)

		Activate(mob/U)
			if(U.choosingHoming) return
			if(CMDATKCHK(U)) return
			var/dist=11;
			var/mob/M

			if(ismob(U.Targeting) && get_dist(U.Targeting,U)<= dist)
				M = U.Targeting
			else
				M = U.TargetSelect(dist)
			if(M!="Cancel")
				for(var/mob/Hittable/Command/EdoClone/B in U.EdoCloneList)
					if(B.Status == STATUS_REVOLT)
						continue
					if(get_dist(U,B)<11)
						if(M != B)
							B.Targeting=M
							B.EdoAttack()

	Edo_Follow
		name="Edo Controls: Follow"
		icon_state="card_EdoFollow"
		cmdstring="EdoFollow"
		CanLevel = 0

		Description = list(
			"about"="Order all resurrected clones to follow you."
			,"title"="Edo Control: Follow"
			,"type"="Other"
			,"strong"="N/A"
			,"weak"="N/A"
			,"rank"="E"
	//		,"pic"='Block.png'
		)

		Activate(mob/U)
			if(CMDATKCHK(U)) return
			for(var/mob/Hittable/Command/EdoClone/B in U.EdoCloneList)
				if(B.Status == STATUS_REVOLT)
					continue
				if(B.Status!=STATUS_FOLLOW)
					B.EdoFollow(U)
					for(var/mob/A in B.MasterBunshinList)
						del A

	Edo_Free_Will
		name="Edo Controls: Give Free Will"
		icon_state="card_EdoFreeWill"
		cmdstring="EdoFreeWill"
		CanLevel = 0


		Description = list(
			"about"="Order all resurrected clones to follow you."
			,"title"="Edo Control: Free Will"
			,"type"="Other"
			,"strong"="N/A"
			,"weak"="N/A"
			,"rank"="E"
	//		,"pic"='Block.png'
		)

		Activate(mob/U)
			if(CMDATKCHK(U)) return
			for(var/mob/Hittable/Command/EdoClone/B in U.EdoCloneList)
				if(B.Status == STATUS_REVOLT)
					continue
				if(B.Status!=STATUS_FREEWILL)
					B.Status = STATUS_FREEWILL

	Edo_Stay
		name="Edo Controls: Stay"
		icon_state="card_EdoStay"
		cmdstring="EdoStay"
		CanLevel = 0


		Description = list(
			"about"="Order all resurrected clones to cease moving."
			,"title"="Edo Control: Stay"
			,"type"="Other"
			,"strong"="N/A"
			,"weak"="N/A"
			,"rank"="E"
	//		,"pic"='Block.png'
		)

		Activate(mob/U)
			if(CMDATKCHK(U)) return
			for(var/mob/Hittable/Command/EdoClone/B in U.EdoCloneList)
				if(B.Status == STATUS_REVOLT)
					continue
				B.Status=STATUS_STAY

	Edo_DestroyAll
		name="Edo Controls: Destroy All"
		icon_state="card_EdoDispelAll"
		cmdstring="EdoDestroyAll"
		CanLevel = 0


		Description = list(
			"about"="Remove all your EdoClone from the map."
			,"title"="Edo Control: Destroy All"
			,"type"="Other"
			,"strong"="N/A"
			,"weak"="N/A"
			,"rank"="E"
	//		,"pic"='Block.png'
		)

		Activate(mob/U)
			for(var/mob/Hittable/Command/EdoClone/B in U.EdoCloneList)
				if(B.Status == STATUS_REVOLT)
					continue
				sleep(pick(1,prob(80); 2))
				del(B)

	Edo_DestroyOne
		name="Edo Controls: Destroy One"
		icon_state="card_EdoDispelOne"
		cmdstring="EdoDestroyOne"
		CanLevel = 0


		Description = list(
			"about"="Remove one of your EdoClone; automatically picks the oldest clone."
			,"title"="Edo Control: Destroy One"
			,"type"="Other"
			,"strong"="N/A"
			,"weak"="N/A"
			,"rank"="E"
	//		,"pic"='Block.png'
		)

		Activate(mob/U)
			for(var/mob/Hittable/Command/EdoClone/B in U.EdoCloneList)
				if(B.Status == STATUS_REVOLT)
					continue
				if(B)
					del(B)
					break