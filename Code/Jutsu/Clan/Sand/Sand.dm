obj/SkillCards/Clan/Sand
	JutsuType = "Clan-Jutsu"

mob
	var
		SandCollected
		GourdWorn = 0
		tmp
			SandArmour=0
			Coffin=0
			KyouOverlay
			list/CoffinList = list()
	proc
		LearnSunaShuriken()
			if(Rank2Num(NinjaRank)>1 && NinjutsuTrue > 1000)
				new/obj/SkillCards/Clan/Sand/SunaShuriken(src)
				src<<"<b><font size=2>You've just learned <i>Suna Shuriken</i>!</b></font>"

		LearnSunaBunshin()
			var/SU = MoveUses["SunaBunshin"] + MoveUses["Bunshin"]
			if(Village=="Sand")
				if(NinjutsuTrue>=4500 && SU >= 1600)
					src<<"<b><font size=2>You've just learned <i>Suna Bunshin no Jutsu</i>!</b></font>"
					new/obj/SkillCards/Clan/Sand/SunaBunshin(src)
			else
				if(NinjutsuTrue>=7000 && SU >= 2000)
					src<<"<b><font size=2>You've just learned <i>Suna Bunshin no Jutsu</i>!</b></font>"
					new/obj/SkillCards/Clan/Sand/SunaBunshin(src)

		LearnArmourOfSand()
			var/SU = MoveUses["SunaBunshin"] + MoveUses["SunaShuriken"]
			if(Village=="Sand")
				if(NinjutsuTrue>=6700 && SU > 1000)
					new/obj/SkillCards/Clan/Sand/SunaYoroi(src)
					src<<"<b><font size=2>You've just learned <i>Suna no Yoroi</i>!</b></font>"
			else
				if(NinjutsuTrue>=9000 && SU > 2000)
					new/obj/SkillCards/Clan/Sand/SunaYoroi(src)
					src<<"<b><font size=2>You've just learned <i>Suna no Yoroi</i>!</b></font>"

		LearnDesertCoffin()
			var/SU = MoveUses["SunaBunshin"] + MoveUses["SunaShuriken"] + MoveUses["SunaYoroi"]
			if(Village=="Sand")
				if(NinjutsuTrue>=9000 && SU > 3000)
					new/obj/SkillCards/Clan/Sand/SabakuKyou(src)
					src<<"<b><font size=2>You've just learned <i>Sabaku Kyou</i>!</b></font>"
			else
				if(NinjutsuTrue>=12000 && SU > 4000)
					new/obj/SkillCards/Clan/Sand/SabakuKyou(src)
					src<<"<b><font size=2>You've just learned <i>Sabaku Kyou</i>!</b></font>"

		LearnDesertFuneral()
			var/SU = (MoveUses["SabakuKyou"]*2) + MoveUses["SunaYoroi"]
			if(Village=="Sand")
				if(NinjutsuTrue>=19000 && TaijutsuTrue>=15000 && SU > 200)
					new/obj/SkillCards/Clan/Sand/SabakuSoso(src)
					src<<"<b><font size=2>You've just learned <i>Sabaku Soso</i>!</b></font>"
			else
				if(NinjutsuTrue>=26000 && TaijutsuTrue>=19000 && SU > 450)
					new/obj/SkillCards/Clan/Sand/SabakuSoso(src)
					src<<"<b><font size=2>You've just learned <i>Sabaku Soso</i>!</b></font>"


obj
	var
		SandCollected
	SandNin
		SunaShuriken
			name="Suna Shuriken"
			icon='Shuriken.dmi'
			icon_state="suna"
			density=1
			Bump(A)
				if(!Owner)
					del src
					return
				if(istype(A,/mob/Hittable/Command/Genjutsu/FakeView))
					density = 0
					spawn(1)
						density = 1
				else if(ismob(A))
					var/mob/M = A
					var/mob/O=Owner
					if(M.kaiten||M.protect) del(src)
					var/Shurikendmg=round((Taijutsu*0.6)+(ThrowingSkill*9))
					M.DamageMe(O,Shurikendmg,"suna shuriken")
					del(src)
				if(istype(A,/turf/))
					var/turf/T = A
					if(T.density) del(src)
				if(istype(A,/obj/)) del(src)

	Item/Clan
		Gourd
			name="Gourd"
			icon='Gourd.dmi'
			icon_state="inventory"
			price=50
			layer = WEAPON_LAYER
			Drop()
				set src in usr.contents
				usr << "This Gourd cannot leave your stable loving grasp!"
			verb
				Equip()
					if(worn)
						SandCollected=usr.SandCollected
						usr.overlays-='Gourd.dmi'
						usr.SandCollected=0
						usr.GourdWorn = 0
						usr<<"You remove the [src]"
						worn=0
					else
						usr.overlays+='Gourd.dmi'
						usr.SandCollected=SandCollected
						usr<<"You equip the [src]."
						worn=1
						usr.GourdWorn = 1
	Item/Profession
		Gourd
			name="Gourd"
			icon='Gourd.dmi'
			icon_state="inventory"
			price=50
			layer = WEAPON_LAYER
			Drop()
				set src in usr.contents
				usr << "This Gourd cannot leave your stable loving grasp!"
			verb
				Equip()
					if(worn)
						SandCollected=usr.SandCollected
						usr.overlays-='Gourd.dmi'
						usr.SandCollected=0
						usr.GourdWorn = 0
						usr<<"You remove the [src]"
						worn=0
					else
						usr.overlays+='Gourd.dmi'
						usr.SandCollected=SandCollected
						usr<<"You equip the [src]."
						worn=1
						usr.GourdWorn = 1