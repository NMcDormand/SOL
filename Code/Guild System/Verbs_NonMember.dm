proc/TakeHTML(T as text)
	if(!istext(T)) return "[T] is not text!"
	if(!findtext(T,"<")||!findtext(T,">")) return T
	while(findtext(T,"<")&&findtext(T,">"))
		var/pre=copytext(T,1,findtext(T,"<"))
		var/pos=copytext(T,findtext(T,">")+1)
		T=pre+pos
	return T
mob
	proc/GuildVerbs()
		if(GuildLeader||CoLeader) verbs += typesof(/mob/VerbHolder/Guild/CoLeader/verb)
		if(!GuildLeader&&!CoLeader) verbs -= typesof(/mob/VerbHolder/Guild/CoLeader/verb)

		if(Recruiter||GuildLeader) verbs += typesof(/mob/RecruiterGuild/verb)
		if(!Recruiter&&!GuildLeader) verbs -= typesof(/mob/RecruiterGuild/verb)

		if(GuildLeader) verbs += typesof(/mob/VerbHolder/Guild/Leader/verb)
		if(!GuildLeader) verbs -= typesof(/mob/VerbHolder/Guild/Leader/verb)

		if(InGuild) {verbs -= typesof(/mob/VerbHolder/Guild/NonMember/verb); verbs += typesof(/mob/VerbHolder/Guild/Member/verb)}
		if(!InGuild)
			verbs += typesof(/mob/VerbHolder/Guild/NonMember/verb)
			verbs -= typesof(/mob/VerbHolder/Guild/Leader/verb); verbs -= typesof(/mob/VerbHolder/Guild/Member/verb)
			verbs -= typesof(/mob/VerbHolder/Guild/CoLeader/verb); verbs -= typesof(/mob/RecruiterGuild/verb)

	VerbHolder/Guild/NonMember
		verb/Create_Guild()
			set hidden=1
			//Check initial conditions
			if(usr.InGuild||usr.NinjaRank=="Academy Student"||usr.CantCreate){alert("Can't do that yet!"); return}
			if(usr.GuildDisabled){alert("Your Guild creation has been disabled!"); return}
			if(usr.gold<5000) {alert("Not enough money!, you need 5000 gold"); return}

			//Check Guild name & Guild Tag
			REF //Hanlde Guild Name
			var/GNAME =	input("Choose a guild name.","Guild Creation") as text
			if(!GNAME||GNAME == "")
				alert("Information did not fit the criteria, try again.")
				goto REF
				return
			if(GuildNameIsTaken(GNAME))
				alert("This guild has already been registered!")
				goto REF
				return

			TAGHTML// Handle Guild Tag Colours
			var/GHTML =input("Choose the HTML for the Guild, This is what is in the chat","Guild Creation") as text
			if(!GHTML)
				goto TAGHTML
			var/GTAG = TakeHTML(GHTML)
			if(GTAG == "*")
				goto TAGHTML
			if(!GTAG||length(GTAG)>10)
				alert("Tags must be one to seven characters long, if this already is please make sure you have closed all your html tags")
				goto TAGHTML
			if(GuildTagIsTaken(GTAG))
				alert("This tag is currently in use!")
				goto TAGHTML

			usr<<"[GHTML] - This is the Guild Badge for the [GNAME] Guild, with the tag [GTAG]. This message should be in GRAY font while your tag is the only thing in colour, if this is coloured something appear to be wrong with your HTML and will need to redo this. Are you sure you would like to complete?"
			if(alert("Does this look correct?",,"Yes","No") == "No")
				if(alert("Would you like to try again?",,"Yes","No") == "No")
					return
				else
					goto REF

			//Create Guild
			usr.CantCreate=1
			GNAME=html_encode(GNAME)
			AddGuildToList(GNAME,GTAG,usr.ckey,GHTML)
			AddPlayerList(usr, GNAME)
			spawn(10)world<<"<b><font size=2 color=#14DBFF>[GNAME] has just been forged by [usr].</b></font>"
			usr.gold-=5000
			usr.CantCreate=0
			usr.InGuild=1
			usr.GuildLeader=1
			usr.GuildTitle = "Leader"
			usr.Guild = "[GNAME]"
			usr.GuildTag = "[GTAG]"
			usr.GuildOHTML = "{[GHTML]} "
			usr.GuildVerbs()
			usr.RefreshGuildPanel()