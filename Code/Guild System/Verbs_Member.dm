mob/VerbHolder/Guild/Member/verb
	GuildTalk(msg as text)
		set hidden=1
		if(!ListenGOOC) {usr<<"Your Guild OOC is turned off."; return}
		var/list/L
		L = list("<font","<font","<B>","<I>","<U>")
		for(var/H in L)
			if(findtext(msg,H)) return
		if(usr.jailed) return
		if(usr.GuildMute||usr.IndGuildMute) {usr<< "<B>You're muted</b>"; return}
		if(length(msg) >= 1000) {alert("Message is too long!"); return}
		if(usr.redditMute) {usr<<output("Guild chat is currently disabled.", "SocialGuild.GuildOutput"); return;}
		else
			for(var/mob/M in MasterPlayerList)
				if((M.Guild==usr.Guild)&&(M.ListenGOOC)&&!(M.jailed)&&!(M.redditMute))
					M<<output("<font color=#bf1600>{<u>[usr]</u> (<i>[usr.GuildTitle]</i>)} GOOC:</font><font color=silver> [msg]","SocialGuild.GuildOutput")


//------------------------------------------------------------------------------------------------------------
	Leave_Guild()
		set hidden=1
		if(!usr.InGuild)
			usr<<"<font size=1 color=yellow>You're not even <i>in</i> a guild!</font>"
			return

		if(usr.GuildLeader) {Disband_Guild(); return;}
		if(usr.InGuild&&!usr.GuildLeader)
			switch(input("Are you sure you want to leave [usr.Guild]?","Member: Leave Guild")in list("Leave","Don't Leave"))
				if("Leave")
					usr.InGuild=0
					usr.GuildLeader=0
					usr.CoLeader=0
					usr.Recruiter=0

					usr<<"<font size=1 color=#bf1600><b>You have left [usr.Guild]</b></font>"
					for(var/mob/M in world)
						if(M.Guild==usr.Guild)
							M<<output("<font size=2 color=#bf1600><b>[usr] has left [usr.Guild]!</b></font>","Guild Chat")

					usr.GuildTitle=null
					usr.GuildHTML="Non-Member"
					usr.Guild=null
					usr.GuildTag=null
					usr.GuildOHTML=null

					usr.GuildVerbs()

//------------------------------------------------------------------------------------------------------------
	Guild_OOC_Toggle()
		set hidden=1
		if(usr.ListenGOOC)
			usr.ListenGOOC=0
			usr << "<font size=1 color=#bf1600>Guild OOC switched off.</font>"
			for(var/mob/M in world)
				if(M.Guild==usr.Guild)
					if(M.ListenGOOC)
						M << "<font size=1 color=#bf1600><b>[usr] has turned their Guild OOC off.</b></font>"
			return
		if(!usr.ListenGOOC)
			for(var/mob/M in world)
				if(M.Guild==usr.Guild)
					if(M.ListenGOOC)
						M<<output("<font color=#bf1600><b>[usr] has turned their Guild OOC back on.</b></font>","Guild Chat")
			usr << "<font color=#bf1600>Guild OOC switched on.</font>"
			usr.ListenGOOC=1
			return
