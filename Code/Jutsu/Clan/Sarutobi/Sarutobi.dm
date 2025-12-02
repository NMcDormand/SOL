obj/SkillCards/Clan/Sarutobi
	JutsuType = "Clan-Jutsu"
	icon='SarutobiCards.dmi'

mob
	var
		tmp/InHien = 0

	proc
		LearnHien()
			if(Rank2Num(NinjaRank)>1 && NinjutsuTrue > 1000)
				new/obj/SkillCards/Clan/Sarutobi/Hien(src)
				src<<"<b><font size=2>You've just learned <i>Hien</i>!</b></font>"

		LearnHaise()
			if(Rank2Num(NinjaRank)>1 && NinjutsuTrue > 5000)
				new/obj/SkillCards/Clan/Sarutobi/Haisekisho(src)
				src<<"<b><font size=2>You've just learned <i>Haeisekisho</i>!</b></font>"

		LearnYagura()
			if(Rank2Num(NinjaRank)>2 && NinjutsuTrue > 10000)
				new/obj/SkillCards/Clan/Sarutobi/HiuchiYagura(src)
				src<<"<b><font size=2>You've just learned <i>Katon: Hiuchi Yagura</i>!</b></font>"
