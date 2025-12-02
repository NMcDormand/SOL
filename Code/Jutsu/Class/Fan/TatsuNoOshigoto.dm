#if DEBUGGING
mob/verb
	SelfLearnTatsuOoshigoto()
		var/obj/SkillCards/Class/Fan/TatsuOoshigoto/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Fuuton: Tatsu no Ooshigoto no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Class/Fan/TatsuOoshigoto(src)
#endif

obj/SkillCards/Class/Fan
	TatsuOoshigoto
		icon_state="card_TatsuOoshigoto"
		cmdstring="TatsuOoshigoto"
		Range=4
		CCost=2400
		Cooldown = 1700
		DM = 1.5

		Description= list(
			"about"="A technique that creates a tornado on top of the victim"
			,"title"="Tatsu no Ooshigoto no Jutsu"
			,"type"="Ninjutsu"

			,"strong"="N/A"
			,"weak"="N/A"
			,"rank"="B"
			//,"pic"='Bunshin.png'
		)

		UpgradeChoices = list("Increase Damage","Lower Cooldown")

		Activate(mob/U)
			if(U.choosingHoming) return
			var/mob/M
			if(ismob(U.Targeting)&&get_dist(U.Targeting,U)<= Range)
				M = U.Targeting
			else
				M = U.TargetSelect(Range)
			if(M)
				if(!U.Class["Fan-Nin"])
					U << "This technique is disabled as you are not currently a Fan-Nin"
					return
				if(U.wielding!="Fan") {U<<"Equip Fan first"; return}
				if(GENERICATTACKCHECK(U)) return
				if(U.CooldownCheck("TatsuOoshigoto",(CooldownCur*U.cooldownmultiplier),0)) return
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
					var/obj/Jutsu/Class/Fan/Ooshigoto/F=new(null,U, U.WindElemental*DM)
					var/t=M.loc
					spawn(10)
						if(M && U)
							F.loc=t
							if(F.loc==M.loc)
								F.Bump(M)
							else
								walk_towards(F,M,3)
						spawn(40){if(F)del(F)}
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
				..()