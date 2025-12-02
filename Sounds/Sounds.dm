var/sound
	Secret = 'secret.mid'
	Popup = 'PopUpBeep.wav'
	Poof = 'poof.wma'
	LevelUp = 'LevelUp.wav'
mob/proc/PlaySound(x)
	if(!Settings) Settings=new()
	var/v=Settings["SFX"]
	if(v && v > 1)
		switch(x)
			if("poof") src << sound(Poof,volume=(v/2))
			if("popup") src << sound(Popup,volume=v)
			if("levelup") src << sound(LevelUp,volume=v)
			if("secret") src << sound(Secret,volume=v)
			else Called("Error: Unrecognised sound")