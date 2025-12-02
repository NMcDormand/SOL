obj/SkillCards/Ninjutsu/Special/Tower
	JutsuType = "S-Rank"

mob
	var
		MaxBangs = 2
		tmp
			ReverseFlow = 0
			ShinsuCircles = 0
	proc
		LearnShinStream()
			src<<"<b><font size=2>You've just learned <i>Shinsu Stream</i>!</font></b>"
			new/obj/SkillCards/Ninjutsu/Special/Tower/ShinsuStream(src)

		LearnShinCircle()
			if(MoveUses["ShinsuStream"] > 4000)
				src<<"<b><font size=2>You've just learned <i>Shinsu Circle</i>!</font></b>"
				new/obj/SkillCards/Ninjutsu/Special/Tower/ShinsuCircle(src)

		LearnShinWonRyu()
			if(MoveUses["ShinsuStream"] > 8000 && MoveUses["ShinsuCircle"] > 2000)
				src<<"<b><font size=2>You've just learned <i>Shinwonryu</i>!</font></b>"
				new/obj/SkillCards/Ninjutsu/Special/Tower/Shinwonryu(src)

		LearnThorn()
			if(MoveUses["Shinwonryu"] > 400 && MoveUses["ShinsuStream"] > 12000 && MoveUses["ShinsuCircle"] > 4000)
				src<<"<b><font size=2>You've just obtained the <i>Thorn</i>!</b></font>"
				new/obj/SkillCards/Ninjutsu/Special/Tower/Thorn(src)

		LearnThorn2()
			if(MoveUses["Thorn"] > 400)
				ThornMax = 2
				src<<"<b><font size=2>The Thorn seems ready to be unleashed, you can now use its full power!</b></font>"