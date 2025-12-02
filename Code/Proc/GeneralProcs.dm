proc
	IsEven(x)
		return x % 2 == 0
	IsOdd(x)
		return !IsEven(x)

proc/MobDistanceCheck(mob/u,mob/s,dist)
	if(!dist) dist=3
	if(get_dist(u,s)>dist) return FALSE
	else return TRUE
mob/var/tmp
	Revenge=list()
	Drugged
	RevengeProtect
	RecentlySpawned

mob/proc
	PracticeMode()
		if(PracticeMode) return 1
		else return 0

	HospitalKillMe(mob/M)
		if(!M) return
		Revenge+=M; spawn(600) Revenge-=M
		choice
		switch(input(src,"[M] has killed you after leaving the hospital. What would you like to do about it?","Hospital Kill") as null|anything in list("Take half of their gold","Drug them","Steal their Experience Points","Forgive"))
			if("Take half of their gold")
				switch(alert(src,"Steal [round(M.gold/2)] gold?","","Yes","No"))
					if("Yes") StealGold(M)
					else goto choice
			if("Drug them") Drug(M)
			if("Steal their Experience Points")
				var/e=round(M.Exp*0.3)
				var/e2=((e/MXP)*100)
				switch(alert(src,"Steal [e2] XP?","","Yes","No"))
					if("Yes") StealEXP(M)
					else goto choice
			if("Forgive") {src<<"<b>You forgave [M] for <i>Hospital Killing</i> you.</b>"; M<<"<b>[src] forgave you for <i>Hospital Killing</i> them.</b>"}
	StealGold(mob/M)
		if(!M||(!(M in Revenge))) return
		var/s
		if(M.gold)
			s=M.gold/2
		if(s)
			gold+=s; M.gold-=s
			StatUpdate_gold(); M.StatUpdate_gold()
			src<<"<b>You stole [s] gold from [M].</b>"
			M<<"<b>[src] stole half of your gold because you <i>Hospital Killed</i> them!</b>"
		else
			src<<"<b>They haven't got any gold.</b>"
	StealEXP(mob/M)
		if(!M||!(M in Revenge)) return
		var/s
		if(M.Exp)
			s=round(M.Exp*0.3)
		if(s)
			Exp+=s; LevelUpCheck(); M.Exp-=s
			src<<"<b>You stole 30% of [M]'s XP.</b>"
			M<<"<b>[src] stole 30% of your XP. because you <i>Hospital Killed</i> them!</b>"
		else
			src<<"<b>They haven't got any experience points at the moment.</b>"
	Drug(mob/M)
		if(!M||!(M in Revenge)) return
		src<<"<b>You drugged [M].</b>"; M<<"<b>[src] has drugged you for <i>Hospital Killing</i> them!</b>"
		M.Drugged=1
		spawn(500)
			if(M) {M<<"You are no longer drugged"; M.Drugged=0}
	RockFind()
		set waitfor = 0
		if(canfindrocks && client && !onwater)
			var/h=80
			if(InVillage=="Rock")
				h+=9
			if(Village=="Rock")
				h+=6
			if(onsand)
				h+=10
			if(onmountain)
				h+=20
			if(rockLuck==1)
				h*=2
			var/a = abs(setspeed-4)
			if(!a)
				a = 1
			var/Chance = pick (
				prob((h/a)+Luck)
					1,
				prob(10000)
					0
				)
			if(Chance)
				src<<"<font color=gray>You found a stone lying on the ground!</font>"
				var/obj/Item/Material/Ore/Stone/R=locate() in contents
				if(!R)
					new/obj/Item/Material/Ore/Stone(src)
				else
					R.amount++
					R.Checkamount()
				RocksFound++

//------------------------------------------------------------------------------------------------------------

mob/var
	Minutes=0; Hours=0; list/Friendship = list()

mob/proc/PlayerOnlineTime()
	//Do Time Stuff
	while(client)
		if(Minutes>59) {Minutes=0; Hours++}
		for(var/mob/player/P in MasterPlayerList)
			if(P != src)
				if(FRIENDCHECK(P,src))
					if(get_dist(P,src) < 12)
						Friendship["[P.trueName]"] += 1

		if(client.inactivity>3000) //If user is afk for 5 minutes (NO ACTIVITY AT ALL)
			if(!AFK && !AfkStam && !afkFishing)
				AFK="AFK"; src<<"You have been set to AFK"; overlays+='AFK.dmi'
				if(GenericAttackCheckAFK()&&!protect) return
				if(!meditating && !meditatetime)
					meditatetime=1
					icon_state="rest"
					src<<"You sit down and meditate."
					meditating=1; spawn(20)meditate(50)
				firing=1; attacking=1

		if(muted && !AFK) //Check if the player is currently Muted
			if(muted<=1) //If 1, change to 0 and remove mute
				OOC=1;
				world<<"<b>[src]'s mute has expired!</b>";
				muteLevel=0;
				muted=0;
			else //Else reduce by 1
				muted--

		if(jailed) //Check if the player is currently Jailed
			if(jailed<=1&&jailed>0) //If 1, change to 0 and remove from jail
				overlays -= 'frozen.dmi'
				src<<"<b><font color=red>You're free to go.</font></b>"; SpawnWhere()
				GMfrozen = 0
				jailLevel = 0;
				jailed=0;
			else //Else reduce by 1
				jailed--

		if(stuckTimer) {stuckTimer--;} //Reduce the stuck usage Cooldown
		if(GeninTimer) {GeninTimer--;} //Reduce the genin exam Cooldown
		Minutes++
		if(!(Minutes % 10)) Save()
		/* - Mangekyou Vision Loss
		if(InMangekyou) {fade()}*/
		if((screen_r + screen_g + screen_b) < 768){restoreVision()}
		if(DeliverWait) DeliverWait--

		sleep(600)

