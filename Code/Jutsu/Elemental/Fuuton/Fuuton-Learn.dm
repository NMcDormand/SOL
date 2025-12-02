obj/SkillCards/Ninjutsu/Fuuton
	icon='FuutonCards.dmi'
	JutsuType = "Primary-Element"
mob/proc
	LearnDaitoppa()
		var/list/badrank=list("Academy Student")
		var
			N=2000
		if(Clan=="Yuki") {N*=0.9}
		if(PE=="Wind") N*=0.6
		if(Village=="Sand") N*=0.8
		if(!(NinjaRank in badrank) && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Fuuton: Daitoppa</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Fuuton/Daitoppa(src)

	LearnMugenSajinDaitoppa()
		var/list/badrank=list("Academy Student","Genin")
		var
			N=6000; E=500
		if(Clan=="Yuki") {N*=0.9}
		if(PE=="Wind") {E*=0.6; N*=0.6}
		if(Village=="Sand") {E*=0.8; N*=0.8}
		if(!(NinjaRank in badrank) && WindElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Fuuton: Mugen Sajin Daitoppa</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Fuuton/MugenSajinDaitoppa(src)

	LearnRenkoudan()
		var/list/badrank=list("Academy Student","Genin","Chuunin")
		var
			N=17000; E=1000
		if(Clan=="Yuki") {N*=0.9}
		if(PE=="Wind") {E*=0.6; N*=0.6}
		if(Village=="Sand") {E*=0.8; N*=0.8}
		if(!(NinjaRank in badrank) && WindElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Fuuton: Renkoudan</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Fuuton/Renkoudan(src)

	LearnFusajin()
		var/list/badrank=list("Academy Student","Genin","Chuunin")
		var
			N=27000; E=1200
		if(Clan=="Yuki") {N*=0.9}
		if(PE=="Wind") {E*=0.6; N*=0.6}
		if(Village=="Sand") {E*=0.8; N*=0.8}
		if(!(NinjaRank in badrank) && WindElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Fuuton: Fusajin no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Fuuton/Fusajin(src)

	LearnFujinHeki()
		var/list/badrank=list("Academy Student","Genin","Chuunin")
		var
			N=37000; E=2200
		if(Clan=="Yuki") {N*=0.9}
		if(PE=="Wind") {E*=0.6; N*=0.6}
		if(Village=="Sand") {E*=0.8; N*=0.8}
		if(!(NinjaRank in badrank) && WindElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Fuuton: Fujin Heki no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Fuuton/FujinHeki(src)
			new/obj/SkillCards/Ninjutsu/Fuuton/FujinHekiRelease(src)