mob/var/tmp/GuildWarChallenge
mob/VerbHolder/Guild/CoLeader/verb
	InitiateGuildWar()
		set hidden=1
		if(usr.GuildWarChallenge) {usr<<"You have challenged someone recently."; return}
		var
			GList=list(); MList=list()
		usr.GuildWarChallenge=1
		for(var/mob/player/M in world)
			if(M.InGuild&&M.Guild!=usr.Guild&&(M.GuildLeader||M.CoLeader)) {GList+="[M.Guild]"; MList+=M}
		var/g=input("Which guild will you declare war on?","Guild War") as null|anything in GList
		if(g)
			var/LList=list()
			spawn(600) usr.GuildWarChallenge=0
			for(var/mob/player/p in MList)
				if(p.Guild==g) LList+=p
			var/mob/E=pick(LList)
			switch(alert(E,"[usr] wishes to initiate a Guild War with [E.GuildHTML]; do you accept?","Guild War","Yes","No"))
				if("Yes")
					usr<<"[E] has accepted the challenge; prepare for war."
					GuildWar(usr,E)
				if("No")
					usr<<"[E] has declined the challenge"
		else usr.GuildWarChallenge=0


	Whole_Guild_Mute()
		set hidden=1
		switch(input("Mute entire guild (except guild leaders)?","Guild Mute")in list("Mute","Unmute"))
			if("Mute")
				for(var/mob/M in world)
					if(M.Guild==usr.Guild)
						M<<output("<font color=#bf1600>[usr] has muted the whole guild.</font>","Guild Chat")
						if(!M.GuildLeader&&!M.CoLeader) M.GuildMute=1
			if("Unmute")
				for(var/mob/M in world)
					if(M.Guild==usr.Guild)
						M<<output("<font color=#bf1600>[usr] has unmuted the whole guild.</font>","Guild Chat")
						M.GuildMute=0

//------------------------------------------------------------------------------------------------------------
	Ind_Guild_Mute(mob/M in world)
		set hidden=1

		switch(input("Mute or Unmute?","Guild Mute")in list("Mute","Unmute"))
			if("Mute")
				if(M.Guild==usr.Guild)
					if(!M.GuildLeader || !M.CoLeader)
						usr<<"<font color=#bf1600>[M] has been guild-muted.</font>"
						M<<output("<font color=#bf1600>[usr] has guild-muted you.</font>","Guild Chat")
						M.IndGuildMute=1
						return
					else
						if(!usr.GuildLeader)
							usr<<"<font color=#bf1600>Cannot mute Guild Leaders.</font>"; return
						else
							usr<<"<font color=#bf1600>[M] has been guild-muted.</font>"
							M<<output("<font color=#bf1600>[usr] has guild-muted you.</font>","Guild Chat")
							M.IndGuildMute=1
							return
				else
					usr<<"<font color=#bf1600>They're not in [usr.GuildHTML].</font>"; return

			if("Unmute")
				if(M.Guild==usr.Guild)
					usr<<"<font color=#bf1600>[M] has been guild-unmuted.</font>"
					M<<output("<font color=#bf1600>[usr] has guild-unmuted you.</font>","Guild Chat")
					M.IndGuildMute=0
					return
				else
					usr<<"<font color=#bf1600>They're not in [usr.GuildHTML].</font>"; return


