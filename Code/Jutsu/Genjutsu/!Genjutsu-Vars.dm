//var
	//SenshokuMobs = list()

mob

	proc
		SightReset()
			sight = 0
			sight |= SEE_SELF

	var
		tmp
			InIllusion = 0

			Dispelling
			IsBlinded
			JubakuBound
			Sleeping
			sleepy
			SleepList=list()
			Dispel
			Darkness
			endjubaku

			//Sutendo
			mob/FakeEyeTgt = null
			mob/Projection = null
			ControlProjection = 0
			OSight = null
			InFakeView = 0

			//Tobenai
			mob/FakeEnemyTgt = 0
			InFakeEnemyView = 0

			SenshokuTargets = list()
			SenshokuDispel = 0

			//Firudo
			InFirudo = 0
			//Kaze
			InSenKaze = 0
			SenKazeBreak = 0

			//Kirabiyakana
			InKirabiyakana = 0
			KiraClones = list()
