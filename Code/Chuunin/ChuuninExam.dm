obj/ChuuninTest
	icon='TestPaper.dmi'
	name="Chuunin Test"
	notblowable=1
	Click()
		TakeExam()
	verb
		TakeExam()
			set name="Take exam"
			set src in oview(1)
			if(usr.NinjaRank!="Genin") {usr<<"You've already graduated from Genin rank"; return}
			if(usr.TakingChuuninExam) {usr<<"You've only just taken the exam. If you've failed, you cannot take it again until next exam."; return}
			if(get_dir(usr,src)!=2) {alert("You're not sitting directly behind it."); return}
			if(!ChuuninTime) {usr<<"The test hasn't started yet!"; return}
			usr<<browse(null,"window=info")
			usr.CantWalk++; usr.TakingChuuninExam=1; usr.ChuuninAttempts++; usr.InChuunin=1;
			winshow(usr,"ExamPaper",1)
			winset(usr,null,"ExamPaper.ExamChild.left='Chuunin_1';Chuunin_1.Student.text='[usr.name]';Chuunin_1.Village.text='[usr.Village]';Chuunin_2.Student.text='[usr.name]';Chuunin_2.Village.text='[usr.Village]'")

		SubmitExam()
			set src in oview(1)
			if(alert("Are you Sure?","Exam","Yes","No") == "Yes")
				winshow(usr,"ExamPaper",0)
				usr.TakingChuuninExam = 2
				usr << "Feel free to explore the room until your exam has been graded, but dont leave the room!"

//------------------------- [ Instant Start Exam Proc ] ---------------------------------------------------------------
proc/InstantChuuninAlert()
	ChuuninAccess=1; ChuuninCheck=1
	ChuuninExamTime=world.timeofday+6000
	for(var/mob/player/M in MasterPlayerList)
		if(M.NinjaRank=="Genin")
			M.TakingChuuninExam=0
			M.HasHeaven=0; M.HasEarth=0
			M.InTower=0; M.ChuuninBattle=0; M.eliminated=0

		ChuuninCheck=0; ChuuninAccess=0; ChuuninTime=1
		for(var/mob/player/G in MasterPlayerList)
			if(G.NinjaRank=="Genin")
				G<<output("<b>Chuunin exam has commenced!")
				spawn(1200)G<<"The Chuunin exam is over."
	spawn(1200)
		ChuuninTime=0; ChuuninCheck=1
		ChuuninVillage=pick("Leaf","Mist","Sand","Cloud","Rock","Sound","Waterfall","Grass","Rain")
		spawn(50)ChuuninExamCollection()
		for(var/mob/player/C in MasterPlayerList)
			if(C.NinjaRank=="Genin")
				if(C.TakingChuuninExam)
					C<<"The Chuunin exam is over; please wait while your papers are collected."
					winshow(C,"ExamPaper",0)
					if(C.client) winset(C,null,"mainwindow.Panel.left='statpane';mainwindow.Panel.right='InventoryPane'")
				else C<<output("The next Chuunin exam will be held in [ChuuninVillage] in two hours.","ann")


//------------------------- [ Exam Alert Proc ] ---------------------------------------------------------------
proc/ChuuninAlert()
	ChuuninAccess=1; ChuuninCheck=1
	ChuuninExamTime=world.timeofday+6000
	for(var/mob/player/M in MasterPlayerList)
		if(M.NinjaRank=="Genin")
			M.TakingChuuninExam=0
			M.HasHeaven=0; M.HasEarth=0
			M.InTower=0; M.ChuuninBattle=0; M.eliminated=0
	for(var/mob/player/G in MasterPlayerList)
		if(G.NinjaRank=="Genin")
			G<<output("<b>A Chuunin exam will be held in [ChuuninVillage] Village in 10 minutes.</b>","ann")
			G<<"Chuunin Exam applicants must have completed at least 8 missions and have their fighting styles add up to at least [3000*EXP_BASE]."
			G.Popup("chuunin",10)
	spawn(3000)
		for(var/mob/player/G in MasterPlayerList)
			if(G.NinjaRank=="Genin")
				G<<output("<b>A Chuunin exam will be held in [ChuuninVillage] Village in 5 minutes.</b></font>","ann")
				G.Popup("chuunin",5)
	spawn(3600)
		for(var/mob/player/G in MasterPlayerList)
			if(G.NinjaRank=="Genin")
				G<<output("<b>A Chuunin exam will be held in [ChuuninVillage] Village in 4 minutes.</b>","ann")

	spawn(4200)
		for(var/mob/player/G in MasterPlayerList)
			if(G.NinjaRank=="Genin")
				G<<output("<b>A Chuunin exam will be held in [ChuuninVillage] Village in 3 minutes.</b>","ann")
				G.Popup("chuunin",3)
	spawn(4800)
		for(var/mob/player/G in MasterPlayerList)
			if(G.NinjaRank=="Genin")
				G<<output("<b>A Chuunin exam will be held in [ChuuninVillage] Village in 2 minutes.</b>","ann")
	spawn(5400)
		for(var/mob/player/G in MasterPlayerList)
			if(G.NinjaRank=="Genin")
				G<<output("<b>A Chuunin exam will be held in [ChuuninVillage] Village in 1 minutes.</b>","ann")
				G.Popup("chuunin",1,,60)
	spawn(6000)

		ChuuninCheck=0; ChuuninAccess=0; ChuuninTime=1
		for(var/mob/player/G in MasterPlayerList)
			if(G.NinjaRank=="Genin")
				G<<output("<b>Chuunin exam has commenced!")
				spawn(1200)G<<"The Chuunin exam is over."
	spawn(7200)
		ChuuninTime=0; ChuuninCheck=1
		ChuuninVillage=pick("Leaf","Mist","Sand","Cloud","Rock","Sound","Waterfall","Grass","Rain")
		spawn(50)ChuuninExamCollection()
		for(var/mob/player/C in MasterPlayerList)
			if(C.NinjaRank=="Genin")
				if(C.TakingChuuninExam)
					C<<"The Chuunin exam is over; please wait while your papers are collected."
					winshow(C,"ExamPaper",0)
					if(C.client) winset(C,null,"mainwindow.Panel.left='statpane';mainwindow.Panel.right='InventoryPane'")
				else C<<output("The next Chuunin exam will be held in [ChuuninVillage] in two hours.","ann")

