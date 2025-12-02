obj/SkillCards/Clan/Hyuuga
	icon='HyuugaCards.dmi'
	JutsuType = "Clan-Jutsu"

mob/var
	CanLearnByakugan
	ByakuganLevel
	ByakuganRange=10
	tmp
		KnockedBack
		BlockedTenketsu
		DouEyes = 0
		Searching
		list/CamoList = list()

mob/proc
	LearnKyushou()
		if(MoveUses["Jyuken"]>400 && TaijutsuTrue>=2500 && HasRequiredRank("Genin"))
			src<<"<b><font size=2>You've just learned <i>Hakke Kyushou</i>!</b></font>"
			new/obj/SkillCards/Clan/Hyuuga/HakkeKyushou(src)

	LearnByakugan()
		if(TaijutsuTrue>=1800 && HasRequiredRank("Genin"))
			src<<"<b><font size=2>You've just learned the Doujutsu: <i>Byakugan</i>!</b></font>"
			new/obj/SkillCards/Clan/Hyuuga/Byakugan(src)
			new/obj/SkillCards/Clan/Hyuuga/Byakugan_Search(src)
			if(!ByakuganLevel) ByakuganLevel=1
			if(!CanLearnByakugan) CanLearnByakugan=1

		if(HasRequiredRank("Chuunin") && CanLearnByakugan==1 && ByakuganLevel==1 && TaijutsuTrue>=6000)
			src<<"<b><font size=2>You can now unlock Byakugan Level 2 from the Stat Points Menu!</b></font>"
			CanLearnByakugan=2

		if(HasRequiredRank("Anbu") && CanLearnByakugan==2 && ByakuganLevel==2 && TaijutsuTrue>=15000)
			src<<"<b><font size=2>You can now unlock Byakugan Level 3 from the Stat Points Menu!</b></font>"
			CanLearnByakugan=3

	Learn64Palms()
		if(MoveUses["Jyuken"]>600 && MoveUses["HakkeKyushou"]>150 && TaijutsuTrue>=4000 && HasRequiredRank("Genin"))
			src<<"<b><font size=2>You've just learned <i>Hakke Rokujyuyon Shou</i> (64 Palms)!</b></font>"
			new/obj/SkillCards/Clan/Hyuuga/HakkeRokujyuyonShou(src)

	Learn128Palms()
		if(MoveUses["Jyuken"]>1000 && MoveUses["HakkeKyushou"]>300 && TaijutsuTrue>=18000 && HasRequiredRank("Anbu"))
			src<<"<b><font size=2>You've just learned <i>Hakke Rokujyuyon Shou</i> (128 Palms)!</b></font>"
			new/obj/SkillCards/Clan/Hyuuga/HakkeHyakunijyuhachiShou(src)