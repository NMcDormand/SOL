obj/SkillCards/Clan/Rinnegan
	icon='RinneganCards.dmi'
	JutsuType = "S-Rank"

mob
	var
		tmp
			RinneBlown = 0
			TrueSpeed = 0
	proc
		LearnShinraPush()
			src<<"<b><font size=2>You've just learned <i>Shinra Tensei - Push</i>!</font></b>"
			new/obj/SkillCards/Clan/Rinnegan/ShinraTenseiPush(src)

		LearnShinraPull()
			if(MoveUses["ShinraTenseiPush"] > 100)
				src<<"<b><font size=2>You've just learned <i>Shinra Tensei - Pull</i>!</font></b>"
				new/obj/SkillCards/Clan/Rinnegan/ShinraTenseiPull(src)

		LearnChibakuTensei()
			if(MoveUses["ShinraTenseiPush"] > 200 && MoveUses["ShinraTenseiPull"] > 100)
				src<<"<b><font size=2>You've just learned <i>Chibaku Tensei</i>!</font></b>"
				new/obj/SkillCards/Clan/Rinnegan/ChibakuTensei(src)

		LearnLimboClone()
			if(MoveUses["ShinraTenseiPush"] > 400 && MoveUses["ShinraTenseiPull"] > 200 && MoveUses["ChibakuTensei"] > 10)
				src<<"<b><font size=2>You've just learned <i>Limbo Hengoku</i>!</font></b>"
				new/obj/SkillCards/Clan/Rinnegan/LimboHengoku(src)

		LearnTengaShinsei()
			if(MoveUses["ShinraTenseiPush"] > 1000 && MoveUses["ShinraTenseiPull"] > 500 && MoveUses["ChibakuTensei"] > 200)
				src<<"<b><font size=2>You've just learned <i>Tenga Shinsei</i>!</font></b>"
				new/obj/SkillCards/Clan/Rinnegan/TengaShinsei(src)