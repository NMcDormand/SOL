mob/var
	tmp
		InCloak; InCloakDelay; InCamo
	HasCloakOfInvisibility
	HasHidingCamo
	HasSilenthomicide

mob/proc
	LearnHidingCamo()
		if(!JutsuList["Meisaigakure"])
			if(NinjutsuTrue>=6000&&GenjutsuTrue>=3000)
				//uses 120 cloak
				src<<"<b><font size=2>You've just learned <i>Meisaigakure no Jutsu</i>!</b></font>"
				new/obj/SkillCards/Class/Assassin/Meisaigakure(src)

	LearnSilenthomicide()
		if(!JutsuList["MuonSatsujin"])
			if(NinjutsuTrue>=8000&&GenjutsuTrue>=5000&&TaijutsuTrue>=22000&&KnifeSkill>=250&&NinjaRank!="Chuunin"&&NinjaRank!="Special Jounin")
				//uses 140 cloak
				src<<"<b><font size=2>You've just learned <i>Muon Satsujin no Jutsu</i>!</b></font>"
				new/obj/SkillCards/Class/Assassin/MuonSatsujin(src)