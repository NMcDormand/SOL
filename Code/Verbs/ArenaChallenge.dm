mob/var
	Arena
	tmp
		Wager=0
		rival
		SavedLocation
		SavedPlace
	ArenaWins=0
	ArenaLosses=0
	ArenaRatio=0
var
	list
		RiverList=list()
		IslandsList=list()
		DesertList=list()
		TropicalList=list()
		WarehouseList=list()
		ArenaForestList=list()
		MountainList=list()

mob/player/verb
	Arena_Challenge()
		set hidden=1
		if(usr.Arena||usr.choosing||usr.jailed) return
		if(usr.NinjaRank=="Academy Student") {alert("Academy Students cannot challenge players to a battle."); return}
		usr.choosing=1
		var/ArenaList = list()
		for(var/mob/player/A in MasterPlayerList)
			if(A.NinjaRank!="Academy Student"&&!A.jailed&&A!=usr&&usr.client.address!=A.client.address&&A.SendIntoBattle("Arena Challenge")) ArenaList+=A
		var/mob/player/p = input("Select a player to challenge","Arena Challenge") as null|anything in ArenaList
		if(!p)
			usr.choosing=0
		else //if(p)
			selectarena
			switch(input("Select the arena you wish to fight in","Arena Challenge") in list("River","Islands","Tropical","Desert","Warehouse","Forest","Mountain","Cancel"))
				if("River")
					var/count=RiverList.len
					if(count>0)
						usr<<"This arena is currently in use."
						goto selectarena
					else
						makebet
						var/Bet = input("How much would you like to bet? (Maximum bet is [p.gold])","Wager",usr.Wager) as num
						if(Bet<0) Bet=0
						Bet=round(Bet)
						if(Bet>usr.gold)
							usr<<"You don't have enough gold."
							goto makebet
						else if(!Bet)
							usr<<"No wager has been made.  Awaiting [p]'s response..."
						else if(Bet>p.gold)
							usr<<"The wager has been automatically set to [p.gold], because that's all \he has on \him."
							Bet=p.gold
						else
							usr<<"Your bet is [Bet]. Awaiting [p]'s response..."
						RiverList+=usr
						usr.AskForArena(p,"River",Bet)
						usr.choosing=0
				if("Islands")
					var/count=IslandsList.len
					if(count>0)
						usr<<"This arena is currently in use."
						goto selectarena
					else
						makebet
						var/Bet = input("How much would you like to bet? (Maximum bet is [p.gold])","Wager",usr.Wager) as num
						if(Bet<0) Bet=0
						Bet=round(Bet)
						if(Bet>usr.gold)
							usr<<"You don't have enough gold."
							goto makebet
						else if(!Bet)
							usr<<"No wager has been made.  Awaiting [p]'s response..."
						else if(Bet>p.gold)
							usr<<"The wager has been automatically set to [p.gold], because that's all \he has on \him."
							Bet=p.gold
						else
							usr<<"Your bet is [Bet]. Awaiting [p]'s response..."
						IslandsList+=usr
						usr.AskForArena(p,"Islands",Bet)
						usr.choosing=0
				if("Tropical")
					var/count=TropicalList.len
					if(count>0)
						usr<<"This arena is currently in use."
						goto selectarena
					else
						makebet
						var/Bet = input("How much would you like to bet? (Maximum bet is [p.gold])","Wager",usr.Wager) as num
						if(Bet<0) Bet=0
						Bet=round(Bet)
						if(Bet>usr.gold)
							usr<<"You don't have enough gold."
							goto makebet
						else if(!Bet)
							usr<<"No wager has been made.  Awaiting [p]'s response..."
						else if(Bet>p.gold)
							usr<<"The wager has been automatically set to [p.gold], because that's all \he has on \him."
							Bet=p.gold
						else
							usr<<"Your bet is [Bet]. Awaiting [p]'s response..."
						TropicalList+=usr
						usr.AskForArena(p,"Tropical",Bet)
						usr.choosing=0
				if("Desert")
					var/count=DesertList.len
					if(count>0)
						usr<<"This arena is currently in use."
						goto selectarena
					else
						makebet
						var/Bet = input("How much would you like to bet? (Maximum bet is [p.gold])","Wager",usr.Wager) as num
						if(Bet<0) Bet=0
						Bet=round(Bet)
						if(Bet>usr.gold)
							usr<<"You don't have enough gold."
							goto makebet
						else if(!Bet)
							usr<<"No wager has been made.  Awaiting [p]'s response..."
						else if(Bet>p.gold)
							usr<<"The wager has been automatically set to [p.gold], because that's all \he has on \him."
							Bet=p.gold
						else
							usr<<"Your bet is [Bet]. Awaiting [p]'s response..."
						DesertList+=usr
						usr.AskForArena(p,"Desert",Bet)
						usr.choosing=0
				if("Warehouse")
					var/count=WarehouseList.len
					if(count>0)
						usr<<"This arena is currently in use."
						goto selectarena
					else
						makebet
						var/Bet = input("How much would you like to bet? (Maximum bet is [p.gold])","Wager",usr.Wager) as num
						if(Bet<0) Bet=0
						Bet=round(Bet)
						if(Bet>usr.gold)
							usr<<"You don't have enough gold."
							goto makebet
						else if(!Bet)
							usr<<"No wager has been made.  Awaiting [p]'s response..."
						else if(Bet>p.gold)
							usr<<"The wager has been automatically set to [p.gold], because that's all \he has on \him."
							Bet=p.gold
						else
							usr<<"Your bet is [Bet]. Awaiting [p]'s response..."
						WarehouseList+=usr
						usr.AskForArena(p,"Warehouse",Bet)
						usr.choosing=0
				if("Forest")
					var/count=ArenaForestList.len
					if(count>0)
						usr<<"This arena is currently in use."
						goto selectarena
					else
						makebet
						var/Bet = input("How much would you like to bet? (Maximum bet is [p.gold])","Wager",usr.Wager) as num
						if(Bet<0) Bet=0
						Bet=round(Bet)
						if(Bet>usr.gold)
							usr<<"You don't have enough gold."
							goto makebet
						else if(!Bet)
							usr<<"No wager has been made.  Awaiting [p]'s response..."
						else if(Bet>p.gold)
							usr<<"The wager has been automatically set to [p.gold], because that's all \he has on \him."
							Bet=p.gold
						else
							usr<<"Your bet is [Bet]. Awaiting [p]'s response..."
						ArenaForestList+=usr
						usr.AskForArena(p,"Forest",Bet)
						usr.choosing=0
				if("Mountain")
					var/count=MountainList.len
					if(count>0)
						usr<<"This arena is currently in use."
						goto selectarena
					else
						makebet
						var/Bet = input("How much would you like to bet? (Maximum bet is [p.gold])","Wager",usr.Wager) as num
						if(Bet<0) Bet=0
						Bet=round(Bet)
						if(Bet>usr.gold)
							usr<<"You don't have enough gold."
							goto makebet
						else if(!Bet)
							usr<<"No wager has been made.  Awaiting [p]'s response..."
						else if(Bet>p.gold)
							usr<<"The wager has been automatically set to [p.gold], because that's all \he has on \him."
							Bet=p.gold
						else
							usr<<"Your bet is [Bet]. Awaiting [p]'s response..."
						MountainList+=usr
						usr.AskForArena(p,"Mountain",Bet)
						usr.choosing=0

