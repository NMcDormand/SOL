var
	KonohaInvasionAccess
	KI_Commenced=0
	list
		KI_Participants=list(); ReadyForBattle=list()
		KonohaInvasionAIList=list()
		KI_Entry_Spawns=list(); KI_Completed_Spawns=list()
		Baki_Spawns=list(); Gaara_Spawns=list(); Kabuto_Spawns=list(); Temari_Spawns=list()
		SandNinja1_Spawns=list(); SandNinja2_Spawns=list(); SandNinja3_Spawns=list(); SandNinja4_Spawns=list()
		SoundNinja1_Spawns=list(); SoundNinja2_Spawns=list(); SoundNinja3_Spawns=list(); SoundNinja4_Spawns=list()
mob/var
	KI_InMission
	KI_BestScore=0
	KI_Banned=0
	KI_TeamKills=0
	tmp
		KonohaInvasionPoints=0
		KonohaInvasionTeamDamage=0


obj/SpawnPoints/KonohaInvasion
	Players
		Entry
			New()
				spawn(rand(20,100)) KI_Entry_Spawns+=loc
		Completed
			New()
				spawn(rand(20,100)) KI_Completed_Spawns+=loc
	Baki
		New()
			spawn(rand(20,100)) Baki_Spawns+=loc
	Gaara
		New()
			spawn(rand(20,100)) Gaara_Spawns+=loc
	Kabuto
		New()
			spawn(rand(20,100)) Kabuto_Spawns+=loc
	Temari
		New()
			spawn(rand(20,100)) Temari_Spawns+=loc
	SandNinja
		Group1
			New()
				spawn(rand(20,100)) SandNinja1_Spawns+=loc
		Group2
			New()
				spawn(rand(20,100)) SandNinja2_Spawns+=loc
		Group3
			New()
				spawn(rand(20,100)) SandNinja3_Spawns+=loc
	SoundNinja
		Group1
			New()
				spawn(rand(20,100)) SoundNinja1_Spawns+=loc
		Group2
			New()
				spawn(rand(20,100)) SoundNinja2_Spawns+=loc
		Group3
			New()
				spawn(rand(20,100)) SoundNinja3_Spawns+=loc
		Group4
			New()
				spawn(rand(20,100)) SoundNinja4_Spawns+=loc

