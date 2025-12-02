mob/Hittable/Unresponsive/NPC/People/Hiashi
	protect=1
	CantHenge=1
	name="Hiashi Hyuuga"
	icon='Hiashi.dmi'
	Village="Leaf"
	Clan="Hyuuga"
	Taijutsu=8000
	Ninjutsu=1000
	Genjutsu=1000
	Stamina=300000
	StaminaMax=300000
	gender="male"
	Action(mob/user)
		if(get_dist(user,src)>2) return
		if(user.Clan=="Hyuuga")
			if(user.TaijutsuTrue>=700&&user.NinjaRank!="Academy Student")
				var/obj/SkillCards/Clan/Hyuuga/Jyuken/J=locate(/obj/SkillCards/Clan/Hyuuga/Jyuken) in user.contents
				if(!(J in user.contents))
					switch(input("Ah, very good. You are strong enough to learn this technique. Would you like me to teach you 'Jyuken'(Gentle Fist Technique)?","Hyuuga, Hiashi")in list("Yes","No Thanks"))
						if("Yes")
							user<<"<b><font size=2>You've just learned <i>Jyuken</i>!</b></font>"
							new/obj/SkillCards/Clan/Hyuuga/Jyuken(user)

			if(user.TaijutsuTrue>=3000&&user.HasRequiredRank("Chuunin")&&user.MoveUses["Jyuken"]>=600&&user.MoveUses["HakkeKyushou"]>=300)
				var/obj/SkillCards/Clan/Hyuuga/Kaiten/J=locate(/obj/SkillCards/Clan/Hyuuga/Kaiten) in user.contents
				if(!(J in user.contents))
					switch(input("Your skills are worthy of this technique... Would you like to learn 'Hakkeshou Kaiten'?","Hyuuga, Hiashi")in list("Yes","No Thanks"))
						if("Yes")
							user<<"<b><font size=2>You've just learned <i>Hakkeshou Kaiten</i>!</b></font>"
							new/obj/SkillCards/Clan/Hyuuga/Kaiten(user)
			else
				switch(pick(1,2,3))
					if(1) user<<"Greetings, and welcome to Hyuuga House."
					if(2) user<<"There is nothing I can teach you at the moment."
					if(3) user<<"You are always welcome here."

		else
			switch(pick(1,2,3))
				if(1) user<<"Greetings, and welcome to Hyuuga House."
				if(2) user<<"The Hyuuga Clan are Taijutsu specialists."
				if(3) user<<"Good day."
	New()
		spawn() respawn=loc