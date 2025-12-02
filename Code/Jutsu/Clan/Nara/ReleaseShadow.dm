obj/SkillCards/Clan/Nara/KagemaneRelease
	icon_state="card_KagemaneRelease"
	cmdstring="KagemaneRelease"
	CanLevel = 0
	Description = list(
		"about"="Release an opponent that has been captured by your shadow manipulation."
		,"title"="Kagemane: Release"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='Kagemane.png'
	)
	Activate(mob/U)
		var/SL = U.ShadowList.len
		if(!SL)
			return
		if(SL>1)
			var/mob/R=input("Who would you like to release?","Kagemane Release") as null|anything in list("All") + U.ShadowList
			if(R)
				if(R=="All")
					for(var/mob/RME in U.ShadowList)
						U.ReleaseKagemane(RME);
				else
					U.ReleaseKagemane(R)
		else
			var/mob/s = pick(U.ShadowList)
			U.ReleaseKagemane(s)