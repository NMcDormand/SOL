mob/proc
	BountyMission()
		switch(input("How can I help?","Mission Man")as null|anything in list("What do I have to do?","I'm here to collect my bounty"))
			if("What do I have to do?")
				src<<{"Mission Man: <i>"You will be given 150 gold for each Missing-Nin you kill.</i>""}
				src.Talking=0
				return
			if("I'm here to collect my bounty")
				src.Talking=0
				var/bounty=src.Kills["CurMissingNin"]*150
				src.MissionsComplete["B"]+=src.Kills["CurMissingNin"]

				MissionPoints+=BMPREWARD * Kills["CurMissingNin"]

				src.MissionsComplete["Total"]+=src.Kills["CurMissingNin"]
				src.gold+=bounty; src.StatUpdate_gold()
				src<<{"Mission Man: <i>"Here's your [bounty] gold."</i>"}
				BB1SP+=Kills["CurMissingNin"]; if(BB1SP>=20) {BB1SP-=20; StatPoints+=4; src.StatUpdate_statpoints(); src<<"<b>Statpoint Earned!</b>"}
				src.Kills["CurMissingNin"]=0
			else src.Talking=0