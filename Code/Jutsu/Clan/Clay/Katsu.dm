#if DEBUGGING
mob/verb
	SelfLearnKatsu()
		var/obj/SkillCards/Clan/Clay/Katsu/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Katsu no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Clay/Katsu(src)
#endif

obj/SkillCards/Clan/Clay/Katsu
	icon_state="card_Katsu"
	cmdstring="Katsu"
	CanLevel = 0

	Description= list(
		"about"="Used to Explode any clay explosions set by the user"
		,"title"="Katsu"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="Lightning"
		,"rank"="B"
		,"Tutorial" = "After placing, or throwing, clay bombs at any location use this technique to cause them to instantly explode."
		//,"pic"='Bunshin.png'
	)

	Activate(mob/U)
		for(var/obj/Clay/O in U.ClayBombs)
			if(!O.Exploding)
				O.ExplodeClay()
