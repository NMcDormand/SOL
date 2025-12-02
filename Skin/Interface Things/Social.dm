mob
	var/tmp
		SocialWho
	verb
		Close_Social()
			set hidden=1
			if(!usr.client) return
			winshow(usr,"SocialMain",0)
		Expand_Social()
			set hidden=1
			if(!usr.client) return
			switch(winget(usr,"SocialMain","is-maximized"))
				if("False") winset(usr,"SocialMain","is-maximized='true'")
		Minimise_Social()
			set hidden=1
			if(!usr.client) return
			switch(winget(usr,"SocialMain","is-minimized"))
				if("False") winset(usr,"SocialMain","is-minimized='true'")

		Filter_All()
			set hidden=1
			usr.Update_Who_All()
			winset(usr,null,"SocialGeneral.Everyone.image=['HLWhoFilter.png']; SocialGeneral.Friends.image=['WhoFilter.png']; SocialGeneral.Village.image=['WhoFilter.png']; SocialGeneral.Guild.image=['WhoFilter.png']")
		Filter_Friends()
			set hidden=1
			usr.Update_Who_Friends()
			winset(usr,null,"SocialGeneral.Everyone.image=['WhoFilter.png']; SocialGeneral.Friends.image=['HLWhoFilter.png']; SocialGeneral.Village.image=['WhoFilter.png']; SocialGeneral.Guild.image=['WhoFilter.png']")
		Filter_Guild()
			set hidden=1
			usr.Update_Who_Guild()
			winset(usr,null,"SocialGeneral.Everyone.image=['WhoFilter.png']; SocialGeneral.Friends.image=['WhoFilter.png']; SocialGeneral.Village.image=['WhoFilter.png']; SocialGeneral.Guild.image=['HLWhoFilter.png']")
		Filter_Village()
			set hidden=1
			usr.Update_Who_Village()
			winset(usr,null,"SocialGeneral.Everyone.image=['WhoFilter.png']; SocialGeneral.Friends.image=['WhoFilter.png']; SocialGeneral.Village.image=['HLWhoFilter.png']; SocialGeneral.Guild.image=['WhoFilter.png']")
		OpenSocialWindow()
			if(usr.TakingExam||!usr.client||!(usr.loggedin)) return
			switch(winget(usr,"SocialMain","is-visible"))
				if("false")
					winshow(usr,"SocialMain",1)
					winset(usr,null,"ButtonArray.SocialButton.image=['Social.png']")
					usr.WhichWho()
					Update_FriendsSelected()
					winset(usr,null,"SocialGeneral.Everyone.image=['HLWhoFilter.png']; SocialGeneral.Friends.image=['WhoFilter.png']; SocialGeneral.Village.image=['WhoFilter.png']; SocialGeneral.Guild.image=['WhoFilter.png']")

		Show_General()
			set hidden=1
			switch(winget(usr,"SocialMain.SocialChild","left"))
				if("SocialGeneral") return
				else {winset(usr,null,"SocialMain.SocialChild.left='SocialGeneral';SocialMain.GeneralButton.image=['HL_SocialButton.png'];SocialMain.VillageButton.image=['SocialButton.png'];SocialMain.GuildButton.image=['SocialButton.png'];SocialMain.WhisperButton.image=['SocialButton.png']")}
		Show_Village()
			set hidden=1
			switch(winget(usr,"SocialMain.SocialChild","left"))
				if("SocialVillage") return
				else {winset(usr,null,"SocialMain.SocialChild.left='SocialVillage';SocialMain.GeneralButton.image=['SocialButton.png'];SocialMain.VillageButton.image=['HL_SocialButton.png'];SocialMain.GuildButton.image=['SocialButton.png'];SocialMain.WhisperButton.image=['SocialButton.png']")}
		Show_Guild()
			set hidden=1
			switch(winget(usr,"SocialMain.SocialChild","left"))
				if("SocialGuild")
					return
				else
					winset(usr,null,"SocialMain.SocialChild.left='SocialGuild';SocialMain.GeneralButton.image=['SocialButton.png'];SocialMain.VillageButton.image=['SocialButton.png'];SocialMain.GuildButton.image=['HL_SocialButton.png'];SocialMain.WhisperButton.image=['SocialButton.png']")
					usr.RefreshGuildPanel()

		Show_Whisper()
			set hidden=1
			switch(winget(usr,"SocialMain.SocialChild","left"))
				if("SocialPrivatey") return
				else {winset(usr,null,"SocialMain.SocialChild.left='SocialPrivate';SocialMain.GeneralButton.image=['SocialButton.png'];SocialMain.VillageButton.image=['SocialButton.png'];SocialMain.GuildButton.image=['SocialButton.png'];SocialMain.WhisperButton.image=['HL_SocialButton.png']")}

	proc
		RefreshGuildPanel()
			if(InGuild)
				if(GuildLeader||CoLeader)
					winset(src,null,"SocialGuild.GuildControls.left='GUILD_leader'; GUILD_leader.GuildRank.text='[GuildTitle]'; GUILD_leader.TotalMembers.text=''; GUILD_leader.GuildTitle.text='[Guild]'")
				else if(Recruiter)
					winset(src,null,"SocialGuild.GuildControls.left='GUILD_recruiter'; GUILD_recruiter.GuildLeader.text=''; GUILD_recruiter.GuildRank.text='[GuildTitle]'; GUILD_recruiter.TotalMembers.text=''; GUILD_recruiter.GuildTitle.text='[Guild]'")
				else
					winset(src,null,"SocialGuild.GuildControls.left='GUILD_member'; GUILD_member.GuildLeader.text=''; GUILD_member.GuildRank.text='[GuildTitle]'; GUILD_member.TotalMembers.text=''; GUILD_member.GuildTitle.text='[Guild]'")
			else
				winset(src,"SocialGuild.GuildControls","left='GUILD_nonmember'")

		WhichWho()
			if(!SocialWho||SocialWho=="all")
				Update_Who_All()
			else
				switch(SocialWho)
					if("friends") Update_Who_Friends()
					if("village") Update_Who_Village()
					if("guild") Update_Who_Guild()
					else Update_Who_All()

		Update_Who_All()
			SocialWho="all"
			var/Row=0
			for(var/mob/player/M in MasterPlayerList)
				Row++
				if(M.BYONDMEMBER) src << output("<font color=#71C671>[M.name]</font> ([M.key]) [M.AFK]","SocialGeneral.WhoGrid:1,[Row]")
				else src << output("<font color=#eeeeee>[M.name]</font> ([M.key]) [M.AFK]","SocialGeneral.WhoGrid:1,[Row]")
			src << output("<font color=#ffffff>Players Online: [Row]</font>","SocialGeneral.WhoGrid:1,[Row+1]")
			winset(src,"SocialGeneral.WhoGrid","cells=1x[Row+1]")

		Update_Who_Village()
			SocialWho="village"
			var/Row=0
			for(var/mob/player/M in MasterPlayerList)
				if(M.Village==Village)
					Row++
					src << output("<font color=#eeeeee>[M.name]</font> ([M.key]) [M.AFK]","SocialGeneral.WhoGrid:1,[Row]")
			src << output("<font color=#ffffff>[Village]-nin Online: [Row]</font>","SocialGeneral.WhoGrid:1,[Row+1]")
			winset(src,"SocialGeneral.WhoGrid","cells=1x[Row+1]")

		Update_Who_Friends()
			if(length(ListOfFriends)<1) return
			SocialWho="friends"
			var/Row=0
			for(var/mob/player/M in MasterPlayerList)
				if((M.ckey in ListOfFriends)&&(M!=src))
					Row++
					src << output("<font color=#eeeeee>[M.name]</font> ([M.key]) [M.AFK]","SocialGeneral.WhoGrid:1,[Row]")
			src << output("<font color=#ffffff>Friends Online: [Row]</font>","SocialGeneral.WhoGrid:1,[Row+1]")
			winset(src,"SocialGeneral.WhoGrid","cells=1x[Row+1]")

		Update_Who_Guild()
			if(!Guild) return
			SocialWho="guild"
			var/Row=0
//			winset(src, "SocialGeneral.FriendsSelected", "cells = 0x0")
			for(var/mob/player/M in MasterPlayerList)
				if(M.Guild==Guild)
					Row++
					src << output("<font color=#eeeeee>[M.name]</font> ([M.key]) [M.AFK]","SocialGeneral.WhoGrid:1,[Row]")
			src << output("<font color=#ffffff>Guild Members Online: [Row]</font>","SocialGeneral.WhoGrid:1,[Row+1]")
			winset(src,"SocialGeneral.WhoGrid","cells=1x[Row+1]")

		Update_FriendsSelected()
			var
				Row=1; Column=1; F=GetFriends_Selected()
			for(var/mob/M in F)
				src << output("[M.name]","SocialGeneral.FriendsSelected:[Column],[Row]")
				if(IsEven(Column)) Row++
				if(Column==1) Column=2
				else Column=1
			winset(src,"SocialGeneral.FriendsSelected","cells=2x[Row]")