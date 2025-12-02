obj/SkillCards/Clan/Yuki/SensatsuSuishou
	icon_state="card_SensatsuSuishou"
	cmdstring="SensatsuSuishou"
	Range=7
	CCost=120
	Seals=1
	Cooldown = 380
	DM = 5
	Shots = 1

	Description = list(
		"about"="Form ice needles and throw them at your opponent."
		,"title"="Hyouton: Sensatsu Suishou"
		,"type"="Ninjutsu"
		,"Element"="Ice"
		,"weak"="Fire"
		,"rank"="D"
//		,"pic"='Sensatsu.png'
	)

	UpgradeChoices = list("Lower Cooldown","More Shots")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("sensatsu",(CooldownCur*U.cooldownmultiplier)+s,1)) return
		if(ChakraUseCheck()) c *= 4
		U.firing=1
		spawn(s)
			spawn(3)
				if(U)
					U.firing=0
			U.icon_state=null
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s); U.JutsuNin(c); U.ElementalUp("Ice",0.25);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				if(U.PracticeMode || ControlCheck(U)) return ..()

				var/N = round(Shots * 0.5)
				for(var/i=1 to Shots)
					var/obj/Yuki/Sensatsu/A = new(U.loc)
					A.IceElemental = U.IceElemental; A.Ninjutsu=U.Ninjutsu; A.Owner=U
					if(Shots>1)
						if(U.dir==NORTH||U.dir==SOUTH)
							A.loc=locate(U.x+N,U.y,U.z)
						else if(U.dir==EAST||U.dir==WEST)
							A.loc=locate(U.x,U.y+N,U.z)
						else if(U.dir==NORTHEAST||U.dir==SOUTHWEST)
							A.loc=locate(U.x-N,U.y+N,U.z)
						else if(U.dir==SOUTHEAST||U.dir==NORTHWEST)
							A.loc=locate(U.x+N,U.y+N,U.z)
						N-=1
					NewProjectile(U,A,src,DM*0.1,DM,A.loc)
					spawn(14)
						if(A) A.loc=null

			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

