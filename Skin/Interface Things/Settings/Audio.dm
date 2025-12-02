mob
//	var
//		tmp
	verb
		Apply_Audio()
			set hidden=1
			usr.Apply_SFX()
			usr.Apply_Music()
	proc
		Apply_SFX()
			var/x=winget(usr,"Settings_Audio.SFX_Slider","value")
			x=(round((text2num(x))))
			Settings["SFX"]=x
		Apply_Music()
			var/x=winget(usr,"Settings_Audio.Music_Slider","value")
			x=(round((text2num(x))))
			Settings["MUSIC"]=x