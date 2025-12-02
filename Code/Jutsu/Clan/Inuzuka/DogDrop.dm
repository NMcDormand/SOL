obj/SkillCards/Clan/Inuzuka/Commands/DogDrop
	icon_state="card_DogDrop"
	cmdstring="DogDrop"

	Description = list(
		"about"="Place your dog out."
		,"title"="Dog: Drop"
		,"type"="Other"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='CallDog.png'
		)

	Activate(mob/U)
		if(CMDATKCHK(U)) return
		var/mob/Hittable/Responsive/Animal/Pet/P=U.Familiar
		if(P && P.loc == U)
			/*if(U.InJuujin)
				U<<"You cant pick it up right now"*/
			IDCOPY(P,U)

			P.loc=U.loc; P.CantWalk=0; P.protect=U.protect; U.StatUpdate_dogStuff();
			P.NinjaRank=U.NinjaRank;
			P.DogFollow(U)

			P.Reflex=(U.Reflex*0.5);
			P.Cap_Stamina=U.Cap_Stamina;
			P.Cap_Taijutsu=U.Cap_Taijutsu;

			for(var/area/A in view(0,P))
				A.Entered(P)
			if(P.loc.loc)
				P.loc.loc.Entered(P)
			P.Reflex = U.Reflex
			switch(U.NinjaRank)
				if("Academy Student","Genin")
					//Dog should be small
					var/icon/I=icon('DogS.dmi')
					I.Blend(U.DogColour)
					P.pixel_x = 0
					P.icon = I;
					P.OriginalIcon = I
				if("Chuunin","Special Jounin","Anbu","Jounin")
					//Dog should be medium
					var/icon/I=icon('Dog.dmi')
					I.Blend(U.DogColour)
					P.pixel_x = 0
					P.icon = I;
					P.OriginalIcon = I
				else
					//Dog should be large
					var/icon/I=icon('Dog.dmi')
					I.Blend(U.DogColour)
					I.Scale(48,48)
					P.pixel_x = -8
					P.icon = I
					P.OriginalIcon = I
		else
			U<<"[U.DogName] isn't with you!"