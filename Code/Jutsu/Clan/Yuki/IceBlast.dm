obj/SkillCards/Clan/Yuki/IceBlast
	icon_state="card_IceBlast"
	cmdstring="IceBlast"
	Range=7
	CCost=800
	Seals=3
	Cooldown = 1500
	Shots = 1

	Description = list(
		"about"="Trap your opponent in ice."
		,"title"="Hyouton: Ice Blast"
		,"type"="Ninjutsu"
		,"Element"="Ice"
		,"weak"="Fire"
		,"rank"="C"
//		,"pic"='IceBlast.png'
		)

	UpgradeChoices = list("More Shots","Lower Cooldown","Lower Cost")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("IceBlast",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 4
		U.firing=1
		U.icon_state="seals"
		spawn(s)
			spawn(12)U.firing=0
			U.icon_state=null
			if(prob(U.ChakraControl))
				U.JutsuSeals(s); U.JutsuNin(c); U.ElementalUp("Ice");
				U.MoveUses[name]++
				U.JutsuUseChakra(c)
				U.JutsuMessage(Description["title"])
				if(U.PracticeMode || ControlCheck(U)) return ..()
				var/N = round(Shots * 0.5)
				for(var/i=1 to Shots)
					var/obj/Yuki/IceBlast/A = new(U.loc)
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
					NewProjectile(U,A,src,0.8,1,A.loc)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()