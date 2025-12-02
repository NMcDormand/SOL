#define DOGDELAY 10

mob/var
	Master
	Familiar
	HasDog
	Status
	DogName
	DogColour="white"
	DogTaijutsu
	DogTaijutsuXP
	DogTaijutsuMXP
	DogStaminaMax
	DogStaminaExp
	DogStaminaMXP
	DeadDog
	tmp/DogCommand
	TheoreticalTaijutsuXP
	TheoreticalstaminaXP
	tmp/list/DynamicMarkingList=list()

obj/SkillCards/Clan/Inuzuka
	icon='InuzukaCards.dmi'
	JutsuType = "Clan-Jutsu"
	Commands
		CanLevel = 0

mob/proc
	LearnTsuuga()
		if(TaijutsuTrue>=1800&&HasRequiredRank("Genin"))
			src<<"<b><font size=2>You've just learned <i>Tsuuga</i>!</b></font>"
			new/obj/SkillCards/Clan/Inuzuka/Tsuuga(src)

//------------------------------------------------------------------------------------------------------------
	LearnDynamicMarking()
		if(NinjutsuTrue>=2000&&HasRequiredRank("Chuunin"))
			src<<"<b><font size=2>You've just learned <i>Dynamic Marking</i>!</b></font>"
			new/obj/SkillCards/Clan/Inuzuka/DynamicMarking(src)

//------------------------------------------------------------------------------------------------------------
	LearnGatsuuga()
		if(TaijutsuTrue>=4000&&HasRequiredRank("Chuunin")&&MoveUses["Tsuuga"]>=70)
			src<<"<b><font size=2>You've just learned <i>Gatsuuga</i>!</b></font>"
			new/obj/SkillCards/Clan/Inuzuka/Gatsuuga(src)

//------------------------------------------------------------------------------------------------------------
	LearnJuujinBunshinNoJutsu()
		if(TaijutsuTrue>=1500&&NinjutsuTrue>=1500&&GenjutsuTrue>=1000&&HasRequiredRank("Genin")&&MoveUses["Bunshin"]>=200)
			src<<"<b><font size=2>You've just learned <i>Juujin Bunshin no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Inuzuka/JuujinBunshin(src)

//------------------------------------------------------------------------------------------------------------
	LearnSoutourou()
		if(TaijutsuTrue>=13000&&NinjutsuTrue>=12000&&HasRequiredRank("Anbu")&&MoveUses["JuujinBunshin"]>=200&&MoveUses["JuujinBunshin"] > 50)
			src<<"<b><font size=2>You've just learned <i>Soutourou</i>!</b></font>"
			new/obj/SkillCards/Clan/Inuzuka/Soutourou(src)

//------------------------------------------------------------------------------------------------------------
	LearnGarouga()
		if(TaijutsuTrue>=20000&&NinjutsuTrue>=15000&&HasRequiredRank("Jounin")&&MoveUses["Tsuuga"]>=150&&MoveUses["Gatsuuga"]>=100&&MoveUses["Soutourou"] > 50)
			src<<"<b><font size=2>You've just learned <i>Garouga</i>!</b></font>"
			new/obj/SkillCards/Clan/Inuzuka/Garouga(src)
