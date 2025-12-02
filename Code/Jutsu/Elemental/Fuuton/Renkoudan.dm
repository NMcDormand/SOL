#if DEBUGGING
mob/verb
	SelfLearnRenkoudan()
		var/obj/SkillCards/Ninjutsu/Fuuton/Renkoudan/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Fuuton: Renkoudan no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Fuuton/Renkoudan(src)
#endif

obj/SkillCards/Ninjutsu/Fuuton/Renkoudan
	icon_state="card_Renkoudan"
	cmdstring="Renkoudan"
	Range=15
	CCost=2000
	Seals=8
	Cooldown = 600
	DM = 30
	Speed = 3
	Shots = 1

	Description = list(
		"about"="Send a heavily damaging wind projectile at your opponents."
		,"title"="Fuuton: Renkoudan"
		,"type"="Ninjutsu"
		,"Element"="Earth"
		,"weak"="Fire"
		,"rank"="TBC"
//		,"pic"='Renkoudan.png'
	)

	UpgradeChoices = list("Increase Damage","More Shots","Increase Speed")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U))
			return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Renkoudan",(CooldownCur*U.cooldownmultiplier)+s,1)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(3)U.firing=0
			//if(U.dir==NORTHWEST||U.dir==SOUTHWEST||U.dir==NORTHEAST||U.dir==SOUTHEAST) return
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.ElementalUp("Wind")
				if(U.PracticeMode || ControlCheck(U)) return ..()
				var/N = round(Shots*0.5)
				var/X = U.x
				var/Y = U.y
				var/Z = U.z
				var/list/Bullets = list()
				for(var/i = 1 to Shots)
					var/turf/LOC
					switch(U.dir)
						if(NORTH)
							LOC = locate(X-1+N,Y-2,Z)
						if(SOUTH)
							LOC = locate(X-1+N,Y,Z)
						if(WEST)
							LOC = locate(X,Y-1+N,Z)
						if(EAST)
							LOC = locate(X-2,Y-1+N,Z)
						if(NORTHWEST)
							LOC = locate(X-N,Y-2-N,Z)
						if(NORTHEAST)
							LOC = locate(X-2+N,Y-2-N,Z)
						if(SOUTHWEST)
							LOC = locate(X+N,Y-N,Z)
						if(SOUTHEAST)
							LOC = locate(X-2-N,Y-N,Z)
					if(LOC)
						var/obj/Jutsu/Fuuton/Renkoudan/F=new(LOC)
						IDCOPY(F,U)
						Bullets += F
					N-=1
				for(var/obj/Jutsu/J in Bullets)
					NewProjectile(U,J,src,1,DM,J.loc)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
			..()