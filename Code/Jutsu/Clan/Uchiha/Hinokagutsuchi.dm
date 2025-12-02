#if DEBUGGING
mob/verb
	SelfLearnHinokagutsuchi()
		var/obj/SkillCards/Clan/Uchiha/MS/Hinokagutsuchi/J=locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Hinokagutsuchi no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Uchiha/MS/Hinokagutsuchi(src)
#endif

obj/SkillCards/Clan/Uchiha/MS/Hinokagutsuchi
	icon_state="card_Hinokagutsuchi"
	cmdstring="Hinokagutsuchi"
	CCost = 15000
	Seals = 0
	Duration = 50
	Cooldown = 8000

	Description = list(
		"about"="The user creates a large fireball similar to amatarasu"
		,"title"="Hinokagutsuchi"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
//		,"pic"='Dispel.png'
	)