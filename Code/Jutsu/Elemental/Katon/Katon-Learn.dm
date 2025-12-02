obj/SkillCards/Ninjutsu/Katon
	icon='KatonCards.dmi'
	JutsuType = "Primary-Element"

mob/proc
	LearnGoukakyuu()
		var
			N=2500
		if(Clan=="Uchiha") N*=0.8
		if(PE=="Fire") N*=0.6
		if(Village=="Leaf") N*=0.8
		if(NinjaRank != "Academy Student" && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Katon: Goukakyuu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Katon/Goukakyuu(src)

//-----------------------------------------------------------------------------------------------------------

	LearnHousenka()
		var
			N=5000; E=500
		if(Clan=="Uchiha") N*=0.8
		if(PE=="Fire") {E*=0.6; N*=0.6}
		if(Village=="Leaf") {E*=0.8; N*=0.8}
		if(NinjaRank != "Academy Student" && NinjaRank != "Genin" && FireElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Katon: Housenka</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Katon/Housenka(src)

//-----------------------------------------------------------------------------------------------------------

	LearnRyuuka()
		var
			N=13000; E=800
		if(Clan=="Uchiha") N*=0.8
		if(PE=="Fire") {E*=0.6; N*=0.6}
		if(Village=="Leaf") {E*=0.8; N*=0.8}
		if(NinjaRank != "Academy Student" && NinjaRank != "Genin" && NinjaRank != "Chuunin" && FireElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Katon Ryuka</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Katon/Ryuuka(src)

//-----------------------------------------------------------------------------------------------------------

	LearnKaryuuEndan()
		var
			N=22000; E=1200
		if(Clan=="Uchiha") N*=0.8
		if(PE=="Fire") {E*=0.6; N*=0.6}
		if(Village=="Leaf") {E*=0.8; N*=0.8}
		if(NinjaRank != "Academy Student" && NinjaRank != "Genin" && NinjaRank != "Chuunin" && NinjaRank != "Special Jounin" && FireElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Katon Karyuu Endan</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Katon/KaryuuEndan(src)