proc
	KI_ResetVariables()//flag
		for(var/mob/a in KonohaInvasionAIList) del(a)
		for(var/mob/player/p in MasterPlayerList) {p.KonohaInvasionPoints=0; p.KonohaInvasionTeamDamage=0}
		KI_Participants=new/list; ReadyForBattle=new/list

	KonohaInvasionMission()
		if(KI_Commenced) return
		KonohaInvasionTime=world.timeofday+6000
		KI_Commenced=1; KI_ResetVariables(); KonohaInvasionAccess=1
		spawn(20)KI_SpawnNPCS()
		for(var/mob/player/p in MasterPlayerList)
			if(Rank2Num(p.NinjaRank)>=5)
				p.Popup("konoha invasion",10)
		spawn(1200)
			for(var/mob/player/p in MasterPlayerList)
				if(Rank2Num(p.NinjaRank)>=5)
					p.Popup("konoha invasion",8)
			spawn(1200)
				for(var/mob/player/p in MasterPlayerList)
					if(Rank2Num(p.NinjaRank)>=5)
						p.Popup("konoha invasion",6)
				spawn(600)
					for(var/mob/player/p in MasterPlayerList)
						if(Rank2Num(p.NinjaRank)>=5)
							p.Popup("konoha invasion",5)
					spawn(600)
						for(var/mob/player/p in MasterPlayerList)
							if(Rank2Num(p.NinjaRank)>=5)
								p.Popup("konoha invasion",4)
						spawn(600)
							for(var/mob/player/p in MasterPlayerList)
								if(Rank2Num(p.NinjaRank)>=5)
									p.Popup("konoha invasion",3)
							spawn(600)
								for(var/mob/player/p in MasterPlayerList)
									if(Rank2Num(p.NinjaRank)>=5)
										p.Popup("konoha invasion",2)
								spawn(600)
									for(var/mob/player/p in MasterPlayerList)
										if(Rank2Num(p.NinjaRank)>=5)
											p.Popup("konoha invasion",1,,60)
									spawn(600)
										KonohaInvasionAccess=0
										KI_Participants<<"<i>Thank you for waiting, you will now be escorted down to the barracks where you can prepare for the mission.</i>"
										spawn(20)
											for(var/mob/s in KI_Participants)
												SpawnInBarracks(s)
												winset(s,"mainwindow","flash=-1")
											if(length(KI_Participants))
												KI_PrepareForBattle()
											else
												for(var/mob/A in KonohaInvasionAIList)
													del(A)
												KI_Commenced=0
												KonohaInvasionTime=world.timeofday+18000;
												spawn(12000) {KonohaInvasionMission();}

	KI_PrepareForBattle()
		KI_Participants<<"Once you ready for battle, head down into the next room. The quest will start in <i>two minutes</i> or as soon as everybody's ready and one minute's passed."
		for(var/mob/player/P in KI_Participants)
			P.KonohaInvasionPoints=0; P.KonohaInvasionTeamDamage=0; P.Show_InvasionScore(); P.Refresh_InvasionScore()
		for(var/i=1,i<=50,i++)
			if(length(ReadyForBattle)==length(KI_Participants)&&i>30) break
			sleep(25)
		if(length(KI_Participants))
			KI_SpawnInKonoha()
		else
			for(var/mob/A in KonohaInvasionAIList) del(A)
			KI_Commenced=0
			KonohaInvasionTime=world.timeofday+18000;
			spawn(12000) {KonohaInvasionMission();}

	KI_SpawnInKonoha()
		KI_Participants<<"<b><font size=2>GO!!</b></font>"
		for(var/mob/s in KI_Participants)
			s.protect=0; s.loc=pick(KI_Entry_Spawns)
			s.firing=1
			s.TempID = 66
			spawn(30)
				if(s) s.firing=0
		spawn()KI_Timer()

	KI_SpawnNPCS()
		new/mob/Hittable/Responsive/NPC/KonohaInvasion/Baki(pick(Baki_Spawns))
		sleep(30)
		new/mob/Hittable/Responsive/NPC/KonohaInvasion/Gaara(pick(Gaara_Spawns))
		sleep(30)
		new/mob/Hittable/Responsive/NPC/KonohaInvasion/Kabuto(pick(Kabuto_Spawns))
		sleep(30)
		new/mob/Hittable/Responsive/NPC/KonohaInvasion/Temari(pick(Temari_Spawns))
		sleep(30)

		for(var/i=1,i<=15,i++)
			if(!KI_Commenced) break
			new/mob/Hittable/Responsive/NPC/KonohaInvasion/SandNinja(pick(SandNinja1_Spawns))
			sleep(20)
		for(var/i=1,i<=15,i++)
			if(!KI_Commenced) break
			new/mob/Hittable/Responsive/NPC/KonohaInvasion/SandNinja(pick(SandNinja2_Spawns))
			sleep(20)
		for(var/i=1,i<=15,i++)
			if(!KI_Commenced) break
			new/mob/Hittable/Responsive/NPC/KonohaInvasion/SandNinja(pick(SandNinja3_Spawns))
			sleep(20)
		for(var/i=1,i<=15,i++)
			if(!KI_Commenced) break
			new/mob/Hittable/Responsive/NPC/KonohaInvasion/SoundNinja(pick(SoundNinja1_Spawns))
			sleep(20)
		for(var/i=1,i<=15,i++)
			if(!KI_Commenced) break
			new/mob/Hittable/Responsive/NPC/KonohaInvasion/SoundNinja(pick(SoundNinja2_Spawns))
			sleep(20)
		for(var/i=1,i<=15,i++)
			if(!KI_Commenced) break
			new/mob/Hittable/Responsive/NPC/KonohaInvasion/SoundNinja(pick(SoundNinja3_Spawns))
			sleep(20)
		for(var/i=1,i<=15,i++)
			if(!KI_Commenced) break
			new/mob/Hittable/Responsive/NPC/KonohaInvasion/SoundNinja(pick(SoundNinja4_Spawns))
			sleep(20)


	KI_Timer()
		spawn(3000) KI_Participants<<"<font size=2><b>10 minutes remain</b></font>"
		spawn(4800) KI_Participants<<"<font size=2><b>7 minutes remain</b></font>"
		spawn(6000) KI_Participants<<"<font size=2><b>5 minutes remain</b></font>"
		spawn(6600) KI_Participants<<"<font size=2><b>4 minutes remain</b></font>"
		spawn(7200) KI_Participants<<"<font size=2><b>3 minutes remain</b></font>"
		spawn(7800) KI_Participants<<"<font size=2><b>2 minutes remain</b></font>"
		spawn(8400) KI_Participants<<"<font size=2><b>Only 1 minute remains</b></font>"
		for(var/i=1,i<=90,i++)//90 loops @ 100 delay = 15 minutes
			if(!KI_Commenced) break
			sleep(100)
		var/mob/A = locate() in KI_Participants
		if(A&&KI_Commenced)
			KI_Participants<<"<font size=2><b>Time Up!</b></font>"; A.loc=(pick(KI_Completed_Spawns))
			if((A in KI_Participants)) KI_Participants-=A
			for(var/mob/a in KonohaInvasionAIList) del(a)
		KonohaInvasionTime=world.timeofday+60000;
		spawn(54000) {KonohaInvasionMission();}
		KI_Commenced=0

	KonohaInvasionCheck_Win()
		var/mob/A = locate() in KonohaInvasionAIList
		if(!(A)&&KI_Commenced)
			KI_Commenced=0
			spawn(50)
				KI_Participants<<"<font size=2><b>Congratulations, you have completed the mission!</b></font>"
				spawn(5)
					sleep(5)
					var/list/WinnerList = list()
					var/WinningPoints
					for(var/mob/p in KI_Participants)
						if(p.KonohaInvasionPoints>=60)
							p<<"+1 S Rank Mission";
							p.MissionsComplete["CurSRank"]++
							p.MissionsComplete["SRank"]++
							p.MissionsComplete["S"]++
							p.MissionsComplete["Cur"]++
							p.MissionsComplete["Total"]++
							p.MissionPoints+=SMPREWARD

							var/Comped=0
							while(p.MissionsComplete["Cur"]>=5)
								p.MissionsComplete["Cur"]-=5
								Comped++
							if(Comped)
								p.AwardVP(1 * Comped)
								Comped *= 2
								p.StatPoints += Comped
								p.StatPointsObtained["MisReward"]+= Comped
								p.StatPointsObtained["Total"]+= Comped
								p.StatUpdate_statpoints()
								p<<"<center><b>* You have been rewarded [2*Comped] Stat Points *</b></center>"

							if(p.KonohaInvasionPoints>2200)
								p.AwardVP(9)
							else if(p.KonohaInvasionPoints>1700)
								p.AwardVP(8)
							else if(p.KonohaInvasionPoints>1300)
								p.AwardVP(7)
							else if(p.KonohaInvasionPoints>900)
								p.AwardVP(6)
							else
								p.AwardVP(5)
							p<<"+[round(p.KonohaInvasionPoints*50)] gold"; p.gold+=round(p.KonohaInvasionPoints*50)

						p<<"Your Score: [round(p.KonohaInvasionPoints)]"
						if(!p.BeenKage && p.MissionsComplete["S"]>=10)//ADD - Mission points
							if(p.KonohaInvasionPoints > p.KageScore)
								p.KageScore = p.KonohaInvasionPoints
							if(!ElligibleKageList[p.Village][p.trueName])
								ElligibleKageList[p.Village][p.trueName] = p

						if(max(p.KonohaInvasionPoints,p.KI_BestScore)>p.KI_BestScore)
							p.KI_BestScore=p.KonohaInvasionPoints; p<<"<b>Congratulations! You set a new Personal Best!</b>"
							var/Score_KonohaInvasion = list("Konoha Invasion"="[round(p.KI_BestScore,0.001)]")
							world.SetScores(p.key,list2params(Score_KonohaInvasion))

						if(p.KonohaInvasionPoints > WinningPoints)
							WinningPoints=p.KonohaInvasionPoints
							WinnerList = list(p)
						else if(p.KonohaInvasionPoints == WinningPoints)
							WinnerList += p

						p.loc=(pick(KI_Completed_Spawns))
						p.protect=1
						p.TempID = 0

						p.KonohaInvasionPoints=0
						p.KonohaInvasionTeamDamage=0

						p.Refresh_InvasionScore()
						p.Hide_InvasionScore()
						KI_Participants-=p
						p.KI_InMission=0

					if(WinnerList.len == 1)
						world<<"Well done to [list2sentence(WinnerList)], who scored <u>[WinningPoints]</u> points that round!"
					else if(WinnerList.len==2)
						world<<"Well done to [list2sentence(WinnerList)], who both scored <u>[WinningPoints]</u> points that round!"
					else if(WinnerList.len>2)
						world<<"Well done to [list2sentence(WinnerList)], who all scored <u>[WinningPoints]</u> points that round!"

					spawn(10)
						CheckForKages()

	SpawnInBarracks(mob/s)
		s.KI_InMission=1
		s.x=rand(769,773)
		s.y=rand(31,34)
		s.z=2

mob/proc/RemoveFromKonohaInvasion()
	src<<"<b>You have been ejected from the mission for hurting your own team or killing an ally!</b>"; loc=(pick(KI_Completed_Spawns))
	KI_TeamKills++; KI_Banned=1
	if((src in KI_Participants))
		KI_Participants-=src; KI_InMission=0

mob/proc/CheckTeamDamage()
	if(KonohaInvasionTeamDamage >=100) RemoveFromKonohaInvasion()

mob/proc/RemoveBanFromKI()
	var/fee = KI_TeamKills*20000
	if(KI_TeamKills <= 1) {KI_Banned=0; alert("As this is your first time, I will remove the traitor mark for free.", "S Rank Mission Man"); src<<"<i>You may now enter the S Rank, please assist your team!</i>"};..()
	switch(input("To enter the S Rank, you will have to pay a fee of [fee]. Do you wish to do so now?","S Rank Traitor") in list ("Yes","No"))
		if("Yes")
			if(gold>=fee) {gold-=fee; KI_Banned=0; src<<"<i>You may now enter the S Rank, please assist your team!</i>"}
			else src<<"<i>You're a bit short on funds!</i>"
		if("No") src<<"<i>You will not be able to enter the mission until you pay!</i>"

