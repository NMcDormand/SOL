obj/SkillCards/Class/Medical/SliceTendons
	icon_state="card_SliceTendons"
	cmdstring="SliceTendons"
	JutsuType = "Class"
	Cooldown = 1200
	Duration = 50
	CCost = 0
	DM = 10
	Seals = 4

	Description=list(
		"about" = "Slice an opponent's tendons to slow them down. Must have Chakra no Mesu active to use this",
		,"title" = "Slice Tendons",
		,"type" ="Ninjutsu",
		,"strong"="N/A",
		,"weak"="N/A",
		,"rank"="A",
		//,"pic"='Bunshin.png',
	)

	UpgradeChoices = list("Increase Wounds","Increase Duration")

	Activate(mob/U)
		if(!U.Class["Medical-Nin"])
			U << "This technique is disabled as you are not currently an Medic-Nin"
			return
		if(GENERICATTACKCHECK(usr)) return
		if(U.CooldownCheck("SliceTendons",(CooldownCur*U.cooldownmultiplier))) return
		if(!U.InMesu)
			var/obj/SkillCards/Class/Medical/ChakranoMesu/CM = locate() in U.contents
			CM.Activate(U)
			if(!U.InMesu)
				U << "you were unable to create the scalpels necessary to usr this technique"
				return
		for(var/mob/M in get_step(usr,usr.dir))
			if(TAICHECKBOTH(U,M)||M.sliced) return
			if(M.KI_InMission&&(usr in KI_Participants)) {usr<<"They are helping aid with the invasion!"; return;}
			U.MoveUses[name]++
			if(usr.HitCheck(M))
				flick("punch",usr)
				usr.attacking=1; spawn(5)usr.attacking=0
				if(U.PracticeMode || ControlCheck(U)) return ..()
				usr<<"You sliced [M]'s tendons."
				M.sliced=1
				M.Wounds+=DM
				M.DamageMe(src,0)
				spawn(Duration)
					if(M&&M.sliced)
						M.sliced=0
						M<<"Your tendons have healed."
			else
				usr.attacking=1; spawn(15)usr.attacking=null
				usr<<"[M] dodged the attack."; M<<"You dodged [usr]'s attack."