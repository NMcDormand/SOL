obj/SkillCards/Country/Sound
	Kyoumeisen
		icon_state="card_Kyoumeisen"
		cmdstring="Kyoumeisen"
		Range=1
		CCost=100
		Seals=2
		Cooldown=100
		Duration = 45

		UpgradeChoices = list("Increase Duration","Increase Range")

		Description = list(
			"about"="Great Sound Blast"
			,"title"="Kyoumeisen"
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
					for(var/mob/M in oview(Range,U))
						if(U.dir==get_dir(U,M))
							if(M.Blasted)
								U<<"[M] has already had their inner ear damaged."
							else
								U<<"You blast [M] with sound."; M<<"[U] has blasted you with sound."
								spawn(2)
									if(M)
										M.NerveDamage(Duration)
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

mob
	var/tmp/Blasted
	proc
		NerveDamage(A)
			src<<"Your inner ear has been damaged."
			Blasted=1
			spawn(A)
				src<<"Your sense of balance has returned."
				Blasted=0