//------------------------------------------------------------------------------------------------------------
	guildBoot()
		set hidden=1
		var/Blist=list()
		for(var/mob/player/P in world)
			if(P.Guild==usr.Guild)
				Blist+=P
		Blist-=usr
		var/mob/boot=input("Who would you like to boot from [usr.Guild]?","Guild Boot")as null|anything in Blist
		if(boot)
			switch(input("Are you sure you want to boot [boot] from [usr.Guild]?","Guild Boot")in list("Boot","Don't Boot"))
				if("Boot")
					if(!boot.GuildLeader&&!boot.CoLeader)
						switch(input("Are you sure you want to boot [boot]?","Guild Boot")in list("Yes, I'm sure","Don't Boot"))
							if("Yes, I'm sure")
								usr<<"<font size =1 color=#bf1600>[boot] has been booted from [usr.GuildHTML].</font>"
								boot<<"<font size =1 color=#bf1600>[usr] has booted you from [usr.GuildHTML]!</font>"

								boot.InGuild=0
								boot.CoLeader=0
								boot.Recruiter=0

								boot.GuildTitle=null
								boot.GuildHTML="None"
								boot.Guild=null
								boot.GuildTag=null
								boot.GuildOHTML=null
								boot.GuildVerbs()
								for(var/mob/player/M in world)
									if(M.Guild==usr.Guild)
										M<<output("<font size=2 color=#bf1600><b>[usr] has booted [boot] from [usr.GuildHTML]!</b></font>","Guild Chat")
					else
						usr<<"<font color=#bf1600>Cannot boot Guild Leaders.</font>"
						boot<<"<font color=#bf1600><b>[usr] has just tried to boot you from [usr.GuildHTML]!</b></font>"
						return

//------------------------------------------------------------------------------------------------------------
	Change_Rank(mob/M in world)
		set hidden=1

		rankchange
		var/Rank=input("","Title Change","[M.GuildTitle]") as text
		if(length(Rank)>15)
			alert("15 Characters is the limit.")
			goto rankchange
			return

		switch(input("Are you sure you want to change [M]'s title to [Rank]?","Title Change")in list("Change it","Don't change it"))
			if("Change it")
				if(M.Guild==usr.Guild)
					if(!M.GuildLeader||usr.GuildLeader)
						usr<<"<font color=#bf1600>Done.</font>"
						M<<output("<font color=#bf1600>[usr] has changed your rank.</font>","Guild Chat")
						M.GuildTitle="[html_encode(Rank)]"
						return
					else
						usr<<"<font color=#bf1600>Leaders can change their <i>own</i> ranks.</font>"; return
				else
					usr<<"<font color=#bf1600>They're not in [usr.GuildHTML].</font>"; return


	Guild_Ann(msg as message)
		set hidden=1
		if(usr.jailed) return
		if(length(msg) >= 2000)
			alert("Message is too long"); return
		else
			for(var/mob/M in world)
				if(M.Guild==usr.Guild)
					M<<output("<font size=3 color=#bf1600><b><center>[usr] ([usr.GuildTitle]):</font></center> \ <center><font color=silver>[msg]</font></b></center>","Chat")


//------------------------------------------------------------------------------------------------------------
mob/RecruiterGuild/verb
	Invite()
		set hidden=1
		var/Plist=list()
		for(var/mob/player/P in MasterPlayerList)
			if(P.loggedin&&P.Guild!=usr.Guild&&P.GuildRequests) Plist+=P
		Plist-=usr
		var/mob/inv=input("Invite a player to join your guild")as null|anything in Plist
		if(inv)
			del(Plist)
			switch(input(inv,"Would you like to join [usr.Guild]?","Join Guild")in list("Join","Don't Join"))
				if("Join")
					inv<<"<font color=#bf1600>You join [usr.Guild].</font>"
					inv.InGuild=1
					inv.Guild=usr.Guild
					inv.GuildHTML="Member"
					inv.GuildOHTML=usr.GuildOHTML
					inv.GuildTag=usr.GuildTag
					inv.GuildTitle = "Member"
					inv.GuildVerbs()
					for(var/mob/player/M in world)
						if(M.Guild==usr.Guild&&M.ListenGOOC)
							M<<output("<font color=#bf1600>[inv] has joined [usr.GuildHTML].</font>","Guild Chat")
					return
				if("Don't Join")
					inv<<"<font color=#bf1600>You decline the invitation.</font>"
					usr<<"<font color=#bf1600>[inv] has declined your invitation.</font>"
					return
