obj/SkillCards/Class/Medical/RanshinShou
	icon_state="card_RanshinShou"
	cmdstring="RanshinShou"
	JutsuType = "Class"
	Cooldown = 1800
	DM = 8
	CCost = 200
	Seals = 4

	Description=list(
		"about" = "Disrupt the victims nerves causing impaired movement.",
		,"title" = "Ranshin Shou",
		,"type" ="Ninjutsu",
		,"strong"="N/A",
		,"weak"="N/A",
		,"rank"="A",
		//,"pic"='Bunshin.png',
	)

	UpgradeChoices = list("Increase Duration","Lower Cooldown")

	Activate(mob/U)
		if(!U.Class["Medical-Nin"])
			U << "This technique is disabled as you are not currently an Medic-Nin"
			return
		if(GENERICATTACKCHECK(usr)) return
		if(U.CooldownCheck("RanshinShou",(CooldownCur*U.cooldownmultiplier))) return
		for(var/mob/M in get_step(usr,usr.dir))
			if(TAICHECKBOTH(U,M)||M.Nerves) return
			if(M.KI_InMission&&(usr in KI_Participants)) {usr<<"They are helping aid with the invasion!"; return;}
			U.MoveUses[name]++
			if(usr.HitCheck(M))
				flick("punch",usr)
				usr.attacking=1; spawn(5)usr.attacking=null
				if(U.PracticeMode || ControlCheck(U)) return ..()
				usr<<"You disrupted [M]'s nerves.";
				M<<"[usr] disrupted your nerves."
				M.disruptNerves(Duration)
			else
				usr.attacking=1; spawn(10)usr.attacking=null
				usr<<"[M] dodged the attack."; M<<"You dodged [usr]'s attack."


mob/proc
	disruptNerves(Dur = 200)
		Nerves=1
		spawn(Dur)
			if(src&&Nerves)
				Nerves=0
				src<<"Your nerves have returned to normal."