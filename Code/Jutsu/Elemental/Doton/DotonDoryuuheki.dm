obj/SkillCards/Ninjutsu/Doton/DoryuuHeki
	icon_state="card_doryuuheki"
	cmdstring="DoryuuHeki"
	Range=1
	CCost=600
	Seals=4
	Cooldown = 200
	DM = 1
	Duration = 60

	Description = list(
		"about"="Create a wall out of rock to protect against incoming attacks."
		,"title"="Doton: Doryuu Heki"
		,"type"="Ninjutsu"
		,"Element"="Earth"
		,"weak"="Lightning"
		,"rank"="B"
		,"pic"='DoryuuHeki.png'
		)

	UpgradeChoices = list("Lower Cooldown","Increase Duration","Increase Depth")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)||U.dir==SOUTHWEST||U.dir==SOUTHEAST||U.dir==NORTHWEST||U.dir==NORTHEAST)
			return
		if(U.onwater&&U.EarthElemental<DotonOnWaterCheck) {U<<"Cannot do this on water."; return}
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Heki",(CooldownCur*U.cooldownmultiplier)+s,1)) return
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
				var/turf/t = get_step(U,U.dir)
				if(!t)
					return
				else
					var/turf/t2 = get_step(t,turn(U.dir,-90))
					var/turf/t3 = get_step(t,turn(U.dir,90))
					for(var/i=1 to DM)
						if(t && !t.density)
							var/obj/Jutsu/DoryuuHeki/D = new(t)
							D.dir=U.dir; D.Owner=U
							spawn(Duration)
								del D
							t = get_step(t,U.dir)

						if(t2 && !t2.density)
							var/obj/Jutsu/DoryuuHeki/O = new(t2)
							O.dir=U.dir; O.Owner=U
							spawn(Duration)
								del O
							t2 = get_step(t,turn(U.dir,-90))

						if(t3 && !t3.density)
							var/obj/Jutsu/DoryuuHeki/T = new(t3)
							T.dir=U.dir; T.Owner=U
							spawn(Duration)
								del T
							t3 = get_step(t,turn(U.dir,90))
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
			..()