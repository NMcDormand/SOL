mob/var/tmp/VOOC=1
mob
	var
		IgnoreVillageInvite = 0
mob/player
	proc
		OfferVillage(mob/M, Vill)
			if(alert(src,"[M.trueName] has invited you to join the [M.Village] Village, doing so will relinquish all rights and titles you currently hold","Village Invite","Yes","No") == "Yes")
				var/VC = 0
				switch(Vill)
					if("Cloud")
						Village="Cloud"; spawnwhere="Cloud";
						VC="#dbef7f"
					if("Leaf")
						Village="Leaf"; spawnwhere="Leaf";
						VC="#e92106"
					if("Mist")
						Village="Mist"; spawnwhere="Mist";
						VC="#1048ff"
					if("Rock")
						Village="Rock"; spawnwhere="Rock";
						VC="#85663d"
					if("Sand")
						Village="Sand"; spawnwhere="Sand";
						VC="#dea700"
					if("Grass")
						Village="Grass"; spawnwhere="Grass";
						VC="#91aa33"
					if("Rain")
						VC="#77DDFF"
					if("Sound")
						Village="Sound"; spawnwhere="Sound";
						VC="#800040"
					if("Waterfall")
						Village="Waterfall"; spawnwhere="Waterfall";
						VC="#a2a2c8"
				if(!CustomSayColour)
					VillageColour = VC
				world << "<h2 style=\"color:[VC]\">[trueName] has joined the [Vill] Village</h2>"
			else
				if(M)
					M << "[trueName] has rejected your invitation"

mob/VerbHolder/Kage/verb
	Invite_To_Village(var/mob/player/M in MasterPlayerList)
		set category="Kage"
		set desc="Invite players to your village."
		if(M)
			if(Rank2Num(M.NinjaRank) >= 7)
				usr << "[M] is currently too valuable to leave their village"
				return
			if(M.IgnoreVillageInvite)
				usr << "[M] is not interested in switching villages"
				return
			M.OfferVillage(usr,usr.Village)

	AssignVillagePoints()
		set name="Kage: Setup Village Boost"
		set category="Kage"
		set desc="Modify the training boosts for your village."
		switch(winget(usr, "VillagePoints", "is-visible"))
			if("true")
				winshow(usr,"VillagePoints",0)
			if("false")
				var/CV = "[Village]Cur"
				VillagePoints[CV] = 0
				TaiBoost[CV] = 0
				NinBoost[CV] = 0
				GenBoost[CV] = 0
				StamBoost[CV] = 0
				ChakBoost[CV] = 0
				SkillBoost[CV] = 0
				PEBoost[CV] = 0
				SEBoost[CV] = 0
				RFXBoost[CV] = 0

				winset(usr,"VillagePoints.VillagePointsRemaining", "text=[VillagePoints[Village]]")
				winset(usr,"VillagePoints.Stamina","value=[(StamBoost[Village])*BarRatio]")
				winset(usr,"VillagePoints.Chakra","value=[(ChakBoost[Village])*BarRatio]")
				winset(usr,"VillagePoints.Ninjutsu","value=[(NinBoost[Village])*BarRatio]")
				winset(usr,"VillagePoints.Genjutsu","value=[(GenBoost[Village])*BarRatio]")
				winset(usr,"VillagePoints.Taijutsu","value=[(TaiBoost[Village])*BarRatio]")
				winset(usr,"VillagePoints.Primary","value=[(PEBoost[Village])*BarRatio]")
				winset(usr,"VillagePoints.Secondary","value=[(SEBoost[Village])*BarRatio]")
				winset(usr,"VillagePoints.Skills","value=[(SkillBoost[Village])*BarRatio]")
				winset(usr,"VillagePoints.Reflexes","value=[(RFXBoost[Village])*BarRatio]")

				winshow(usr,"VillagePoints",1)

	ApplyVillageBoost()
		set hidden=1
		var/CV = "[Village]Cur"
		VillagePoints[Village] -= VillagePoints[CV]

		TaiBoost[Village] += TaiBoost[CV]
		NinBoost[Village] += NinBoost[CV]
		GenBoost[Village] += GenBoost[CV]
		StamBoost[Village] += StamBoost[CV]
		ChakBoost[Village] += ChakBoost[CV]
		SkillBoost[Village] += SkillBoost[CV]
		PEBoost[Village] += PEBoost[CV]
		SEBoost[Village] += SEBoost[CV]
		RFXBoost[Village] += RFXBoost[CV]

		VillagePoints[CV] = 0
		TaiBoost[CV] = 0
		NinBoost[CV] = 0
		GenBoost[CV] = 0
		StamBoost[CV] = 0
		ChakBoost[CV] = 0
		SkillBoost[CV] = 0
		PEBoost[CV] = 0
		SEBoost[CV] = 0
		RFXBoost[CV] = 0

		RefreshVillagersBoosts(usr)

