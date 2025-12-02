mob/var/BunNin = 0

mob/proc
	bunatck()
		var/mob/t=target; var/m=movespeed; if(m<1) m=1
		while(get_dist(t,src)<17&&!t.dead&&Status==STATUS_ATTACK)
			if(!Creator)
				del src
				return
			if(protect || IDCHECK(src,t))
				Status = STATUS_FOLLOW
				CloneFollow(Creator)
				return
			t=target
			if(!t) break
			if(t.Kawarimi) t=t.Kawarimi
			if(get_dist(t,src)<=10)
				var/GD = get_dist(t,src)
				if(GD>1)
					if(!Creator)
						del src
						return
					step_to(src,t)
					if(!firing && Creator.BunNin && !istype(src,/mob/Hittable/Command/Clones/Bunshin))
						Move_Aim(t)
						switch(pick(
							prob(WaterElemental)
							1,
							prob(FireElemental)
							2,
							prob(EarthElemental)
							3,
							prob(LightningElemental)
							4,
							prob(WindElemental)
							5,
							prob(1)
							0
						))
							if(1)
								Suiryuudan(t)
							if(2)
								Housenka(t)
							if(3)
								DoryuuDango()
							if(4)
								Rairyuu(t)
							if(5)
								Mugen()
						sleep(m+3)
					else
						sleep(m)
				if(GD<=1)
					if(t in get_step(src,dir))
						if(HitCheck(t))
							BunshinAttack(t)
						else
							t <<"You dodged [src]'s attack"
						sleep(atkspeed)
					else
						step_towards(src,t)
						sleep(1)
				else
					step_to(src,t)
					sleep(m)
			else sleep(m+3)
		if(!Creator || !Creator.client)
			del src
		Status=null

	CloneFollow(mob/M)
		while(Status==STATUS_FOLLOW)
			if(M)
				var/cloneSpeed=M.movespeed
				if(M.movespeed<=0) cloneSpeed=1
				if(get_dist(src,M)<=1 && !moving)
					sleep(cloneSpeed+1)
				else
					if(get_dist(src,M)<=3)
						step_to(src,M)
					else step_to(src,M,1)
					sleep(cloneSpeed)
			else
				del src

	CloneMeditate(mob/M)
		var/TIMEINCREASE = 1
		var/TIME = 0
		var/C
		if(meditatetime||resting) return
		meditatetime=1
		icon_state="rest"
		meditating=10

		while(Status==STATUS_MEDITATE)
			var/multi=(round(abs(ChakraTrue/50000)))+1 //Grab the amount of 10k numbers in this
			if(ChakraTrue<200) C=rand(1,3)
			else if(ChakraTrue>=200&&ChakraTrue<500) C=rand(2,4)
			else if(ChakraTrue>=500&&ChakraTrue<1000) C=rand(3,5)
			else if(ChakraTrue>=1000&&ChakraTrue<5000) C=rand(4,6)
			else if(ChakraTrue>=5000) C=rand(1,10)
			if(multi) C*=multi
			if(TIME)
				C += C*TIME

			ChakraXP+=C;

			TIMEINCREASE++
			if(TIMEINCREASE >= 60)
				TIME += 0.02

			sleep(rand(60,120))

			CHECK_TICK

