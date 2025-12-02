obj/SkillCards/Ninjutsu/Doton
	icon='DotonCards.dmi'
	JutsuType = "Primary-Element"

obj/Jutsu/DoryuudanSpawn
	notblowable=1
	icon='Doryuudan.dmi'
	icon_state="spawn"

mob/var
	tmp
		Underground
		DorouDoumu

mob/proc
	LearnDoryuuDango()
		var
			N=3500
		if(Clan=="Hyuuga") {N*=0.9}
		if(PE=="Earth") N*=0.6
		if(Village=="Rock") N*=0.8
		if(NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Doton: Doryuu Dango</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Doton/DoryuuDango(src)

//------------------------------------------------------------------------------------------------------------

	LearnDoryuuHeki()
		var
			N=10000; E=650
		if(Clan=="Hyuuga") {N*=0.9}
		if(PE=="Earth") {E*=0.6; N*=0.6}
		if(Village=="Rock") {E*=0.8; N*=0.8}
		if(EarthElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Doton: Doryuu Heki</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Doton/DoryuuHeki(src)

//------------------------------------------------------------------------------------------------------------

	LearnDoryudan()
		var
			N=15000; E=1000
		if(Clan=="Hyuuga") {N*=0.9}
		if(PE=="Earth") {E*=0.6; N*=0.6}
		if(Village=="Rock") {E*=0.8; N*=0.8}
		if(EarthElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Doton: Doryudan</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Doton/DoryuuDan(src)

//-----------------------------------------------------------------------------------------------------------

	LearnShinjuu()
		var
			N=5000; E=400
		if(Clan=="Hyuuga") {N*=0.9}
		if(PE=="Earth") {E*=0.6; N*=0.6}
		if(Village=="Rock") {E*=0.8; N*=0.8}
		if(EarthElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Doton: Shinjuu Zanshu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Doton/ShinjuuZanshu(src)

//------------------------------------------------------------------------------------------------------------

	LearnDorouDoumu()
		var
			N=30000; E=2000
		if(Clan=="Hyuuga") {N*=0.9}
		if(PE=="Earth") {E*=0.6; N*=0.6}
		if(Village=="Rock") {E*=0.8; N*=0.8}
		if(EarthElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Doton: Dorou Doumu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Doton/DorouDoumu(src)

//------------------------------------------------------------------------------------------------------------

	LearnRetsudoTensho()
		var
			N=25000; E=900
		if(Clan=="Hyuuga") {N*=0.9}
		if(PE=="Earth") {E*=0.6; N*=0.6}
		if(Village=="Rock") {E*=0.8; N*=0.8}
		if(EarthElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Doton: Retsudo Tensho no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Doton/RetsudoTensho(src)

//----------------------------------------------------------------------------------------------------------

	LearnYomiNuma()
		var
			N=40000; E=2500
		if(Clan=="Hyuuga") {N*=0.9}
		if(PE=="Earth") {E*=0.6; N*=0.6}
		if(Village=="Rock") {E*=0.8; N*=0.8}
		if(EarthElemental>= E && NinjutsuTrue >= N)
			src<<"<b><font size=2>You've just learned <i>Doton: Yomi Numa</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Doton/YomiNuma(src)
			new/obj/SkillCards/Ninjutsu/Doton/YomiNumaRelease(src)