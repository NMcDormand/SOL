var
	Rate_Stamina=300
	Rate_Chakra=100
	Rate_NGT=30

	Rate_Weapon = 8
	Rate_AllWeaps = 1
	Rate_Skill=1
	Rate_Luck = 1

	Rate_Elemental=15
	Rate_CC=1
	Rate_SS=1

	Rate_Reflex=1
	Rate_Gold=20

	Rate_JDT = 0.05

	Rate_JuEx = 100

	NewEleCost = 1000

mob
	var
		list/StatPointsSpent = list()
		list/StatPointsObtained = list()
		Luck = 0
		tmp
			SPSASK = 0
			InSPS = 0
			SPchoosing
			list/BonusSPS = list()
			TheoreticalStatPoints
			StatCount = 0
			SPNewEle = 0

mob/player
	verb

		UseSPS()
			set hidden=1
			if(SpyStatus)
				return
			InSPS=1
			if(usr.TakingExam||!usr.client||!usr.loggedin||usr.dead) return
			winshow(usr,"StatPoints",1)
			//winset(usr,null,"OutputChild.left='StatPointsGrid';StatPoints.ClanChild.left='SP_[usr.Clan]'")
			var/CL = usr.Clan
			if(usr.Clan == "Taijutsu Specialist")
				CL = "TaijutsuSpecialist"
			winset(usr,null,"StatPoints.ClanChild.left='SP_[CL]';StatPoints.SPName.text='[usr.Clan], [usr.trueName]';")
			usr.TheoreticalStatPoints=usr.StatPoints;
			usr.StatCount=0;
			usr.SPNewEle = 0
			ClearSPGrid()
			usr.BonusSPS=list()
			if(!usr.StatPointsSpent) usr.StatPointsSpent=new()

			usr.verbs += typesof(/mob/StatPointsVerbs/proc)
			usr << output(usr.TheoreticalStatPoints,"StatPoints.Remaining")
			CantWalk++

	proc
		AskAndShowSPUseEffect(selected_field, field_bonus_sps_name, single_cost, single_add_rate, max_adds_from_cap)
			set hidden=1
			if(SPSASK)
				return

			if(single_cost > TheoreticalStatPoints)
				alert("You don't have enough stat points left.")
				return

			if(max_adds_from_cap <= 0)
				alert("You are already at the maximum!")
				return

			SPSASK = 1
			var
				max_adds = min(max_adds_from_cap, round(TheoreticalStatPoints / single_cost))
				theoretical_sps_to_add = 1

			if(max_adds > 0.99 && max_adds < 1)
				max_adds = 1

			theoretical_sps_to_add = round(input("You can add to [selected_field] [max_adds] time/s. How many times would you like to use SPs in this?", "SP Uses") as num)

			if(theoretical_sps_to_add < 0)
				alert("You can't apply a negative number of SPs!")
				SPSASK = 0
				return

			if(theoretical_sps_to_add == 0)
				SPSASK = 0
				return

			if(theoretical_sps_to_add > max_adds)
				alert("That would take you beyond the maximum!")
				SPSASK = 0
				return

			var
				add_amount = theoretical_sps_to_add * single_add_rate
				total_cost = theoretical_sps_to_add * single_cost

			if(!(field_bonus_sps_name in BonusSPS))
				BonusSPS[field_bonus_sps_name] = 0

			BonusSPS[field_bonus_sps_name] += add_amount
			TheoreticalStatPoints -= total_cost

			var/total_added = BonusSPS[field_bonus_sps_name]

			src << output(TheoreticalStatPoints,"StatPoints.Remaining")
			UpdateSPGrid("+[total_added] [selected_field]","[lowertext(selected_field)]")
			SPSASK = 0

