mob/VerbHolder/Admin/MGM/verb
	Max_Skills(mob/M in MasterPlayerList)
		for(var/obj/SkillCards/SC in M)
			if(SC.CanLevel && SC.Level < SC.LevelMax)
				SC.Control = 100
				SC.Level = 99
				SC.EXP(100000)

mob
	verb
		Teach_Me()
			set category = "TECHNIQUES"
			var/obj/SkillCards/S
			if(usr.HighlightedCard && istype(usr.HighlightedCard,/obj/SkillCards))
				S = HighlightedCard
			else
				var/list/UList = list()
				for(var/obj/SkillCards/SC in usr.contents)
					UList[SC.Description["title"]] =  SC
				if(UList.len)
					S = UList[input(usr,"Which Skill would you like to upgrade?","Upgrade") as null|anything in UList]
				else
					return
			if(S)
				usr << "<h2>[S.Description["title"]]</h2><br><b>[S.Tutorial()]</b>"

obj/var/tmp
	freeze
	mob/Owner
	movespeed=1
	moving
	Taijutsu
	Ninjutsu
	Genjutsu
	//elements
	FireElemental=0
	EarthElemental=0
	WaterElemental=0
	WindElemental=0
	LightningElemental=0
	//adv elements
	LavaElemental = 0
	ExplosionElemental = 0
	WoodElemental = 0
	MagnetElemental = 0
	BlazeElemental = 0
	BoilElemental = 0
	ScorchElemental = 0
	StormElemental = 0
	SwiftElemental = 0
	GaleElemental = 0
	IceElemental = 0
	SandElemental = 0
	ParticleElemental = 0
	YinElemental = 0
	YangElemental = 0

	target=""
	hitcount
	Power

mob
	var
		list/MoveUses = list()
		JutsuMulti = 1
		tmp
			Charging = 0
			SkillTime = 0
			SkillTimer = 0
			EventTime = 0
			EventTimer = 0
	proc
		SetTimer(A=60,C="Skill",B="SkillTimer")
			set waitfor = 0, background = 1
			switch(B)
				if("SkillTimer")
					if(A>0)
						if(SkillTime == C)
							SkillTimer = A
						else if(winget(src, "[B]","is-visible") == "false")
							SkillTimer = A
							SkillTime = C
							winshow(src,"mainwindow.[B]",1)
							src<<output("<center>[A]</center>","mainwindow.[B]")
							while(SkillTimer && SkillTime == C)
								sleep(10)
								SkillTimer--
								src<<output("<center>[SkillTimer]</center>","mainwindow.[B]")
							if(SkillTime == C)
								SkillTime = 0
								spawn(40)
									if(!SkillTime)
										winshow(src,"mainwindow.[B]",0)
					else
						if(SkillTime == C)
							winshow(src,"mainwindow.[B]",0)
							SkillTime = 0
							SkillTimer = 0
				if("EventTimer")
					if(A>0)
						if(SkillTime == C)
							EventTimer = A
						else if(winget(src, "[B]","is-visible") == "false")
							EventTimer = A
							EventTime = C
							winshow(src,"mainwindow.[B]",1)

							src<<output("<center>[A]</center>","mainwindow.[B]")
							while(EventTimer && EventTime == C)
								sleep(10)
								EventTimer--
								src<<output("[A]","mainwindow.[B]")
							if(EventTime == C)
								EventTime = 0
								spawn(40)
									if(!EventTime)
										winshow(src,"mainwindow.[B]",0)

					else
						if(EventTime == C)
							winshow(src,"mainwindow.[B]",0)
							EventTime = 0
							EventTimer = 0

