mob/var
	SensatsuL2
	UnlockedSensatsuL2
	tmp
		InMist; IceBlasted;InMado; obj/SkillCards/OniKagamiCard

obj/SkillCards/Clan/Yuki
	icon='YukiCards.dmi'
	JutsuType = "Clan-Jutsu"

mob/proc
	LearnSensatsu()
		if(NinjutsuTrue>=1100)
			src<<"<b><font size=2>You've just learned <i>Sensatsu Suishou</i>!</b></font>"
			new/obj/SkillCards/Clan/Yuki/SensatsuSuishou(src)

//------------------------------------------------------------------------------------------------------------
	LearnIceBlast()
		if(HasRequiredRank("Chuunin")&&WindElemental>=1000&&WaterElemental>=1000&&NinjutsuTrue>=6000)
			src<<"<b><font size=2>You've just learned <i>Hyouton: Ice Blast</i>!</b></font>"
			new/obj/SkillCards/Clan/Yuki/IceBlast(src)

//------------------------------------------------------------------------------------------------------------
	LearnMirrorFormation()
		if(MoveUses["SensatsuSuishou"]>=2000 && HasRequiredRank("Chuunin") && NinjutsuTrue>=8000 && TaijutsuTrue>=4000 && WindElemental>=500 && WaterElemental>=500)
			src<<"<b><font size=2>You've just learned <i>Hyouton: Oni Kagami</i>!</b></font>"
			new/obj/SkillCards/Clan/Yuki/OniKagami(src)

//------------------------------------------------------------------------------------------------------------
	LearnMirrorAttack()
		if(MoveUses["OniKagami"]>=20)
			src<<"<b><font size=2>You've just learned <i>Hyouton: Kori Kogeki</i>!</b><br>Use this technique when you have a target and have mirrors within range</font>"
			new/obj/SkillCards/Clan/Yuki/MakyouHyoushouKogeki(src)

//------------------------------------------------------------------------------------------------------------
	LearnCrossHaven()
		if(MoveUses["OniKagami"]>=100&&MoveUses["MakyouHyoushouKogeki"]>=50&&HasRequiredRank("Special Jounin"))
			src<<"<b><font size=2>You've just learned <i>Hijutsu: Kurosuhebun</i>!</b></font>"
			new/obj/SkillCards/Clan/Yuki/Kurosuhebun(src)

//------------------------------------------------------------------------------------------------------------
	LearnMirrorDome()
		if(MoveUses["OniKagami"]>=200&&HasRequiredRank("Anbu") && NinjutsuTrue>=25000&&TaijutsuTrue>=10000&&GenjutsuTrue>=16000&&WindElemental>=1500&&WaterElemental>=1500)
			src<<"<b><font size=2>You've just learned <i>Hyouton: Makyou Hyoushou</i>!</b></font>"
			new/obj/SkillCards/Clan/Yuki/MakyouHyoushou(src)

//------------------------------------------------------------------------------------------------------------
	LearnMirrorDefense()
		if(MoveUses["OniKagami"]>=200&&HasRequiredRank("Anbu") && NinjutsuTrue>=25000&&TaijutsuTrue>=10000&&GenjutsuTrue>=16000&&WindElemental>=1500&&WaterElemental>=1500)
			src<<"<b><font size=2>You've just learned <i>Hyouton: Sukui no Mado</i>!</b></font>"
			new/obj/SkillCards/Clan/Yuki/Sukuinomado(src)

//Hissatsu Hyōsō - Diamond field
//Hyōton: Mangehyō - all direction sensatsu