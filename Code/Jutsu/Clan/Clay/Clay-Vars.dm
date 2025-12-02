obj/SkillCards/Clan/Clay
	JutsuType = "Clan-Jutsu"
	icon='ClayCards.dmi'
#define CLAYMAXSKILL 200
mob
	#if DEBUGGING
	verb
		LearnClayClan()
			ClayMax = 100
			EarthElemental = 1000
			SelfLearnKibakuNendo()
			SelfLearnKatsu()
			SelfLearnShiFo()
			SelfLearnJirai()
			SelfLearnKyukyokuGeijutsu()
	#endif
	var
		ClaySkill = 10
		ClayXP = 0
		ClayMXP = 10
		ClayCur=0
		ClayMax=0
		ClayExMax = 0
		ClayInfused=0
		ClayInfusedMax=60
		tmp
			bombs
			Grown
			ShifoICon
			ClayInfection = 0
			ShiFoClone = 0
			list
				ShifoOverlays=list()
				ShifoUnderlays=list()
				ClayBombs = list()

	proc
		ClayXPUP(var/A)
			ClayXP += A
			if(ClayXP >= ClayMXP)
				ClayXP -= ClayMXP
				ClayMXP += 5
				if(ClaySkill < CLAYMAXSKILL)
					ClaySkill++
					src << "Your skill in moulding Clay has improved"
				else
					ClayInfusedMax++
					ClayMax++
					src << "You can now carry more Clay"


mob/proc
	LearnKibakuNendo()
		if(Rank2Num(NinjaRank)>1 && NinjutsuTrue > 1000)
			src<<"<b><font size=2>You've just learned <i>Kibaku Nendo no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Clay/KibakuNendo(src)

	LearnKibakuJirai()
		if(MoveUses["KibakuNendo"] > 10)
			src<<"<b><font size=2>You've just learned <i>Kibaku Jirai no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Clay/KibakuJirai(src)

	LearnKatsu()
		src<<"<b><font size=2>You've just learned <i>Katsu no Jutsu</i>!</b></font>"
		new/obj/SkillCards/Clan/Clay/Katsu(src)

	learnShiFo()
		if(MoveUses["KibakuJirai"] > 200 && ClaySkill >= 50)
			src<<"<b><font size=2>You've just learned <i>Shi Fo no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Clay/ShiFo(src)

	learnKyukyokuGeijutsu()
		if(MoveUses["ShiFo"] > 50 && ClaySkill >= 100)
			src<<"<b><font size=2>You've just learned <i>Kyukyoku Geijutsu no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Clay/KyukyokuGeijutsu(src)
