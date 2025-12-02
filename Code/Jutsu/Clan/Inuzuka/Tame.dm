obj/SkillCards/Clan/Inuzuka/Tame
	icon_state="card_Tame"
	cmdstring="Tame"

	Description = list(
		"about"="Tame a wild dog to become your pet"
		,"title"="Tame Dog"
		,"type"="Other"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='Tame.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		for(var/mob/Hittable/Responsive/Animal/Wild/Dog/P in get_step(U,U.dir))
			if(P.Master) {U<<"This dog belongs to [P.Master]!"; return}
			P.Master=U
			namepet
			P.loc = null
			var/dogname = input("What will you call your new companion?","Pet") as text
			var/list/T=list("<font","<font","<B>","<I>","<U>","<br","span","div")
			for(var/H in T)
				if(findtext(dogname,H)){U<<"<font color=red>No HTML in names.</font>"; goto namepet}
			if(length(dogname)>20||length(dogname)<2||!dogname||dogname == "")
				alert("Name too long or short.")
				goto namepet

			var/mob/Hittable/Responsive/Animal/Pet/Dog/C = new(U)
			if(!C)
				world << "Not created"
				return
			U.DogColour = P.HairColour
			C.name=dogname; U.DogName=C.name
			C.Master=U; U.Familiar=C; U.HasDog=1

			U.DogTaijutsu=P.Taijutsu; U.DogTaijutsuXP=P.TaijutsuXP; P.DogTaijutsuMXP=C.TaijutsuMXP
			U.DogStaminaMax=P.StaminaMax; U.DogStaminaExp=P.StaminaXP; U.DogStaminaMXP=C.StaminaMXP

			C.Taijutsu=P.Taijutsu; C.StaminaMax=P.StaminaMax; C.Stamina=P.StaminaMax;

			new/obj/SkillCards/Clan/Inuzuka/Commands/DogCall(U)
			new/obj/SkillCards/Clan/Inuzuka/Commands/DogAttack(U)
			new/obj/SkillCards/Clan/Inuzuka/Commands/DogStay(U)
			new/obj/SkillCards/Clan/Inuzuka/Commands/DogDrop(U)
			new/obj/SkillCards/Clan/Inuzuka/Commands/DogPickup(U)

			U<<"[C] is now your K-9 Companion! [C] will become stronger through hitting stumps and climbing mountains. You can also spend your stat points on [C]."

			del P
			del src