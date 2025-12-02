#if DEBUGGING
mob/verb
	SelfLearnOokamaitachi()
		var/obj/SkillCards/Class/Fan/Ookamaitachi/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Fuuton: Ookamaitachi no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Class/Fan/Ookamaitachi(src)
#endif

obj/SkillCards/Class/Fan
	Ookamaitachi
		icon_state="card_Ookama"
		cmdstring="Ookamaitachi"
		CCost = 2000
		Cooldown = 1200
		DM = 1.2

		Description= list(
			"about"="Great Cutting Whirlwind Technique"
			,"title"="Ookamaitachi no Jutsu"
			,"type"="Ninjutsu"
			,"strong"="N/A"
			,"weak"="N/A"
			,"rank"="A"
			//,"pic"='Bunshin.png'
			)

		UpgradeChoices = list("Increase Damage","Lower Cooldown")

		Activate(mob/U)
			if(GENERICATTACKCHECK(usr)) return
			if(!usr.Class["Fan-Nin"])
				usr << "This technique is disabled as you are not currently a Fan-Nin"
				return
			if(U.wielding!="Fan") {U<<"Equip Fan first"; return}
			if(U.CooldownCheck("Ookamaitachi",(CooldownCur*U.cooldownmultiplier))) return
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

				var/DIR = U.dir
				var/WE = U.WindElemental*DM

				var/obj/Jutsu/Class/Fan/Ookamaitachi/F=new/obj/Jutsu/Class/Fan/Ookamaitachi(U.loc, U, WE)
				var/obj/Jutsu/Class/Fan/Ookamaitachi/F2=new/obj/Jutsu/Class/Fan/Ookamaitachi(get_step(U,turn(DIR,90)), U, WE)
				var/obj/Jutsu/Class/Fan/Ookamaitachi/F3=new/obj/Jutsu/Class/Fan/Ookamaitachi(get_step(U,turn(DIR,-90)), U, WE)
				var/obj/Jutsu/Class/Fan/Ookamaitachi/F4=new/obj/Jutsu/Class/Fan/Ookamaitachi(get_step(F2,turn(DIR,90)), U, WE)
				var/obj/Jutsu/Class/Fan/Ookamaitachi/F5=new/obj/Jutsu/Class/Fan/Ookamaitachi(get_step(F3,turn(DIR,-90)), U, WE)

				F.movespeed=0

				walk(F,DIR); walk(F2,DIR); walk(F3,DIR); walk(F4,DIR); walk(F5,DIR)
				spawn(16)
					if(F)del(F)
					if(F2)del(F3)
					if(F3)del(F3)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
			..()