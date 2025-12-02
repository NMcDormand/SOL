mob/var/list
	JutsuList = list()
mob/proc
	RelogJutsu()
		if(!JutsuList)
			JutsuList = list()
		else
			if(JutsuList["Waterwalk"])
				verbs+=new/mob/VerbHolder/WaterWalk/verb/ToggleWW()

	Skills()
		if(!JutsuList)
			JutsuList=list()
		var/list/JL = JutsuList
		SpeedCheck()
		LearnWaterWalk()
		ChuuninChecker()
		if(NinjaRank!="Academy Student"&&NinjaRank!="Genin")
			CSLevel()
			if(!RankUp) Ranks()
		//if(NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&NinjaRank!="Chuunin") LearnCustomJutsu()
// -- -- Skill Seeds -- --*
		for(var/SK in SkillSeeds)
			var/SkillSeed/SS = SkillSeeds[SK]
			if(SS)
				if(SS.Clan && SS.Clan != Clan)
					continue
				SS.Check(src)
// -- -- PROFESSIONS -- --*
		for(var/P in Class)
			if(Class[P])
				switch(P)
					if("Assassin-Nin")
						if(!JL["Meisaigakure"])
							LearnHidingCamo();
						if(!JL["MuonSatsujin"])
							LearnSilenthomicide()
					if("Fan-Nin")
						if(!JL["Daikamaitachi"])
							learnDaikamaitachi()
						if(!JL["Ookamaitachi"])
							learnOokamaitachi()
						if(!JL["TatsuOoshigoto"])
							learnTatsuOoshigoto()
					if("Hand2Hand-Nin")
						if(!JL["Oukashou"])
							LearnOukashou()
						if(!JL["TsuutenKyaku"])
							LearnTsuutenKyaku()
					//if("Jashin")
					if("Medical-Nin")
						if(!JL["ChakranoMesu"])
							LearnMesu()
						if(!JL["RanshinShou"])
							LearnRanshinShou()
					//if("Sensory-Nin")

