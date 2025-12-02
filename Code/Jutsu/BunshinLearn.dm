mob/proc
	LearnKageBunshin()
		if(NinjaRank!="Academy Student"&&NinjaRank!="Genin")
			if(MoveUses["Bunshin"] >= 1000 && NinjutsuTrue >= 2000)
				src<<"<b><font size=2>You've just learned <i>Kage Bunshin no Jutsu</i>!</b></font>"
				new/obj/SkillCards/Ninjutsu/KageBunshin(src)

//------------------------------------------------------------------------------------------------------------

	LearnBunshinLimit()
		switch(NinjaRank)
			if("Chuunin")
				if(BunshinLimitMax != 4)
					UpBunshinLimit(4, 0)
			if("Special Jounin")
				if(Clan=="Uzumaki")
					if(BunshinLimitMax!=7)
						UpBunshinLimit(6, 1)
				else if (BunshinLimitMax != 6)
					UpBunshinLimit(6, 1)
			if("Jounin")
				if(Clan=="Uzumaki")
					if(BunshinLimitMax!=10)
						UpBunshinLimit(8, 2)
				else if (BunshinLimitMax != 8)
					UpBunshinLimit(8, 2)

	UpBunshinLimit(num, bonus)
		var/total = num;
		if(Clan=="Uzumaki") {total = (num+bonus)}
		BunshinLimit=total; BunshinLimitMax=total;
		src<<"<b>You can now summon [total] clones at a time!</b>"

//------------------------------------------------------------------------------------------------------------

	LearnMizuBunshin()
		if((PE=="Water"||SE=="Water"))
			if(NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&NinjaRank!="Chuunin")
				if(PE=="Water")
					if((Clan=="Yuki")&&(MoveUses["Bunshin"]>=700))
						src<<"<b><font size=2>You've just learned <i>Mizu Bunshin no Jutsu</i>!</b></font>"
						new/obj/SkillCards/Ninjutsu/MizuBunshin(src)

					else if(MoveUses["Bunshin"]>=900)
						src<<"<b><font size=2>You've just learned <i>Mizu Bunshin no Jutsu</i>!</b></font>"
						new/obj/SkillCards/Ninjutsu/MizuBunshin(src)

				else if(SE=="Water")
					if((Clan=="Yuki")&&(MoveUses["Bunshin"]>=1200))
						src<<"<b><font size=2>You've just learned <i>Mizu Bunshin no Jutsu</i>!</b></font>"
						new/obj/SkillCards/Ninjutsu/MizuBunshin(src)

					else if(MoveUses["Bunshin"]>=1500)
						src<<"<b><font size=2>You've just learned <i>Mizu Bunshin no Jutsu</i>!</b></font>"
						new/obj/SkillCards/Ninjutsu/MizuBunshin(src)

	LearnRaitonKageBunshin()
		if(HasRequiredRank("Anbu")&&HasRequiredElement("Lightning"))
			if(PE=="Lightning")
				if(MoveUses["KageBunshin"]>=500)
					src<<"<b><font size=2>You've just learned <i>Raiton Kage Bunshin no Jutsu</i>!</b></font>"
					new/obj/SkillCards/Ninjutsu/RaitonKageBunshin(src)

			else if(SE=="Lightning")
				if(MoveUses["KageBunshin"]>=800)
					src<<"<b><font size=2>You've just learned <i>Raiton Kage Bunshin no Jutsu</i>!</b></font>"
					new/obj/SkillCards/Ninjutsu/RaitonKageBunshin(src)