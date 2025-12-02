obj/SkillCards/Ninjutsu/Suiton
	icon='SuitonCards.dmi'
	JutsuType = "Primary-Element"
mob/proc

	LearnDaibakufu()
		var/list/badrank=list("Academy Student")
		var
			N=2000
		if(Clan=="Yuki") {N*=0.9}
		if(PE=="Water") N*=0.6
		if(Village=="Mist") N*=0.8
		if(!(NinjaRank in badrank) && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Suiton Daibakufu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Suiton/Daibakufu(src)

//------------------------------------------------------------------------------------------------------------

	LearnSuiryuudan()
		var/list/badrank=list("Academy Student","Genin","Chuunin")
		var
			N=7000; E=500
		if(Clan=="Yuki") {N*=0.9}
		if(PE=="Water") {E*=0.6; N*=0.6}
		if(Village=="Mist") {E*=0.8; N*=0.8}
		if(!(NinjaRank in badrank) && WaterElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Suiton Suiryuudan</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Suiton/Suiryuudan(src)

//------------------------------------------------------------------------------------------------------------

	LearnGoshoKuzame()
		var/list/badrank=list("Academy Student","Genin","Chuunin","Special Jounin")
		var
			N=13000; E=1000
		if(Clan=="Yuki") {N*=0.9}
		if(PE=="Water") {E*=0.6; N*=0.6}
		if(Village=="Mist") {E*=0.8; N*=0.8}
		if(!(NinjaRank in badrank) && WaterElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Suiton Goshokuzame</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Suiton/GoshoKuzame(src)

//------------------------------------------------------------------------------------------------------------

	LearnSuikoudan()
		var/list/badrank=list("Academy Student","Genin","Chuunin","Special Jounin")
		var
			N=19000; E=750
		if(Clan=="Yuki") {N*=0.9}
		if(PE=="Water") {E*=0.6; N*=0.6}
		if(Village=="Mist") {E*=0.8; N*=0.8}
		if(!(NinjaRank in badrank) && WaterElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Suiton Suikoudan</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Suiton/Suikoudan(src)