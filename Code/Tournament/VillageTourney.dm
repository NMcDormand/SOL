var
	CloudCount; LeafCount; GrassCount; MistCount; RainCount; RockCount; SandCount; SoundCount; WaterfallCount
	Clouds; Leafs; Grasss; Mists; Rains; Rocks; Sands; Sounds; Waterfalls
	CloudList=list(); LeafList=list(); GrassList=list(); MistList=list(); RainList=list(); RockList=list(); SandList=list(); SoundList=list(); WaterfallList=list()
	CloudSP=list()
	LeafSP=list()
	GrassSP=list()
	MistSP=list()
	RainSP=list()
	RockSP=list()
	SandSP=list()
	SoundSP=list()
	WaterfallSP=list()


proc

	RemoveFromTournamentLists(mob/ENTRANT)
		LeafList-= ENTRANT
		MistList-= ENTRANT
		CloudList-= ENTRANT
		RockList-= ENTRANT
		SandList-= ENTRANT

	VillageWar()
		if(TournamentHosted) return
		TournamentOpen=1; TournamentHosted=1; TournamentList=new/list
		Clouds=0; Leafs=0; Grasss=0; Mists=0; Rains=0; Rocks=0; Sands=0; Sounds=0; Waterfalls=0
		CloudCount=0; LeafCount=0; GrassCount=0; MistCount=0; RainCount=0; RockCount=0; SandCount=0; SoundCount=0; WaterfallCount=0
		for(var/mob/player/p in MasterPlayerList)
			if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Village War",8)
		spawn(1800)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Village War",5)
		spawn(3000)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Village War",3)
		spawn(3600)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Village War",2)
		spawn(4200)
			for(var/mob/player/p in MasterPlayerList)
				if(p&&p.NinjaRank!="Academy Student") p.Popup("tournament","Village War",1,60)
		spawn(4800)
			for(var/mob/player/P in TournamentList)
				if(P.Village=="Cloud") {CloudList+=P; CloudCount++; Clouds=1}
				if(P.Village=="Leaf") {LeafList+=P; LeafCount++; Leafs=1}
				if(P.Village=="Grass") {GrassList+=P; GrassCount++; Grasss=1}
				if(P.Village=="Mist") {MistList+=P; MistCount++; Mists=1}
				if(P.Village=="Rain") {RainList+=P; RainCount++; Rains=1}
				if(P.Village=="Rock") {RockList+=P; RockCount++; Rocks=1}
				if(P.Village=="Sand") {SandList+=P; SandCount++; Sands=1}
				if(P.Village=="Sound") {SoundList+=P; SoundCount++; Sounds=1}
				if(P.Village=="Waterfall") {WaterfallList+=P; WaterfallCount++; Waterfalls=1}
			var/VillageCount=Clouds+Leafs+Grasss+Mists+Rains+Rocks+Sands+Sounds+Waterfalls
			if(VillageCount>1)
				world<<"<font size=2><u>The Village Tournament entrants are as follows</u></font>:"
				if(Clouds) MasterPlayerList<<"[CloudCount] members of the Cloud Village."
				if(Leafs) MasterPlayerList<<"[LeafCount] members of the Leaf Village."
				if(Grasss) MasterPlayerList<<"[GrassCount] members of the Grass Village."
				if(Mists) MasterPlayerList<<"[MistCount] members of the Mist Village."
				if(Rains) MasterPlayerList<<"[RainCount] members of the Rain Village."
				if(Rocks) MasterPlayerList<<"[RockCount] members of the Rock Village."
				if(Sands) MasterPlayerList<<"[SandCount] members of the Sand Village."
				if(Sounds) MasterPlayerList<<"[SoundCount] Sound Village."
				if(Waterfalls) MasterPlayerList<<"[WaterfallCount] Waterfall Village."
				spawn(20) VillageWarSpawn()
				spawn(40) {TournamentCountdown();TournamentCheck_Village()}
			else
				world<<"Less than two villages entered the tournament; the tournament is called off."; TournamentHosted=0


	VillageWarSpawn()
		for(var/obj/SpawnPoints/VillageWar/Cloud/SP in world) CloudSP+=SP.loc
		for(var/obj/SpawnPoints/VillageWar/Leaf/SP in world) LeafSP+=SP.loc
		for(var/obj/SpawnPoints/VillageWar/Grass/SP in world) GrassSP+=SP.loc
		for(var/obj/SpawnPoints/VillageWar/Mist/SP in world) MistSP+=SP.loc
		for(var/obj/SpawnPoints/VillageWar/Rain/SP in world) RainSP+=SP.loc
		for(var/obj/SpawnPoints/VillageWar/Rock/SP in world) RockSP+=SP.loc
		for(var/obj/SpawnPoints/VillageWar/Sand/SP in world) SandSP+=SP.loc
		for(var/obj/SpawnPoints/VillageWar/Sound/SP in world) SoundSP+=SP.loc
		for(var/obj/SpawnPoints/VillageWar/Waterfall/SP in world) WaterfallSP+=SP.loc
		for(var/mob/player/b in TournamentList) b<<"<b>You will now be taken to the arena!</b>"
		spawn(15)
			for(var/mob/player/A in CloudList) A.loc=pick(CloudSP)
			for(var/mob/player/B in LeafList) B.loc=pick(LeafSP)
			for(var/mob/player/C in GrassList) C.loc=pick(GrassSP)
			for(var/mob/player/D in MistList) D.loc=pick(MistSP)
			for(var/mob/player/E in RainList) E.loc=pick(RainSP)
			for(var/mob/player/F in RockList) F.loc=pick(RockSP)
			for(var/mob/player/G in SandList) G.loc=pick(SandSP)
			for(var/mob/player/H in SoundList) H.loc=pick(SoundSP)
			for(var/mob/player/H in WaterfallList) H.loc=pick(WaterfallSP)

	TournamentCheck_Village()
		Clouds=0; Leafs=0; Grasss=0; Mists=0; Rains=0; Rocks=0; Sands=0; Sounds=0
		for(var/mob/player/P in TournamentList)
			if(P.Village=="Cloud") Clouds=1
			if(P.Village=="Leaf") Leafs=1
			if(P.Village=="Grass") Grasss=1
			if(P.Village=="Mist") Mists=1
			if(P.Village=="Rain") Rains=1
			if(P.Village=="Rock") Rocks=1
			if(P.Village=="Sand") Sands=1
			if(P.Village=="Sound") Sounds=1
		var/VillageCount=Clouds+Leafs+Grasss+Mists+Rains+Rocks+Sands+Sounds
		if(VillageCount>1)
			spawn(25) TournamentCheck_Village()
		else
			var/Winners
			for(var/mob/player/W in TournamentList)
				W<<"Congratulations you won the tournament!"
				Winners=W.Village
				W.ExitArena()
				W.VillageWarMedal()
				RemoveFromTournamentLists(W)
				TournamentList-=W
			world<<output("The [Winners] Village has won the tournament!","ann")
			TournamentHosted=0

mob/proc
	VillageWarMedal()
		src.VillageWarWins++; src.TournamentWins++
		if(!world.GetMedal("Village Tournament Winner", src)) world.SetMedal("Village Tournament Winner", src)
		src<<"Congratulations! You have been awarded the Village Tournament medal!"
		src.gold+=2000; src.StatPoints+=10
		src.StatUpdate_gold(); src.StatUpdate_statpoints()