//-------------- [ Arena Confirmation ] ----------------
mob/proc/AskForArena(mob/M,var/A,var/W)
	set waitfor = 0
	switch(input(M,"[src] has challenged you to a fight in the [A] arena.  A wager of [W] has been placed on this fight.","Arena Challenge")in list("Accept Challenge","Decline Challenge"))
		if("Accept Challenge")
			if(usr.jailed||M.jailed)
				src<<"<b>One of the players is currently in jail.</b>"; M<<"<b>One of the players is currently in jail.</b>"
				RiverList-=src; IslandsList-=src; TropicalList-=src; DesertList-=src; WarehouseList-=src; ArenaForestList-=src; MountainList-=src
				return
			else
				src<<"<b>[M] has accepted your challenge! Entering arena...</b>"; M<<"<b>You have accepted [src]'s challenge! Entering arena...</b>"
				Arena=1; M.Arena=1
				M.rival=src; rival=M
				M.Wager=W; Wager=W
				ChoiceCheck(src,M,A)
				spawn(40)
					M.gold-=M.Wager; gold-=Wager
					StatUpdate_gold(); M.StatUpdate_gold()
					SpawnArena(src,M,A)
					world<<"<b>[src] and [M] have entered the [A] arena!</b>"
		if("Decline Challenge")
			src<<"<b>[M] has declined your challenge.</b>"
			RiverList-=src; IslandsList-=src; TropicalList-=src; DesertList-=src; WarehouseList-=src; ArenaForestList-=src; MountainList-=src
			return

mob/proc/ChoiceCheck(mob/M,var/A)
	if(A=="River") RiverList+=M
	if(A=="Islands") IslandsList+=M
	if(A=="Tropical") TropicalList+=M
	if(A=="Desert") DesertList+=M
	if(A=="Warehouse") WarehouseList+=M
	if(A=="Forest") ArenaForestList+=M
	if(A=="Mountain") MountainList+=M

