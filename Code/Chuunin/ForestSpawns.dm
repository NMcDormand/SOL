var/tmp
	ChuuninSpawnPoint=1
	list/ChuuninList
	chuuninClock
area
	ChuuninForest
		Outdoor = 0
		Spawn
			name = "Forest of Death"
proc/ForestSpawn()
	ChuuninList=list()
	var/ChuuninScroll = "HeavenScroll"
	var/list/SpawnPointList = list()
	for(var/turf/A in locate(/area/ChuuninForest/Spawn))
		if(!length(A.contents))
			SpawnPointList += A
	if(length(ForestList) == 1)
		var/mob/Hittable/Responsive/NPC/ChuuninEntrant/NC = new()
		ForestList += NC
	for(var/mob/C in ForestList)
		C.ZCoord="Forest of Death"
		C.ZCoordProc(C.ZCoord)
		C.protect=0
		var/turf/SP = pick(SpawnPointList)
		C.loc = SP
		SpawnPointList -= SP
		var/SCTYP = text2path("/obj/Scrolls/ChuuninScrolls/[ChuuninScroll]")
		new SCTYP(C)
		if(ChuuninScroll == "HeavenScroll")
			ChuuninScroll = "EarthScroll"
			C.HasHeaven = 1
		else
			ChuuninScroll = "HeavenScroll"
			C.HasEarth = 1

		if(C.client)
			ChuuninList+=C
			C.UpdateInventory()
	spawn(4200) BeginChuuninTournament()
	chuuninClock()

proc/chuuninClock()
	set waitfor = 0
	chuuninClock=7
	while(chuuninClock>0)
		sleep(600)
		chuuninClock-=1;


proc/BeginChuuninTournament()
	BattleList=new()
	for(var/obj/Scrolls/ChuuninScrolls/X in world) del(X)
	for(var/mob/B in ChuuninList)
		B.UpdateInventory()
		if(!B.InTower)
			B.ChuuninExit()
		else if(B.InTower)
			B<<"<i><b>Congratulations, you have passed the second part of the Chuunin exam!</i></b>"
			B<<"<i>In the third stage of the exams, each participant must have a 1-on-1 fight to the death.</i>"
			BattleList+=B
	spawn(1)del(ChuuninList)
	spawn(40)PassersCheck()