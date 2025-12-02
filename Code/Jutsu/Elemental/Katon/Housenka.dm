obj/SkillCards/Ninjutsu/Katon/Housenka
	icon_state="card_Housenka"
	cmdstring="Housenka"
	Range=14
	CCost=350
	Seals=8
	DM = 1
	Shots = 3
	Cooldown = 500

	Description = list(
		"about"="Send homing fireballs at your opponent."
		,"title"="Katon: Housenka"
		,"type"="Ninjutsu"
		,"Element"="Fire"
		,"weak"="Water"
		,"rank"="B"
//		,"pic"='Housenka.png'
		)

	UpgradeChoices = list("Increase Damage","More Shots")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Housenka",(CooldownCur*U.cooldownmultiplier)+s,1)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(4)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.ElementalUp("Fire")
				if(U.PracticeMode || ControlCheck(U)) return ..()

				var/N = round(Shots * 0.5)
				for(var/i=1 to Shots)
					var/obj/Jutsu/Katon/Housenka/A=new(U.loc)
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
					NewProjectile(U,A,src,1,DM,A.loc)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()