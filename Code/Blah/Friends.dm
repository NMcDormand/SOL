mob
	var
		ListOfFriends=list()
		tmp
			SelectedFriends=list()
			TempFriend=list()
	player
		verb
			AddFriend()
				set hidden=1
				var/f=list()
				for(var/mob/player/m in MasterPlayerList)
					if(m.FriendRequests&&!(m.ckey in usr.ListOfFriends)&&m!=usr) f+=m
				var/mob/player/M=input("Who do you want to add as a friend?","Add Friend") as null|anything in f
				if(M)
					usr.TempFriend+=M.ckey
					if(FriendCheck(usr,M))
						if(!(M.ckey in usr.ListOfFriends)) usr.ListOfFriends+=M.ckey
						if(!(usr.ckey in M.ListOfFriends)) M.ListOfFriends+=usr.ckey

			RemoveFriend()
				set hidden=1
				var/R=GetFriends()
				var/mob/r=input("","remove") as null|anything in R
				if(r)
					usr.ListOfFriends-=r.ckey
					if(r.ckey in usr.SelectedFriends)
						usr.SelectedFriends-=r.ckey

			FriendTalk(msg as text)
				set hidden=1
				if(msg)
					msg=html_encode(msg)
					var/w=usr.GetFriends()
					usr<<output("<b><font color=blue>[usr]</font>:</b>  [msg]","SocialGeneral.FriendOutput")
					for(var/mob/player/M in w)
						if(M.ckey in usr.SelectedFriends)
							M<<output("<b>[usr]:</b>  [msg]","SocialGeneral.FriendOutput")

			SelectFriends()
				set hidden=1
				var/F=usr.GetFriends_Unselected()
				var/mob/f=input("Select people to be included in your friend chatter","Select Friends") as null|anything in F
				if(f)
					usr.SelectedFriends+=f.ckey
					usr.Update_FriendsSelected()

			DeselectFriends()
				set hidden=1
				var/F=usr.GetFriends_Selected()
				var/mob/f=input("Select people to be excluded in your friend chatter","Deselect Friends") as null|anything in F
				if(f)
					usr.SelectedFriends-=f.ckey
					usr.Update_FriendsSelected()





	proc
		FriendCheck(mob/A,mob/B)
			if((A.ckey in B.TempFriend)&&(B.ckey in A.TempFriend)) return TRUE
			else return FALSE
		GetFriends()
			var/R=list()
			for(var/mob/player/M in MasterPlayerList)
				if(M.ckey in ListOfFriends) R+=M
			return R
		GetFriends_Unselected()
			var/R=list()
			for(var/mob/player/M in MasterPlayerList)
				if((M.ckey in ListOfFriends)&&!(M.ckey in SelectedFriends)) R+=M
			return R
		GetFriends_Selected()
			var/R=list()
			for(var/mob/player/M in MasterPlayerList)
				if((M.ckey in ListOfFriends)&&(M.ckey in SelectedFriends)) R+=M
			return R