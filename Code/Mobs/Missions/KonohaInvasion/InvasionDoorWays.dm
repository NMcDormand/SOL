turf/DoorWays/KonohaInvasion
	WaitingRoom
		Entrance
			Enter(mob/M)
				if(istype(M,/mob/player))
					if(KonohaInvasionAccess)
						if(M.KI_Banned)
							M<<"<i>The village has marked you as a traitor! Please speak to your villages S Rank Mission Ninja!</i>"
							return
						if(Rank2Num(M.NinjaRank)>=5 || KageMob[M.Village]==M)
							if(!(M in KI_Participants))
								M<<"<i>Please take your place in the waiting room while we co-ordinate our response team.</i>"
								M.loc = locate(790,18,2); M.protect=1; KI_Participants+=M;
						else {M<<"You must be Anbu Rank or higher to do this quest."; return}
					else {M<<"Cannot enter Quest now"; return}
		Exit
			Enter(mob/M)
				if((M in KI_Participants))KI_Participants-=M
				M.loc=locate(484,191,1); M.protect=0;
	SupplyRoom
		ReadyExit
			Enter(mob/M)
				M.loc=locate(779,20,2)
				if(!ReadyForBattle) ReadyForBattle=new()
				if(!(M in ReadyForBattle)) ReadyForBattle+=M
		ReEnter
			Enter(mob/M)
				M.loc=locate(779,26,2)
				if(!ReadyForBattle) ReadyForBattle=new()
				if((M in ReadyForBattle)) ReadyForBattle-=M