mob/StatPointsVerbs/proc
	SPReset()
		set hidden=1
		var/mob/player/user = usr
		user.TheoreticalStatPoints=usr.StatPoints;
		user.StatCount=0;
		user.SPNewEle = 0
		ClearSPGrid()
		user.BonusSPS=list()
		if(!user.StatPointsSpent) usr.StatPointsSpent=new()
		user << output(usr.TheoreticalStatPoints,"StatPoints.Remaining")

	SPExEl()
		set hidden=1
		var/mob/player/user = usr
		var/list/EleList = list("Fire","Water","Lightning","Wind","Earth")
		for(var/A in EleList)
			if(user.vars["[A]Elemental"])
				EleList -=A
		if(EleList.len)
			if(SPNewEle < EleList.len)
				if(TheoreticalStatPoints >= NewEleCost)
					TheoreticalStatPoints -= NewEleCost
					SPNewEle++
					src << output(TheoreticalStatPoints,"StatPoints.Remaining")
					UpdateSPGrid("+[SPNewEle] New Element","New Element")
				else
					alert(user,"You need [NewEleCost] to unlock another element")
					return
			else
				alert(user,"You have already selected to acquire as many as is possible")
				return
		else
			alert(user,"You already have the 5 basic elements")
			return


	SPJuEx()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("Jutsu Experience", "JuEx", 1, Rate_JuEx, TheoreticalStatPoints)

	SPInLu()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("Luck", "LUCK", 50, Rate_Luck, TheoreticalStatPoints)

	SPstamina()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("Stamina", "STAMINA", 1, Rate_Stamina, TheoreticalStatPoints)

	SPchakra()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("Chakra", "CHAKRA", 1, Rate_Chakra, TheoreticalStatPoints)

	SPtaijutsu()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("Taijutsu", "TAI", 1, Rate_NGT, TheoreticalStatPoints)

	SPninjutsu()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("Ninjutsu", "NIN", 1, Rate_NGT, TheoreticalStatPoints)

	SPgenjutsu()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("Genjutsu", "GEN", 1, Rate_NGT, TheoreticalStatPoints)

	SPWSkill(SkillName as text)
		set hidden=1
		var/mob/player/user = usr
		var/R = Rate_Weapon
		var/SC =  uppertext(SkillName)
		if(SkillName == "All")
			SC = "AllWeaps"
			SkillName = "Weapon Skills"
			R = Rate_AllWeaps

		user.AskAndShowSPUseEffect(SkillName, SC, 3, R, TheoreticalStatPoints)

	SPKnife()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("Knife", "KNIFE", 3, Rate_Weapon, TheoreticalStatPoints)

	SPsword()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("Sword", "SWORD", 3, Rate_Weapon, TheoreticalStatPoints)

	SPhandtohand()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("H2H", "H2H", 3, Rate_Weapon, TheoreticalStatPoints)
/*
	SPthrowing()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("Throwing", "THROWING", 3, Rate_Weapon, TheoreticalStatPoints)

	SPfirstaid()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("First Aid", "FIRSTAID", 5, Rate_Skill, 100 - BonusSPS["FIRSTAID"] - FirstAidSkillTrue)

	SPcrafting()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("Crafting", "CRAFTING", 5, Rate_Skill, 100 - BonusSPS["CRAFTING"] - CraftingSkill)

	SPfishing()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("Fishing", "FISHING", 5, Rate_Skill, 100 - BonusSPS["FISHING"] - FishingSkillTrue)


	SPprimary()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect(PE, "PRIMARY", 1, Rate_Elemental, TheoreticalStatPoints)

	SPsecondary()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect(SE, "SECONDARY", 1, Rate_Elemental, TheoreticalStatPoints)


	SPgold()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("Gold", "GOLD", 1, Rate_Gold, TheoreticalStatPoints)

	SPchakracontrol()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("CC", "CC", 2, Rate_CC, 100 - BonusSPS["CC"] - ChakraControl)

	SPsealspeed()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("Seal Speed", "SS", 13, Rate_SS, (SS - BonusSPS["SS"] - 1) / Rate_SS)

	SPreflexes()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("Reflexes", "REFLEXES", 8, Rate_Reflex, (600 - BonusSPS["REFLEXES"] - ReflexTrue) / Rate_Reflex)
*/

	SPdowntime()
		set hidden=1
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("Jutsu Downtime", "JDT", 6, Rate_JDT, (cooldownmultiplier - BonusSPS["JDT"] - 0.6) / Rate_JDT)
		//user.AskAndShowSPUseEffect("Jutsu Downtime", "JDT", 6, Rate_JDT, (cooldownmultiplier - BonusSPS["JDT"] - 0.6) / Rate_JDT)
		// if((cooldownmultiplier - b - Rate_JDT) < 0.6) {alert("That would take you beyond the maximum!"); return}
		// UpdateSPGrid("-[b*100]% Downtime","Downtime")


