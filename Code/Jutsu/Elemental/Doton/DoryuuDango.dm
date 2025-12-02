obj/SkillCards/Ninjutsu/Doton/DoryuuDango
	icon_state="card_doryuudango"
	cmdstring="DoryuuDango"
	Range=8
	CCost=900
	Seals=9
	Cooldown = 280
	Shots = 1

	Description = list(
		"about"="Send a giant ball of earth at your opponents."
		,"title"="Doton: Doryuu Dango"
		,"type"="Ninjutsu"
		,"Element"="Earth"
		,"weak"="Lightning"
		,"rank"="C"
//		,"pic"='DoryuuDango.png'
		)

	UpgradeChoices = list("More Shots","Lower Cooldown","Lower Cost")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U))
			return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.onwater&&U.EarthElemental<DotonOnWaterCheck) {U<<"Cannot do this on water."; return}
		if(U.CooldownCheck("DoryuuDango",(CooldownCur*U.cooldownmultiplier)+s,1)) return
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
				var/N = round(Shots * 0.5)
				for(var/i=1 to Shots)
					var/obj/Jutsu/DoryuuDango/A = new(U.loc)
					A.EarthElemental = U.EarthElemental; A.Ninjutsu=U.Ninjutsu; A.Owner=U
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
					NewProjectile(U,A,src,1,1.4,A.loc)
				/*var/ST = 0
				for(var/i=1 to Shots)
					var/obj/Jutsu/DoryuuDango/I=new()
					var/turf/T
					switch(ST)
						if(1)
							T = get_step(U,turn(U.dir,90))
						if(2)
							T = get_step(U,turn(U.dir,-90))
						else
							T = U.loc
					if(T)
						I=new(T)
						I.EarthElemental= U.EarthElemental; I.Ninjutsu=U.Ninjutsu; I.Owner=U
						walk(I,U.dir)
					ST++*/
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()