//------------------------- [ Exam Collection Proc ] ----------------------------------------------------------
proc/ChuuninExamCollection()
	var/p=0
	ForestList=list()
	for(var/mob/player/o in MasterPlayerList) if(o.NinjaRank=="Genin"&&o.TakingChuuninExam&&o.ChuuninScoreCheck()>=5) p++
	for(var/mob/player/C in MasterPlayerList)
		if(C.TakingChuuninExam)
			C.TakingChuuninExam=0; C.CantWalk = 0
			if(C.ChuuninScoreCheck()>=5)
				C<<"<i><b>You have passed the written part of the Chuunin exam!</i></b>"
				if(p>0) //Used to be 1, now it lets everyone into the next round.
					if(!(C in ForestList)) ForestList+=C
					C<<"<i>You must now compete in the Forest of Death. Each of you will be given either the Heaven OR Earth Scroll.  You must find the scroll that you do <b>not</b> have (as well as the one you do), and bring them to the tower in the centre of the forest. Do this by any means necessary.</i>"
				else if((C.NinjutsuTrue+C.TaijutsuTrue+C.GenjutsuTrue)>=10000&&C.ChuuninScoreCheck()==10)
					C.PassedChuunin()
					C.InChuunin=0;
				else
					C.InChuunin=0;
					C<<"<i>The instructors regretfully advise you that there were not enough participants and that this Chuunin Exam cannot continue.</i>"
					C<<"To complete the exam solo you need to have a perfect score on the exam and total combined stats of 10k"
			else {C.ChuuninExit(); C<<"<i><b>You have failed the written part of the Chuunin exam.</i></b>"}
	spawn(100)ForestSpawn()
	ChuuninExamTime=world.timeofday+(chuuninDelay + 6000) // Next chuunin
	spawn(chuuninDelay)ChuuninAlert()
	ChuuninTime=null

mob/proc/ChuuninScoreCheck()
	var/R = winget(src, "Chuunin_1.Q1d;Chuunin_1.Q2c;Chuunin_1.Q3c;Chuunin_1.Q5a;Chuunin_1.Q5b;Chuunin_1.Q5c;Chuunin_1.Q5d;\
	Chuunin_2.Q6c;Chuunin_2.Q8a;Chuunin_2.Q8b;Chuunin_2.Q8c;Chuunin_2.Q8d;Chuunin_2.Q9a;Chuunin_2.Q9b;Chuunin_2.Q9c;Chuunin_2.Q9d;Chuunin_2.Q10a","is-checked")
	var/RI= winget(src, "Chuunin_1.PythagorasQuestion;Chuunin_2.ShurikenQuestion","text")

	var/Result=params2list(R)
	var/Result2=params2list(RI)
	var/pq=Result2["Chuunin_1.PythagorasQuestion.text"]
	var/sq=Result2["Chuunin_2.ShurikenQuestion.text"]
	var/C=0
	if(Result["Chuunin_1.Q1d.is-checked"]== "true") C++
	if(Result["Chuunin_1.Q2c.is-checked"]== "true") C++
	if(Result["Chuunin_1.Q3c.is-checked"]== "true") C++
	if(pq=="5"||pq=="5m"||pq=="5 metres"||pq=="five"||pq=="five metres"||pq=="5 meters"||pq=="five meters") C++
	if(Result["Chuunin_1.Q5a.is-checked"]== "true") C+=0.5
	if(Result["Chuunin_1.Q5b.is-checked"]== "true") C+=0.5
	if(Result["Chuunin_1.Q5c.is-checked"]== "true") C-=0.5
	if(Result["Chuunin_1.Q5d.is-checked"]== "true") C-=0.5

	if(Result["Chuunin_2.Q6c.is-checked"]== "true") C++
	if(sq=="3"||sq=="3s"||sq=="3 seconds"||sq=="three"||sq=="three seconds") C++
	if(Result["Chuunin_2.Q8a.is-checked"]== "true") C-=0.5
	if(Result["Chuunin_2.Q8b.is-checked"]== "true") C+=0.5
	if(Result["Chuunin_2.Q8c.is-checked"]== "true") C+=0.5
	if(Result["Chuunin_2.Q8d.is-checked"]== "true") C-=0.5

	if(Result["Chuunin_2.Q9a.is-checked"]== "true") C+=0.5
	if(Result["Chuunin_2.Q9b.is-checked"]== "true") C+=0.5
	if(Result["Chuunin_2.Q9c.is-checked"]== "true") C-=0.5
	if(Result["Chuunin_2.Q9d.is-checked"]== "true") C-=0.5

	if(Result["Chuunin_2.Q10a.is-checked"]== "false") C=0
	if(C<=0 && Result["Chuunin_2.Q10a.is-checked"]== "true"){ C=9; src<<"<i>Did you just pass as a candidate who didn't answer a single question?</i>"}
	else if(Result["Chuunin_2.Q10a.is-checked"]== "true") C++

	if(C<0) C=0
	Medal_BrainBox(C)
	return C
