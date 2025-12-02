obj/SkillCards/Ninjutsu/Raiton/RairyuunoTatsumaki
	icon_state="card_RairyuunoTatsumaki"
	cmdstring="RairyuunoTatsumaki"
	Range=6
	CCost=250
	Seals=7
	Cooldown = 400
	DM = 0.5
	Tracker = 2

	Description = list(
		"about"="Launch a targeted lightning attack."
		,"title"="Raiton: Rairyuuno Tatsumaki"
		,"type"="Ninjutsu"
		,"Element"="Lightning"
		,"weak"="Earth"
		,"rank"="B"
//		,"pic"='RairyuunoTatsumaki.png'
		)

	UpgradeChoices = list("Increase Damage","Lower Cooldown")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)||U.choosingHoming)
			return
		var/mob/M

		if(ismob(U.Targeting)&&get_dist(U.Targeting,U)<= Range)
			M = U.Targeting
		else
			M = U.TargetSelect(Range)
		if(M)
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("Rairyuu",(CooldownCur*U.cooldownmultiplier)+s,1)) return
			if(U.CooldownCheck("Homing",(100*U.cooldownmultiplier)+s,1)) return
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
					U.ElementalUp("Lightning")
					if(U.PracticeMode || ControlCheck(U)) return ..()
					if(M)
						var/obj/Jutsu/Raiton/RairyuunoTatsumaki/R=new(U.loc)
						NewProjectile(U,R,src,1,DM)
						R.Ninjutsu=U.Ninjutsu*(DM); R.LightningElemental=U.LightningElemental*DM
						R.target=M; R.Owner=U; R.BetterHoming(M,M.loc)
						spawn(16)
							del(R)
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()