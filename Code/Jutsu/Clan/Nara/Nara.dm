mob/var
	KagemaneRange=8
	tmp/InKageArashi = 0
	tmp/UsedArashi = 0
	ArashiRange = 1

obj/SkillCards/Clan/Nara
	icon='NaraCards.dmi'
	JutsuType = "Clan-Jutsu"

mob/proc
	LearnKagemane()
		if(GenjutsuTrue>=1000&&NinjutsuTrue>=1500&&NinjaRank!="Academy Student")
			src<<"<b><font size=2>You've just learned <i>Kagemane no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Nara/Kagemane(src)
			new/obj/SkillCards/Clan/Nara/KagemaneRelease(src)

	LearnNeckBind()
		if(GenjutsuTrue>=2000&&NinjutsuTrue>=5000&&NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&MoveUses["Kagemane"]>=50)
			src<<"<b><font size=2>You've just learned <i>Kage Kubi Shibari no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Nara/KageKubiShibari(src)

	LearnKageArashi()
		if(GenjutsuTrue>=14000&&NinjutsuTrue>=50000&&NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&MoveUses["Kagemane"]>=300)
			src<<"<b><font size=2>You've just learned <i>Kage Arashi no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Nara/Kagearashi(src)