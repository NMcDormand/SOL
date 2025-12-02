mob/var/tmp
	Yield; Yielded
	YieldList=list()

obj/SkillCards/Starter/Yield
	icon='Card_Icons.dmi'
	icon_state="yield"
	JutsuType = "Other"
	cmdstring="Yield"
	CanLevel = 0
	Description = list(
		"about"="Submit to the authorities if you are being attacked for breaking the law."
		,"title"="Yield"
		,"type"="Other"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="E"
//		,"pic"='Rest.png'
	)

	Activate(mob/U)
		if(!U.Yield)
			U.Yield=1; spawn(20) U.Yield=0
			if(U.icon_state != "swim")
				U.icon_state="block"
				spawn(10)
					if(U)
						U.icon_state=null

mob/proc

	YieldCheck(mob/Y)
		if(Y&&Y.Yield)
			if(Y&&Wounds<20)
				Y<<"[src] accepts your yield.";Wounds=0
				return 1
			else if(Y&&Wounds>=20)
				Y<<"[src] refuses your yield!"
				return 0

	VillageYieldCheck(mob/Y)
		if(Y&&Y.Yield)
			if(!Y.Bounty) Y.Bounty=new()
			if(!Y.BingoBookAssociations) Y.BingoBookAssociations=new()
			if(!BingoBook) BingoBook=new()
			if(!Y.BingoBookAssociations[Village])
				if(Wounds<30&&Y) {Y<<"[src] accepts your yield."; YieldList+=Y}
				else if(Wounds>30&&Y) Y<<"[src] refuses your yield!"
			else if(Y.BingoBookAssociations[Village])
				if(Y.Bounty[Village]>=5000)
					Y<<"[src] refuses your yield because your bounty is too high!"
				else if(Y.gold>=Y.Bounty[Village])
					Y<<"[src] accepts your yield and you pay fines of [Y.Bounty[Village]] gold."
					Y.gold-=Y.Bounty[Village]; Y.Bounty[Village]=0; Y.BingoBookAssociations[Village]=FALSE
					for(var/mob/L in LeafNinList) if(!(L in L.YieldList)) L.YieldList+=Y
					Y.StatUpdate_gold()
				else if(Y) Y<<"[src] refuses your yield because you cannot afford the fines!"