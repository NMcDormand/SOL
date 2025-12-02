#if DEBUGGING
mob/verb
	SelfLearnGoukakyuu()
		var/obj/SkillCards/Ninjutsu/Katon/Goukakyuu/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Katon: Goukakyuu no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Katon/Goukakyuu(src)
#endif

obj/SkillCards/Ninjutsu/Katon/Goukakyuu
	icon_state="card_Goukakyuu"
	cmdstring="Goukakyuu"

	Range=8
	CCost=240
	Seals=6
	Cooldown = 480
	Speed = 3
	DM = 1

	Description = list(
		"about"="Send out a huge flaming fireball at opponents."
		,"title"="Katon: Goukakyuu"
		,"type"="Ninjutsu"
		,"Element"="Fire"
		,"weak"="Water"
		,"rank"="B"
		,"pic"='Goukakyuu.png'
	)

	UpgradeChoices = list("Increase Damage","Lower Cooldown")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Goukak",(CooldownCur*U.cooldownmultiplier)+s,1)) return
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
				var/turf/LOC
				switch(U.dir)
					if(NORTH)
						LOC = locate(U.x-1,U.y-2,U.z)
					if(SOUTH)
						LOC = locate(U.x-1,U.y,U.z)
					if(WEST)
						LOC = locate(U.x,U.y-1,U.z)
					if(EAST)
						LOC = locate(U.x-2,U.y-1,U.z)
					if(NORTHWEST)
						LOC = locate(U.x,U.y-2,U.z)
					if(NORTHEAST)
						LOC = locate(U.x-2,U.y-2,U.z)
					if(SOUTHWEST)
						LOC = locate(U.x,U.y,U.z)
					if(SOUTHEAST)
						LOC = locate(U.x-2,U.y,U.z)
				var/obj/Jutsu/Katon/Goukakyuu/K=new(LOC,U)
				K.FireElemental = U.FireElemental * DM
				walk(K,U.dir,Speed)
				spawn(40)
					del K
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
			..()