//----------------- [ Arena Spawning ] -------------------
proc
	SpawnArena(mob/Q,mob/M,var/A)
		Q.protect=0; Q.onwater=0; Q.onmountain=0; Q.onsand=0
		M.protect=0; M.onwater=0; M.onmountain=0; M.onsand=0
		Q.SavedLocation=Q.loc; Q.SavedPlace=Q.ZCoord
		M.SavedLocation=M.loc; M.SavedPlace=M.ZCoord
		M.ZCoord="[A] Arena"; Q.ZCoord="[A] Arena"
		M.ZCoordProc(M.ZCoord); Q.ZCoordProc(Q.ZCoord)
		M.ArenaLosses++; Q.ArenaLosses++
		var
			spawns=list()
		var/obj
			S1; S2
		if(A=="River")
			for(var/obj/ArenaChallengeSpawns/River/s in world) spawns+=s
			S1=pick(spawns); spawns-=S1; S2=pick(spawns)
		if(A=="Islands")
			for(var/obj/ArenaChallengeSpawns/Islands/s in world) spawns+=s
			S1=pick(spawns); spawns-=S1; S2=pick(spawns)
		if(A=="Tropical")
			for(var/obj/ArenaChallengeSpawns/Tropical/s in world) spawns+=s
			S1=pick(spawns); spawns-=S1; S2=pick(spawns)
		if(A=="Desert")
			for(var/obj/ArenaChallengeSpawns/Desert/s in world) spawns+=s
			S1=pick(spawns); spawns-=S1; S2=pick(spawns)
		if(A=="Warehouse")
			for(var/obj/ArenaChallengeSpawns/Warehouse/s in world) spawns+=s
			S1=pick(spawns); spawns-=S1; S2=pick(spawns)
		if(A=="Forest")
			for(var/obj/ArenaChallengeSpawns/Forest/s in world) spawns+=s
			S1=pick(spawns); spawns-=S1; S2=pick(spawns)
		if(A=="Mountain")
			for(var/obj/ArenaChallengeSpawns/Mountain/s in world) spawns+=s
			S1=pick(spawns); spawns-=S1; S2=pick(spawns)
		Q.loc=S1.loc; M.loc=S2.loc; ArenaCheck(Q,M,A); ArenaTimeUpCheck(Q,M,40)
		for(var/area/E in oview(0,M)) E.Entered(M)
		for(var/area/E in oview(0,Q)) E.Entered(Q)

	ArenaTimeUpCheck(mob/Q,mob/M,var/T)
		if(Q&&M&&(Q.Arena||M.Arena))
			T--
			if(T)
				spawn(60) ArenaTimeUpCheck(Q,M,T)
			else
				RiverList=new/list; IslandsList=new/list; TropicalList=new/list; DesertList=new/list; WarehouseList=new/list; ArenaForestList=new/list; MountainList=new/list
				Q.gold+=Q.Wager; Q<<"<b>Time Up!</b>"; Q.SpawnWhere()
				M.gold+=M.Wager; M<<"<b>Time Up!</b>"; M.SpawnWhere()
				Q.StatUpdate_gold(); M.StatUpdate_gold()
//----------------- [ Arena Checking ] -------------------
	ArenaCheck(mob/Q,mob/M,var/A)
		if(Q&&M)
			if(Q.dead||Q.protect)
				RiverList=new/list; IslandsList=new/list; TropicalList=new/list; DesertList=new/list; WarehouseList=new/list; ArenaForestList=new/list; MountainList=new/list
				M.ArenaWin(A,Q); RiverList-=Q; RiverList-=M
			else if(M.dead||M.protect)
				RiverList=new/list; IslandsList=new/list; TropicalList=new/list; DesertList=new/list; WarehouseList=new/list; ArenaForestList=new/list; MountainList=new/list
				Q.ArenaWin(A,M); RiverList-=Q; RiverList-=M
			else
				spawn(20) ArenaCheck(Q,M,A)
		else
			RiverList=new/list; IslandsList=new/list; TropicalList=new/list; DesertList=new/list; WarehouseList=new/list; ArenaForestList=new/list; MountainList=new/list
			if(Q&&!M) {Q.ArenaWin(A); RiverList-=Q}
			if(M&&!Q) {M.ArenaWin(A); RiverList-=M}

mob/proc/ArenaWin(var/A,mob/Loser)
	RiverList=new/list; IslandsList=new/list; TropicalList=new/list; DesertList=new/list; WarehouseList=new/list; ArenaForestList=new/list; MountainList=new/list
	ArenaLosses--; ArenaWins++
	Arena_RatioCheck(); Medal_Gladiator()
	if(Loser) Loser<<"<b>You lost the Arena Challenge!</b>"
	src<<"<b>You won the Arena Challenge!</b>"
	gold+=round(Wager*2); StatUpdate_gold()
	for(var/area/a in oview(0,src)) a.Exited(src)
	Wager=null; Arena=null; ReSpawn()
	world<<"<b>[src] has beaten [rival] in the [A] arena!</b>"
