var
	GuildHouseOwners[3];
	GuildHouseTimers[3]; // Use Real Time and link to the Guild House for a "Safety Time" or "Expiry Time"

proc
	LoadHousing()
		if(fexists("Data/Wipe/Guilds.sav"))
			var/savefile/F = new ("Data/Wipe/Guilds.sav")
			F["GHOwners"]>>GuildHouseOwners
			F["GHTimers"]>>GuildHouseTimers
			F["Guilds"]>>GuildMasterList

	SaveHousing()
		var/savefile/F = new("Data/Wipe/Guilds.sav")
		F["GHOwners"]<<GuildHouseOwners
		F["GHTimers"]<<GuildHouseTimers
		F["Guilds"]<<GuildMasterList

	checkGH(mob/player,GH)
		if (isnull(GuildHouseOwners[GH]))
			if(!isnull(player.Guild) && player.Guild in GuildHouseOwners){player<<"You already have a Guild House!"; return}
			if(!isnull(player.Guild) && !player.GuildLeader) {player<<"Maybe you should inform your Guild Leader about this place..."; return}
			buyGH(player,GH)
		else
			if (player.Guild == GuildHouseOwners[GH]){return 1;}
			else
				if(!isnull(player.Guild)) player<<"This place seems to be occupied!"

	buyGH(mob/player,GH)
		if(!player.GuildLeader) return
		switch(input("Would you like to claim this space?","Guild House")in list("Yes","No"))
			if("Yes")
				if(isnull(GuildHouseOwners[GH]))
					GuildHouseOwners[GH] = player.Guild
					GuildHouseTimers[GH] = world.realtime + 50




//-------------------------------------------------------------------------------------- GH Doors

turf/GuildHouses/Doorways


	GH_1
		Maindoor
			Entry
				Enter(mob/M)
					usr<<"This would be a neat place to hide out!"
					//if(checkGH(M, 1))
					//	M.loc=locate(15,539,2); M.ZCoord="Guild House"; M.ZCoordProc(M.ZCoord)
					//if(usr.Guild=="the Revolution")
						//M.loc=locate(891,970,1); M.ZCoord="Guild House"; M.ZCoordProc(M.ZCoord)}
						//usr<<"Disabled Kakumei GH. Reason: mutiny"
					//else return
			Exit
				Entered(mob/M)
					M.loc=locate(440,30,1); M.ZCoord="Roaming"; M.ZCoordProc(M.ZCoord)

	GH_2
		Maindoor
			Entry
				Enter(mob/M)
					usr<<"This would be a neat place to hide out!"
					//if(checkGH(M, 2))
					//	M.loc=locate(45,539,2); M.ZCoord="Guild House"; M.ZCoordProc(M.ZCoord)
					//if(usr.Guild=="the Revolution")
						//M.loc=locate(891,970,1); M.ZCoord="Guild House"; M.ZCoordProc(M.ZCoord)}
						//usr<<"Disabled Kakumei GH. Reason: mutiny"
					//else return
			Exit
				Entered(mob/M)
					M.loc=locate(440,30,1); M.ZCoord="Roaming"; M.ZCoordProc(M.ZCoord)