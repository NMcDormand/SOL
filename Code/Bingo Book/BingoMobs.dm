obj/var/tmp/Link
mob/var/tmp/clicked
obj/BingoBook
	icon='Ranks.dmi'
	Click()
		if(usr.clicked) return
		usr.clicked=1; spawn(10) usr.clicked=0
		var/mob/m=Link
		if(!m.Bounty) m.Bounty=new()
		usr<<output("\icon [AcquireSelfImage(m)]","BingoBook.Criminal_Image")
		usr<<output("[m.name]","BingoBook.Criminal_Name")
		usr<<output("[Rank_Calculator(m)] Rank","BingoBook.Criminal_Rank")
		if(KageMob[m.Village]==m) usr<<output("[m.Bounty[usr.Village]*2]","BingoBook.Criminal_Bounty")
		else usr<<output("[m.Bounty[usr.Village]]","BingoBook.Criminal_Bounty")
		usr<<output("[m.Village]","BingoBook.Criminal_Village")
		usr<<output("[m.Speciality]","BingoBook.Criminal_Specialty")
		var/PList = "None"
		if(!m.Class["None"])
			for(var/P in m.Class)
				if(m.Class[P])
					if(!PList)
						PList = "[P]"
					else
						PList += ", [P]"
		usr<<output("[PList]","BingoBook.Criminal_Profession")
		usr<<output("[m.Clan]","BingoBook.Criminal_Clan")
	pic