obj/SkillCards
	icon='Card_Icons.dmi'
	var
		JutsuType = 0
		VerbIt = 1
		Tier = 1
		AcquiredReal
		AcquiredDate

		CanLevel = 1
		Level = 1
		LevelMax = 100

		//Uses = 0
		IsBunshin = 0
		Control = 10

		CXP = 0
		MXP = 10
		XPLGain = 3
		XPMulti = 1

		Cooldown = 0
		CooldownCur = 0

		Seals = 0

		CCost = 0
		SCost = 0
		ECost = 0

		AOE = 0
		Range = 9
		Duration = 0
		Shots = 1
		Size = 1
		Tracker = 0
		DM = 0 //for damages
		Speed = 1

		WaterUsage = 0 //For jutsu that can upgrade to use on water

		Enabled = 0
		Disabled = 0

		UpgradeAvailable = 0
		Upgraded = 0
		UpgradeMax = 3
		var/Created = 0
		list/Upgrades = list()
		list/UpgradeChoices = list()

	Starter
		CanLevel = 0

	Click(x,y)
		//var/FI = findtext("[y]","HotBar")
		if(VerbIt && !usr.JutsuBrowse)
			Activate(usr)
		else
			//if((src in usr)&&(findtext("[y]","AllJutsu")))
			//if(!FI)
			usr.CurrentSkillSelection=cmdstring
			if(usr.HighlightedCard)
				usr.HighlightedCard.overlays=null
			usr.HighlightedCard=src
			overlays+='Card_Highlight.dmi'
			//AttackType.text='[JutsuType]';
			winset(usr,"JutsuWindow.UpgradeButton", "is-visible = [Upgraded < UpgradeAvailable ? "true":"false"]")
			if(ECost)
				if(istype(src,/obj/SkillCards/Clan/Aburame))
					winset(usr,null,"ExtraCost.text='Insect Cost = [ECost]")
				else if(istype(src,/obj/SkillCards/Clan/Akimichi))
					winset(usr,null,"ExtraCost.text='Calorie Cost = [ECost]")
				else if(istype(src,/obj/SkillCards/Clan/Clay))
					winset(usr,null,"ExtraCost.text='Clay Cost = [ECost]")
				else if(istype(src,/obj/SkillCards/Clan/Sand))
					winset(usr,null,"ExtraCost.text='Sand Cost = [ECost]")
			else
				winset(usr,null,"ExtraCost.text=''")
			winset(usr,null,"DamageAmount.text=''")
			var/LevelMSG
			if(Level>=LevelMax)
				LevelMSG = "Max"
			else
				LevelMSG = "[Level]/[LevelMax]"
			winset(usr,null,"JutsuLevel.text='[LevelMSG]'; JutsuName.text='[name]';JutsuAbout.text='[Description["about"]]' ChakraLabel.text='Chakra Cost'; ChakraCost.text='[CCost]'; StaminaCost.text='[SCost]';Range.text='[Range]';SealsRequired.text='[Seals]'; SkillType.text='[Description["type"]]'; WeakAgainst.text='[Description["weak"]]'; Rank.text='[Description["rank"]]'; JutsuUses.text='[usr.MoveUses[name]]'; JutsuThumbnail.image=[Description["pic"]]")

	New()
		if(!Description.len)
			del src
		if(VerbIt)
			verbs += new/obj/SkillCards/proc/VerbMe(src,cmdstring)
		if(!CanLevel)
			Level = LevelMax
		if(!CooldownCur)
			CooldownCur = Cooldown
		.=..()
		if(ismob(loc)) //double check the card is actually in a player
			var/mob/M = loc
			if(M.JutsuList[name])
				Created = M.trueName
			if(Created == M.trueName)
				return
			Created = M.trueName
			M.JutsuList[name] = 1
			AcquiredReal = world.realtime
			//We dont want standard skills and commands to be given again via a seed
			if(istype(src,/obj/SkillCards/Ninjutsu/Special/EdoTensei/Commands)||istype(src,/obj/SkillCards/ClimbTree)||istype(src,/obj/SkillCards/ActionButton))
				return
			//No skill seed for release commands
			if(istype(src,/obj/SkillCards/Clan/Lee/HachimonClose)||istype(src,/obj/SkillCards/Ninjutsu/Doton/YomiNumaRelease)||istype(src,/obj/SkillCards/Clan/Nara/KagemaneRelease)||istype(src,/obj/SkillCards/Ninjutsu/Fuuton/FujinHekiRelease)||istype(src,/obj/SkillCards/Clan/Kaguya/SawarabiNoMaiRelease))
				return

			if(istype(src,/obj/SkillCards/Starter)||istype(src,/obj/SkillCards/Taijutsu/Starter)||istype(src,/obj/SkillCards/Ninjutsu/Starter)||istype(src,/obj/SkillCards/Genjutsu/Starter)||istype(src,/obj/SkillCards/CS/CS_Basic))
				return

			GlobalSkills[name]++ //For stats on how many jutsu have been collected of each type

			if(istype(src,/obj/SkillCards/Clan/Uchiha/MS)) //We still want a count of these but dont want a skill seed
				return

			if(istype(src,/obj/SkillCards/Taijutsu/CursedSeal_Earth)||istype(src,/obj/SkillCards/Ninjutsu/CursedSeal_Heaven)||istype(src,/obj/SkillCards/Taijutsu/CreationRebirth)) //We still want a count of these but dont want a skill seed
				return

			if(!ReadySkills[name]) //We want the type path saved for future seeds
				ReadySkills[name] = "[type]"

			var/SkillSeed/SS
			if(M.SkillSeeds[name])
				SS = M.SkillSeeds[name]
				M.SkillSeeds[name] = null
			else
				SS = new(name,list("Taijutsu" = M.TaijutsuTrue,"Ninjutsu" = M.NinjutsuTrue,"Genjutsu" = M.GenjutsuTrue),0,0,Level,M)

			if(Description["Element"])
				var/EL = Description["Element"]
				SS.Stat_Req["[EL]Elemental"] = M.vars["[EL]Elemental"]
			if(istype(src,/obj/SkillCards/Clan))
				SS.Clan = M.Clan
			SS.Setup(M)

	proc
		VerbMe()
			set category = "TECHNIQUES"
			set src in usr
			Activate(usr)

		Activate(mob/U)
			if(CanLevel && Level < LevelMax)
				var/XPL = XPLGain * XPMulti
				if(U.DamagedRecently)
					XPL *= 3
				EXP(XPL)

		DeActivate()
			..()

		Tutorial()
			return Description["Tutorial"]

		ChakraUseCheck(mob/U)
			if(Level<10 && prob(60))
				U << "Your lack of control of [name] made this costly"
				return 1
			else
				return 0

		ControlCheck(mob/U)
			if(!prob(Control))
				switch(pick(1,2,3,4))
					if(1)
						U << "<i><b>Your chakra didnt mould correctly, you failed using [Description["title"]]</b></i>"
					if(2)
						U << "<i><b>You missed a seal and failed using [Description["title"]]</b></i>"
					if(3)
						U << "<i><b>You weren't concentrating and failed using [Description["title"]]</b></i>"
					if(4)
						U << "<i><b>Nothing happened, you failed using [Description["title"]]</b></i>"
				return 1
			else
				if(U.InKamui)
					U.InKamui = 0
					U << "Your Kamui has deactivated"
				return 0

		EXP(A)
			var/mob/M = loc
			A *=  (10*M.JutsuMulti) * EXPGains_JutsuLevel

#if DEBUGGING
			A *= 20
#endif
			if(Level < LevelMax)
				CXP += A
				var/Levels = 0
				while(CXP >= MXP && Level < LevelMax)
					Levels = 1
					Level++
					CXP -= MXP
					MXP = round(MXP*1.02)
					if(Control<100)
						Control += 3
				if(Levels)
					M << "Your skill with [Description["title"]] has improved"
					CooldownCur = Cooldown - ((Cooldown*0.005)*Level)
					if(CooldownCur<0)
						CooldownCur = 1
					if(Control>100)
						Control = 100

				if(Level == LevelMax)
					if(Control < 100)
						Control = 100
					M << "[name] has reached its Max Level"

				if(UpgradeMax > UpgradeAvailable)
					if(Level >= 15 && !UpgradeAvailable)
						UpgradeAvailable++
						M<<"Your first upgrade to [name] is available"
					if(Level>=45 && UpgradeAvailable<2)
						UpgradeAvailable++
						M<<"Your second upgrade to [name] is available"
					if(Level >= 80 && UpgradeAvailable<3)
						UpgradeAvailable++
						M<<"Your final upgrade to [name] is available"
