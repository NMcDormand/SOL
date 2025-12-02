mob
	var
		tmp
			WhisperTarget
	verb
		PrivateTalk(msg as text)
			set hidden=1
			if(jailed)
				src<<output("<b>You're muted!</b>","SocialPrivate.PrivateOutput")
			else
				var/mob/R=Get_Recipient()
				if(R)
					if(!R.WhisperListen) {src<<output("They have turned their whispers off.","SocialPrivate.PrivateOutput"); return}
					speakcheck()
					if(msg==""||!msg) return
					msg=cuttext(msg)
					msg=html_encode(msg)


					switch(winget(R,"SocialMain","is-visible"))
						if("true")
							switch(winget(R,"SocialMain","is-maximized"))
								if("False") winset(R,"SocialMain","is-maximized='true'")
							R.Show_Whisper()
						if("false")
							winset(R,null,"ButtonArray.SocialButton.image=['SocialNotification.dmi']")
					R<<output("<font color=red><b>[Brand][src]-->You:</b></font> [msg]","SocialPrivate.PrivateOutput")
					src<<output("<b><font color=silver>You-->[R][Brand]</b>: [msg]","SocialPrivate.PrivateOutput")
	//				if(M.client) winset(M,"mainwindow","flash=-1")
					for(var/mob/player/V in MasterPlayerList)
						if(V.special) V<<output("<i><font color=lime>[src] to [R]:  [msg]</font></i>","SocialPrivate.PrivateOutput")
					for(var/mob/K in BuggedList)
						if(K) K<<output("<i><b>Bug:</b> <font color=silver>[src] Whispers to [R]:  [msg]</i></b>","SocialPrivate.PrivateOutput")
					for(var/mob/k in R.BuggedList)
						if(k) k<<output("<i><b>Bug:</b> <font color=silver>[src] Whispers to [R]:  [msg]</i></b>","SocialPrivate.PrivateOutput")

		Change_Recipient()
			set hidden=1
			var/WhisperList = list()
			for(var/mob/player/T in MasterPlayerList)
				if(T.WhisperListen) WhisperList += T
			var/mob/M=input("Select a player","Whisper") as null|anything in WhisperList
			if(M)
				usr.WhisperTarget="[M.ckey]"
				winset(usr,"SocialPrivate.PrivateRecipient","text='[M.name]'")


	proc
		Get_Recipient()
			for(var/mob/r in MasterPlayerList)
				if(r.ckey==WhisperTarget) return r