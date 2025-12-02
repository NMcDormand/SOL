mob/var/tmp
	healing; healingself; InMesu; sliced; Nerves

mob/proc
	LearnMesu()
		if(NinjutsuTrue>=3000&&TaijutsuTrue>=2000&&NinjaRank!="AcademyStudent"&&NinjaRank!="Genin")
			//verbs += new/mob/VerbHolder/Jutsu/Class/verb/ChakranoMesu()
			new/obj/SkillCards/Class/Medical/SliceTendons(src)
			new/obj/SkillCards/Class/Medical/ChakranoMesu(src)
			src<<"<b><font size=2>You've just learned <i>Chakra no Mesu</i>!</b></font>"
			src<<"<b><font size=2>You've just learned how to <i>Slice Tendons</i></b></font>"

	LearnRanshinShou()
		if(NinjutsuTrue>=10000&&TaijutsuTrue>=12000&&NinjaRank!="AcademyStudent"&&NinjaRank!="Genin"&&NinjaRank!="Chuunin")
			if(MoveUses["Shousen"] > 100)
				new/obj/SkillCards/Class/Medical/RanshinShou(src)
				src<<"<b><font size=2>You've just learned <i>Ranshin Shou</i>!</b></font>"