//---------------------------------------------
	SPMaxBugs()
		set hidden=1
		if(Clan!="Aburame") return
		var/PseudoKonchuuLimit=KonchuuLimit+BonusSPS["MAXBUGS"]
		var
			cost=2
			bonus=round(PseudoKonchuuLimit*0.1)
			b=BonusSPS["MAXBUGS"]
		if(bonus<3)bonus=5
		if(bonus>30)bonus=30
		if(NinjaRank=="Academy Student"||NinjaRank=="Genin") {alert("You must be Chuunin rank or higher to upgrade these stats."); return}
		if(cost>TheoreticalStatPoints) {alert("You don't have that many Stat Points."); return}
		b+=bonus; TheoreticalStatPoints-=cost
		BonusSPS["MAXBUGS"]=b
		src << output(TheoreticalStatPoints,"StatPoints.Remaining")
		UpdateSPGrid("+[b] Bugs","Bugs")

	SPSensatsu()
		set hidden=1
		if(Clan!="Yuki") return
		var
			cost=8
		if(NinjaRank=="Academy Student"||NinjaRank=="Genin") {alert("You must be Chuunin rank or higher to upgrade these stats."); return}
		if(cost>TheoreticalStatPoints) {alert("You don't have that many Stat Points."); return}
		if(SensatsuL2) {alert("You already have this attribute!"); return}
		if(BonusSPS["SENSATSU"] > 0) {alert("You only need to upgrade this once!"); return}
		BonusSPS["SENSATSU"]=1; TheoreticalStatPoints-=cost
		src << output(TheoreticalStatPoints,"StatPoints.Remaining")
		UpdateSPGrid("Lvl 2 Sensatsu","sens")

	SPIce()
		set hidden=1
		if(Clan!="Yuki") return
		var
			cost=1
			bonus=10
			b=BonusSPS["ICE"]
		if(NinjaRank=="Academy Student"||NinjaRank=="Genin") {alert("You must be Chuunin rank or higher to upgrade these stats."); return}
		if(cost>TheoreticalStatPoints) {alert("You don't have that many Stat Points."); return}
		b+=bonus; TheoreticalStatPoints-=cost
		BonusSPS["ICE"]=b
		src << output(TheoreticalStatPoints,"StatPoints.Remaining")
		UpdateSPGrid("+[b] Ice","Ice")

	SPSearch()
		set hidden=1
		if(Clan!="Hyuuga") return
		var
			cost=3; bonus=1; b=BonusSPS["SEARCH"]
		if(NinjaRank=="Academy Student"||NinjaRank=="Genin") {alert("You must be Chuunin rank or higher to upgrade these stats."); return}
		if(cost>TheoreticalStatPoints) {alert("You don't have that many Stat Points."); return}
		if(ByakuganRange+b+bonus>60) {alert("That would take you beyond the maximum!"); return}
		b+=bonus; TheoreticalStatPoints-=cost
		BonusSPS["SEARCH"]=b
		src << output(TheoreticalStatPoints,"StatPoints.Remaining")
		UpdateSPGrid("+[b] Range","SearchRange")

	SPUpgradeByakugan()
		set hidden=1
		if(Clan!="Hyuuga") return
		var
			cost=8
		if(ByakuganLevel==2) cost=17
		if(NinjaRank=="Academy Student"||NinjaRank=="Genin") {alert("You must be Chuunin rank or higher to upgrade these stats."); return}
		if(cost>TheoreticalStatPoints) {alert("You don't have that many Stat Points."); return}
		if(!ByakuganLevel) {alert("You don't even have Byakugan Level 1!"); return}

		if(ByakuganLevel==1&&CanLearnByakugan==2)
			if(BonusSPS["UPGRADE_BYAK"] == 2) {alert("You only need to upgrade this once!"); return}
			BonusSPS["UPGRADE_BYAK"]=2; TheoreticalStatPoints-=cost
			src << output(TheoreticalStatPoints,"StatPoints.Remaining")
			UpdateSPGrid("Lvl [BonusSPS["UPGRADE_BYAK"]] Byakugan","byak")
		else if(ByakuganLevel==1&&CanLearnByakugan!=2)
			alert("You are not ready to learn this yet."); return

		else if(ByakuganLevel==2&&CanLearnByakugan==3)
			if(BonusSPS["UPGRADE_BYAK"] == 3) {alert("You only need to upgrade this once!"); return}
			BonusSPS["UPGRADE_BYAK"]=3; TheoreticalStatPoints-=cost
			src << output(TheoreticalStatPoints,"StatPoints.Remaining")
			UpdateSPGrid("Lvl [BonusSPS["UPGRADE_BYAK"]] Byakugan","ByakLevel")
		else if(ByakuganLevel==2&&CanLearnByakugan!=3)
			alert("You are not ready to learn this yet."); return


	SPDogStam()
		set hidden=1
		if(Clan!="Inuzuka") return
		var/mob/F=Familiar
		if(!F) {alert("You do not seem to have a K-9 Partner"); return}
		var
			cost=1
			bonus=450
			b=BonusSPS["DOG_STAMINA"]
		if(NinjaRank=="Academy Student"||NinjaRank=="Genin") {alert("You must be Chuunin rank or higher to upgrade these stats."); return}
		if(cost>TheoreticalStatPoints) {alert("You don't have that many Stat Points."); return}
		b+=bonus; TheoreticalStatPoints-=cost
		BonusSPS["DOG_STAMINA"]=b
		src << output(TheoreticalStatPoints,"StatPoints.Remaining")
		UpdateSPGrid("+[b] Dog Stamina","dogstamina")

	SPDogTai()
		set hidden=1
		if(Clan!="Inuzuka") return
		var/mob/F=Familiar
		if(!F) {alert("You do not seem to have a K-9 Partner"); return}
		var
			cost=1
			bonus=90
			b=BonusSPS["DOG_TAI"]
		if(NinjaRank=="Academy Student"||NinjaRank=="Genin") {alert("You must be Chuunin rank or higher to upgrade these stats."); return}
		if(cost>TheoreticalStatPoints) {alert("You don't have that many Stat Points."); return}
		b+=bonus; TheoreticalStatPoints-=cost
		BonusSPS["DOG_TAI"]=b
		src << output(TheoreticalStatPoints,"StatPoints.Remaining")
		UpdateSPGrid("+[b] Dog Taijutsu","dogTaijutsu")

	SPKekkaiGenkaiChakra()
		set hidden=1
		if(Clan!="Kaguya") return
		var
			cost=5
			bonus=0.125
			b=BonusSPS["KG_CHAKRA"]
		if(cost>TheoreticalStatPoints) {alert("You don't have that many Stat Points."); return}
		if((KGCModifier - b - bonus) < 0.6) {alert("That would take you beyond the maximum!"); return}
		b+=bonus; TheoreticalStatPoints-=cost
		BonusSPS["KG_CHAKRA"]=b
		src << output(TheoreticalStatPoints,"StatPoints.Remaining")
		UpdateSPGrid("-[b*100]% Chakra Cost","ChakraCost")

	SPShadowRange()
		set hidden=1
		if(Clan!="Nara") return
		var
			cost=4
			bonus=1
			b=BonusSPS["SHADOWRANGE"]
		if(NinjaRank=="Academy Student"||NinjaRank=="Genin") {alert("You must be Chuunin rank or higher to upgrade these stats."); return}
		if(cost>TheoreticalStatPoints) {alert("You don't have that many Stat Points."); return}
		if((KagemaneRange + b + bonus) > 50) {alert("That would take you beyond the maximum!"); return}
		b+=bonus; TheoreticalStatPoints-=cost
		BonusSPS["SHADOWRANGE"]=b
		src << output(TheoreticalStatPoints,"StatPoints.Remaining")
		UpdateSPGrid("+[b] Shadow Range","ShadowRange")

	SPShadowMax()
		set hidden=1
		if(Clan!="Nara") return
		var
			cost=7
			bonus=1
			b=BonusSPS["MAXSHADOWS"]
		if(NinjaRank=="Academy Student"||NinjaRank=="Genin") {alert("You must be Chuunin rank or higher to upgrade these stats."); return}
		if(cost>TheoreticalStatPoints) {alert("You don't have that many Stat Points."); return}
		if((ShadowLimit + b + bonus) > 8) {alert("That would take you beyond the maximum!"); return}
		b+=bonus; TheoreticalStatPoints-=cost
		BonusSPS["MAXSHADOWS"]=b
		src << output(TheoreticalStatPoints,"StatPoints.Remaining")
		UpdateSPGrid("+[b] Shadow Limit","ShadowLimit")

	SPArashiUpgrade()
		set hidden=1
		if(Clan!="Nara") return
		var
			cost=35
			bonus=1
			b=BonusSPS["ARASHIUPGRADE"]
		if(NinjaRank=="Academy Student"||NinjaRank=="Genin") {alert("You must be Chuunin rank or higher to upgrade these stats."); return}
		if(cost>TheoreticalStatPoints) {alert("You don't have that many Stat Points."); return}
		if(ArashiRange + bonus + b > 3) {alert("That would take you beyond the maximum!"); return}
		b+=bonus; TheoreticalStatPoints-=cost
		BonusSPS["ARASHIUPGRADE"]=b
		src << output(TheoreticalStatPoints,"StatPoints.Remaining")
		UpdateSPGrid("+[b] Arashi Level","ArashiLevelt")

	SPUpgradeSharingan()
		set hidden=1
		if(Clan!="Uchiha") return
		if(!SharinganLevel) {alert("You don't even have Sharingan Level 1 yet!"); return}
		var
			cost=4; b=BonusSPS["UPGRADE_SHARINGAN"]
		if(NinjaRank=="Academy Student"||NinjaRank=="Genin") {alert("You must be Chuunin rank or higher to upgrade these stats."); return}
		if(SharinganLevel==2) cost=8
		if(SharinganLevel==3) cost=18
		if(cost>TheoreticalStatPoints) {alert("You don't have that many Stat Points."); return}
		if(SharinganLevel==1&&CanLearnSharingan==2)
			if(BonusSPS["UPGRADE_SHARINGAN"] == 2) {alert("You only need to upgrade this once!"); return}
			b=2; TheoreticalStatPoints-=cost
			src << output(TheoreticalStatPoints,"StatPoints.Remaining")
			UpdateSPGrid("Lvl [b] Sharingan","ShazLevel")
			BonusSPS["UPGRADE_SHARINGAN"]=b
		else if(SharinganLevel==1&&CanLearnSharingan!=2)
			alert("You are not ready to learn this yet.")
		else if(SharinganLevel==2&&CanLearnSharingan==3)
			if(BonusSPS["UPGRADE_SHARINGAN"] == 3) {alert("You only need to upgrade this once!"); return}
			b=3; TheoreticalStatPoints-=cost
			src << output(TheoreticalStatPoints,"StatPoints.Remaining")
			UpdateSPGrid("Lvl [b] Sharingan","ShazLevel")
			BonusSPS["UPGRADE_SHARINGAN"]=b
		else if(SharinganLevel==2&&CanLearnSharingan!=3)
			alert("You are not ready to learn this yet.")
		else if(CanLearnMangekyouSharingan == 1)
			if(BonusSPS["UPGRADE_SHARINGAN"] >= 4) {alert("You only need to upgrade this once!"); return}
			b=4; TheoreticalStatPoints-=cost
			src << output(TheoreticalStatPoints,"StatPoints.Remaining")
			UpdateSPGrid("Mangekyou Sharingan","ShazLevel")
			BonusSPS["UPGRADE_SHARINGAN"]=b
		else if(!CanLearnMangekyouSharingan&&SharinganLevel==3)
			alert("You are not ready to learn this yet.")

	SPSharinganReflexes()
		set hidden=1
		if(Clan!="Uchiha") return
		var
			cost=3
			bonus=1
			b=BonusSPS["SHARINGAN_REFLEXES"]
		if(NinjaRank=="Academy Student"||NinjaRank=="Genin") {alert("You must be Chuunin rank or higher to upgrade these stats."); return}
		if(cost>TheoreticalStatPoints) {alert("You don't have that many Stat Points."); return}
		if((SharinganReflexes + b + bonus) > 30) {alert("That would take you beyond the maximum!"); return}
		b+=bonus; TheoreticalStatPoints-=cost
		BonusSPS["SHARINGAN_REFLEXES"]=b
		src << output(TheoreticalStatPoints,"StatPoints.Remaining")
		UpdateSPGrid("+[b] Sharingan Reflexes","SharinganReflexes")

	SPSuperiorTai()
		set hidden=1
		if(Clan!="Taijutsu Specialist") return
		if(NinjaRank=="Academy Student"||NinjaRank=="Genin") {alert("You must be Chuunin rank or higher to upgrade these stats."); return}
		var/mob/player/user = usr
		user.AskAndShowSPUseEffect("Taijutsu", "LEE_TAI", 1, 70, TheoreticalStatPoints)
		/*var
			cost=1
			bonus=70
			b=BonusSPS["LEE_TAI"]
		if(cost>TheoreticalStatPoints) {alert("You don't have that many Stat Points."); return}
		b+=bonus; TheoreticalStatPoints-=cost
		BonusSPS["LEE_TAI"]=b
		src << output(TheoreticalStatPoints,"StatPoints.Remaining")
		UpdateSPGrid("+[b] Taijutsu","Supetai")*/

	SPAccept()
		set hidden=1
		if(SPchoosing) return
		SPchoosing=1
		switch(alert("Are you sure?","Accept","Yes","No"))
			if("Yes")
				winshow(src,"StatPoints",0)
				winset(src,"OutputChild","left='damagepane'")
				sleep(10)
				spawn(20)SPchoosing=0
				SPsUsed+=(StatPoints-TheoreticalStatPoints)
				StatPoints=TheoreticalStatPoints

				Stamina+=BonusSPS["STAMINA"]
				StaminaMax+=BonusSPS["STAMINA"]
				StaminaTrue+=BonusSPS["STAMINA"]
				BonusCap["Stamina"]+=BonusSPS["STAMINA"]
				StatPointsSpent["STAMINA"]+=(BonusSPS["STAMINA"]/Rate_Stamina)
				Cap_Stamina += BonusSPS["STAMINA"]

				Chakra+=BonusSPS["CHAKRA"]
				ChakraMax+=BonusSPS["CHAKRA"]
				ChakraTrue+=BonusSPS["CHAKRA"]
				BonusCap["Chakra"]+=BonusSPS["CHAKRA"]
				StatPointsSpent["CHAKRA"]+=(BonusSPS["CHAKRA"]/Rate_Chakra)
				Cap_Chakra += BonusSPS["CHAKRA"]

				Ninjutsu+=BonusSPS["NIN"]
				NinjutsuMax+=BonusSPS["NIN"]
				NinjutsuTrue+=BonusSPS["NIN"]
				BonusCap["Ninjutsu"]+=BonusSPS["NIN"]
				StatPointsSpent["NIN"]+=(BonusSPS["NIN"]/Rate_NGT)
				Cap_Ninjutsu += BonusSPS["NIN"]

				Genjutsu+=BonusSPS["GEN"]
				GenjutsuMax+=BonusSPS["GEN"]
				GenjutsuTrue+=BonusSPS["GEN"]
				BonusCap["Genjutsu"]+=BonusSPS["GEN"]
				StatPointsSpent["GEN"]+=(BonusSPS["GEN"]/Rate_NGT)
				Cap_Genjutsu += BonusSPS["GEN"]

				if(BonusSPS["JuEx"])
					StatPointsSpent["JuEx"]+=(BonusSPS["JuEx"]/Rate_JuEx)
					for(var/obj/SkillCards/SC in src)
						if(SC.CanLevel && SC.Level < SC.LevelMax)
							SC.EXP(BonusSPS["JuEx"])

				Taijutsu+=BonusSPS["TAI"]
				TaijutsuMax+=BonusSPS["TAI"]
				TaijutsuTrue+=BonusSPS["TAI"]
				BonusCap["Taijutsu"]+=BonusSPS["TAI"]
				StatPointsSpent["TAI"]+=(BonusSPS["TAI"]/Rate_NGT)
				Cap_Taijutsu += BonusSPS["TAI"]

				if(SPNewEle)
					var/list/EleList = list("Fire","Water","Lightning","Wind","Earth")
					for(var/A in EleList)
						if(src.vars["[A]Elemental"])
							EleList -=A
					if(!EleList.len)
						src << "there is an error here, please report this to a GM"
						return
					for(var/i=1 to SPNewEle)
						var/A = pick(EleList)
						EleList -= A
						src << "You have unlocked the ability to use the [A] Element"
						src.vars["[A]Elemental"] += 100

				switch(PE)
					if("Fire") FireElemental+=BonusSPS["PRIMARY"]
					if("Water") WaterElemental+=BonusSPS["PRIMARY"]
					if("Wind") WindElemental+=BonusSPS["PRIMARY"]
					if("Earth") EarthElemental+=BonusSPS["PRIMARY"]
					if("Lightning") LightningElemental+=BonusSPS["PRIMARY"]
				StatPointsSpent["PRIMARY"]+=(BonusSPS["PRIMARY"]/Rate_Elemental)

				switch(SE)
					if("Fire") FireElemental+=BonusSPS["SECONDARY"]
					if("Water") WaterElemental+=BonusSPS["SECONDARY"]
					if("Wind") WindElemental+=BonusSPS["SECONDARY"]
					if("Earth") EarthElemental+=BonusSPS["SECONDARY"]
					if("Lightning") LightningElemental+=BonusSPS["SECONDARY"]
				StatPointsSpent["SECONDARY"]+=(BonusSPS["SECONDARY"]/Rate_Elemental)

				Luck += BonusSPS["LUCK"]
				StatPointsSpent["Luck"]+=(BonusSPS["LUCK"]/Rate_Luck)

				StatPointsSpent["AXE"]+=(BonusSPS["AXE"]/Rate_Weapon)
				StatPointsSpent["FAN"]+=(BonusSPS["FAN"]/Rate_Weapon)
				StatPointsSpent["H2H"]+=(BonusSPS["H2H"]/Rate_Weapon)
				StatPointsSpent["KNIFE"]+=(BonusSPS["KNIFE"]/Rate_Weapon)
				StatPointsSpent["SCYTHE"]+=(BonusSPS["SCYTHE"]/Rate_Weapon)
				StatPointsSpent["STAFF"]+=(BonusSPS["STAFF"]/Rate_Weapon)
				StatPointsSpent["SWORD"]+=(BonusSPS["SWORD"]/Rate_Weapon)
				StatPointsSpent["THROWING"]+=(BonusSPS["THROWING"]/Rate_Weapon)
				StatPointsSpent["AllWeaps"]+=BonusSPS["AllWeaps"]

				BonusSPS["H2H"] += BonusSPS["AllWeaps"]
				BonusSPS["THROWING"] += BonusSPS["AllWeaps"]
				BonusSPS["KNIFE"] += BonusSPS["AllWeaps"]
				BonusSPS["FAN"] += BonusSPS["AllWeaps"]
				BonusSPS["SWORD"] += BonusSPS["AllWeaps"]
				BonusSPS["SCYTHE"] += BonusSPS["AllWeaps"]
				BonusSPS["AXE"] += BonusSPS["AllWeaps"]
				BonusSPS["STAFF"] += BonusSPS["AllWeaps"]

				FanSkill+=BonusSPS["FAN"]
				FanSkillTrue+=BonusSPS["FAN"]
				BonusCap["FanSkill"]+=BonusSPS["FAN"]

				ScytheSkill+=BonusSPS["SCYTHE"]
				ScytheSkillTrue+=BonusSPS["SCYTHE"]
				BonusCap["ScytheSkill"]+=BonusSPS["SCYTHE"]

				AxeSkill+=BonusSPS["AXE"]
				AxeSkillTrue+=BonusSPS["AXE"]
				BonusCap["AxeSkill"]+=BonusSPS["AXE"]

				StaffSkill+=BonusSPS["STAFF"]
				StaffSkillTrue+=BonusSPS["STAFF"]
				BonusCap["StaffSkill"]+=BonusSPS["STAFF"]

				H2HSkill+=BonusSPS["H2H"]
				H2HSkillTrue+=BonusSPS["H2H"]
				BonusCap["H2HSkill"]+=BonusSPS["H2H"]

				KnifeSkill+=BonusSPS["KNIFE"]
				KnifeSkillTrue+= BonusSPS["KNIFE"]
				BonusCap["KnifeSkill"]+=BonusSPS["KNIFE"]

				SwordSkill+=BonusSPS["SWORD"]
				SwordSkillTrue+=BonusSPS["SWORD"]
				BonusCap["SwordSkill"]+=BonusSPS["SWORD"]

				ThrowingSkill+=BonusSPS["THROWING"]
				ThrowingSkillTrue+=BonusSPS["THROWING"]
				BonusCap["Throwing"]+=BonusSPS["THROWING"]

				cooldownmultiplier-=BonusSPS["JDT"]
				StatPointsSpent["JDT"]+=(BonusSPS["JDT"]/Rate_JDT)