//------------------------------------------------------------------------------------------------------------
obj/SkillCards/Starter
	Bunshin_Attack
		name="Bunshin Controls: Attack"
		icon_state="card_BunshinAttack"
		cmdstring="BunshinSendToAttack"
		JutsuType = "Other"
		CanLevel=0

		Description = list(
			"about"="Order all clones to attack a specific target."
			,"title"="Bunshin Controls: Attack"
			,"type"="Other"
			,"strong"="N/A"
			,"weak"="N/A"
			,"rank"="E"
	//		,"pic"='Block.png'
			)

		verb/Toggle_Bunshin_Ninjutsu()
			set category="TECHNIQUES"
			set src in usr.contents
			if(usr.BunNin)
				usr.BunNin = 0
				usr << "Your Bunshins will now avoid using Ninjutsu when attacking their target"
			else
				usr.BunNin = 1
				usr << "Your Bunshins will now use Ninjutsu when attacking their target"

		Activate(mob/U)
			if(U.choosingHoming) return
			if(CMDATKCHK(U)||U.BunshinCommand) return
			var/dist=11;
			var/mob/M

			if(ismob(U.Targeting)&&get_dist(U.Targeting,U)<= dist)
				M = U.Targeting
			else
				M = U.TargetSelect(dist)
			if(M)
				U.BunshinCommand=1
				spawn(4)
					if(U)
						U.BunshinCommand=0
				for(var/mob/Hittable/Command/Clones/B in U.MasterBunshinList)
					if(get_dist(U,B)<11)
						B.icon_state=null
						B.meditating=0
						B.target=M
						if(B.Status!=STATUS_ATTACK) {B.Status=STATUS_ATTACK; spawn()B.bunatck()}

	Bunshin_Follow
		name="Bunshin Controls: Follow"
		icon_state="card_BunshinFollow"
		cmdstring="BunshinFollow"
		JutsuType = "Other"
		CanLevel=0

		Description = list(
			"about"="Order all clones to follow you."
			,"title"="Bunshin Controls: Follow"
			,"type"="Other"
			,"strong"="N/A"
			,"weak"="N/A"
			,"rank"="E"
	//		,"pic"='Block.png'
			)
		Activate(mob/U)
			if(CMDATKCHK(U)) return
			U.BunshinCommand=1; spawn(5)U.BunshinCommand=0
			for(var/mob/Hittable/Command/Clones/B in U.MasterBunshinList)
				B.icon_state=null
				B.meditating=0
				if(get_dist(U,B)<11&&B.Status!=STATUS_FOLLOW) {B.Status=STATUS_FOLLOW; spawn()B.CloneFollow(U)}

	Bunshin_Meditate
		name="Bunshin Controls: Meditate"
		icon_state="card_BunshinMeditate"
		cmdstring="BunshinMeditate"
		JutsuType = "Other"
		CanLevel=0

		Description = list(
			"about"="Order all clones to meditate."
			,"title"="Bunshin Controls: Meditate"
			,"type"="Other"
			,"strong"="N/A"
			,"weak"="N/A"
			,"rank"="E"
	//		,"pic"='Block.png'
			)
		Activate(mob/U)
			if(CMDATKCHK(U)) return
			U.BunshinCommand=1; spawn(5)U.BunshinCommand=0
			for(var/mob/Hittable/Command/Clones/B in U.MasterBunshinList)
				if(get_dist(U,B)<11 && B.Status!=STATUS_MEDITATE)
					B.Status=STATUS_MEDITATE;
					spawn()
						B.CloneMeditate(U)

	Bunshin_Stay
		name="Bunshin Controls: Stay"
		icon_state="card_BunshinStay"
		cmdstring="BunshinStay"
		JutsuType = "Other"
		CanLevel=0

		Description = list(
			"about"="Order all clones to cease moving."
			,"title"="Bunshin Controls: Stay"
			,"type"="Other"
			,"strong"="N/A"
			,"weak"="N/A"
			,"rank"="E"
	//		,"pic"='Block.png'
			)

		Activate(mob/U)
			if(CMDATKCHK(U)) return
			U.BunshinCommand=1; spawn(5)U.BunshinCommand=0
			for(var/mob/Hittable/Command/Clones/B in U.MasterBunshinList)
				B.icon_state=null
				B.meditating=0
				if(B in oview(U.client.view,U)&&B.Status!=STATUS_STAY) {B.Status=STATUS_STAY}

	Bunshin_DestroyAll
		name="Bunshin Controls: Destroy All"
		icon_state="card_BunshinDispelAll"
		cmdstring="BunshinDestroyAll"
		JutsuType = "Other"
		CanLevel=0

		Description = list(
			"about"="Remove all your clones from the map."
			,"title"="Bunshin Controls: Destroy All"
			,"type"="Other"
			,"strong"="N/A"
			,"weak"="N/A"
			,"rank"="E"
	//		,"pic"='Block.png'
			)

		Activate(mob/U)
			for(var/mob/Hittable/Command/Clones/B in U.MasterBunshinList)
				spawn(pick(1,3,5))
					del(B)

	Bunshin_DestroyOne
		name="Bunshin Controls: Destroy One"
		icon_state="card_BunshinDispelOne"
		cmdstring="BunshinDestroyOne"
		JutsuType = "Other"
		CanLevel=0

		Description = list(
			"about"="Remove one of your clones; automatically picks the oldest clone."
			,"title"="Bunshin Controls: Destroy One"
			,"type"="Other"
			,"strong"="N/A"
			,"weak"="N/A"
			,"rank"="E"
	//		,"pic"='Block.png'
			)

		Activate(mob/U)
			for(var/mob/Hittable/Command/Clones/B in U.MasterBunshinList)
				if(B) del(B)
				break