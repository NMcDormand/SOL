mob/VerbHolder/Guild/Leader/verb

	Give_Leadership(mob/M in world)
		set hidden=1
		if(!usr.GuildLeader) return

		switch(input("Would you like to give [M] Co-Leader status?","Guild Co-Leader")in list("Yes","No"))
			if("Yes")

				if(M==usr)
					usr<<output("<font color=#bf1600>You're already <i>the</i> Leader</font>","Guild Chat"); return

				if(M.Guild==usr.Guild)
					M<<output("<font color=#bf1600>[usr] has made you Co-Leader of [usr.GuildHTML].</font>","Guild Chat")
					usr<<output("<font color=#bf1600>[M] has been made Co-Leader of [usr.GuildHTML].</font>","Guild Chat")
					M.GuildTitle="Co-Leader"; M.CoLeader=1; M.GuildVerbs()
					return
				else
					usr<<output("<font color=#bf1600>They're not in [usr.GuildHTML].</font>","Guild Chat"); return

//------------------------------------------------------------------------------------------------------------
	Revoke_Leadership(mob/M in world)
		set hidden=1
		if(!usr.GuildLeader) return
		switch(input("Would you like to revoke [M]'s Co-Leader status?","Guild Revoke Co-Leader")in list("Yes","No"))
			if("Yes")

				if(M==usr)
					usr<<output("<font color=#bf1600>You're the <i>Leader</i></font>","Guild Chat"); return

				if(M.Guild==usr.Guild)
					usr<<output("<font color=#bf1600>[M] has had their Co-Leader status revoked.</font>","Guild Chat")
					M<<output("<font color=#bf1600>[usr] has revoked your Co-Leader status!</font>","Guild Chat")
					M.GuildTitle="Member"; M.CoLeader=0; M.GuildVerbs()
					return
				else
					usr<<output("<font color=#bf1600>They're not in [usr.GuildHTML].</font>","Guild Chat"); return

//------------------------------------------------------------------------------------------------------------
	Give_Invite(mob/M in world)
		set hidden=1
		switch(input("Would you like to give [M] recruitment Ninjutsus?","Guild Give Recruit to [M]")in list("Yes","No"))
			if("Yes")

				if(M==usr)
					usr<<output("<font color=#bf1600>You already have this Ninjutsu.</font>","Guild Chat"); return

				if(M.Guild==usr.Guild)
					usr<<output("<font color=#bf1600>[M] has been given the ability to invite new members.</font>","Guild Chat")
					M<<output("<font color=#bf1600>[usr] has given you the ability to invite new members to [usr.GuildHTML].</font>","Guild Chat")
					M.GuildTitle="Recruiter"; M.Recruiter=1; M.GuildVerbs()
					return
				else
					usr<<output("<font color=#bf1600>They're not in [usr.GuildHTML].</font>","Guild Chat"); return

//------------------------------------------------------------------------------------------------------------
	Take_Invite(mob/M in world)
		set hidden=1
		switch(input("Would you like to revoke [M]'s recruitment Ninjutsus?","Guild Revoke Recruit from [M]")in list("Yes","No"))
			if("Yes")
				if(M==usr)
					usr<<output("<font color=#bf1600>You can't do this to yourself.</font>","Guild Chat"); return

				if(M.Guild==usr.Guild)
					usr<<output("<font color=#bf1600>[M] has had the ability to invite new members revoked.</font>","Guild Chat")
					M<<output("<font color=#bf1600>[usr] has revoked your ability to invite new members to [usr.GuildHTML].</font>","Guild Chat")
					M.GuildTitle="Member"; M.Recruiter=0; M.GuildVerbs()
				else
					usr<<output("<font color=#bf1600>They're not in [usr.GuildHTML].</font>","Guild Chat"); return

proc/Disband_Guild()
	if(usr.InGuild&&usr.GuildLeader)
		switch(input("Are you sure you want to leave [usr.Guild]?","Leader: Leave Guild")in list("Leave","Don't Leave"))
			if("Leave")
				usr.InGuild=0
				usr.GuildLeader=0
				usr.CoLeader=0
				usr.Recruiter=0

				usr<<"<font color=#bf1600><b>You have left [usr.Guild]</b></font>"
				for(var/mob/M in world)
					if(M.Guild==usr.Guild&&M!=usr)
						M<<output("<font size=2><font color=#bf1600><b>Since [usr] was the leader the Guild will be deleted and all its logged in members ejected!</b></font>","Guild Chat")
						M<<output("<font size=2><font color=#bf1600><b>[usr] has left [usr.Guild]!</b></font>","Guild Chat")

						M.GuildTitle = null
						M.GuildHTML = "Non-Member"
						M.GuildOHTML=null
						M.GuildTag = null
						M.Guild = null
						M.InGuild=0
						M.CoLeader=0
						M.Recruiter=0
						M.GuildVerbs()

				usr.GuildTitle=null
				usr.GuildHTML="Non-Member"
				usr.GuildOHTML=null
				usr.GuildTag = null
				usr.Guild=null
				usr.GuildVerbs()