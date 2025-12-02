var
	GuildWarList=list()
	UList=list()
	MList=list()
	GuildWarOccuring
proc
	GuildWar(mob/U,mob/M)
		if(GW_Cooldown(U.GuildHTML,18000,U,M)) return
		else if(GW_Cooldown(M.GuildHTML,18000,M,U)) return
		else if(!GuildWarOccuring)
			GuildWarOccuring=1
			UList=new/list
			MList=new/list
			GuildWarList=new/list
			for(var/mob/player/p in MasterPlayerList)
				if(p.Guild==U.Guild&&p.SendIntoBattle())
					UList+=p; GuildWarList+=p
			for(var/mob/player/B in MasterPlayerList)
				if(B.Guild==M.Guild&&B.SendIntoBattle())
					MList+=B; GuildWarList+=B
			for(var/mob/player/W in GuildWarList)
				W<<"A Guild War has been organised between [U.GuildHTML] and [M.GuildHTML].  20 seconds until the war commences."
				W.Popup("guild war",M.Guild,,20)
			spawn(170)
				for(var/mob/player/a in UList)
					a<<"Prepare for war!"
					a.SavedLocation=a.loc; a.SavedPlace=a.ZCoord
					a.GuildWarSpawn1()
				for(var/mob/player/b in MList)
					b<<"Prepare for war!"
					b.SavedLocation=b.loc; b.SavedPlace=b.ZCoord
					b.GuildWarSpawn2()
				GuildWarCheck()
		else
			U<<"There is already a Guild War occuring, please wait until it is completed and try again."
			M<<"There is already a Guild War occuring, please wait until it is completed and try again."

	GuildWarCheck()
		var
			AParty=0; BParty=0
		for(var/mob/player/P in GuildWarList)
			if(P in UList) AParty=1
			if(P in MList) BParty=1
		var/GuildCount=AParty+BParty
		if(GuildCount>1)
			spawn(25) GuildWarCheck()
		else
			var/Winners
			for(var/mob/player/W in GuildWarList)
				W<<"Congratulations you won the Guild War!"; Winners=W.GuildHTML; W.ReSpawn()
				W.StatPoints++; W.StatUpdate_statpoints()
			world<<"[Winners] have won a Guild War!"; GuildWarOccuring=0
mob/proc
	GuildWarSpawn1()
		var/S=list()
		for(var/obj/SpawnPoints/GuildWar/SA/s in world) S+=s.loc
		loc=pick(S); protect=0
	GuildWarSpawn2()
		var/S=list()
		for(var/obj/SpawnPoints/GuildWar/SB/s in world) S+=s.loc
		loc=pick(S); protect=0


var/GW_Cooldowns[]

proc/GW_Cooldown(Name,Cooldown,mob/user,mob/other)
	if(!GW_Cooldowns) GW_Cooldowns=new()
	if(GW_Cooldowns[Name]&&GW_Cooldowns[Name]>world.timeofday)
		if(GW_Cooldowns[Name]>world.timeofday+(Cooldown*3)) GW_Cooldowns[Name]=100

		user<<"[user.GuildHTML] has already taken part in a Guild War too recently."
		other<<"[user.GuildHTML] has already taken part in a Guild War too recently."
		return 1

	GW_Cooldowns[Name]=world.timeofday+Cooldown
	return 0