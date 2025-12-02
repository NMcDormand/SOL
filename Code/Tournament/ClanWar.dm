var
	AburameCount; YukiCount; HyuugaCount; InuzukaCount; KaguyaCount; NaraCount; UchihaCount; LeeCount; UzumakiCount;
	Aburames; Yukis; Hyuugas; Inuzukas; Kaguyas; Naras; Uchihas; Lees; Uzumaki;
	AburameList=list(); YukiList=list(); HyuugaList=list(); InuzukaList=list(); KaguyaList=list(); NaraList=list(); UchihaList=list(); LeeList=list()
	AburameSP=list()
	YukiSP=list()
	HyuugaSP=list()
	InuzukaSP=list()
	KaguyaSP=list()
	NaraSP=list()
	UchihaSP=list()
	TaijutsuSP=list()
	UzumakiSP = list()

proc
	ClanWar()
		if(TournamentHosted) return
		TournamentOpen=1; TournamentHosted=1;
		del(TournamentList); TournamentList=new/list
		Aburames=0; Yukis=0; Hyuugas=0; Inuzukas=0; Kaguyas=0; Naras=0; Uchihas=0; Lees=0; Uzumaki=0;
		AburameCount=0; YukiCount=0; HyuugaCount=0; InuzukaCount=0; KaguyaCount=0; NaraCount=0; UchihaCount=0; LeeCount=0; UzumakiCount=0;
		for(var/mob/player/p in MasterPlayerList)
			if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Clan War",8)
		spawn(1800)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Clan War",5)
		spawn(3000)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Clan War",3)
		spawn(3600)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Clan War",2)
		spawn(4200)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Clan War",1,59)
		spawn(4800)
			for(var/mob/player/P in TournamentList)
				if(P.Clan=="Aburame") {AburameList+=P; AburameCount++; Aburames=1}
				if(P.Clan=="Yuki") {YukiList+=P; YukiCount++; Yukis=1}
				if(P.Clan=="Hyuuga") {HyuugaList+=P; HyuugaCount++; Hyuugas=1}
				if(P.Clan=="Inuzuka") {InuzukaList+=P; InuzukaCount++; Inuzukas=1}
				if(P.Clan=="Kaguya") {KaguyaList+=P; KaguyaCount++; Kaguyas=1}
				if(P.Clan=="Nara") {NaraList+=P; NaraCount++; Naras=1}
				if(P.Clan=="Uchiha") {UchihaList+=P; UchihaCount++; Uchihas=1}
				if(P.Clan=="Taijutsu Specialist") {LeeList+=P; LeeCount++; Lees=1}
			var/ClanCount=Aburames+Yukis+Hyuugas+Inuzukas+Kaguyas+Naras+Uchihas+Lees
			if(ClanCount>1)
				world<<"<font size=2><u>The Clan War entrants are as follows</u></font>:"
				if(Aburames) MasterPlayerList<<"[AburameCount] members of the Aburame Clan."
				if(Yukis) MasterPlayerList<<"[YukiCount] members of the Yuki Bloodline."
				if(Hyuugas) MasterPlayerList<<"[HyuugaCount] members of the Hyuuga Clan."
				if(Inuzukas) MasterPlayerList<<"[InuzukaCount] members of the Inuzuka Clan."
				if(Kaguyas) MasterPlayerList<<"[KaguyaCount] members of the Kaguya Clan."
				if(Naras) MasterPlayerList<<"[NaraCount] members of the Nara Clan."
				if(Uchihas) MasterPlayerList<<"[UchihaCount] members of the Uchiha Clan."
				if(Lees) MasterPlayerList<<"[LeeCount] Taijutsu Specialists."
				spawn(20) ClanWarSpawn()
				spawn(40) {TournamentCountdown();TournamentCheck_Clan()}
			else
				world<<"Less than two clans entered the tournament; the tournament is called off."; TournamentHosted=0


	ClanWarSpawn()
		for(var/obj/SpawnPoints/ClanWar/Aburame/SP in world) AburameSP+=SP.loc
		for(var/obj/SpawnPoints/ClanWar/Yuki/SP in world) YukiSP+=SP.loc
		for(var/obj/SpawnPoints/ClanWar/Hyuuga/SP in world) HyuugaSP+=SP.loc
		for(var/obj/SpawnPoints/ClanWar/Inuzuka/SP in world) InuzukaSP+=SP.loc
		for(var/obj/SpawnPoints/ClanWar/Kaguya/SP in world) KaguyaSP+=SP.loc
		for(var/obj/SpawnPoints/ClanWar/Nara/SP in world) NaraSP+=SP.loc
		for(var/obj/SpawnPoints/ClanWar/Uchiha/SP in world) UchihaSP+=SP.loc
		for(var/obj/SpawnPoints/ClanWar/Taijutsu/SP in world) TaijutsuSP+=SP.loc
		for(var/obj/SpawnPoints/ClanWar/Uzumaki/SP in world) UzumakiSP+=SP.loc
		for(var/mob/player/b in TournamentList) b<<"<b>You will now be taken to the arena!</b>"
		spawn(15)
			for(var/mob/player/A in AburameList) A.loc=pick(AburameSP)
			for(var/mob/player/B in YukiList) B.loc=pick(YukiSP)
			for(var/mob/player/C in HyuugaList) C.loc=pick(HyuugaSP)
			for(var/mob/player/D in InuzukaList) D.loc=pick(InuzukaSP)
			for(var/mob/player/E in KaguyaList) E.loc=pick(KaguyaSP)
			for(var/mob/player/F in NaraList) F.loc=pick(NaraSP)
			for(var/mob/player/G in UchihaList) G.loc=pick(UchihaSP)
			for(var/mob/player/H in LeeList) H.loc=pick(TaijutsuSP)

	TournamentCheck_Clan()
		Aburames=0; Yukis=0; Hyuugas=0; Inuzukas=0; Kaguyas=0; Naras=0; Uchihas=0; Lees=0; Uzumaki=0
		for(var/mob/player/P in TournamentList)
			if(P.Clan=="Aburame") Aburames=1
			if(P.Clan=="Yuki") Yukis=1
			if(P.Clan=="Hyuuga") Hyuugas=1
			if(P.Clan=="Inuzuka") Inuzukas=1
			if(P.Clan=="Kaguya") Kaguyas=1
			if(P.Clan=="Nara") Naras=1
			if(P.Clan=="Uchiha") Uchihas=1
			if(P.Clan=="Taijutsu Specialist") Lees=1
			if(P.Clan=="Uzumaki") Uzumaki=1
		var/ClanCount=Aburames+Yukis+Hyuugas+Inuzukas+Kaguyas+Naras+Uchihas+Lees+Uzumaki
		if(ClanCount>1)
			spawn(25) TournamentCheck_Clan()
		else
			var/Winners
			for(var/mob/player/W in TournamentList)
				W<<"Congratulations you won the tournament!"; Winners=W.Clan; W.ExitArena()
				W.ClanWarMedal()
				TournamentList-=W
			world<<output("The [Winners] clan has won the tournament!","ann")
			TournamentHosted=0

mob/proc
	ClanWarMedal()
		src.ClanWarWins++; src.TournamentWins++
		if(!world.GetMedal("Clan War Winner", src)) world.SetMedal("Clan War Winner", src)
		src<<"Congratulations! You have been awarded the Clan War medal!"
		src.gold+=1000; src.StatPoints+=10
		src.StatUpdate_gold(); src.StatUpdate_statpoints()