//--------------------------------------------------------
				CraftingSkill+=BonusSPS["CRAFTING"]
				StatPointsSpent["CRAFTING"]+=(BonusSPS["CRAFTING"]/Rate_Skill)
				CraftSkills()

				FishingSkill+=BonusSPS["FISHING"]
				FishingSkillTrue+=BonusSPS["FISHING"]
				StatPointsSpent["FISHING"]+=(BonusSPS["FISHING"]/Rate_Skill)

				FirstAidSkill+=BonusSPS["FIRSTAID"]
				FirstAidSkillTrue+=BonusSPS["FIRSTAID"]
				StatPointsSpent["FIRSTAID"]+=(BonusSPS["FIRSTAID"]/Rate_Skill)

				Reflex+=BonusSPS["REFLEXES"]
				ReflexTrue+=BonusSPS["REFLEXES"]
				StatPointsSpent["REFLEXES"]+=(BonusSPS["REFLEXES"]/Rate_Reflex)
//-------------------------------------------------------
				switch(Clan)
					if("Aburame")
						KonchuuLimit+=BonusSPS["MAXBUGS"]

					if("Yuki")
						if(BonusSPS["SENSATSU"]>0)
							SensatsuL2=BonusSPS["SENSATSU"]
						//WaterElemental+=BonusSPS["ICE"]
						//WindElemental+=BonusSPS["ICE"]
						IceElemental+=BonusSPS["ICE"]
						StatPointsSpent["ICE"]+=BonusSPS["ICE"]*0.1

					if("Hyuuga")
						ByakuganRange+=BonusSPS["SEARCH"]
						if(BonusSPS["UPGRADE_BYAK"]>0)ByakuganLevel=BonusSPS["UPGRADE_BYAK"]

					if("Inuzuka")
						var/mob/F=Familiar
						if(F)
							F.StaminaMax+=BonusSPS["DOG_STAMINA"]; F.StaminaTrue+=BonusSPS["DOG_STAMINA"]
							DogStaminaMax+=BonusSPS["DOG_STAMINA"]
							F.Taijutsu+=BonusSPS["DOG_TAI"]
							DogTaijutsu+=BonusSPS["DOG_TAI"]
						//add cap bonus stats e.g. ---  BonusCap["Taijutsu"]+=BonusSPS["TAI"]

					if("Kaguya")
						KGCModifier-=BonusSPS["KG_CHAKRA"]

					if("Nara")
						KagemaneRange+=BonusSPS["SHADOWRANGE"]
						ShadowLimit+=BonusSPS["MAXSHADOWS"]
						ArashiRange+=BonusSPS["ARASHIUPGRADE"]

					if("Uchiha")
						if(BonusSPS["UPGRADE_SHARINGAN"]>0)SharinganLevel=BonusSPS["UPGRADE_SHARINGAN"]
						if(BonusSPS["UPGRADE_SHARINGAN"]==4)
							var/obj/SkillCards/Clan/Uchiha/MangekyouSharingan/J=locate() in contents
							if(!J)
								new/obj/SkillCards/Clan/Uchiha/MangekyouSharingan(src)
								CanLearnMangekyouSharingan++
						SharinganReflexes+=BonusSPS["SHARINGAN_REFLEXES"]

					if("Taijutsu Specialist")
						Taijutsu+=BonusSPS["LEE_TAI"]
						TaijutsuMax+=BonusSPS["LEE_TAI"]
						TaijutsuTrue+=BonusSPS["LEE_TAI"]
						BonusCap["Taijutsu"]+=BonusSPS["LEE_TAI"]
						Cap_Taijutsu+=BonusSPS["LEE_TAI"]

				RefreshPlayerStats()
				usr.BonusSPS=new()
				if(usr.SS<1) usr.SS=1
