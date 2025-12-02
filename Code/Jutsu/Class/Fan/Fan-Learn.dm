obj/SkillCards/Class/Fan/icon = 'Fuutoncards.dmi'
mob/proc
	learnDaikamaitachi()
		if(!JutsuList["Daikamaitachi"])
			if(NinjutsuTrue>=4500&&TaijutsuTrue>=2500)
				if(MoveUses["Kamaitachi"] >= 120)
					src<<"<b><font size=2>You've just learned <i>Fuuton: Daikamaitachi no Jutsu</i>!</b></font>"
					new/obj/SkillCards/Class/Fan/Daikamaitachi(src)
	learnOokamaitachi()
		if(!JutsuList["Ookamaitachi"])
			if(NinjutsuTrue>=14500&&TaijutsuTrue>=12500)
				if(MoveUses["Daikamaitachi"] >= 100)
					src<<"<b><font size=2>You've just learned <i>Fuuton: Ookamaitachi no Jutsu</i>!</b></font>"
					new/obj/SkillCards/Class/Fan/Ookamaitachi(src)
	learnTatsuOoshigoto()
		if(!JutsuList["TatsuOoshigoto"])
			if(NinjutsuTrue>=34500&&TaijutsuTrue>=22500)
				if(MoveUses["Ookamaitachi"] >= 50)
					src<<"<b><font size=2>You've just learned <i>Fuuton: Tatsu no Ooshigoto no Jutsu</i>!</b></font>"
					new/obj/SkillCards/Class/Fan/TatsuOoshigoto(src)