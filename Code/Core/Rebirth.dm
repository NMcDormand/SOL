mob
	var
		Rebirth/RebirthData = null

Rebirth
	var
		Total = 0
		list
			StatsTotal = list("Stamina" = 0,"Chakra"=0,"Taijutsu"=0,"Ninjutsu"=0,"Genjutsu"=0)
			StatsBar = list("Stamina" = 0,"Chakra"=0,"Taijutsu"=0,"Ninjutsu"=0,"Genjutsu"=0)

			SkillTotal = list("ScytheSkill" = 0,"AxeSkill" = 0,"FanSkill" = 0,"StaffSkill" = 0,"SwordSkill" = 0,"KnifeSkill" = 0,
							"ThrowingSkill" = 0,"H2HSkill" = 0,
							"FishingSkill" = 0,"FirstAidSkill" = 0,"MiningSkill" = 0,"CraftingSkill" = 0,
							"SS" = 0,"ChakraControl" = 0)

			SkillBar = list("ScytheSkill" = 0,"AxeSkill" = 0,"FanSkill" = 0,"StaffSkill" = 0,"SwordSkill" = 0,"KnifeSkill" = 0,
							"ThrowingSkill" = 0,"H2HSkill" = 0,
							"FishingSkill" = 0,"FirstAidSkill" = 0,"MiningSkill" = 0,"CraftingSkill" = 0,
							"SS" = 0,"ChakraControl" = 0)

			Multis = list("Stamina" = 0,"Chakra"=0,"Taijutsu"=0,"Ninjutsu"=0,"Genjutsu"=0)
			JL = list()
			SeedList = list()
			SecretList = list()

		RebirthVersion = 1
		RinneRebirth = 0

		//list/Chances = list()
		//PreviousElement = list()
		//list/SkillList = list()

	New(mob/M)
		..()
		if(M)
			/*if(GlobalRebirthTotal)
				for(var/A in StatsBar)
					StatsTotal[A] = GlobalRebirthTotal[A]*/
			RebirthVersion = CurrentRebirthVersion
			var/savefile/RB=new("Saves/[copytext(M.ckey, 1, 2)]/[M.ckey]/[M.Slot]/Rebirth.sav")
			RB["REData"] << src
	proc
		Birthed(mob/M)
			for(var/ST in Multis)
				M.Multipliers[ST] += Multis[ST]
			for(var/ST in SkillTotal)
				if(Total)
					M.vars[ST] += SkillTotal[ST]
					M.vars["[ST]True"] += SkillTotal[ST]
				else
					if(GlobalRebirthTotal)
						M.vars[ST] += GlobalRebirthTotal[ST]
						M.vars["[ST]True"] += GlobalRebirthTotal[ST]
				SkillBar[ST] = M.vars["[ST]True"]
			if(M.ChakraControlTrue >100)
				M.ChakraControlTrue = 99
			for(var/A in JL)
				if(JL[A])
					M.SkillSeeds[A] = JL[A]
					JL -= A

			var/savefile/RB=new("Saves/[copytext(M.ckey, 1, 2)]/[M.ckey]/[M.Slot]/Rebirth.sav")
			RB["REData"] << src

		Initialize(mob/M)
			for(var/ST in StatsBar)
				if(Total)
					M.vars["Cap_[ST]"] += StatsTotal[ST]
				else
					if(GlobalRebirthTotal)
						M.vars["Cap_[ST]"] += GlobalRebirthTotal[ST]
				StatsBar[ST] = M.vars["Cap_[ST]"]

		Commence(PLAYER(M))
		#if DEBUGGING
			if(M.NinjaRank == "Academy Student")
				M << "Ranking you to Genin and then Chuunin"
				M.RankGenin()
				M.RankChuunin()
			else if(M.NinjaRank == "Genin")
				M << "Ranking you to Chuunin"
				M.RankChuunin()
			if(alert("Use the preset?(100k over caps)","Preset?","Yes","No") == "Yes")
				M.StaminaTrue = M.Cap_Stamina + 100000
				M.ChakraTrue = M.Cap_Chakra + 100000
				M.TaijutsuTrue = M.Cap_Taijutsu + 100000
				M.NinjutsuTrue = M.Cap_Ninjutsu + 100000
				M.GenjutsuTrue = M.Cap_Genjutsu + 100000
		#endif
			var/RP = RebirthPercentage
			var/SRP = RP * 0.5
			for(var/ST in Multis)
				Multis[ST] += M.Multipliers[ST]*(RP*0.1)

			if(!CatchUP)
				var/list/BC = M.BonusCap
				for(var/ST in StatsBar)
					var/CurrentStat = M.vars["[ST]True"]
					var/B = round((CurrentStat - StatsBar[ST] - BC[ST]) * RP)
					if(B>0)
						StatsTotal[ST] += B
				for(var/ST in SkillBar)
					var/CurrentStat = M.vars[ST]
					var/B = round((CurrentStat - SkillBar[ST]) * SRP)
					if(B>0)
						SkillTotal[ST] += B
			else
				var/CU = CatchUP
				var/SCU = CU * 0.5
				if(!GlobalRebirthTotal)
					GlobalRebirthTotal = list()
					var/list/BC = M.BonusCap
					for(var/ST in StatsBar)
						var/CurrentStat = M.vars["[ST]True"]
						var/Addition = round((CurrentStat - StatsBar[ST] - BC[ST]) * RP, 1)//Rebirth Total
						if(Addition>0)
							var/CUP = Addition * CU //Catch Up Addition

							GlobalRebirthTotal[ST] = CUP
							StatsTotal[ST] += Addition

					for(var/ST in SkillBar)
						var/CurrentStat = M.vars[ST]
						var/B = round((CurrentStat - SkillBar[ST]) * SRP,1)
						if(B>0)
							var/CUP = B * SCU //Catch Up Addition
							GlobalRebirthTotal[ST] = CUP
							SkillTotal[ST] += B
				else
					var/list/BC = M.BonusCap
					for(var/ST in StatsBar)
						if(!Total)
							StatsTotal[ST] += GlobalRebirthTotal[ST]
						var/CurrentStat = M.vars["[ST]True"]
						var/Addition = round((CurrentStat - StatsBar[ST] - BC[ST]) * RP, 1)
						if(Addition>0)
							GlobalRebirthTotal[ST] += (Addition * CU)

							StatsTotal[ST] += Addition

					for(var/ST in SkillBar)
						if(!Total)
							SkillTotal[ST] += GlobalRebirthTotal[ST]
						var/CurrentStat = M.vars[ST]
						var/B = round((CurrentStat - SkillBar[ST]) * SRP,1)
						if(B>0)
							GlobalRebirthTotal[ST] += B * (SCU)
							SkillTotal[ST] += B

			Total++
			for(var/A in M.SkillSeeds)
				//M << "[A] = [M.SkillSeeds[A]]"
				if(M.SkillSeeds[A])
					JL[A] = M.SkillSeeds[A]
					M.SkillSeeds -= A
			M.SkillSeeds = list()
			var/THISPATH = "Saves/[copytext(M.ckey, 1, 2)]/[M.ckey]/[M.Slot]"
			var/savefile/RB=new("[THISPATH]/Rebirth.sav")
			RB["CSBites"] << M.OroBittenTimes
			RB["PlayerKills"] << M.PlayerKills
			RB["VillageKills"] << M.VillageKills
			RB["CriminalKills"] << M.CriminalKills
			RB["AnimalKills"] << M.AnimalKills
			RB["LargeAnimalKills"] << M.LargeAnimalKills
			RB["TotalKills"] << M.TotalKills
			RB["BossKills"] << M.BossKills
			//RB["Missions"] << M.Missions
			RB["MissionPoints"] << round(M.MissionPoints * RP)
			RB["REData"] << src
		#if DEBUGGING
			if(alert("Would you like to restart?","Delete","Yes","No")=="Yes")
				RemoveName(M.trueName)
				M.EjectKage("Passed On")
				fdel("[THISPATH]/save.sav")
				CheckForKages()
				for(var/obj/O in M)
					O.OnSpeedRail = 0
					O.loc = null
				del M
			else
				clan_Start(M.Clan,M)
				M.NinjaRank = "Academy Student"
				Birthed(M)
				M.ShowRebirthProfile(M)
				world<<"<font color=green><b>[M]</b> is restarting in [M.Village]. Amount restarted: [M.RebirthData.Total]"

		#else
			RemoveName(M.trueName)
			M.EjectKage("Passed On")
			fdel("[THISPATH]/save.sav")
			CheckForKages()
			for(var/obj/O in M)
				O.OnSpeedRail = 0
				O.loc = null
			del M
		#endif

