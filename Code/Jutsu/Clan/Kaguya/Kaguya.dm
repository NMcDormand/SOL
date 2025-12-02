mob/var
	KGCModifier=3
	//SawaLevel = 1
	tmp
		InBone = 0
		list/InSawa = 0
		turf/SawaCentre = 0
		Bones = list()
		SawaBoost = 0
		InKaramatsu
		InSawarabi

obj/SkillCards/Clan/Kaguya
	icon='KaguyaCards.dmi'
	JutsuType = "Clan-Jutsu"
	Weapons
		CanLevel = 0

mob/proc
	LearnBoneKunai()
		if(HasRequiredRank("Genin") && TaijutsuTrue>=450)
			src<<"<b><font size=2>You've just learned how to create dual <i>Bone Kunais</i>!</b></font>"
			new/obj/SkillCards/Clan/Kaguya/Weapons/CreateBoneKunai(src)

//------------------------------------------------------------------------------------------------------------
	LearnYanaginoMai()
		if(HasRequiredRank("Chuunin") && TaijutsuTrue>=1800)
			src<<"<b><font size=2>You've just learned the Kaguya dance: <i>Yanagi no Mai</i>!</b></font>"
			new/obj/SkillCards/Clan/Kaguya/YanagiNoMai(src)

//------------------------------------------------------------------------------------------------------------
	LearnBoneSword()
		if(HasRequiredRank("Genin") && TaijutsuTrue>=3000)
			src<<"<b><font size=2>You've just learned how to create a <i>Bone Sword</i>!</b></font>"
			new/obj/SkillCards/Clan/Kaguya/Weapons/CreateBoneSword(src)

//------------------------------------------------------------------------------------------------------------
	LearnTsubakinoMai()
		if(HasRequiredRank("Chuunin") && TaijutsuTrue>=6000)
			src<<"<b><font size=2>You've just learned the Kaguya dance: <i>Tsubaki no Mai</i>!</b></font>"
			new/obj/SkillCards/Clan/Kaguya/TsubakiNoMai(src)

//------------------------------------------------------------------------------------------------------------
	LearnSpineWhip()
		if(HasRequiredRank("Special Jounin") && TaijutsuTrue>=10000)
			src<<"<b><font size=2>You've just learned how to create a <i>Spine Whip</i>!</b></font>"
			new/obj/SkillCards/Clan/Kaguya/Weapons/CreateSpineWhip(src)

//------------------------------------------------------------------------------------------------------------
	LearnTessenkanoMai()
		if(HasRequiredRank("Anbu") && TaijutsuTrue>=15000)
			src<<"<b><font size=2>You've just learned the Kaguya dance: <i>Tessenka no Mai</i>!</b></font>"
			new/obj/SkillCards/Clan/Kaguya/TessenkanoMai(src)

//------------------------------------------------------------------------------------------------------------
	LearnKaramatsuNoMai()
		if(HasRequiredRank("Anbu") && TaijutsuTrue>=18000)
			src<<"<b><font size=2>You've just learned the Kaguya dance: <i>Karamatsu no Mai</i>!</b></font>"
			new/obj/SkillCards/Clan/Kaguya/KaramatsuNoMai(src)

//------------------------------------------------------------------------------------------------------------
	LearnTeshiSendan()
		if(HasRequiredRank("Chuunin") && TaijutsuTrue>=6000 && NinjutsuTrue>=4000)
			src<<"<b><font size=2>You've just learned <i>Teshi Sendan</i>!</b></font>"
			new/obj/SkillCards/Clan/Kaguya/TeshiSendan(src)

//------------------------------------------------------------------------------------------------------------
	LearnSawarabiNoMai()
		if(HasRequiredRank("Jounin") && TaijutsuTrue>=32000 && NinjutsuTrue>=27000)
			src<<"<b><font size=2>You've just learned the Kaguya dance: <i>Sawarabi no Mai</i>!</b></font>"
			new/obj/SkillCards/Clan/Kaguya/SawarabiNoMai(src)

//------------------------------------------------------------------------------------------------------------
	LearnWarabiNoMai()
		if(HasRequiredRank("Jounin") && TaijutsuTrue>=42000 && NinjutsuTrue>=32000)
			src<<"<b><font size=2>You've just learned the Kaguya dance: <i>Warabi no Mai</i>!</b></font>"
			new/obj/SkillCards/Clan/Kaguya/WarabiNoMai(src)

//------------------------------------------------------------------------------------------------------------