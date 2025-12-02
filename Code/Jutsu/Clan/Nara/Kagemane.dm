obj/SkillCards/Clan/Nara/Kagemane
	icon_state="card_Kagemane"
	cmdstring="Kagemane"
	Range=8
	CCost=200
	Seals=3
	Speed = 3
	UpgradeChoices = list("Increase Speed","Lower Cost")

	Description = list(
		"about"="Manipulate your shadow and blend it with the shadow of your opponents in order to bind them where they stand."
		,"title"="Kagemane no Jutsu"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='Kagemane.png'
		)

	Activate(mob/U)
		if(U.choosingHoming)
			return
		if(U.Shadows>=U.ShadowLimit) {U<<"You cannot create any more than [U.ShadowLimit]."; return}
		var/mob/M

		if(ismob(U.Targeting) && get_dist(U.Targeting,U) <= U.KagemaneRange)
			M = U.Targeting
		else
			M = U.TargetSelect(U.KagemaneRange,1)

		if(M)
			if(M in U.ShadowList) {U<<"That target is already acquired."; return}
			if(GENERICATTACKCHECK(U)) return
			if(M.TreeStump||M.protect)
				return
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			U.icon_state="seals"
			if(ChakraUseCheck()) c *= 4
			U.firing=1
			//U.frozen=1
			spawn(s)
				spawn(1)U.icon_state=null
				spawn(5)U.firing=0
				if(prob(U.ChakraControl))
					U.JutsuMessage(Description["title"])
					U.JutsuSeals(s); U.JutsuUseChakra(c); U.JutsuNin(c)
					U.MoveUses[name]++

					if(U.PracticeMode || ControlCheck(U))
						return ..()

					if(U.Shadows<1)
						var/obj/Jutsu/Nara/KagemaneSource/K=new(U.loc)
						K.target=M;
						K.Owner=U;
						U.TrailList+=K
					U.Shadows++; U.AcquiringList+=M

					var/obj/Jutsu/Nara/KagemaneHead/H = new(U.loc)
					H.dir=U.dir; U.TrailList+=H; H.Owner=U; H.target=M; H.Ninjutsu=U.Ninjutsu; H.Kagemane_CloseIn(M,Speed,c)

					spawn(U.KagemaneRange)
						if((H&&!H.AcquiredTarget)||!H) U.KagemaneMiss(M)
					for(var/obj/Jutsu/Nara/Trail/T in U.loc) del(T)
					spawn(3)
						for(var/obj/Jutsu/Nara/Trail/Z in range(1,U))
							if(Z.target==M) {var/obj/Jutsu/Nara/KagemaneSemiTrail/S = new(U.loc); U.TrailList+=S; S.target=M; S.dir=get_dir(S,Z)}
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"; U.frozen=0; return}
				..()