mob
	verb
		Check_SPS_Usage()
			if(StatPointsSpent)
				var/msg="<b>Stat Points</b>"
				var/T = 0
				for(var/A in StatPointsSpent)
					T+=StatPointsSpent[A]
					msg+="<br/><b>[A]</b>: [StatPointsSpent[A]]"
				msg += "<br/><br/><b>Total</b>: [T]"
				usr << msg
	#if DEBUGGING
		RebirthDelete()
			if(alert("Are you sure you would like to clear your rebirth profile?","Clear?","Yes","No") == "Yes")
				RebirthData = null
				RebirthData = new()
				var/THISPATH = "Saves/[copytext(ckey, 1, 2)]/[ckey]/[Slot]"
				fdel("[THISPATH]/Rebirth.sav")
				var/savefile/RB=new("[THISPATH]/Rebirth.sav")
				RB["REData"] << RebirthData
	#endif
		Rebirth()
			if(Brand||jailed)
				return
			switch(alert(src,"What would you like to do?","Rebirth","Investigate","Rebirth","Cancel"))
				if("Rebirth")
					#if DEBUGGING
					if(alert(src,"Are you Sure?","Rebirth","Yes","No") == "Yes")
						//if(AdminLevel > 5)
						//	if(alert("Would you like to clear the Global Total?","Clear?","Yes","No") == "Yes")
						//		GlobalRebirthTotal = list()
						//		CurrentRebirthVersion = 1
						RebirthData.Commence(src)
					#else
					if(NinjaRank == "Academy Student"||NinjaRank == "Genin")
						usr << "You can only rebirth if you are chuunin or higher"
						return
					if(RebirthCap)
						if(RebirthData.Total >= (RebirthCap+1))
							usr << "You have reached your limit for Rebirths"
							return
						var/RT = (RebirthCap - RebirthData.Total)
						alert(src,"Reminder you only have [RT] Rebirth/s left, this will leave you with [RT - 1] if completed")
					if(alert(src,"Are you Sure? (Reminder, the higher your stats the better your gains from a rebirth)","Rebirth","Yes","No") == "Yes")
						RebirthData.Commence(src)
					#endif
				if("Investigate")
					if(alert(src,"What would you like to see?","Rebirth","Profile","Help") == "Help")
						src << "When you rebirth your character it will delete your character but transfer a percentage of all your stats to the next created on the same slot. This does include your gained experience which will then allow for faster training on your new save."
					else
						ShowRebirthProfile()
				else
					return
	proc
		ShowRebirthProfile(var/mob/M = src)
			set category="Z"
			var
				NextLife = {""}
				ReTotal = {""}
				ReBar = {""}
				ReCaps = {""}
				B = 0
				RP = RebirthPercentage
			var/Rebirth/THISGUY = RebirthData
			for(var/A in THISGUY.StatsBar)
				if(B==0)
					B=1
				else
					B=0
				var/CC = vars["Cap_[A]"]
				var/TT = THISGUY.StatsTotal[A]

				ReCaps+={"<div class="Var[B]" id="Var"><span class="varname">[A]</span> = (
				<div onmouseover="DispDesc(this)" onmouseout="DispDesc(this)">[CC]&nbsp;<span class="desc" style="display: none;">Current Cap</span></div>
				)</div>"}

				ReBar+={"<div class="Var[B]" id="Var"><span class="varname">[A]</span> = (
				<div onmouseover="DispDesc(this)" onmouseout="DispDesc(this)">[THISGUY.StatsBar[A]]&nbsp;<span class="desc" style="display: none;">Current Bar</span></div>
				)</div>"}

				ReTotal+={"<div class="Var[B]" id="Var"><span class="varname">[A]</span> = (
				<div onmouseover="DispDesc(this)" onmouseout="DispDesc(this)">[TT]&nbsp;<span class="desc" style="display: none;">Accumulated Total</span></div>
				)</div>"}

				var/NL = (vars["[A]True"] - (THISGUY.StatsBar[A] + BonusCap[A]))*RP
				if(NL<0)
					NL = 0
				if(!THISGUY.Total && GlobalRebirthTotal)
					var/CU = GlobalRebirthTotal[A] + (NL * CatchUP)

					NextLife+={"<div class="Var[B]" id="Var"><span class="varname">[A]</span> = (
					<div onmouseover="DispDesc(this)" onmouseout="DispDesc(this)">[TT + NL + CU] (+[TT] Previous, +[NL] Current, +[CU] Catch Up)&nbsp;<span class="desc" style="display: none;">Cap Aaddition</span></div>
					)</div>"}

				else
					NextLife+={"<div class="Var[B]" id="Var"><span class="varname">[A]</span> = (
					<div onmouseover="DispDesc(this)" onmouseout="DispDesc(this)">[TT + NL] (+[TT] Previous, +[NL] Current)&nbsp;<span class="desc" style="display: none;">Cap Aaddition</span></div>
					)</div>"}

			var/HTML={"<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><title>[trueName]'s Rebirth Profile</title></head>
						<style type="text/css">
							html		{overflow-x:hidden;}
							body		{background:#151515;font-family:Arial;color:#BBB;font-size:10pt;scrollbar-base-color:#333;scrollbar-highlight-color:#151515;scrollbar-arrow-color:#333;scrollbar-face-color:#333;scrollbar-shadow-color:#151515;width:100%;margin:0px;}}
							h1			{position:relative;left:35px;padding:0px;}
							h3			{position:relative;left:35px;padding:0px;}
							#Var		{position:relative;height:24px;padding:2px;}
							#Var div	{position:relative;display:inline-block;*display:inline;zoom:1;margin:0px;padding:0px;}
							.Var0		{background:#151515}
							.Var1		{background:#202020}
							.desc		{position:absolute;top:-21px;left:-10px;color:#F00;padding:0px;}
							.Var0 .desc	{background:#202020;}
							.Var1 .desc	{background:#151515;}
							.varname	{position:relative;font-weight:bold;}
							#RedLine	{position:absolute;left:20px;Top:0px;background:#FF0000;height:30px;width:10px;}
							.InnerList	{position:relative;display:inline-block;*display:inline;zoom:1;}
							.InnerList div{position:relative;display:inline-block;*display:inline;zoom:1;}
							.ListItem	{position:relative;display:inline-block;*display:inline;zoom:1;}
						</style>
						<script type="text/javascript">
							function DispDesc(el){
								var inner = el.lastChild;
								if (inner.style.display == "none"){inner.style.display = "";}
								else{inner.style.display = "none";}
							}
							function ReFocus(el){window.focus();window.location='byond://?src=\ref[src]&action=ReFocus';}
						</script>
						<body>
							<h1>[trueName] Rebirth Profile</h1>
							<h3>Total Rebirths: [THISGUY.Total]</h3>
							<h3>Transfer Percentage: [RP*100]%</h3>
							<h3>Catch-Up Rate: [CatchUP*100]%</h3>
							<h2>Current Limits</h2>
							<div id="ContB">
								[ReCaps]
							</div>
							<h2>Rebirth Addition Total:</h2>
							<div id="ContB">
								[ReTotal]
								<span>This is the total of each skill you have accumulated from every rebirth thus far</span>
							</div>
							<h2>Estimated Addition:</h3>
							<div id="ContB">
								[NextLife]
								<span>This is an estimate of how your limits will be increased for the next life after you reach Chuunin rank</span>
							</div>
							<h2>Minimum Stat for Increase:</h3>
							<div id="ContA">
								[ReBar]
								<span>You must have a higher skill level than this to begin increasing your limits on the reincarnated character</span>
							</div>
							<div id="RedLine"></div>
						</body>
						</html>"}
			M<<browse(HTML,"window=Browser[trueName];size=600x400")
