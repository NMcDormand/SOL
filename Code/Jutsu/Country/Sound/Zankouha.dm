obj/SkillCards/Country/Sound
	Zankouha
		icon_state="card_Zankouha"
		cmdstring="Zankouha"
		Range=9
		CCost=140
		Seals=2
		Cooldown=600

		UpgradeChoices = list("Lower Cooldown","Lower Cost")

		Description = list(
			"about"="Decapitating Air Waves"
			,"title"="Zankouha"
			,"type"="Ninjutsu"
			,"Element"="Wind"
			,"weak"="?"
			,"rank"="C"
	//		,"pic"='MakyouHyoushou.png'
		)

		Activate(mob/U)
			if(U.choosingHoming)
				return
			if(GENERICATTACKCHECK(U))
				return
			var/mob/M
			if(ismob(U.Targeting)&&get_dist(U.Targeting,U)<= Range)
				M = U.Targeting
			else
				M = U.TargetSelect(Range)
			if(M)
				if(GENERICATTACKCHECK(U)) return
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
						var/obj/Jutsu/Zankouha/Z = new(U.loc)
						Z.WindElemental=U.WindElemental; Z.Ninjutsu=U.Ninjutsu
						if(Z.WindElemental < 500)
							Z.WindElemental = 500
						var/ZW = Z.WindElemental
						Z.dir=U.dir; Z.target=M; Z.Owner=U
						if(M && U)
							Z.Homing(M,M.loc)
							spawn(20)
								if(Z)
									del(Z)
							spawn(4)
								if(M && U)
									var/obj/Jutsu/Zankouha/A = new(U.loc)
									A.WindElemental=ZW; A.Ninjutsu=U.Ninjutsu
									A.dir=U.dir; A.target=M; A.Owner=U
									A.Homing(M,M.loc)
									spawn(18)
										if(A)
											del(A)
								spawn(4)
									if(M && U)
										var/obj/Jutsu/Zankouha/N = new(U.loc)
										N.WindElemental=ZW; N.Ninjutsu=U.Ninjutsu
										N.dir=U.dir; N.target=M; N.Owner=U
										N.Homing(M,M.loc)
										spawn(14)
											if(N)
												del(N)
						else
							if(Z)
								del Z
					else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()