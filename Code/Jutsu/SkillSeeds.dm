var/RandomReqs = 1
var/SkillResetTime = 1800
var
	list
		ReadySkills = list()
		GlobalSkills = list()

proc

	SaveSkills()
		if(TotalSavePrevention) return
		var/savefile/F = new("Data/Wipe/Skills.sav")
		F["ReadySkills"] << ReadySkills
		F["GlobalSkills"] << GlobalSkills

mob/var/SkillSeeds = list()

mob/verb/CheckSkillSeeds()
	var/T={"<tr><th>Skill Seed<th><th>Ninjutsu</th><th>Taijutsu</th><th>Genjutsu</th>"}
	var/T2=""
	var/B=0
	for(var/X in SkillSeeds)
		if(B==0)
			B=1
		else
			B=0
		//if(istype(x.vars[X]))
		/*if(0)
		//Stats(Name,Current,Max,True,CEXP,MEXP,Multi,Cap)
			//var/Z=x.vars[X]
			//T+={"<div class="Var[B]" id="Var"><span class="varname">[Z]</span> = (

			//)</div>"}
			var/hi=1;*/
		var/SkillSeed/SS = SkillSeeds[X]
		if(SS)
			var/list/SR = SS.Stat_Req
			T+={"<tr><th>[X]<th><th>[SR["Ninjutus"]]</th><th>[SR["Taijutsu"]]</th><th>[SR["Genjutsu"]]</th>"}
			T2+={"<div class="Var[B]" id="Var"><span class="varname">[X]</span>&nbsp;=&nbsp;<span>Ninjutsu:[SR["Ninjutsu"]], Taijutsu: [SR["Taijutsu"]], Genjutsu: [SR["Genjutsu"]]</span></div>"}
	//var/i="\[i]"
	var/HTML={"<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><title>[trueName]'s Skill Seeds</title></head>
				<style type="text/css">
					html		{overflow-x:hidden;}
					body		{background:#151515;font-family:Arial;color:#BBB;font-size:12pt;scrollbar-base-color:#333;scrollbar-highlight-color:#151515;scrollbar-arrow-color:#333;scrollbar-face-color:#333;scrollbar-shadow-color:#151515;width:100%;margin:0px;}}
					h1			{position:relative;left:35px;padding:0px;}
					#Var		{position:relative;height:32;padding:2px;}
					#Var div	{position:relative;display:inline-block;*display:inline;zoom:1;margin:0px;padding:8px 0px;}
					.Var0		{background:#151515}
					.Var1		{background:#202020}
					.desc		{position:absolute;top:-21px;left:-10px;color:#F00;padding:0px;}
					.Var0 .desc	{background:#202020;}
					.Var1 .desc	{background:#151515;}
					.varname	{color:#FF0000;position:relative;font-weight:bold;}
					#RedLine	{position:absolute;left:20px;Top:0px;background:#FF0000;height:30px;width:10px;}
					.InnerList	{position:relative;display:inline-block;*display:inline;zoom:1;}
					.InnerList div{position:relative;display:inline-block;*display:inline;zoom:1;}
					.ListItem	{position:relative;display:inline-block;*display:inline;zoom:1;}
					table, th, td {
						border:1px solid #FFFFFF;
					}
					table{
						width:100%;
					}
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
					<h1>[trueName]'s Skill Seeds</h1><h3>If you obtain the following Stat levels you will unlock the Skill</h3>"
					<table>
						[T]
					</table>
					<div id="ContA">
						[T2]
					</div>
					<div id="RedLine"></div>
				</body>
				</html>"}
	src<<browse(HTML,"window=Browser[trueName]SS;size=600x400")
SkillSeed
	var
		name
		Stat_Req
		Uses_Req
		Mast_Req
		Irregular = 0
		CLVL = 1
		Checked = 0
		Clan

	New(ST,SR,UR,MR,LVL,mob/M)
		if(ST)
			name = ST
		if(SR)
			Stat_Req = SR
		if(UR)
			Uses_Req = UR
		if(MR)
			Mast_Req = MR
		if(M && M.RebirthData)
			M.RebirthData.JL[name] = src

	proc
		Setup(mob/M)
			/*var/JL = M.RebirthData.JL
			if(JL[name])
				var/list/OS = JL[name]
				Stat_Req =  OS["Stat_Req"]
				Uses_Req =  OS["Uses_Req"]
				Mast_Req =  OS["Mast_Req"]*/

			if(RandomReqs)
				if(Stat_Req)
					for(var/A in Stat_Req)
						Stat_Req[A] = round(Stat_Req[A]*pick(0.7,0.6,0.5))

				if(Mast_Req || Uses_Req)
					if(Uses_Req)
						for(var/A in Uses_Req)
							A = round(A*pick(0.7,0.6,0.5))
					if(Mast_Req)
						for(var/A in Mast_Req)
							A = round(A*pick(0.9,0.8,0.7))
			else
				if(Stat_Req)
					for(var/A in Stat_Req)
						Stat_Req[A] = round(Stat_Req[A]*0.6)

				if(Mast_Req || Uses_Req)
					if(Uses_Req)
						for(var/A in Uses_Req)
							A = round(A*0.6)
					if(Mast_Req)
						for(var/A in Mast_Req)
							A = round(A*0.8)
			if(M.RebirthData)
				M.RebirthData.JL[name] = src

			//M << "You feel inspired to learn a new Technique"

		Check(mob/M)
			set waitfor = 0
			//if(M.JutsuList[name])
			//	del src
			//	return
			Checked = 1
			spawn(SkillResetTime)//wait 15 minutes to check this skill again
				Checked = 0

			if(M.JutsuList[name]||!ReadySkills[name])
				M << "Your Skill Seed for [name] has rotted"
				M.SkillSeeds -= name
				return

			if(Stat_Req)
				for(var/A in Stat_Req)
					if(M.vars[A] < Stat_Req[A])
						return

			/*if(Mast_Req || Uses_Req)
				var/list/SL = list()
				for(var/obj/SkillCards/SC in M)
					SL[SC.name] = list(SC.Uses,SC.Level)
				if(Uses_Req)
					for(var/A in Uses_Req)
						if(SL[A])
							if(SL[A][0] < Uses_Req[A])
								return
						else
							return
				if(Mast_Req)
					for(var/A in Mast_Req)
						if(SL[A])
							if(SL[A][1] < Mast_Req[A])
								return
						else
							return*/

			var/TP = ReadySkills[name]
			M << "You have unlocked [name] using your skill seed"
			var/obj/SkillCards/NS = new TP(M)

/*			if(Irregular)
				M.RebirthData.SecretList += name*/

			NS.AcquiredReal = world.realtime
			NS.Level = round(CLVL*0.3)
			if(NS.Level < 1)
				NS.Level = 1
			NS.Control = NS.Level * 3
			if(NS.Control>100)
				NS.Control = 100
			//M.JutsuList[name] = 1
			//M.SkillSeeds -= name
			//del src