mob/proc/ZCoordProc(location)
	set waitfor = 0
	if(client)
		winset(src,"minimappane.Location","text='[ZCoord]'")

mob/proc/ZCoordVillage(location)
	InVillage=location; ZCoord="[location] Village"; ZCoordProc(ZCoord)

mob/proc/fade()
	if (screen_r>0||screen_g>0||screen_b>0)
		screen_r-=12.8;screen_g-=12.8;screen_b-=12.8;
	client.color = rgb(screen_r,screen_g,screen_b)

mob/proc/restoreVision()
	if(screen_r>=256||screen_g>=256||screen_b>=256){screen_r=256;screen_g=256;screen_b=256;return}
	else if (screen_r<256||screen_g<256||screen_b<256)
		screen_r+=50;screen_g+=50;screen_b+=50;
	client.color = rgb(screen_r,screen_g,screen_b)

var/const/ARTICLE_DEFAULT    =  0
var/const/ARTICLE_INDEFINITE =  1
var/const/ARTICLE_DEFINITE   =  2
var/const/ARTICLE_NONE       = -1

proc/list2sentence(list/L, and="and", article=ARTICLE_DEFAULT)
	var/sentence = ""
	var/separator = ","
	if(!istype(L, /list)) L = list(L)
	for(var/i = 1, i <= L.len, i++)
		if(istype(L[i], /list))
			separator = ";"
			break
	if(L.len > 1)
		for(var/j = 1, j < L.len, j++)
			if(istype(L[j], /list)) //automatically recurse lists of lists
				sentence += list2sentence(L[j], and="and", article)
			else
				if(article == ARTICLE_NONE)
					sentence += "\proper [L[j]][(L.len > 2 || \
						(L.len > 1 && article==ARTICLE_NONE)) ? separator : ""] "
				else if(article == ARTICLE_INDEFINITE)
					sentence += "\a [L[j]][(L.len > 2 || \
						(L.len > 1 && article==ARTICLE_NONE)) ? separator : ""] "
				else if(article == ARTICLE_DEFINITE)
					sentence += "\the [L[j]][(L.len > 2 || \
						(L.len > 1 && article==ARTICLE_NONE)) ? separator : ""] "
				else
					sentence += "[L[j]][L.len > 2 ? separator : ""] "
	if(L.len)
		if(L.len > 1 && article != ARTICLE_NONE)
			sentence += "[and] "
		if(istype(L[L.len], /list))
			sentence += list2sentence(L[L.len], and="and", article)
		else
			if(article == ARTICLE_NONE)
				sentence += "\proper [L[L.len]]"
			else if(article == ARTICLE_INDEFINITE)
				sentence += "\a [L[L.len]]"
			else if(article == ARTICLE_DEFINITE)
				sentence += "\the [L[L.len]]"
			else
				sentence += "[L[L.len]]"
	return sentence

var/list/ListOfPlayerNames=list()
proc
	LoadNames()
		if(fexists("Data/Wipe/PlayerNames.sav"))
			var/savefile/F = new ("Data/Wipe/PlayerNames.sav")
			F["PlayerNames"]>>ListOfPlayerNames

	SaveNames()
		if(TotalSavePrevention) return
		var/savefile/F = new("Data/Wipe/PlayerNames.sav")
		F["PlayerNames"] << ListOfPlayerNames

	RemoveName(A="Name")
		for(var/B in Villages)
			if(KageCurrent[B] == A)
				KageCurrent[B] = 0
			if(ElligibleKageList[B][A])
				ElligibleKageList[B] -= A
		ListOfPlayerNames[A] = 0


mob/proc
	NameArchive()
		if(ckey=="screwyparasite") {ListOfPlayerNames[name]=ckey; SaveNames()}
		else if(!ListOfPlayerNames[trueName]) {ListOfPlayerNames[trueName]=ckey; SaveNames()}
		else {name="[name]_[rand(1,100)]"}
