obj/SkillCards/Clan/Lee
	icon='LeeCards.dmi'
	JutsuType = "Clan-Jutsu"

mob/var
	tmp
		Drunk
		Gate=0
		GateTime
		Lotus
mob/proc
	Kicks()
		AttackMethod="kick"
		var/dmg=0
		if(Class["Hand2Hand-Nin"]) dmg=H2HSkill*5
		else dmg=H2HSkill*2
		dmg += (Kicks*0.1)
		if(istype(src,/mob/player)) ApplyEXP(2,"unarmed")
		return round(dmg)

	LearnSenpuu()
		if(MoveUses["Kick"]>=250&&TaijutsuTrue>=2500 && Rank2Num(NinjaRank) > 1)
			src<<"<b><font size=2>You've just learned <i>Senpuu</i>!</b></font>"
			new/obj/SkillCards/Clan/Lee/Senpuu(src)

	LearnDaiSenpuu()
		if(MoveUses["Kick"]>=500&&TaijutsuTrue>=5000&& Rank2Num(NinjaRank) > 1)
			src<<"<b><font size=2>You've just learned <i>Dai Senpuu</i>!</b></font>"
			new/obj/SkillCards/Clan/Lee/DaiSenpuu(src)

	LearnReppuu()
		if(MoveUses["Kick"]>=200&&TaijutsuTrue>=2200&& Rank2Num(NinjaRank) > 1)
			src<<"<b><font size=2>You've just learned <i>Reppuu</i>!</b></font>"
			new/obj/SkillCards/Clan/Lee/Reppuu(src)

	LearnShoufuu()
		if(MoveUses["Kick"]>=450&&TaijutsuTrue>=8000&& Rank2Num(NinjaRank) > 2)
			src<<"<b><font size=2>You've just learned <i>Shoufuu</i>!</b></font>"
			new/obj/SkillCards/Clan/Lee/Shoufuu(src)

	LearnkGourikiSenpuu()
		if(MoveUses["Kick"]>=1000&&TaijutsuTrue>=18000 && Rank2Num(NinjaRank) > 3)
			src<<"<b><font size=2>You've just learned <i>Gouriki Senpuu</i>!</b></font>"
			new/obj/SkillCards/Clan/Lee/GourikiSenpuu(src)

	LearnGates()
		if(!JutsuList["Hachimon"])
			if(TaijutsuTrue>=2000 && Rank2Num(NinjaRank) > 1)
				src<<"<b><font size=2>You've just learned how to open chakra gates; You can now open the <i>Initial Gate</i>!</b></font>"
				spawn()
					new/obj/SkillCards/Clan/Lee/Hachimon(src)
				new/obj/SkillCards/Clan/Lee/HachimonClose(src)
				JutsuList["Hachimon"]=1
		else
			if(JutsuList["Hachimon"]==1)
				if(TaijutsuTrue>=3500)
					src<<"<b><font size=2>You can now open the <i>Rest Gate</i>!</b></font>"
					JutsuList["Hachimon"]=2
			if(JutsuList["Hachimon"]==2)
				if(TaijutsuTrue>=5000)
					src<<"<b><font size=2>You can now open the 3rd gate, the <i>Life Gate</i>!</b></font>"
					JutsuList["Hachimon"]=3
			if(JutsuList["Hachimon"]==3)
				if(TaijutsuTrue>=6500)
					src<<"<b><font size=2>You can now open the 4th gate, the <i>Wound Gate</i>!</b></font>"
					JutsuList["Hachimon"]=4
			if(JutsuList["Hachimon"]==4)
				if(TaijutsuTrue>=8000)
					src<<"<b><font size=2>You can now open the 5th gate, the <i>Limit Gate</i>!</b></font>"
					JutsuList["Hachimon"]=5
			if(JutsuList["Hachimon"]==5)
				if(TaijutsuTrue>=9500&&NinjaRank!="Chuunin")
					src<<"<b><font size=2>You can now open the 6th gate, the <i>View Gate</i>!</b></font>"
					JutsuList["Hachimon"]=6
			if(JutsuList["Hachimon"]==6)
				if(TaijutsuTrue>=11000)
					src<<"<b><font size=2>You can now open the 7th gate, the <i>Wonder Gate</i>!</b></font>"
					JutsuList["Hachimon"]=7
			if(JutsuList["Hachimon"]==7)
				if(TaijutsuTrue>=14000)
					src<<"<b><font size=2>You can now open the final gate, the <i>Death Gate</i>!</b></font>"
					JutsuList["Hachimon"]=8

	LearnOmoteRenge()
		if(JutsuList["Hachimon"]>1&&TaijutsuTrue>=5000&&NinjaRank!="Academy Student"&&NinjaRank!="Genin")
			src<<"<b><font size=2>You've just learned <i>Omote Renge</i>!</b></font>"
			new/obj/SkillCards/Clan/Lee/OmoteRenge(src)

	LearnUraRenge()
		if(JutsuList["Hachimon"]>3&&TaijutsuTrue>=15000&&NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&NinjaRank!="Chuunin")
			src<<"<b><font size=2>You've just learned <i>Ura Renge</i>!</b></font>"
			new/obj/SkillCards/Clan/Lee/UraRenge(src)