// -- -- CLANS -- --*
		switch(Clan)
			if("Aburame")
				if(!JL["MushiYose"])
					LearnMushiYose()
				if(!JL["PlaceBug"])
					LearnPlaceSpyBug()
				if(!JL["LocateBug"])
					LearnLocateBug()
				if(!JL["MushiBunshin"])
					LearnMushiBunshin()
				if(!JL["MushiKabe"])
					LearnMushiKabe()
				if(!JL["MushiNoYoroi"])
					LearnMushinoYoroi()
				if(!JL["MushiSwarm"])
					LearnMushiSwarm()
				if(!JL["BakuhatsuMushikui"])
					LearnBugExplode()

			if("Akimichi")
				if(!JL["Baika"])
					LearnGiant()
				if(!JL["NikudanSensha"] && JutsuList["Baika"])
					LearnTank()

			if("Clay")
				if(!JL["KibakuJirai"])
					LearnKibakuJirai()
				if(!JL["KibakuNendo"])
					LearnKibakuNendo()
				if(JL["KibakuNendo"] && !JL["Katsu"])
					LearnKatsu()
				if(!JL["ShiFo"])
					learnShiFo()
				if(!JL["KyukyokuGeijutsu"])
					learnKyukyokuGeijutsu()

			if("Hyuuga")
				if(!JL["HakkeKyushou"])
					LearnKyushou()
				if(!JL["Byakugan"])
					LearnByakugan()
				if(!JL["HakkeRokujyuyonShou"])
					Learn64Palms()
				if(!JL["HakkeHyakunijyuhachiShou"])
					Learn128Palms()

			if("Inuzuka")
				if(!JL["Tsuuga"])
					LearnTsuuga()
				if(!JL["DynamicMarking"])
					LearnDynamicMarking()
				if(!JL["JuujinBunshin"])
					LearnJuujinBunshinNoJutsu()
				if(!JL["Garouga"])
					LearnGarouga()
				if(!JL["Gatsuuga"])
					LearnGatsuuga()
				if(!JL["Soutourou"])
					LearnSoutourou()

			if("Kaguya")
				if(!JL["CreateBoneKunai"])
					LearnBoneKunai()
				if(!JL["YanagiNoMai"])
					LearnYanaginoMai()
				if(!JL["CreateBoneSword"])
					LearnBoneSword()
				if(!JL["TsubakiNoMai"])
					LearnTsubakinoMai()
				if(!JL["CreateSpineWhip"])
					LearnSpineWhip()
				if(!JL["TessenkanoMai"])
					LearnTessenkanoMai()
				if(!JL["KaramatsuNoMai"])
					LearnKaramatsuNoMai()
				if(!JL["TeshiSendan"])
					LearnTeshiSendan()
				if(!JL["SawarabiNoMai"])
					LearnSawarabiNoMai()
				if(!JL["WarabiNoMai"])
					LearnWarabiNoMai()

			if("Nara")
				if(!JL["Kagemane"])
					LearnKagemane()
				if(!JL["KageKubiShibari"])
					LearnNeckBind()
				if(!JL["Kagearashi"])
					LearnKageArashi()

			if("Sand")
				if(!JL["SunaShuriken"])
					LearnSunaShuriken()
				if(!JL["SunaBunshin"])
					LearnSunaBunshin()
				if(!JL["SunaYoroi"])
					LearnArmourOfSand()
				if(!JL["SabakuKyou"])
					LearnDesertCoffin()
				if(!JL["SabakuSoso"])
					LearnDesertFuneral()

			if("Sarutobi")
				if(!JL["Hien"])
					LearnHien()
				if(!JL["Haisekisho"])
					LearnHaise()
				if(!JL["HiuchiYagura"])
					LearnYagura()
				if(!JL["Senpuu"])
					LearnSenpuu()
				if(!JL["Reppuu"])
					LearnReppuu()
				if(!JL["ReaperDeath"])
					LearnReaper()

			if("Taijutsu Specialist")
				if(!JL["Senpuu"])
					LearnSenpuu()
				if(!JL["DaiSenpuu"])
					LearnDaiSenpuu()
				if(!JL["Reppuu"])
					LearnReppuu()
				if(!JL["Shoufuu"])
					LearnShoufuu()
				if(!JL["GourikiSenpuu"])
					LearnkGourikiSenpuu()
				if(JutsuList["Hachimon"] < 8)
					LearnGates()
				if(!JL["OmoteRenge"])
					LearnOmoteRenge()
				if(!JL["UraRenge"])
					LearnUraRenge()

			if("Uchiha")
				if(!JL["Sharingan"])
					LearnSharingan();
				if(!CanLearnMangekyouSharingan && !HasMangekyou)
					LearnHigherSharingan();
				if(!JL["KyoutenChiten"])
					LearnKyoutenChiten()

			if("Uzumaki")
				if(!JL["ReaperDeath"])
					LearnReaper()
				if(!JL["TajuuKageBunshin"])
					LearnTajuu()

			if("Yuki")
				if(!JL["SensatsuSuishou"])
					LearnSensatsu()
				if(!JL["IceBlast"])
					LearnIceBlast()
				if(!JL["OniKagami"])
					LearnMirrorFormation()
				if(!JL["MakyouHyoushouKogeki"])
					LearnMirrorAttack()
				if(!JL["Kurosuhebun"])
					LearnCrossHaven()
				if(!JL["MakyouHyoushou"])
					LearnMirrorDome()
				if(!JL["Sukuinomado"])
					LearnMirrorDefense()

		if(HasRinnegan)//"Unknown")
			//if(!JL["ShinraTenseiPush"])
			//	LearnShinraPush()
			if(!JL["ShinraTenseiPull"])
				LearnShinraPull()
			if(!JL["ChibakuTensei"])
				LearnChibakuTensei()
			if(!JL["LimboHengoku"])
				LearnLimboClone()
			if(!JL["TengaShinsei"])
				LearnTengaShinsei()

// -- -- Mangekyou -- --*
		if(HasMangekyou && SharType)
			if(!JL["Tsukuyomi"] && (SharType == 1||SharType2 == 1))
				LearnTsukuyomi()
			if(!JL["Amaterasu"] && (SharType == 2||SharType2 == 2))
				LearnAmaterasu()
			if(!JL["KamuiToggle"] && (SharType == 3||SharType2 == 3))
				LearnKamuiToggle()
			if(!JL["Izanami"] && (SharType == 4||SharType2 == 4))
				LearnIzanami()
			if(!JL["Izanagi"] && (SharType == 5||SharType2 == 5))
				LearnIzanagi()

// -- -- BUNSHINS -- --*
		if(!JL["KageBunshin"])
			LearnKageBunshin()
		if(BunshinLimitMax<8||Clan != "Uzumaki" && BunshinLimitMax<10)
			LearnBunshinLimit();

