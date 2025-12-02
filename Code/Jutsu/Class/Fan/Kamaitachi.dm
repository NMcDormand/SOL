#if DEBUGGING
mob/verb
	SelfLearnKamaitachi()
		var/obj/SkillCards/Class/Fan/Kamaitachi/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Fuuton: Kamaitachi no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Class/Fan/Kamaitachi(src)
#endif

obj/SkillCards/Class/Fan
	Kamaitachi
		icon_state="card_Kama"
		cmdstring="Kamaitachi"
		CCost=500
		Cooldown = 500
		DM = 0.5

		Description= list(
			"about"="Cutting Whirlwind Technique"
			,"title"="Kamaitachi no Jutsu"
			,"type"="Ninjutsu"
			,"strong"="N/A"
			,"weak"="N/A"
			,"rank"="B"
			//,"pic"='Bunshin.png'
		)

		UpgradeChoices = list("Increase Damage","Lower Cooldown")

		Activate(mob/U)
			if(GENERICATTACKCHECK(usr)) return
			if(!usr.Class["Fan-Nin"])
				usr << "This technique is disabled as you are not currently a Fan-Nin"
				return
			if(usr.wielding!="Fan") {usr<<"Equip Fan first"; return}
			if(usr.CooldownCheck("Kamaitachi",(CooldownCur*usr.cooldownmultiplier),0)) return
			var
				c=CCost; mx=c
			if(usr.Chakra<=c) {usr<<"Not enough Chakra."; return}
			if(ChakraUseCheck()) c *= 4
			usr.firing=1; spawn(5)usr.firing=0
			flick("fan",usr)
			if(prob(U.ChakraControl))
				U.JutsuNin(c); U.ElementalUp("Wind");
				U.MoveUses[name]++
				U.JutsuUseChakra(c)
				U.JutsuMessage(Description["title"])
				if(U.PracticeMode || ControlCheck(U)) return ..()

				var/obj/Jutsu/Class/Fan/Kamaitachi/F=new/obj/Jutsu/Class/Fan/Kamaitachi(usr.loc,usr)
				F.Ninjutsu=usr.Ninjutsu*0.7; F.WindElemental=usr.WindElemental*DM
				F.dir=usr.dir; F.movespeed=0; F.Owner=usr
				walk(F,usr.dir)
				spawn(9){if(F)del(F)}

			else {c-=rand(1,mx/2); usr.Chakra-=c; usr<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};
			..()
