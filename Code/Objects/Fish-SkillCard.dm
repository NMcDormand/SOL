obj/SkillCards/Starter/Fish
	icon_state="card_Fish"
	JutsuType = "Other"
	cmdstring="GoFish"

	Description = list(
		"about"="Cast a line in pools of water to try and catch Fish"
		,"title"="Fish"
		,"type"="Fish"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='Action.png'
	)

	Activate(mob/U)
		set background = 1
		if(U.afkFishing||U.fishing)
			U.afkFishing = 0
		else
			if(U.CooldownCheck("Fishing",300)) return
			var/turf/M=get_step(U,U.dir)
			if(M)
				if(!istype(M.loc,/area/Water))
					U<<"You must be near water to fish"
					return
				REDO
				var/obj/Item/rod/R = U.SelectRod()
				if(R)
					U.afkFishing++
					if(U.afkFishing == 1)
						while(U.afkFishing && R && R.Durability > 0)
							if(U.afkFishing>1)
								U.afkFishing--
								return
							if(AutoFishingAttackCheck(U))
								U.afkFishing=0
								return
							else
								if(R.Durability > 0)
									R.Fish(U)
								else
									break
							sleep(1)
						if(U.afkFishing)
							U.afkFishing = 0
							goto REDO
				else
					U << "You dont have any Fishing Rod's you can use"