mob/var/tmp/Finishing
obj/SkillCards/Taijutsu/Starter/Finish
	icon_state="card_finish"
	JutsuType = "Taijutsu"
	cmdstring="Finish"
	VerbIt=1
	CanLevel=0

	Description = list(
		"about"="Will kill any unconcious player. Will do nothing on a concious player."
		,"title"="Finish"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="E"
		,"pic"='Finish.png'
	)

	Activate(mob/U)
		if(U.InVillage == Village && U.NinjaRank == "Academy Student")
			U << "Leave the dirty work to Shinobi of the village"
			return
		for(var/mob/M in get_step(U,U.dir))
			if(TAICHECKBOTH(U,M)||!M.KO||IDCHECK(M,src))
				continue
			if(istype(M,/mob/player) && M.KI_InMission)
				return
			U.attacking=1; spawn(U.atkspeed+3)U.attacking=0
			if(U.FinishMSG)
				hearers(U)<<output("[U.Brand]<b><font face=verdana color=[U.VillageColour]>[U]</font> says</b>: [U.FinishMSG]","Chat")
			U.Finishing=1; flick("punch",U); U.ExperienceCheck(0,M); M.Wounds=200; M.KillMe(U); U.Finishing=0