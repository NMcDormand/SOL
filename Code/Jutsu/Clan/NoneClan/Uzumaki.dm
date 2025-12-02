obj/SkillCards/Clan/Uzumaki
	//icon='LeeCards.dmi'
	JutsuType = "Clan-Jutsu"

obj/Jutsu/Uzumaki
	Reaper
		icon = 'Reaper2.dmi'
		icon_state="reaper"
		layer=10
		pixel_y=25
		pixel_x=-64


mob
	var/reaper=0

	proc
		LearnReaper()
			if(Rank2Num(NinjaRank)>7)
				src<<"<b><font size=2>You've just learned <i>Reaper Death Seal</i>!</b></font>"
				new/obj/SkillCards/Clan/Uzumaki/ReaperDeath(src)

		LearnTajuu()
			if(MoveUses["KageBunshin"] > 8000)
				src<<"<b><font size=2>You've just learned <i>Tajuu Kage Bunshin no Jutsu</i>!</b></font>"
				new/obj/SkillCards/Ninjutsu/TajuuKageBunshin(src)