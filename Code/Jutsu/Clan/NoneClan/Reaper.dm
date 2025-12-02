obj/SkillCards/Clan/Uzumaki/ReaperDeath
	//icon_state="card_Kaiten"
	cmdstring="ShikiFujin" //Expansion Jutsu
	Cooldown=13000
	Seals=20
	XPLGain = 100

	UpgradeChoices = list("Lower Cooldown")

	Description = list(
		"about"="Sealing Jutsu: Reaper Death Seal"
		,"title"="Fuinjutsu: Shiki Fujin"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="s"
//		,"pic"='Kaiten.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			//c=1000
			//mx=c
			s=U.SS*10
		if(U.CooldownCheck("ReaperDeath",(CooldownCur*U.cooldownmultiplier)+s)) return
		U.icon_state="seals"
		U.frozen=1
		U.firing=1
		spawn(s)
			U.JutsuMessage(Description["title"])
			U.JutsuSeals(s); U.JutsuNin(100);U.MoveUses[name]++
			spawn(40) {U.firing=0;}

			if(U.PracticeMode || ControlCheck(U))
				U.frozen=0
				return ..()

			var/icon/IC=icon('Reaper2.dmi')
			var/image/C = image(IC,U)
			C.pixel_x = -64
			var/list/Reapers = list(C)

			U.reaper=10;
			U<<C;
			var/DMG = (U.Stamina + U.Chakra + U.Taijutsu + U.Ninjutsu + U.Genjutsu)*0.2
			U.ReaperSelfDamage()
			var/list/Ms = list()
			for(var/mob/A in get_step(U, U.dir))
				Ms += A
			for(var/mob/A in U.MasterBunshinList)
				var/image/GotEm = 0
				for(var/mob/B in get_step(A, A.dir))
					if(!GotEm)
						GotEm = image(IC,A)
						GotEm.pixel_x = -64
						Reapers += GotEm
						U << GotEm
					Ms += A
				spawn(50)
					if(A)
						del A
			for(var/mob/M in Ms)
				for(var/image/A in Reapers)
					M<<A
				M.reaper=10;
				M.ReaperDamage(U,DMG);
			sleep(50)
			U.RemoveReaper(Reapers)

mob/proc
	RemoveReaper(list/Reapers)
		set waitfor = 0
		while(reaper && src)
			sleep(10)
		for(var/image/A in Reapers)
			del A

	ReaperSelfDamage()
		set waitfor = 0
		var/dmg = Stamina *0.25
		for(var/i=1 to 5)
			Wounds+=30
			DamageMe(src,dmg,AttackMethod, 1)
			if(reaper>1)
				reaper-= 3
			//StatUpdate_stamina()
			//StatUpdate_wounds()
			sleep(reaper)
		reaper = 0
		hearers(4,src) << "[src] begins drawing their final breaths as the reaper fades"
		sleep(20)
		reaper = 1
		KillMe(src)
		reaper = 0

	ReaperDamage(var/mob/U,dmg)
		set waitfor = 0
		if(!dmg)
			reaper = 0
		for(var/i=1 to 5)
			Wounds+=30
			DamageMe(U,dmg,"ShikiFujin", 1)
			if(reaper>1)
				reaper-= 3
			//StatUpdate_stamina()
			//StatUpdate_wounds()
			sleep(reaper)
		reaper=0