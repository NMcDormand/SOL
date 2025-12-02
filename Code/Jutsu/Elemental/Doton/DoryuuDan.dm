obj/SkillCards/Ninjutsu/Doton/DoryuuDan
	icon_state="card_doryuudan"
	cmdstring="DoryuuDan"
	Range=8
	CCost=1500
	Seals=10
	Cooldown = 800
	Shots = 3

	Description = list(
		"about"="Launched targeted earth attacks at your opponent."
		,"title"="Doton: Doryuu Dan"
		,"type"="Ninjutsu"
		,"Element"="Earth"
		,"weak"="Lightning"
		,"rank"="C"
//		,"pic"='DoryuuDan.png'
		)

	UpgradeChoices = list("Lower Cost","More Shots")

	Activate(mob/U)
		if(U.choosingHoming)
			return
		if(GENERICATTACKCHECK(U))
			return
		var/mob/M
		if(ismob(U.Targeting)&&get_dist(U.Targeting,U)<= Range)
			M = U.Targeting
		else
			M = U.TargetSelect(Range)
		if(M)
			if(U.onwater&&U.EarthElemental<DotonOnWaterCheck) {U<<"Cannot do this on water."; return}
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("Doryuudan",(CooldownCur*U.cooldownmultiplier)+s,1)) return
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
					U.ElementalUp("Earth")
					if(U.PracticeMode || ControlCheck(U)) return ..()
					var/obj/Jutsu/DoryuudanSpawn/S=new(get_step(U,get_dir(U,M)))
					IDCOPY(S,U)
					S.dir=get_dir(S,M)
					for(var/i= 1 to Shots)
						if(!S||!M)
							break
						var/obj/Jutsu/Doryuudan/D=new(S.loc)
						IDCOPY(D,U)
						D.Ninjutsu=U.Ninjutsu; D.EarthElemental=U.EarthElemental
						D.Owner=U; D.target=M; D.movespeed = 1
						D.BetterHoming(M,M.loc)
						spawn(20)
							if(D)
								del D
						sleep(2)

					spawn(10)
						del S

				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
				..()