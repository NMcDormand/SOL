mob
	var
		list/EdoList = list()
		tmp/list/EdoCloneList = list()
		HasEdo = 0
		EdoMax = 1
		SpokeToKabuto = 0

#if DEBUGGING
	verb
		ResetEdo()
			EdoList = list()
		TestVisual()
			var/mob/Hittable/Command/EdoClone/EC = new(loc)

			var/icon/IC = icon(icon)
			var/OL = overlays
			OL -= 'SpeachBubble.dmi'
			OL -= 'waterwalk.dmi'
			for(var/A in OL)
				IC.Blend(icon(A:icon),ICON_OVERLAY)
			IC.Blend("#404040")

			EC.icon = IC
mob/verb
	SelfLearnEdoTensei()
		var/obj/SkillCards/Ninjutsu/Special/EdoTensei/Edo/J=locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Edo Tensei no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Special/EdoTensei/Edo(src)
			new/obj/SkillCards/Ninjutsu/Special/EdoTensei/Commands/Edo_Attack(src)
			new/obj/SkillCards/Ninjutsu/Special/EdoTensei/Commands/Edo_Follow(src)
			new/obj/SkillCards/Ninjutsu/Special/EdoTensei/Commands/Edo_Stay(src)
			new/obj/SkillCards/Ninjutsu/Special/EdoTensei/Commands/Edo_DestroyAll(src)
			new/obj/SkillCards/Ninjutsu/Special/EdoTensei/Commands/Edo_DestroyOne(src)
#endif

obj/SkillCards/Ninjutsu/Special/EdoTensei
	icon='Card_Icons.dmi'
	JutsuType = "S-Rank"

obj/SkillCards/Ninjutsu/Special/EdoTensei/Edo
	icon_state="card_EdoTensei"
	cmdstring="EdoTensei"
	CCost=30000
	Seals=1
	CanLevel = 0
	var/Choosing = 0

	Description = list(
		"about"="Create a clone of the enemies you have stored in the past"
		,"title"="Edo Tensei"
		,"type"="Kinjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
//		,"pic"='HeavenCursedSeal.png'
	)

	New()
		..()
		if(!ismob(loc))
			return
		else
			var/mob/user = loc
			new/obj/SkillCards/Ninjutsu/Special/EdoTensei/Commands/Edo_Attack(user)
			new/obj/SkillCards/Ninjutsu/Special/EdoTensei/Commands/Edo_Follow(user)
			new/obj/SkillCards/Ninjutsu/Special/EdoTensei/Commands/Edo_Stay(user)
			new/obj/SkillCards/Ninjutsu/Special/EdoTensei/Commands/Edo_DestroyAll(user)
			new/obj/SkillCards/Ninjutsu/Special/EdoTensei/Commands/Edo_DestroyOne(user)

	Activate(mob/user)
		Choosing++
		if(Choosing == 1)
			var/list/Choices = list()
			for(var/C in user.EdoList)
				var/DNA/A = user.EdoList[C]
				if(!A.Summoned && !A.Destroyed)
					if(A.Cost <= user.Chakra)
						Choices["[A.name](Cost: [A.Cost] Chakra)"] = C
			if(Choices.len)
				var/DNA/A = user.EdoList[Choices[input("Who would you like to bring back?","Edo Tensei") as null|anything in Choices]]
				if(A)
					A.BringMeBack(get_step(user,user.dir))
					Choosing = 0
				else
					Choosing = 0
			else
				Choosing = 0

	verb/Store_DNA(var/mob/A in get_step(usr,usr.dir))
		set category="TECHNIQUES"
		set src in usr.contents
		var/mob/user = usr
		#if DEBUGGING
		#else
		if(!A.KO)
			user << "The target manages to avoid your grasp"
			return
		#endif
		if(A)
			if(!istype(A,/mob/Hittable/Unresponsive/Training) && !istype(A,/mob/Hittable/Unresponsive/Inanimate) && !istype(A,/mob/Hittable/Command/Clones)&& !istype(A,/mob/Hittable/Command/EdoClone) && !istype(A,/mob/Hittable/Command/Genjutsu)&& !istype(A,/mob/Hittable/Responsive/Animal) && (istype(A,/mob/player)||istype(A,/mob/Hittable)))
				if(alert("Are you sure you would like to store [A] as they currently are? you will not be able to store this target again in the future","Store DNA","Yes","No") == "Yes")
					if(A)
						if(!A.trueName)
							A.trueName = A.name
						if(user.EdoList[A.trueName])
							var/DNA/D = user.EdoList[A.trueName]
							if(D.Destroyed)
								D.Destroyed = 0
								D.Summoned = 0
								usr << "You have repaired the stored DNA sample of [A]"
						else
							user.EdoList[A.trueName] = new/DNA(A,user)
							usr << "You have stored a DNA sample of [A]"

