

mob/proc
	LearnTsuutenKyaku()
		if(!JutsuList["TsuutenKyaku"])
			if(TaijutsuTrue>=8000&&MoveUses["Kicks"]>=600&&NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&NinjaRank!="Chuunin")
				src<<"<b><font size=2>You've just learned <i>Tsuuten Kyaku</i>!</b></font>"
				new/obj/SkillCards/Class/H2H/TsuutenKyaku(src)

	LearnOukashou()
		if(!JutsuList["Oukashou"])
			if(TaijutsuTrue>=4000&&NinjaRank!="Academy Student"&&NinjaRank!="Genin")
				src<<"<b><font size=2>You've just learned <i>Oukashou</i>!</b></font>"
				new/obj/SkillCards/Class/H2H/Oukashou(src)