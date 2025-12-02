#if DEBUGGING
mob/verb
	SelfLearnKotoamatsukami()
		var/obj/SkillCards/Clan/Uchiha/MS/Kotoamatsukami/J=locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Kotoamatsukami no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Uchiha/MS/Kotoamatsukami(src)
#endif

obj/SkillCards/Clan/Uchiha/MS/Kotoamatsukami
	icon_state="card_Kotoamatsukami"
	cmdstring="Kotoamatsukami"
	CCost = 15000
	Seals = 0
	Duration = 50
	Cooldown = 8000

	Description = list(
		"about"="The user manipulates the victims mind to self inflict damage. There is no escape to this Genjutsu"
		,"title"="Kotoamatsukami"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
//		,"pic"='Dispel.png'
	)