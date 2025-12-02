mob/var
	HasKageBuyou
mob/proc
	LearnKageBuyou()
		if(TaijutsuTrue>=2500&&NinjaRank!="Academy Student")
			src<<"<b><font size=2>You've just learned <i>Kage Buyou</i>!</b></font>"
			new/obj/SkillCards/Taijutsu/KageBuyou(src)