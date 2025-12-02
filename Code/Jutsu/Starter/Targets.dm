atom/movable/var/tmp/mob/Targeting //This MUST BE TEMP! Otherwise it will break!
mob/
	Click()
		if(istype(src,/mob/Hittable/Unresponsive/Inanimate)||BlockTarget)
			return
		if(src == usr||get_dist(src,usr) >= 12) //if the source is the user, return. // you can also change 10 if you wish
			return
		if(usr.Targeting==src)//If it's the same person, remove target.
			usr<<"You stop Targeting [src]"
			usr.DeleteTarget()
			return
			//var/mob/Hittable/Unresponsive/Inanimate/IA = src
			//if(IA.Owner == usr)
			//	return
		for(var/image/x in usr.client.images) // first, check to see if your have a target.
			if(x.icon=='target.dmi') // if so.
				del(x) // delete it.
		var/image/I = image('target.dmi',src) // create a new target on the source.
		usr<<I // make it so only u can see the target
		usr.Targeting=src // make your target variable source name.
		usr<<"You target [src]" // tell yourself your you targeted him/her.

mob
	proc
		SetTarget(mob/M,MSG=1)
			for(var/image/x in client.images) // first, check to see if your have a target.
				if(x.icon=='target.dmi') // if so.
					del(x) // delete it.
			var/image/I = image('target.dmi',M) // create a new target on the source.
			src<<I // make it so only u can see the target
			Targeting = M // make your target variable source name.
			if(MSG)
				src<<"You target [M]" // tell yourself your you targeted him/her.

		DeleteTarget() //Removes the target from user & deletes the target image
			Targeting=null
			if(client)
				for(var/image/x in client.images)
					if(x.icon=='target.dmi')
						del(x)

		RemoveAllTargetMe() //Removes you as a target from anyone within range.
			for(var/mob/player/M in range(15,src))
				if((M.SharinganLevel==3&&M.InSharingan)||M.InMangekyou||(M.InByakugan&&InKawarimi)) continue
				if(M.Targeting == src)
					M.DeleteTarget()
				sleep(1)