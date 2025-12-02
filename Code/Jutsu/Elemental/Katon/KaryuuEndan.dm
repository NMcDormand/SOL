obj/SkillCards/Ninjutsu/Katon/KaryuuEndan
	icon_state="card_KaryuuEndan"
	cmdstring="KaryuuEndan"
	Range=7
	CCost=650
	Seals=11
	DM = 1
	Cooldown = 700

	Description = list(
		"about"="Send a powerful homing flame at your opponent."
		,"title"="Katon: Karyuu Endan"
		,"type"="Ninjutsu"
		,"Element"="Fire"
		,"weak"="Water"
		,"rank"="B"
		//,"pic"='KaryuuEndan.png'
	)

	UpgradeChoices = list("Increase Damage","Lower Cooldown")

	Activate(mob/U)
		if(U.choosingHoming) return
		if(GENERICATTACKCHECK(U)) return

		var/mob/M
		if(ismob(U.Targeting)&&get_dist(U.Targeting,U)<= Range)
			M = U.Targeting
		else
			M = U.TargetSelect(Range)

		if(M)
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("Endan",(CooldownCur*U.cooldownmultiplier)+s,1)) return
			if(U.CooldownCheck("Homing",(100*U.cooldownmultiplier)+s,1)) return
			if(ChakraUseCheck()) c *= 4
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				spawn(1)U.icon_state=null
				spawn(3)U.firing=0
				if(prob(U.ChakraControl))
					U.JutsuMessage(Description["title"])
					U.JutsuSeals(s); U.JutsuNin(c);
					U.MoveUses[name]++
					U.JutsuUseChakra(c);
					U.ElementalUp("Fire")
					if(U.PracticeMode || ControlCheck(U)) return ..()
					var/obj/Jutsu/Katon/KaryuuEndan/K=new/obj/Jutsu/Katon/KaryuuEndan
					K.Ninjutsu=U.Ninjutsu; K.FireElemental=U.FireElemental*DM
					K.loc=U.loc; K.dir=U.dir; K.target=M; K.Owner=U
					K.Homing(M,M.loc)
					spawn(28)del(K)
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
				..()