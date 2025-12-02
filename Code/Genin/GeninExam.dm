
obj/GeninTest
	icon='TestPaper.dmi'
	name="Genin Test"
	notblowable=1
	verb
		TakeExam()
			set name="Take exam"
			set src in oview(1)
			if(usr.NinjaRank!="Academy Student") {usr<<"You've already graduated from the Ninja Academy"; return}
			else if(usr.GeninTimer) {usr<<"Please wait [usr.GeninTimer] minutes before attempting the exam!"; return}
			else if(usr.TakingExam==1) {usr<<"You are already taking the exam! You should pay attention..."; return}
			else if(usr.dir != SOUTH || usr.x != x)
				usr<<"Please take your correct seat behind the exam."
				return
			else if(!GeninTime) {usr<<"The test hasn't started yet!"; return 1}
			winshow(usr,"ExamPaper",1)
			winset(usr,null,"ExamPaper.ExamChild.left='Genin_1';Genin_1.Student.text='[usr.name]';Genin_1.Village.text='[usr.Village]';Genin_2.Student.text='[usr.name]';Genin_2.Village.text='[usr.Village]';Genin_3.Student.text='[usr.name]';Genin_3.Village.text='[usr.Village]'"); usr<<browse(null,"window=info")
			usr.GeninScore=0; usr.TakingExam=1; usr.GeninAttempts++; usr.GeninTimer=10;
			usr<<"You have 3 minutes to complete the exam. If you finish early, please wait until your paper is collected!"
			spawn(1800)
				if(usr && usr.TakingExam)
					GeninExamCollectionNew(usr);
		SubmitExam()
			set src in oview(1)
			set hidden = 1
			if(alert("Are you Sure?","Exam","Yes","No") == "Yes")
				usr << "Feel free to explore the room until your exam has been graded, but dont leave the room!"
				GeninExamCollectionNew(usr);

mob/proc/speakcheck()
	if(GeninTime&&InGeninRoom)
		TakingExam=null; InGeninRoom=null; loc=locate(33,37,2); GeninScore=null
		src<<"<font color=red><b>You have been removed from the exam for making a disturbance!</font></b>"
		src<<"<i>0/14. <b>You have failed the Genin exam.</i></b>"
		winshow(src,"ExamPaper",0)

//------------------------------------------------------------------------------------------------------------|
//---------------- [ The proc that collects students' papers ] -----------------------------------------------|
//------------------------------------------------------------------------------------------------------------|
proc/GeninExamCollectionNew(mob/player/G)
	//world << "<font size=2 color=silver><b>The followling players are now Genin:</font></b>"
	winshow(G,"ExamPaper",0)
	G.TakingExam=0; G.GeninScore=0
	G.GeninScoreCheck()
	if(G.GeninScore>=12)
	//world << "<font size=2 color=silver><b>[G] is now a Genin! followling players are now Genin:</font></b>"
	//world << "<font size=2><b>[G]</b></font>"
		if(G.GeninScore > 14)
			G.GeninScore = 14
		G<< "<i>[G.GeninScore]/14. <b>Congratulations!</i></b>"
		G<< "<i><b>You have passed the Genin exam and are now a Genin!</i></b>"
		//G.LevelUp_notification("genin",client)
		G.GeninResults=G.GeninScore
		spawn(20)
			G.RankGenin()
			sleep(20)
			G.ExitAcademy(); G.frozen=null; G.InGeninRoom=0; G.protect=0
			usr.ZCoord="[usr.Village] Village"
	else
		//G.loc=locate(33,37,2)
		G<< "<i>[G.GeninScore]/14. <b>Unfortunately you have failed the exam. Study hard and attempt it again soon!</i></b>"
		G.GeninTimer=30;
		G.frozen=null; G.GeninScore=0; G.protect=null
	G.Save()