DNA
	var
		name
		mob/Owner

		Wielding
		Appearance

		Rank = ""
		Cost = 0

		Destroyed = 0
		Summoned = 0

		Stamina = 1000
		Chakra = 1000
		Taijutsu = 0
		Ninjutsu = 0
		Genjutsu = 0
		Reflex = 1
		SealSpeed = 2
		MoveSpeed = 1
		JDT = 2

		Water = 0
		Fire = 0
		Wind = 0
		Earth = 0
		Lightning = 0

		KnifeSkill=1;
		ThrowingSkill=1;
		SwordSkill=1;
		H2HSkill=1;

		HasSharingan = 0
		HasByakugan = 0
		Control = 0

	New(mob/M,mob/O)
		if(M && O)
			if(!M.trueName||M.trueName=="")
				M.trueName = M.name

			name = M.trueName
			Owner = O

			Wielding = M.wielding
			var/icon/IC = icon(M.icon)
			var/OL = M.overlays
			OL -= 'SpeachBubble.dmi'
			OL -= 'waterwalk.dmi'
			for(var/A in OL)
				IC.Blend(icon(A:icon),ICON_OVERLAY)
			IC.Blend("#404040")
			Appearance = IC

			Rank = M.NinjaRank
			Cost = 6000 * Rank2Num(Rank)
			if(M.Stamina > M.StaminaMax)
				Stamina = round(M.Stamina * 0.9)
			else
				Stamina = round(M.StaminaMax * 0.9)
			if(M.Chakra>M.ChakraMax)
				Chakra = round(M.Chakra * 0.9)
			else
				Chakra = round(M.ChakraMax  * 0.9)
			Taijutsu = round(M.Taijutsu * 0.7)
			Ninjutsu = round(M.Ninjutsu * 0.9)
			Genjutsu = round(M.Genjutsu * 0.9)
			Reflex = M.Reflex
			SealSpeed = M.SS
			MoveSpeed = M.movespeed
			JDT = M.cooldownmultiplier

			Water = M.WaterElemental
			Fire = M.FireElemental
			Wind = M.WindElemental
			Earth = M.EarthElemental
			Lightning = M.LightningElemental

			KnifeSkill = M.KnifeSkill
			ThrowingSkill = M.ThrowingSkill
			SwordSkill = M.SwordSkill
			H2HSkill = M.H2HSkill

			HasSharingan = M.SharinganLevel
			HasByakugan = M.ByakuganLevel

			Control = (Taijutsu + Ninjutsu + Genjutsu + Cost)*1.4
		..()

	proc
		BringMeBack(LOC)
			Summoned = 1
			var/mob/Hittable/Command/EdoClone/A = new(LOC)

			A.name = "Edo [name]"
			A.trueName = name
			A.Creator = Owner
			A.overlays+='SharinganEyes.dmi'
			A.Cost = Cost

			A.wielding = Wielding
			A.icon = Appearance

			A.Stamina = Stamina
			A.StaminaMax = Stamina
			A.StaminaTrue = Stamina
			A.Chakra = Chakra
			A.ChakraMax = Chakra
			A.ChakraTrue = Chakra
			A.Taijutsu = Taijutsu
			A.TaijutsuMax = Taijutsu
			A.TaijutsuTrue = Taijutsu
			A.Ninjutsu = Ninjutsu
			A.NinjutsuMax = Ninjutsu
			A.NinjutsuTrue = Ninjutsu
			A.Genjutsu = Genjutsu
			A.GenjutsuMax = Genjutsu
			A.GenjutsuTrue = Genjutsu
			A.Reflex = Reflex
			A.SS = SealSpeed
			A.movespeed = MoveSpeed
			A.cooldownmultiplier = JDT

			A.WaterElemental = Water
			A.FireElemental = Fire
			A.WindElemental = Wind
			A.EarthElemental = Earth
			A.LightningElemental = Lightning

			A.KnifeSkill = KnifeSkill
			A.ThrowingSkill = ThrowingSkill
			A.SwordSkill = SwordSkill
			A.H2HSkill = H2HSkill
			A.NinjaRank = "NA"

			if(HasSharingan)
				A.InSharingan = HasSharingan
				A.see_invisible += HasSharingan
			if(HasByakugan)
				A.InByakugan = HasByakugan
				A.see_invisible += HasByakugan

			Owner.EdoCloneList += A
			Owner.Chakra -= Cost
			Owner.ChakraMax -= Cost
			Owner.JutsuChakra(Cost*0.01)
			Owner.JutsuNin(Cost*0.02);
			Owner.MoveUses["EdoTensei"]++

			IDCOPY(A,Owner)

			Owner.StatUpdate_chakra()
			if((Owner.Taijutsu + Owner.Ninjutsu + Owner.Genjutsu) < Control)// || Owner.ckey == "silvershodow" || Owner.ckey == "3hunnoblock" || Owner.ckey == "posaidon")
				Owner << "You dont seem to have full control of this clone"
				spawn(pick(60,180,360))
					if(A)
						A.Status = STATUS_REVOLT
						IDSET(A,"[Owner.trueName]Revolt")
						Owner << "[A] has broken free of your control"