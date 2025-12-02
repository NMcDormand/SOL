mob/var/tmp/maptext/level_up
	_levelUp
	background/_levelUp_bg

maptext
	parent_type = /atom/movable
	icon = null
	layer = FLY_LAYER+1
	mouse_opacity = 0
	alpha = 0
	var created

	level_up
		maptext_height = 100
		maptext_width = 500
		screen_loc = "CENTER-8,NORTH-1"
		layer = FLY_LAYER+5
		appearance_flags=PASS_MOUSE
		background
			screen_loc = "CENTER-8,NORTH-1"//"2:21,17:7"
			layer = FLY_LAYER+1
			//blend_mode = BLEND_MULTIPLY
			icon = 'levelup_bg.dmi'
		proc
			_update(_txt,client/c,timeIn = 6, timeStay = 30, timeOut = 4)
				if(c)
					_txt = "<style>body {font-family: 'Trajan Pro';color: #FFFFFF; font-size: 4;}</style><center>[_txt]</center>"
					//<b><center><font size=4 face=Trajan-Pro>[_txt]</font></b></center>"
					alpha=0
					c.screen += src
					animate(src,maptext = "[_txt]",alpha=255,time=timeIn, easing = SINE_EASING|EASE_OUT)
					var t = world.time
					created = t
					spawn(timeStay)
						if(created == t)
							animate(src,alpha=0,time=timeOut)
							spawn(4)
								if(c)
									c.screen-= src
									maptext=null
			_BG_update(client/c,timeIn = 6, timeStay = 30, timeOut = 4)
				if(c)
					alpha=0
					c.screen += src
					animate(src,alpha=150,time=0, easing = SINE_EASING|EASE_OUT)
					var t = world.time
					created = t
					spawn(timeStay)
						if(created == t)
							animate(src,alpha=0,time=timeOut)
							spawn(timeOut)
								if(c)
									c.screen-= src

proc
	NotifyAll(_msg, time=0)
		src<<"Got this!"
		if(_msg == "reboot")
			for(var/mob/player/p in MasterPlayerList)
				p.reboot_notification(p.client, 0)
		if(_msg == "reboot2")
			for(var/mob/player/p in MasterPlayerList)
				p.reboot_notification(p.client, time)
		return //Reboot
mob/proc
	LevelUp_notification(_skill,client)
		if(!_skill) CRASH("No skill sent through level up notification; proc halted.")
		if(!_levelUp_bg) _levelUp_bg = new()
		if(!_levelUp) _levelUp = new()
		_levelUp_bg._BG_update(client)
		var/MSG
		switch(_skill)
			if("test")
				MSG = "This is a test announcement!"
			if("level")
				MSG = "You have gained a level!"
			if("Genin")
				MSG = "You have been promoted to Genin!"
			if("Chuunin")
				MSG = "You have been promoted to Chuunin!"
			if("Special Jounin")
				MSG = "You have been promoted to Special Jounin!"
			if("Anbu")
				MSG = "You have been promoted to ANBU!"
			if("Jounin")
				MSG = "You have been promoted to Jounin!"
			if("Kage Level")
				MSG = "You have been recognized as Kage Level!"
			if("Hokage","Mizukage","Raikage","Tsuchikage","Kazekage")
				MSG = "You are now the [_skill] of the [Village] village!"
			if("Sound Leader","Grass Leader","Rain Leader","Waterfall Leader")
				MSG = "You are now the leader of the [Village] village!"
			else
				MSG = "Your [_skill] skill has increased."
		_levelUp._update(MSG,client)
		//play a sound
		//display level too


	Achievement_notification(_skill,client)
		if(!_skill) CRASH("No skill sent through level up notification; proc halted.")
		if(!_levelUp_bg) _levelUp_bg = new()
		if(!_levelUp) _levelUp = new()
		_levelUp._update(call(src,"achievementNotification")(_skill),client)
		_levelUp_bg._BG_update(client)
		//play a sound
		//display level too

	achievementNotification(_skill)
		return "You have been awarded the [_skill] medal."


/*	NotifyAll(_msg)
		src<<"Got this!"
		if(_msg == "reboot")
			for(var/mob/player/p in MasterPlayerList)
				p.reboot_notification(p.client)
		return //Reboot
*/

	reboot_notification(client, time)
		set waitfor = 0
		if(!_levelUp_bg) _levelUp_bg = new()
		if(!_levelUp) _levelUp = new()


		if(time > 0) {
			_levelUp_bg._BG_update(client,0,650,0)
			if(time == 1)
				_levelUp._update("The world will reboot in <b>1</b> minute",client,0,650,0)
			else
				_levelUp._update("The world will reboot in [time] minutes",client,0,650,0)
		}
		else {
			_levelUp_bg._BG_update(client,0,250,0)
			for(var/i=10; i>0; i--) {
				_levelUp._update("The world will reboot in: [i]",client,0,12,0)
				sleep(10)
			}
			_levelUp._update("The world is rebooting...",client,0,100,0)
		}
		//play a sound
		//display level too