mob/proc/GeninScoreCheck()
	var/R = winget(src, "Genin_1.Q1b;Genin_1.Q2a;Genin_1.Q3d;Genin_1.Q4a;Genin_1.Q4b;Genin_1.Q4c;Genin_1.Q4d;Genin_1.Q5b;\
	Genin_2.Q6c;Genin_2.Q7a;Genin_2.Q7b;Genin_2.Q7c;Genin_2.Q7d;Genin_2.Q8b;Genin_2.Q9d;Genin_2.Q10b;\
	Genin_3.Q11a;Genin_3.Q11b;Genin_3.Q11c;Genin_3.Q11d;Genin_3.Q12a;Genin_3.Q13a;Genin_3.Q13b;Genin_3.Q13c;Genin_3.Q13d;\
	Genin_3.Q14a;Genin_3.Q14b;Genin_3.Q14c;Genin_3.Q14d;Genin_3.Q14e;Genin_3.Q14f;Genin_3.Q14g;Genin_3.Q14h","is-checked")

	var/Result=params2list(R)
	var/c=0
	var/C=0
	if(Result["Genin_1.Q1b.is-checked"]== "true") C++
	if(Result["Genin_1.Q2a.is-checked"]== "true") C++
	if(Result["Genin_1.Q3d.is-checked"]== "true") C++

	if(Result["Genin_1.Q4a.is-checked"]== "true") C-=0.5
	if(Result["Genin_1.Q4b.is-checked"]== "true") C+=0.5
	if(Result["Genin_1.Q4c.is-checked"]== "true") C+=0.5
	if(Result["Genin_1.Q4d.is-checked"]== "true") C-=0.5

	if(Result["Genin_1.Q5b.is-checked"]== "true") C++

	if(Result["Genin_2.Q6c.is-checked"]== "true") C++

	if(Result["Genin_2.Q7a.is-checked"]== "true") {c++; C+=0.3}
	if(Result["Genin_2.Q7b.is-checked"]== "true") {c++; C+=0.3}
	if(Result["Genin_2.Q7c.is-checked"]== "true") {c++; C+=0.3}
	if(Result["Genin_2.Q7d.is-checked"]== "true") {c--; C-=0.3}
	if(c==3) C+=0.1
	c=0
	if(Result["Genin_2.Q8b.is-checked"]== "true") C++
	if(Result["Genin_2.Q9d.is-checked"]== "true") C++
	if(Result["Genin_2.Q10b.is-checked"]== "true") C++
	if(Result["Genin_3.Q11a.is-checked"]== "true") {c++; C+=0.3}
	if(Result["Genin_3.Q11b.is-checked"]== "true") {c++; C+=0.3}
	if(Result["Genin_3.Q11c.is-checked"]== "true") {c++; C+=0.3}
	if(Result["Genin_3.Q11d.is-checked"]== "true") {c--; C-=0.3}
	if(c==3) C+=0.1
	c=0
	if(Result["Genin_3.Q12a.is-checked"]== "true") C++
	if(Result["Genin_3.Q13a.is-checked"]== "true") C+=0.34
	if(Result["Genin_3.Q13b.is-checked"]== "true") C+=0.33
	if(Result["Genin_3.Q13c.is-checked"]== "true") C-=0.5
	if(Result["Genin_3.Q13d.is-checked"]== "true") C+=0.33

	if(Result["Genin_3.Q14a.is-checked"]== "true") C-=0.2
	if(Result["Genin_3.Q14b.is-checked"]== "true") C+=0.2
	if(Result["Genin_3.Q14c.is-checked"]== "true") C+=0.2
	if(Result["Genin_3.Q14d.is-checked"]== "true") C+=0.5
	if(Result["Genin_3.Q14e.is-checked"]== "true") C+=0.2
	if(Result["Genin_3.Q14f.is-checked"]== "true") C+=0.2
	if(Result["Genin_3.Q14g.is-checked"]== "true") C+=0.2
	if(Result["Genin_3.Q14h.is-checked"]== "true") C+=0.5

	GeninScore=C
