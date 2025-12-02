var/list
	BingoBook[0]
mob/var
	Bounty[0]
	BingoBookAssociations[0]
	LastBingoKill
proc
	BingoBook_Check(mob/victim,mob/killer)
		var/kb=Bounty_Calculator(killer,victim)
		if(!killer)
			return
		if(!killer.Bounty) killer.Bounty=new()
		if(!killer.BingoBookAssociations) killer.BingoBookAssociations=new()
		if(!victim.BingoBookAssociations) victim.BingoBookAssociations=new()
		if(!BingoBook) BingoBook=new()
		if(istype(killer,/mob/player/) && (victim.OverWorldKillMe()))
			if((victim.InVillage==victim.Village)||(!(victim in killer.Provoke)&&killer.InVillage!=killer.Village))
				if(victim.Village==killer.Village) return
				killer.Bounty[victim.Village]+=kb; killer.BingoBookAssociations[victim.Village]=TRUE
				if(!(killer in BingoBook)) BingoBook+=killer
				for(var/mob/p in MasterPlayerList)
					if(p.Village==victim.Village) p.UpdateBingoBook()
			if((victim in BingoBook)&&(victim.BingoBookAssociations[killer.Village]))
				world<<"[victim] killed by [killer]"
				BingoBook-=victim; victim.BingoBookAssociations[killer.Village]=FALSE
				killer.gold+=victim.Bounty[killer.Village]
				if(killer.LastBingoKill != victim.trueName)
					switch(Rank_Calculator(victim))
						if("S")
							killer.MissionsComplete["A"]+=2
							killer.MissionPoints+=round(AMPREWARD*1.5)
							killer.AwardVP(6)
							world << "[killer.trueName] has killed the infamous S Rank ninja [victim.trueName]"
						if("A")
							killer.MissionsComplete["A"]++
							killer.MissionPoints+=AMPREWARD
							killer.AwardVP(3)
						if("B")
							killer.MissionsComplete["B"]++
							killer.MissionPoints+=BMPREWARD
							killer.AwardVP(2)
						if("C")
							killer.MissionsComplete["C"]++
							killer.MissionPoints+=CMPREWARD
							killer.AwardVP(1)
						if("D")
							killer.MissionsComplete["D"]++
							killer.MissionPoints+=DMPREWARD
							killer.AwardVP(0.5)
				killer.LastBingoKill = victim.trueName
				killer<<"[victim] was \an [Rank_Calculator(victim)] ranked criminal in your Bingo Book and you have been rewarded with [victim.Bounty[killer.Village]] gold."
				victim.Bounty[killer.Village]=0
				killer.StatUpdate_gold()
				for(var/mob/p in MasterPlayerList)
					if(p.Village==killer.Village) p.UpdateBingoBook()
				victim.UpdateBingoBook()
				victim.BB_LoginCheck()

	Rank_Calculator(mob/k)
		var/t=k.TaijutsuTrue+k.NinjutsuTrue+k.GenjutsuTrue
		t = max(t,3)
		switch(t)
			if(3 to 8000)
				if(k.NinjaRank=="Chuunin") return "C"
				else return "D"
			if(8001 to 45000)
				if(k.NinjaRank=="Special Jounin") return "B"
				else return "C"
			if(45001 to 100000)
				if(k.NinjaRank=="Anbu"||k.NinjaRank=="Jounin") return "A"
				else return "B"

			if(100001 to 170000)
				if(k.NinjaRank=="Kage Level") return "S"
				else return "A"
			else return "S"

	Bounty_Calculator(mob/k,mob/v)
		if(k)
			var/b=0
			if(istype(k,/mob/player))
				switch(Rank_Calculator(k))
					if("S") b += 150
					if("A") b += 80
					if("B") b += 40
					if("C") b += 20
					if("D") b += 10
				if(v&&v.Village==k.Village) b += 5
				if(v&&v.InVillage==v.Village) b += 80
			return b

mob
	proc
		BB_LoginCheck()
			set waitfor = 0
			if(!BingoBook) BingoBook=new()
			if(!BingoBookAssociations) BingoBookAssociations=new()
			for(var/a in BingoBookAssociations)
				if(BingoBookAssociations[a])
					if(!(src in BingoBook)) BingoBook+=src
					break

		VillageChecker()
			set waitfor = 0
			var/list/viable_targets=list()
			for(var/mob/m in MasterPlayerList)
				if(!m.BingoBookAssociations) m.BingoBookAssociations=new
				if(m.BingoBookAssociations[Village]&&!(m in viable_targets)) viable_targets+=m
			return viable_targets

	verb
		BingoBookButtonClose()
			set hidden=1
			winshow(usr,"BingoBook",0)
