obj/SkillCards/Ninjutsu/Raiton
	icon='RaitonCards.dmi'
	JutsuType = "Primary-Element"

mob/proc
	LearnRaikyuu()
		var
			N=3000
		if(PE=="Lightning") N*=0.6
		if(Village=="Cloud") N*=0.8
		if(NinjaRank!="Academy Student" && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Raiton: Raikyuu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Raiton/Raikyuu(src)

//-----------------------------------------------------------------------------------------------------------

	LearnRairyuunoTatsumaki()
		var/list/badrank=list("Academy Student","Genin")
		var
			N=8000; E=600
		if(PE=="Lightning") {E*=0.6; N*=0.6}
		if(Village=="Cloud") {E*=0.8; N*=0.8}
		if(!(NinjaRank in badrank) && LightningElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Raiton: Rairyuuno Tatsumaki</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Raiton/RairyuunoTatsumaki(src)

//-----------------------------------------------------------------------------------------------------------

	LearnRaijuTsuiga()
		var/list/badrank=list("Academy Student","Genin","Chuunin")
		var
			N=16000; E=1600
		if(PE=="Lightning") {E*=0.6; N*=0.6}
		if(Village=="Cloud") {E*=0.8; N*=0.8}
		if(!(NinjaRank in badrank) && LightningElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Raiton Raiju Tsuiga no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Raiton/RaijuTsuiga(src)

//-----------------------------------------------------------------------------------------------------------

	LearnShibari()
		var/list/badrank=list("Academy Student","Genin","Chuunin")
		var
			N=24000; E=2000
		if(PE=="Lightning") {E*=0.6; N*=0.6}
		if(Village=="Cloud") {E*=0.8; N*=0.8}
		if(!(NinjaRank in badrank) && LightningElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Raiton Shichu Shibari no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Raiton/Shibari(src)

//-----------------------------------------------------------------------------------------------------------

	LearnRaitonYoroi()
		var/list/badrank=list("Academy Student","Genin","Chuunin")
		var
			N=48000; E=6000
		if(PE=="Lightning") {E*=0.6; N*=0.6}
		if(Village=="Cloud") {E*=0.8; N*=0.8}
		if(!(NinjaRank in badrank) && LightningElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Raiton no Yoroi</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Raiton/RaitonYoroi(src)