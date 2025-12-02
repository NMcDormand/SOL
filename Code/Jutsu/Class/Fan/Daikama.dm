#if DEBUGGING
mob/verb
	SelfLearnDaikama()
		var/obj/SkillCards/Class/Fan/Daikamaitachi/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Fuuton: Daikamaitachi no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Class/Fan/Daikamaitachi(src)
#endif

obj/SkillCards/Class/Fan
	Daikamaitachi
		icon_state="card_Daikama2"
		cmdstring="Daikamaitachi"
		CCost=1000
		DM = 1
		Cooldown = 900

		Description= list(
			"about"="Great Cutting Whirlwind Technique"
			,"title"="Daikamaitachi no Jutsu"
			,"type"="Ninjutsu"
			,"strong"="N/A"
			,"weak"="N/A"
			,"rank"="B"
			,"pic"='Bunshin.png'
		)

		UpgradeChoices = list("Increase Damage","Lower Cooldown")

		Activate(mob/U)
			if(GENERICATTACKCHECK(U)) return
			if(!U.Class["Fan-Nin"])
				U << "This technique is disabled as you are not currently a Fan-Nin"
				return
			if(U.wielding!="Fan") {U<<"Equip Fan first"; return}
			if(U.CooldownCheck("Daikamaitachi",(CooldownCur*U.cooldownmultiplier))) return
			var
				c=CCost; mx=c
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(ChakraUseCheck()) c *= 4
			U.firing=1; spawn(5)U.firing=0
			flick("fan",U)
			if(prob(U.ChakraControl))
				U.JutsuNin(c); U.ElementalUp("Wind");
				U.MoveUses[name]++
				U.JutsuUseChakra(c)
				U.JutsuMessage(Description["title"])
				if(U.PracticeMode || ControlCheck(U)) return ..()

				var/obj/Jutsu/Class/Fan/Daikamaitachi/F=new/obj/Jutsu/Class/Fan/Daikamaitachi(U.loc)
				var/obj/Jutsu/Class/Fan/Daikamaitachi/F2=new/obj/Jutsu/Class/Fan/Daikamaitachi(get_step(U,turn(U.dir,90)))
				var/obj/Jutsu/Class/Fan/Daikamaitachi/F3=new/obj/Jutsu/Class/Fan/Daikamaitachi(get_step(U,turn(U.dir,-90)))

				F.Ninjutsu=U.Ninjutsu; WindElemental=(U.WindElemental * DM)
				F.dir=U.dir; F.movespeed=0; F.Owner=U

				F2.Ninjutsu=U.Ninjutsu; F2.WindElemental=(U.WindElemental*(0.85*DM))
				F2.dir=U.dir; F2.Owner=U;

				F3.Ninjutsu=U.Ninjutsu; F3.WindElemental=(U.WindElemental*(0.85*DM))
				F3.dir=U.dir; F3.Owner=U;

				walk(F,U.dir); walk(F2,U.dir); walk(F3,U.dir)
				spawn(12)
					if(F)del(F)
					if(F2)del(F3)
					if(F3)del(F3)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
			..()
