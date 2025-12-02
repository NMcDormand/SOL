mob/var
	tmp/CantCreate=0
	GuildDisabled=0
	GuildTitle=""
	GuildHTML="Non-member"
	Guild
	GuildTag
	GuildOHTML
	InGuild
	GuildLeader
	CoLeader
	Recruiter

	GuildMute
	IndGuildMute
	ListenGOOC=1

var/list/GuildMasterList[]=list() // Stores all information about Guilds ( Name / Tag / Level / Experience)
var/list/GuildTagsList[]=list() // Stores Guild Tags
var/list/PlayersInGuild[]=list() // Stores ckey of people who are in a Guild (Same account guilds)
var/guildMaxExp = 100;
proc
//========== Save/Load Guild Lists to File =====================================
	LoadGuilds()
		if(fexists("Data/Wipe/Guilds.sav"))
			var/savefile/F = new ("Data/Wipe/Guilds.sav")
			F["GuildMaster"]>>GuildMasterList
			F["GuildTag"]>>GuildTagsList
			F["PlayersInGuild"]>>PlayersInGuild

	SaveGuilds()
		if(TotalSavePrevention) return
		var/savefile/F = new("Data/Wipe/Guilds.sav")
		F["GuildMaster"]<<GuildMasterList
		F["GuildTag"]<<GuildTagsList
		F["PlayersInGuild"]<<PlayersInGuild

//========== Guild Procs for adding to List =====================================
	AddGuildToList(name,tag,creator,HTML)
		//Todo - Add "Members online" and "Members Total" to list
		var/list/member = list(creator)
		var/list/Guild = list("tag", "level", "members", "XP", "max_XP", "HTML") //Create a temporary Guild with names of each field it will hold.
		Guild["tag"] = tag; Guild["level"]=1; Guild["XP"]=0; Guild["max_XP"]=guildMaxExp // Add values to each list element
		Guild["HTML"] = HTML
		Guild["members"] = member //Add the owner to members list
		GuildMasterList.Add(name) //Add a new Guild to the Guild Master List
		GuildMasterList[name] = Guild //Adds values to the new Guild
		GuildTagsList.Add(tag) // Add tag for reference

//============THIS ONE NEEDS TO CHANGE BECAUSE IF IT ONLY CHECKS PLAYER NAME, ALT CAN LOG BACK IN AND GET ACCESS. STUPID JORDAN!
	AddPlayerList(mob/M, guild)
		var/nextNum = PlayersInGuild.len+1 //This is stupid - what if someone leaves - then you will have one less person and it will duplicate the last person.. STUPID JORDAN!
		var/list/player = list("name", "guild", "ckey") //Create temporary player Info
		player["name"]=M.name; player["guild"]=guild; player["ckey"]=M.ckey //Add values to each list element
		PlayersInGuild.Add(nextNum) //Add the player to the list
		PlayersInGuild[nextNum] = player //Add the info to the player

	RemoveGuildFromList(name,tag)
		if(name in GuildMasterList) GuildMasterList-=name //Remove from Guild List
		if(tag in GuildTagsList) GuildTagsList-=tag //Remove from Tags List

	RemovePlayerFromList(mob/M)
		if(M.name in PlayersInGuild) PlayersInGuild-=M.name //Remove player from List

//=========== Guild Procs for checking the List =================================
	GuildNameIsTaken(guild)
		if(guild in GuildMasterList)
			return 1
	GuildTagIsTaken(tag)
		if(tag in GuildTagsList)
			return 1