//				if((StatPointsSpent["JDT"]*6)>300)
//					var/x=StatPointsSpent["JDT"]-300
//					StatPointsSpent["JDT"]=300; StatPoints+=(x*6)
				InSPS = 0
				CantWalk--
			else
				SPchoosing=0
/*				usr.BonusSPS=new()
				SPchoosing=0
				winshow(src,"StatPoints",0)
				winset(src,"OutputChild","left='damagepane'")
				InSPS = 0
				CantWalk--*/

	SPCancel()
		set hidden=1
		winshow(src,"StatPoints",0)
		//winset(src,"OutputChild","left='damagepane'")
		InSPS = 0
		SPNewEle = 0
		CantWalk--
		usr.RemoveSPVerbs()

mob/proc/RemoveSPVerbs()
	verbs += typesof(/mob/StatPointsVerbs/proc)

mob/proc/UpdateSPGrid(STAT,TYPE)
	if(!(StatList[TYPE])) StatList[TYPE]=++StatCount
	winset(src,null,"StatPoints.SPSGrid.current-cell=[StatList[TYPE]];StatPoints.SPSGrid.cells=[StatList.len]")
	src << output(STAT, "StatPoints.SPSGrid")

mob/proc/ClearSPGrid()
	StatList=new/list
	winset(src,null,"StatPoints.SPSGrid.current-cell=0;StatPoints.SPSGrid.cells=0")
mob/var/tmp
	StatList[0]

mob/verb/CheckSPS(mob/m in world)
	set hidden=1
	if(!usr.GM) return
	for(var/Z in m.StatPointsSpent)
		var/Y=m.StatPointsSpent[Z]
		usr<<"[Z]: [Y]"