mob/VerbHolder/Kage2/verb
	VillageAnnounce(msg as text)
		set category="Kage"
		set name="Kage: Village Announce"
		set desc="Announce something to those from your village."
		for(var/H in extreme_profanity)
			if(findtext(msg,H))
				usr<< "Deducted [round(usr.StaminaTrue*0.01)] Maximum Stamina for bad language."
				var/deduct=round(usr.StaminaTrue*0.01)
				usr.Stamina-=deduct; usr.StaminaMax-=deduct; usr.StaminaTrue-=deduct
		if(msg)
			if(!usr.Villagelistenooc) Villagelistenooc=1
			msg=cuttext(msg)
			usr.speakcheck()
			usr.spamrate++; spawn(50)usr.spamrate--
			if(usr.spamrate>=5)
				usr<<"<font color=red>The following was not posted because you exceeded the spam rate:</font> '[msg]'"
				usr.VOOC=null; spawn(100)usr.VOOC=1
				return
			else
				for(var/mob/player/M in MasterPlayerList)
					if(M.Village==usr.Village)
						M<<output("<font size=2 color=[VillageColour]>Village Announce - [usr.Brand]<b>[usr]:</b></font>  [html_encode(msg)]","Chat")

	ModifyBingoBook()
		set category="Kage"
		set name="Kage: Modify Bingo Book"
		switch(input("What would you like to do?","Modify Bingo Book") as null|anything in list("Add Ninja","Remove Ninja","Increase Bounty"))
			if("Add Ninja")
				switch(alert("This will cost 10,000 gold (+ bounty), do you want to proceed?","Add Ninja","Yes","No"))
					if("Yes")
						var/list/people=list()
						for(var/mob/player/p in MasterPlayerList)
							if(p.Village!=usr.Village&&p.NinjaRank!="Academy Student"&&!BingoBookAssociations[usr.Village]) people+=p
						var/mob/m=input("Add whom?","Add Ninja to Bingo Book") as null|anything in people
						if(m)
							if(usr.gold<10000) {usr<<"Adding ninja to the Bingo Book costs 10,000 ryo"; return}
							var/bounty=input("What shall their bounty be?","Add Ninja to Bingo Book") as null|num
							if(!bounty||bounty<0) bounty=0
							if(bounty>(usr.gold+10000)) bounty=(usr.gold-10000)
							bounty=round(bounty); usr.gold-=(10000+bounty)
							m.Kage_AddToBB(usr.Village,bounty)
							usr<<"[m] added to [usr.Village]'s Bingo Book with a bounty of [bounty] gold."
							for(var/mob/player/v in MasterPlayerList)
								if(v.Village==usr.Village&&v!=usr) v<<"<b>Your [usr.NinjaRank]: <i>[usr]</i> has just added [m] to the [usr.Village]'s Bingo Book, and set his bounty at <u>[bounty]</u> gold.</b>"
							m<<"<b>The [usr.NinjaRank] of [usr.Village] has just put a bounty on your head for <u>[bounty]</u> gold!</b>"
							m.Popup("add bingo book",usr,,10)
							for(var/mob/p in MasterPlayerList)
								if(p.Village==usr.Village) p.UpdateBingoBook()
							m.UpdateBingoBook()
			if("Remove Ninja")
				switch(alert("This will cost 50,000 gold (+ bounty), do you want to proceed?","Add Ninja","Yes","No"))
					if("Yes")
						var/list/people=list()
						for(var/mob/player/p in BingoBook)
							if(BingoBookAssociations[usr.Village]) people+=p
						var/mob/m=input("Remove whom?","Remove Ninja from Bingo Book") as null|anything in people
						if(m)
							if(!m.Bounty) m.Bounty=new()
							if(usr.gold<(50000+m.Bounty[usr.Village])) {usr<<"Removing this ninja from the Bingo Book will cost [50000+m.Bounty[usr.Village]] gold"; return}
							usr.gold-=(50000+m.Bounty[usr.Village])
							m.Kage_RemoveFromBB(usr.Village)
							usr<<"[m] has been removed from [usr.Village]'s Bingo Book successfully."
							for(var/mob/player/v in MasterPlayerList)
								if(v.Village==usr.Village&&v!=usr) v<<"<b>Your [usr.NinjaRank]: <i>[usr]</i> has just pardoned [m] from the [usr.Village]'s Bingo Book!</b>"
							m<<"<b>The [usr.NinjaRank] of [usr.Village] has just pardoned you!</b>"
							for(var/mob/p in MasterPlayerList)
								if(p.Village==usr.Village) p.UpdateBingoBook()
							m.UpdateBingoBook()
			if("Increase Bounty")
				switch(alert("This will cost 5,000 gold (+ bounty), do you want to proceed?","Increase Bounty","Yes","No"))
					if("Yes")
						var/list/people=list()
						for(var/mob/player/p in BingoBook)
							if(BingoBookAssociations[usr.Village]) people+=p
						var/mob/m=input("Increase whose bounty?","Increase Bounty") as null|anything in people
						if(m)
							if(!m.Bounty) m.Bounty=new()
							if(usr.gold<5000) {usr<<"Increasing bounties costs 5,000 gold each time"; return}
							var/bounty=input("How much would you like to increase [m]'s bounty by?","Add Ninja to Bingo Book") as null|num
							if(!bounty) bounty=0
							if(bounty>(usr.gold+5000)) bounty=(usr.gold-5000)
							bounty=round(bounty); usr.gold-=(5000+bounty)
							m.Bounty[usr.Village]+=bounty
							usr<<"[m]'s bounty has been increased by [bounty] and is now sitting at [m.Bounty[usr.Village]]."
							for(var/mob/player/v in MasterPlayerList)
								if(v.Village==usr.Village&&v!=usr) v<<"<b>Your [usr.NinjaRank]: <i>[usr]</i> has just added <u>[bounty]</u> gold to the [m]'s bounty! It is now [m.Bounty[usr.Village]] gold!"
							m<<"<b>The [usr.NinjaRank] of [usr.Village] has just increased the bounty on your head by <u>[bounty]</u> gold!</b>"
							m.Popup("increase bingo book",usr,,10)
							for(var/mob/p in MasterPlayerList)
								if(p.Village==usr.Village) p.UpdateBingoBook()
							m.UpdateBingoBook()

mob/proc
	Kage_AddToBB(VILLAGE,bounty)
		if(!(src in BingoBook)) BingoBook+=src
		Bounty[VILLAGE]+=bounty; BingoBookAssociations[VILLAGE]=TRUE
	Kage_RemoveFromBB(VILLAGE)
		if(!Bounty) Bounty=new()
		if(!BingoBookAssociations) BingoBookAssociations=new()
		if((src in BingoBook)) BingoBook-=src
		Bounty[VILLAGE]=0; BingoBookAssociations[VILLAGE]=FALSE
		BB_LoginCheck()
