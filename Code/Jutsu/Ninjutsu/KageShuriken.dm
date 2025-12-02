obj/SkillCards/Ninjutsu/KageShuriken
	icon_state="card_KageShuriken"
	cmdstring="kageshuriken"
	CCost=1000
	Seals=2
	Cooldown = 400
	DM = 1
	Shots = 1

	Description = list(
		"about"="Throw Shuriken with one hidden cloned copy."
		,"title"="Kage Shuriken"
		,"type"="Ninjutsu"
		,"weak"="N/A"
		,"rank"="B"
		//,"pic"='Chidori.png'
	)

	UpgradeChoices = list("Increase Damage","Lower Cost")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals;
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("KageShuriken",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 4
		var/obj/Weapon/Thrown/Shuriken/S = locate() in U
		if(!S) {U<<"You need at least one shuriken"; return}
		U.firing=1
		spawn(s)
			spawn(10)U.firing=0
			U.throwing=1; spawn(12)U.throwing=0
			if(prob(U.ChakraControl))
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c)
				U.JutsuMessage(Description["title"])
				if(U.PracticeMode || ControlCheck(U)) return ..()
				U.UpdateInventory()
				var/obj/Weapon/Thrown/ThrownShuriken/TS=new(U.loc)
				TS.Taijutsu=U.Taijutsu; TS.ThrowingSkill=U.ThrowingSkill*5; TS.Owner=U; TS.Multiplier = S.Multiplier*DM
				TS.appearance = S.appearance; TS.icon_state = "KS"
				IDCOPY(TS,U)
				walk(S,U.dir)
				U<<"<i>You threw a shuriken</i>"
				U.ApplyEXP(9,"throwing")
				U.MoveUses["ShurikenThrows"]++;
				S.amount--
				if(S.amount<1) del(S)
				else S.Checkamount()
				spawn(11)
					del(S)
				spawn(2)
					var/obj/Weapon/Thrown/ThrownShuriken/H=new(U.loc)
					H.Taijutsu=U.Taijutsu; H.ThrowingSkill=U.ThrowingSkill*5;
					H.Owner=U; H.Multiplier = TS.Multiplier;
					H.appearance = TS.appearance;
					H.invisibility= 8
					IDCOPY(H,U)
					walk(H,U.dir)
					spawn(11)
						del(H)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()