obj/SkillCards/Clan/Inuzuka/JuujinBunshin
	icon_state="card_JuujinBunshin"
	cmdstring="JuujinBunshin"
	CCost=100
	Seals=3
	Duration = 300

	UpgradeChoices = list("Increase Duration","Lower Cooldown")

	Description = list(
		"about"="Have your companion transform into a clone of yourself."
		,"title"="Juujin Bunshin no Jutsu"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='JuujinBunshin.png'
		)

	Activate(mob/U)
		var/mob/Hittable/Responsive/Animal/Pet/P=U.Familiar
		if(!P)
			U<<"You don't seem to have a companion..."
			return
		else if(P.InJuujin)
			flick('Smoke.dmi',P)
			P.overlays=null
			P.icon=P.OriginalIcon
			P.InJuujin=0
			return
		if(GENERICATTACKCHECK(U)||!P) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(get_dist(U,P)>12 && P.loc != U) {U<<"[P] is not in range."; return}
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			U.icon_state=null
			spawn(20) U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuSeals(s); U.JutsuNin(c); U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.JutsuMessage(Description["title"])
				if(U.PracticeMode || ControlCheck(U)) return ..()
				if(P)
					if(P.loc == U)
						P.loc=U.loc; P.CantWalk=0; P.protect=U.protect; U.StatUpdate_dogStuff();
						P.NinjaRank=U.NinjaRank;
						P.DogFollow(U)

						P.Reflex=(U.Reflex*0.5);
						P.Cap_Stamina = U.Cap_Stamina;
						P.Cap_Taijutsu = U.Cap_Taijutsu;

						for(var/area/A in view(0,P))
							A.Entered(P)

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
								P.pixel_x = -4
								P.icon = I
								P.OriginalIcon = I
					P.InJuujin=1
				spawn(2)
					if(P)
						flick('Smoke.dmi',P)
						P.appearance = U.appearance
				spawn(Duration)
					if(P)
						if(P.InJuujin)
							flick('Smoke.dmi',P)
							P.overlays=null
							P.icon=P.OriginalIcon
							P.InJuujin=0
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()