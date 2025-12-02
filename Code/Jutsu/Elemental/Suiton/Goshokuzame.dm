obj/SkillCards/Ninjutsu/Suiton/GoshoKuzame
	icon_state="card_goshokuzame"
	cmdstring="GoshoKuzame"
	Range=4
	CCost=3000
	Seals=7
	Cooldown = 5000
	Shots = 5
	Speed = 2

	Description = list(
		"about"="Ravage opponents below the surface of the water."
		,"title"="Suiton: Gosho Kuzame"
		,"type"="Ninjutsu"
		,"Element"="Fire"
		,"weak"="Lightning"
		,"rank"="B"
//		,"pic"='GoshoKuzame.png'
		)

	UpgradeChoices = list("Increase Speed","More Sharks")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)||U.choosingHoming) return
		var/mob/M
		if(ismob(U.Targeting)&&get_dist(U.Targeting,U)<= Range)
			M = U.Targeting
		else
			M = U.TargetSelect(Range,1)
		if(M)
			if(!U.onwater && U.WaterElemental < SuitonOnEarthCheck*4) {U<<"You must be on water to use this."; return}
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("GoshoKuzame",(CooldownCur*U.cooldownmultiplier)+s,1)) return
			if(ChakraUseCheck()) c *= 4
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				spawn(1)U.icon_state=null
				spawn(2)U.firing=0
				if(prob(U.ChakraControl))
					U.JutsuMessage(Description["title"])
					U.JutsuSeals(s); U.JutsuNin(c);
					U.MoveUses[name]++
					U.JutsuUseChakra(c);
					U.ElementalUp("Water")
					if(U.PracticeMode || ControlCheck(U)) return ..()
					for(var/i=1 to Shots)
						var/obj/Jutsu/Suiton/Goshokuzame/S=new(U.loc)
						S.Ninjutsu=U.Ninjutsu; S.WaterElemental=U.WaterElemental; S.target=M
						S.dir=U.dir; S.movespeed=Speed; S.Owner=U
						spawn()
							S.BetterHoming(M)
						spawn(48)
							del(S)
						sleep(1)

				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()