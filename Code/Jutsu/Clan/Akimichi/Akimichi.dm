obj/SkillCards/Clan/Akimichi
	//icon='LeeCards.dmi'
	JutsuType = "Clan-Jutsu"

obj/Akimichi
	BALL
		icon = 'MeatTank96.dmi'
		layer=FLOAT_LAYER+10
		pixel_x=-30
		pixel_y=-30

mob
	var
		Calories
		CalorieLimit=200
		InBaika=0
		InMeatTank=0
		tmp
			Giant=0
			ExpansionStamGain = 0
			ExpansionRFXGain = 0
			ORFX = 0

mob/proc
	LearnGiant()
		if(TaijutsuTrue>=5000&&Calories>200&&NinjaRank!="Academy Student")
			src<<"<b><font size=2>You've just learned <i>Giant Form</i>!</b></font>"
			new/obj/SkillCards/Clan/Akimichi/Baika(src)

	LearnTank()
		if(TaijutsuTrue>=8000&&NinjaRank!="Academy Student"&&NinjaRank!="Genin")
			src<<"<b><font size=2>You've just learned <i>Bullet Tank</i>!</b></font>"
			new/obj/SkillCards/Clan/Akimichi/NikudanSensha(src)
