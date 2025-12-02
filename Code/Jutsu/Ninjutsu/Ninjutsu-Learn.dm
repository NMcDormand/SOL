obj/SkillCards/Ninjutsu
	JutsuType = "Ninjutsu"
mob/proc
	LearnKanashibari()
		src<<"<b><font size=2>You've just learned <i>Kanashibari no Jutsu</i>!</b></font>"
		new/obj/SkillCards/Ninjutsu/Kanashibari(src)

	LearnShunshin()
		if(NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&MoveUses["Kawarimi"]>=250)
			src<<"<b><font size=2>You've just learned <i>Shunshin no Jutsu</i>!</b></font>"
			src<<"Shunshin is now toggled on. You may toggle this off at any time."
			CanShunshin=1;
			MoveUses["Shunshin"] = 0
			new/obj/SkillCards/Ninjutsu/ShunshinToggle(src)
//-----------------------------------------------------------------------------------------------------------
	LearnKirigakure()
		if(HasRequiredRank("Chuunin")&&WaterElemental)
			var
				N=10000; G=10000
			if(Clan=="Yuki") {N*=0.8; G*=0.8}
			if(PE=="Water") {N*=0.8; G*=0.8}
			if(Village=="Mist") {N*=0.4; G*=0.4}
			if(GenjutsuTrue>=G&&NinjutsuTrue>=N)
				src<<"<b><font size=2>You've just learned <i>Kirigakure no Jutsu</i>!</b></font>"
				new/obj/SkillCards/Ninjutsu/Suiton/Kirigakure(src)
//----------------------------------------------------------------------------------------------------------
	LearnWaterPrison()
		if(HasRequiredRank("Anbu")&&WaterElemental)
			var
				N=35000; W=2100
			if(Village=="Mist") {N*=0.5; W*=0.5}
			if(PE=="Water") {N*=0.8; W*=0.8}
			if(NinjutsuTrue>=N && WaterElemental>=W&&MoveUses["MizuBunshin"]>=500)
				src<<"<b><font size=2>You've just learned <i>Suirou no Jutsu</i>!</b></font>"
				new/obj/SkillCards/Ninjutsu/Suiton/Suirou(src)

//----------------------------------------------------------------------------------------------------------
/***************************-- SOUND JUTSU --**************************************************************/
//----------------------------------------------------------------------------------------------------------
	LearnZankouha();
		if(NinjutsuTrue>=500&&NinjaRank!="Academy Student"&&NinjaRank!="Genin")
			src<<"<b><font size=2>You've just learned <i>Zankouha</i>!</b></font>"
			new/obj/SkillCards/Country/Sound/Zankouha(src)

	LearnKyoumeisen()
		if(NinjutsuTrue>=700&&GenjutsuTrue>=850&&NinjaRank!="Academy Student"&&NinjaRank!="Genin")
			src<<"<b><font size=2>You've just learned <i>Kyoumeisen</i>!</b></font>"
			new/obj/SkillCards/Country/Sound/Kyoumeisen(src)

	LearnZankoukyokuha()
		if(NinjutsuTrue>=2000&&NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&NinjaRank!="Chuunin")
			//uses ZankouhaUses 500
			src<<"<b><font size=2>You've just learned <i>Zankoukyokuha</i>!</b></font>"
			new/obj/SkillCards/Country/Sound/Zankoukyokuha(src)