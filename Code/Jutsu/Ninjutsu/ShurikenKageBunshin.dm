obj/SkillCards/Ninjutsu/ShurikenKageBunshin
	icon_state="card_ShurikenKageBunshin"
	cmdstring="shurikenkagebunshin"
	CCost=2000
	Seals=2
	Cooldown = 1800
	DM = 1
	Shots = 1

	Description = list(
		"about"="Throw Shuriken and duplicate them identically to create more shuriken."
		,"title"="Shuriken Kage Bunshin"
		,"type"="Ninjutsu"
		,"weak"="N/A"
		,"rank"="A"
		//,"pic"='Chidori.png'
	)

	UpgradeChoices = list("More Shuriken Clones","More Shots")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("KageShuriken",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 4
		var/obj/Weapon/Thrown/Shuriken/S = locate() in U
		if(S&&S.amount>0)
			U.firing=1
			spawn(s)
				spawn(10)U.firing=0
				if(prob(U.ChakraControl))
					U.JutsuSeals(s); U.JutsuNin(c);
					U.MoveUses[name]++
					U.JutsuUseChakra(c)
					U.JutsuMessage(Description["title"])
					if(U.PracticeMode || ControlCheck(U)) return ..()
					U<<"<i>You throw the shuriken</i>"
					U.MoveUses["ShurikenThrows"]++;
					var/obj/Weapon/Thrown/ThrownShuriken/x=new(loc)
					x.Taijutsu=U.Taijutsu; x.ThrowingSkill=U.ThrowingSkill*10; x.Owner=U

					x.icon = S.icon
					IDCOPY(x,U)
					S.amount--
					if(S.amount<1) del(S)
					else S.Checkamount()
					U.ApplyEXP(11,"throwing")
					walk(x,U.dir); spawn(11)del(x)
					U.throwing=1; spawn(12)U.throwing=0
					if(x)
						var/DIR = dir
						var/MU = x.Multiplier*DM
						spawn()
							flick("bunshin",src)
							x.icon_state = "[DM]"
						x.Multiplier = MU

						for(var/i = 1 to Shots)
							var/obj/Weapon/Thrown/ThrownShuriken/Bunshin/Q = new/obj/Weapon/Thrown/ThrownShuriken/Bunshin(U.loc)
							var/obj/Weapon/Thrown/ThrownShuriken/Bunshin/W = new/obj/Weapon/Thrown/ThrownShuriken/Bunshin(get_step(Q,turn(U.dir,90)))
							var/obj/Weapon/Thrown/ThrownShuriken/Bunshin/E = new/obj/Weapon/Thrown/ThrownShuriken/Bunshin(get_step(Q,turn(U.dir,-90)))

							Q.appearance = x.appearance; W.appearance = x.appearance; E.appearance = x.appearance;
							Q.Multiplier = MU; W.Multiplier = MU; E.Multiplier = MU;

							IDCOPY(Q,U)
							IDCOPY(W,U)
							IDCOPY(E,U)

							Q.Taijutsu=Taijutsu; Q.ThrowingSkill=ThrowingSkill; Q.Owner=U
							W.Taijutsu=Taijutsu; W.ThrowingSkill=ThrowingSkill; W.Owner=U
							E.Taijutsu=Taijutsu; E.ThrowingSkill=ThrowingSkill; E.Owner=U
							walk(Q,DIR); walk(W,DIR); walk(E,DIR)
							spawn(11)
								if(Q)del(Q)
								if(W)del(W)
								if(E)del(E)
							sleep(2)
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()
		else {U<<"You need at least one shuriken"; return}
