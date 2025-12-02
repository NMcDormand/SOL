mob/proc
	LearnHeavenCS()
		src<<"<b><font size=2>You've just acquired the <i>Heaven Cursed Seal</i>!</b></font>"
		new/obj/SkillCards/Ninjutsu/CursedSeal_Heaven(src)

	LearnEarthCS()
		src<<"<b><font size=2>You've just acquired the <i>Earth Cursed Seal</i>!</b></font>"
		new/obj/SkillCards/Taijutsu/CursedSeal_Earth(src)