obj/SkillCards/Country/Sound
	Zankoukyokuha
		icon_state="card_Zankoukyokuha"
		cmdstring="Zankoukyokuha"
		Range=9
		CCost=300
		Seals=4
		Cooldown=400

		UpgradeChoices = list("Lower Cooldown","Lower Cost")

		Description = list(
			"about"="Extreme Decapitating Air Waves"
			,"title"="Zankoukyokuha"
			,"type"="Ninjutsu"
			,"Element"="Wind"
			,"weak"="?"
			,"rank"="C"
	//		,"pic"='MakyouHyoushou.png'
			)

		Activate(mob/U)
			if(GENERICATTACKCHECK(U))
				return
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck(cmdstring,(CooldownCur*U.cooldownmultiplier)+s)) return
			if(ChakraUseCheck()) c *= 4
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				spawn(1)U.icon_state=null
				spawn(20)U.firing=0
				if(prob(U.ChakraControl))
					U.JutsuMessage(Description["title"])
					U.JutsuSeals(s); U.JutsuNin(c);
					if(U.WindElemental)
						U.ElementalUp("Wind")
					U.MoveUses[name]++
					U.JutsuUseChakra(c);

					if(U.PracticeMode || ControlCheck(U)) return ..()
					var/obj/Jutsu/Zankoukyokuha/Z = new(U.loc)
					Z.Ninjutsu=U.Ninjutsu
					Z.WindElemental=U.WindElemental
					if(Z.WindElemental < 1000)
						Z.WindElemental=1000
					Z.dir=U.dir; Z.Owner=U
					walk(Z,U.dir,2)
					spawn(22) del(Z)
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()