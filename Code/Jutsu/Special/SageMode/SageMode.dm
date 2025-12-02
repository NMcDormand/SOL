mob
	var
		SageChakra = 0
		SageMax = 20000
		tmp
			SageMode = 0
			SageStoring = 0
			SageBoostT = 0
			SageBoostN = 0
			SageBoostS = 0

obj/SkillCards/Ninjutsu/Special/SenninMode
	icon_state=""
	cmdstring="SageMode"
	JutsuType = "S-Rank"

	Seals=1
	VerbIt=1
	CanLevel=0

	Description = list(
		"about"="Begin using natural chakra to increase your attributes"
		,"title"="Sage Mode"
		,"type"="Kinjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
//		,"pic"='HeavenCursedSeal.png'
		)

	Activate(mob/U)
		if(U.SageMode)
			U.SageMode = 0
		else
			if(U.GMfrozen||U.fishing||U.firing||U.transing) return
			if(!MultiBuffs && U.InBoost)
				U << "You already using a boost of some kind"
				return
			if(U.SageChakra<10000) {U<<"<font color=green>You need to have stored 10000 chakra before you can use this.</font>"; return}
			U<<"<b>You tap into your stored natural chakra.</b>"
			U.SageBoostT = U.Taijutsu * 0.3
			U.SageBoostN = U.Ninjutsu * 0.3
			U.SageBoostS = U.Stamina * 0.1
			U.Taijutsu += U.SageBoostT
			U.Ninjutsu += U.SageBoostN
			U.Stamina += U.SageBoostS
			U.RefreshStats()
			U.SageMode = 1
			U.InBoost = 1
			U.SageDrain()

	verb/SageMeditate()
		set name="Sage Mode: Store Chakra"
		var/mob/U = usr
		if(U.GMfrozen||U.afkFishing||U.firing) return
		if(U.SageStoring)
			U.SageStoring=0
			U<<"You are no longer storing your Chakra"
			U << "You now have [U.SageStoring] Natural Chakra Store"
		else
			U.SageStoring=1
			U.SageStore()
mob
	proc
		SageStore()
			set waitfor = 0
			icon_state = "rest"
			src<<"You begin focusing inward and begin storing natural chakra"
			while(SageStoring)
				var/ST = rand(100,1000)
				if(SageChakra >= SageMax)
					ST*=0.01
				SageChakra += ST
				sleep(5)
			icon_state = null

		SageDrain()
			set waitfor = 0
			while(SageMode)
				var/C =rand(100,2000)
				if(SageChakra > SageMax)
					C*=3
				if(SageChakra >= C)
					SageChakra -= C
					sleep(20)
				else
					break
			src<<"<font color=green>You are no longer using your natural chakra.</font>"
			Taijutsu -= SageBoostT
			Ninjutsu -= SageBoostN
			Stamina -= SageBoostS
			SageBoostT = 0
			SageBoostN = 0
			SageBoostS = 0
			InBoost = 0
			RefreshStats()