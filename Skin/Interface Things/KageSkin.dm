var
	list/VillageData=list()

Infobox
	var
		Name=""
		Desc=""
		list/Pop=list()

	Village
		var
			Message
			Money
			Missions
			STax	//Sales
			ITax	//Income
			OSTax	//Outsider Sales
			ServTax //Services
			ATax
			MedTax	//Hospital
			Income
			Fame
			Expense
			ANBU
			PANBU
			PCouncil
			Leader
			DoABounty
			NEBU
			CV
			Voting
			ANBULead
			VoteTimer
			FightTimer
			list/Guilds=list()
			list/Council=list()
			list/ANBUL=list()
			list/Leaders=list()
			list/Bounties[]=list()
			list/Standings[]=list()
			list/Masks=list()
			list/POs=list()
			list/Voted=null
			Incumbent
			Trump
			KageMess
			AssHair
			AssColor
			AssSkin
			AssName
			AssEye
			AssGender

mob
	var
		KageUp
	proc
		UStandings(var/Infobox/Village/A)
			var/u=1
			var/x=0
			for(var/M in A.Standings)
				var/H="[M] Village - "
				if(A.Standings[M]=="Ally")
					H="[H]<a style=color:#0066FF>[A.Standings[M]]</a>"
				if(A.Standings[M]=="Pact")
					H="[H]<a style=color:#3399FF>[A.Standings[M]]</a>"
				if(A.Standings[M]=="Peace")
					H="[H]<a style=color:#008000>[A.Standings[M]]</a>"
				if(A.Standings[M]=="Hostile")
					H="[H]<a style=color:#FF3300>[A.Standings[M]]</a>"
				if(A.Standings[M]=="War")
					H="[H]<a style=color:#FF0000>[A.Standings[M]]</a>"
				usr<<output("[H]","KPage2.grid3:[++x],[u]")
				if(x==2)
					x=0
					u++

	verb
		KageButtons(J as num)
			set hidden=1
			switch(J)
				if(1)
					return
				if(2)

				if(3)

				if(4)

				if(5)

				if(6)
					var/Infobox/Village/A=VillageData["[usr.Village]Label"]
					var/list/L=list()
					for(var/M in A.Standings)
						if(A.Standings[M]=="Peace"||A.Standings[M]=="Hostile")
							L+=M
					var/H=input("Which village would you like to declare war on?")in L+list("Cancel")
					if(H!="Cancel")
						A.Standings[H]="War"
						var/Infobox/Village/R=VillageData["[H]Label"]
						R.Standings[A.Name]="War"
						UStandings(A)

				if(7)
					var/Infobox/Village/A=VillageData["[usr.Village]Label"]
					var/list/L=list()
					for(var/M in A.Standings)
						if(A.Standings[M]=="War"||A.Standings[M]=="Hostile")
							L+=M
					var/H=input("Which village would you like to make peace with?")in L+list("Cancel")
					if(H!="Cancel")
						var/Infobox/Village/B=VillageData["[H]Label"]
						var/mob/M=null
						for(var/mob/G in MasterPlayerList)
							if(G.trueName==B.Leader)
								M=G
								break
						if(M)
							var/G=alert(M,"[usr.trueName] leader of [usr.Village] has asked to make peace, how do you respond?","Peace","Yes","No")
							if(G=="Yes")
								A.Standings[H]="Peace"
								var/Infobox/Village/R=VillageData["[H]Label"]
								R.Standings[A.Name]="Peace"
								UStandings(A)
								usr<<"[M.trueName] has accepted your offer of peace"
						else
							B.POs[A.Name]="Peace"
							usr<<"A message of peace has been sent to [B.Name]"
				if(8)
					var/Infobox/Village/A=VillageData["[usr.Village]Label"]
					var/list/L=list()
					for(var/M in A.Standings)
						if(A.Standings[M]=="Peace")
							L+=M
					var/H=input("Which village would you like to form a pact with?")in L+list("Cancel")
					if(H!="Cancel")
						var/Infobox/Village/B=VillageData["[H]Label"]
						var/mob/M=null
						for(var/mob/G in MasterPlayerList)
							if(G.trueName==B.Leader)
								M=G
								break
						if(M)
							var/G=alert(M,"[usr.trueName] leader of [usr.Village] has asked to form a defensive pact, how do you respond?","Pact","Yes","No")
							if(G=="Yes")
								A.Standings[H]="Pact"
								var/Infobox/Village/R=VillageData["[H]Label"]
								R.Standings[A.Name]="Pact"
								UStandings(A)
								usr<<"[M.trueName] has agreed to form a pact with you"
						else
							B.POs[A.Name]="Pact"
							usr<<"A message to form a pact has been sent to [B.Name]"
				if(9)
					var/Infobox/Village/A=VillageData["[usr.Village]Label"]
					var/list/L=list()
					for(var/M in A.Standings)
						if(A.Standings[M]=="Pact")
							L+=M
					var/H=input("Which village would you like to forge an alliance with?")in L+list("Cancel")
					if(H!="Cancel")
						var/Infobox/Village/B=VillageData["[H]Label"]
						var/mob/M=null
						for(var/mob/G in MasterPlayerList)
							if(G.trueName==B.Leader)
								M=G
								break
						if(M)
							var/G=alert(M,"[usr.trueName] leader of [usr.Village] has asked to forge an alliance, how do you respond?","Alliance","Yes","No")
							if(G=="Yes")
								A.Standings[H]="Ally"
								var/Infobox/Village/R=VillageData["[H]Label"]
								R.Standings[A.Name]="Ally"
								UStandings(A)
								usr<<"[M.trueName] has forged an alliance with you"
						else
							B.POs[A.Name]="Ally"
							usr<<"A message requesting an alliance been sent to [B.Name]"

		KButt(T as num)
			set hidden=1
			KageUp=null
			winset(src,"Kage","is-visible=false")
			winset(src,"Kage.child3","is-visible=false")
			winset(src,"Kage.child4","is-visible=false")
			winset(src,"Kage.child2","is-visible=true")
			winset(src,"Kage.button89","is-visible=true")
			winset(src,"Kage.button90","is-visible=false")

			switch(T)
				if(2)
					var/Infobox/Village/A=VillageData["[usr.Village]Label"]
					var/a=params2list(winget(src,"KPage2.input7;KPage2.input9;KPage2.input10;KPage2.input11;KPage2.input12;KPage2.input13;KPage2.input14","text"))
					var/b=params2list(winget(src,"KPage3.button95;KPage3.button96;KPage3.button97;KPage3.button98;KPage3.button99;KPage3.button100;KPage3.button101;KPage3.button102;KPage3.input103","is-checked"))

					if(b["KPage2.button95.is-checked"]=="true")
						A.NEBU="Villagers"
					if(b["KPage2.button96.is-checked"]=="true")
						A.NEBU="Allies"
					if(b["KPage2.button97.is-checked"]=="true")
						A.NEBU="Outsiders"

					if(b["KPage2.button101.is-checked"]=="true")
						A.CV="Allies"
					if(b["KPage2.button102.is-checked"]=="true")
						A.CV="Outsiders"
					if(b["KPage2.button103.is-checked"]=="true")
						A.CV="None"

		TurnKPage(T as num)
			set hidden=1
			switch(T)
				if(1)
					if(KageUp=="Page1")
						winset(src,"Kage.child2","is-visible=false")
						winset(src,"Kage.child3","is-visible=true")
						winset(src,"Kage.button90","is-visible=true")
						winset(src,"Kage.button89","is-visible=false")
						KageUp="Page2"
					winset(src,"Kage.button89","is-checked=false")
				if(2)
					if(KageUp=="Page2")
						winset(src,"Kage.child2","is-visible=true")
						winset(src,"Kage.child3","is-visible=false")
						winset(src,"Kage.button90","is-visible=false")
						winset(src,"Kage.button89","is-visible=true")
						KageUp="Page1"

		Check_Village()
			if(KageUp!=null)
				return
			winset(src,"Kage","is-visible=true")
			KageUp="Page1"
			var/Infobox/Village/A=VillageData["[usr.Village]Label"]
			var/i=1
			var/c=0
			for(var/M in A.Pop)
				usr<<output(M,"KPage1.VilPop:[++c],[i]")
				if(c==3)
					c=0
					i++

			if(A.Guilds.len>0)
				var/o=1
				var/v=0
				for(var/M in A.Guilds)
					usr<<output(M,"KPage1.GuildOut:[++v],[o]")
					if(v==3)
						v=0
						o++
			else
				usr<<output("None","KPage1.GuildOut:1,1")

			winset(src,"KPage1.PopOutput","text=[A.Pop.len]")
			winset(src,"KPage1.VilOverview","text=[Village]+Village+Overview")
			winset(src,"KPage1.FundOut","text=[A.Money]")
			winset(src,"KPage1.FameOutput","text=[A.Fame]")
			winset(src,"KPage2.input14","text=[A.Message]")

			UStandings(A)