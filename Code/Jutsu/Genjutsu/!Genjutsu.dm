obj/Genjutsu
	notblowable=1
	JubakuTree
		layer=MOB_LAYER+1
		Main
			icon='JubakuTree.dmi'
			icon_state="main"
		Top
			icon='JubakuTree.dmi'
			icon_state="top"
		Side
			icon='JubakuTree.dmi'
			icon_state="side"

obj/SkillCards/Genjutsu
	icon='GenjutsuCards.dmi'
	JutsuType = "Genjutsu"

mob/proc
	LearnSexyJutsu()
		if((NinjaRank!="Academy Student" && Clan=="Uzumaki") || (NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&NinjaRank!="Chuunin"))
			src<<"<b><font size=2>You've just learned how to use sexy jutsu!</b></font>"
			new/obj/SkillCards/Genjutsu/sexyjutsu(src)

	LearnDispel()
		if(GenjutsuTrue>=500&&NinjaRank!="Academy Student")
			src<<"<b><font size=2>You've just learned how to <u>Dispel</u> Genjutsu attacks!</b></font>"
			new/obj/SkillCards/Genjutsu/Dispel(src)

	LearnNehanShoujanoJutsu()
		if(GenjutsuTrue>=4000&&NinjaRank!="Academy Student"&&NinjaRank!="Genin")
			src<<"<b><font size=2>You've just learned <i>Nehan Shouja no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Genjutsu/NehanSouja(src)


	LearnKokuangyounoJutsu()
		if(GenjutsuTrue>=6000&&NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&NinjaRank!="Chuunin"&&NinjaRank!="Special Jounin")
			src<<"<b><font size=2>You've just learned <i>Kokuangyou no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Genjutsu/Kokuangyou(src)

	LearnJubakuSatsu()
		if(GenjutsuTrue>=12000&&NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&NinjaRank!="Chuunin")
			src<<"<b><font size=2>You've just learned <i>Jubaku Satsu</i>!</b></font>"
			new/obj/SkillCards/Genjutsu/JubakuSatsu(src)

	LearnPetalEscape()
		if(NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&NinjaRank!="Chuunin"&&NinjaRank!="Anbu"&&NinjaRank!="Special Jounin")
			if(GenjutsuTrue>=20000&&TaijutsuTrue>=20000 && MoveUses["MeiMei"]>=150 && MoveUses["Kawarimi"]>=500 )
				src<<"<b><font size=2>You've just learned <i>Flower Petal Escape</i>!</b></font>"
				new/obj/SkillCards/Genjutsu/FlowerPetalEscape(src)

	LearnNarakumi()
		if(NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&NinjaRank!="Chuunin"&&NinjaRank!="Special Jounin")
			if(GenjutsuTrue>=7000)
				src<<"<b><font size=2>You've just learned <i>Narakumi no Jutsu</i>!</b></font>"
				new/obj/SkillCards/Genjutsu/Narakumi(src)

	LearnSutendomira()
		if(NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&NinjaRank!="Chuunin"&&NinjaRank!="Special Jounin")
			if(GenjutsuTrue>=12000)
				src<<"<b><font size=2>You've just learned <i>Sutendomira no Jutsu</i>!</b></font>"
				new/obj/SkillCards/Genjutsu/Sutendomira(src)

	LearnTobenai()
		if(NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&NinjaRank!="Chuunin"&&NinjaRank!="Special Jounin")
			if(GenjutsuTrue>=22000)
				src<<"<b><font size=2>You've just learned <i>Tobenai Boko no Jutsu</i>!</b></font>"
				new/obj/SkillCards/Genjutsu/TobenaiBoko(src)

	LearnSenshokuKaze()
		if(GenjutsuTrue>=25000)
			src<<"<b><font size=2>You've just learned <i>Senshoku Kaze no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Genjutsu/SenshokuKaze(src)

	LearnSenshokuFirudo()
		if(GenjutsuTrue>=32000 && MoveUses["SenshokuKaze"] > 20)
			src<<"<b><font size=2>You've just learned <i>Senshoku Firudo no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Genjutsu/SenshokuFirudo(src)

	LearnKirabiyakanaKibarashi()
		if(GenjutsuTrue>=34000 && MoveUses["SenshokuFirudo"] > 5)
			src<<"<b><font size=2>You've just learned <i>Kirabiyakana Kibarashi no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Genjutsu/KirabiyakanaKibarashi(src)