// -- -- Elementals -- --*
		if(EarthElemental)
			if(!JL["DoryuuDango"])
				LearnDoryuuDango()
			if(!JL["DoryuuHeki"])
				LearnDoryuuHeki()
			if(!JL["DoryuuDan"])
				LearnDoryudan()
			if(!JL["ShinjuuZanshu"])
				LearnShinjuu()
			if(!JL["DorouDoumu"])
				LearnDorouDoumu()
			if(!JL["RetsudoTensho"])
				LearnRetsudoTensho()
			if(!JL["YomiNuma"])
				LearnYomiNuma()

		if(FireElemental)
			if(!JL["Goukakyuu"])
				LearnGoukakyuu()
			if(!JL["Housenka"])
				LearnHousenka()
			if(!JL["Ryuuka"])
				LearnRyuuka()
			if(!JL["KaryuuEndan"])
				LearnKaryuuEndan()

		if(WindElemental)
			if(!JL["Daitoppa"])
				LearnDaitoppa()
			if(!JL["MugenSajinDaitoppa"])
				LearnMugenSajinDaitoppa()
			if(!JL["Renkoudan"])
				LearnRenkoudan()
			if(!JL["Fusajin"])
				LearnFusajin()
			if(!JL["FujinHeki"])
				LearnFujinHeki()

		if(WaterElemental)
			if(!JL["Daibakufu"])
				LearnDaibakufu()
			if(!JL["MizuBunshin"])
				LearnMizuBunshin()
			if(!JL["Suiryuudan"])
				LearnSuiryuudan()
			if(!JL["GoshoKuzame"])
				LearnGoshoKuzame()
			if(!JL["Suikoudan"])
				LearnSuikoudan()

		if(LightningElemental)
			if(!JL["Raikyuu"])
				LearnRaikyuu()
			if(!JL["RairyuunoTatsumaki"])
				LearnRairyuunoTatsumaki()
			if(!JL["RaitonKageBunshin"])
				LearnRaitonKageBunshin()
			if(!JL["RaijuTsuiga"])
				LearnRaijuTsuiga()
			if(!JL["Shibari"])
				LearnShibari()
			if(!JL["RaitonYoroi"])
				LearnRaitonYoroi()

// -- -- TAIJUTSU -- --*
		if(!JL["KageBuyou"])
			LearnKageBuyou()

// -- -- NINJUTSU -- --*
		if(!JL["Zankouha"])
			LearnZankouha()
		if(!JL["Kyoumeisen"])
			LearnKyoumeisen()
		if(!JL["Zankoukyokuha"])
			LearnZankoukyokuha()

		if(!JL["ShunshinToggle"])
			LearnShunshin()
		if(!JL["Kirigakure"])
			LearnKirigakure()
		if(!JL["Suirou"])
			LearnWaterPrison()

		if(!JL["ShinsuCircle"])
			LearnShinCircle()
		if(!JL["Shinwonryu"])
			LearnShinWonRyu()
		if(!JL["Thorn"])
			LearnThorn()
		if(JutsuList["Thorn"] && ThornMax < 2)
			LearnThorn2()

		if(HasRequiredRank("Anbu")&&ChoseANBU)
			if(!JL["Kanashibari"])
				LearnKanashibari()

		if(HasSeal=="Heaven")
			if(!JL["CursedSeal Heaven"])
				LearnHeavenCS()
		if(HasSeal=="Earth")
			if(!JL["CursedSeal Earth"])
				LearnEarthCS()

		if(HasSeal=="Genesis Seal")
			if(!JL["CreationRebirth"])
				Learn_CreationRebirth()

		if(HasHiraishin)
			if(!JL["HiraishinDanmaku"])
				LearnHiraishinDanmaku()

// -- -- GENJUTSU -- --*
		if(!JL["Dispel"])
			LearnDispel();

		if(!JL["sexyjutsu"])
			LearnSexyJutsu();

		if(!JL["NehanSouja"])
			LearnNehanShoujanoJutsu();
		if(!JL["Kokuangyou"])
			LearnKokuangyounoJutsu();
		if(!JL["JubakuSatsu"])
			LearnJubakuSatsu();
		if(!JL["FlowerPetalEscape"])
			LearnPetalEscape();
		if(!JL["Narakumi"])
			LearnNarakumi()

		if(!JL["Sutendomira"])
			LearnSutendomira();
		if(!JL["TobenaiBoko"])
			LearnTobenai();
		if(!JL["SenshokuKaze"])
			LearnSenshokuKaze();
		if(!JL["SenshokuFirudo"])
			LearnSenshokuFirudo();
		if(!JL["KirabiyakanaKibarashi"])
			LearnKirabiyakanaKibarashi()

		LearnStarters()


mob/proc
	HasRequiredRank(RANKNEEDED)
		if(Rank2Num(NinjaRank)>=Rank2Num(RANKNEEDED)) return TRUE

	HasRequiredElement(ELEMENT)
		if(PE==ELEMENT||SE==ELEMENT) return TRUE

proc/Rank2Num(RANK)
	switch(RANK)
		if("Academy Student") return 1
		if("Genin")  return 2
		if("Chuunin") return 3
		if("Special Jounin") return 4
		if("Anbu","Missing-Nin") return 5
		if("Jounin") return 6
		if("Kage Level") return 7
		else
			return 8
		/*
		if("Mizukage") return 8
		if("Hokage") return 8
		if("Raikage") return 8
		if("Kazekage") return 8
		if("Tsuchikage") return 8
		*/