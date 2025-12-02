proc/RemovePortrait(mob/m,obj/x)
	set waitfor = 0
	while(m)
		sleep(10)
	if(x)
		spawn(10) del(x)

client/proc
	LoadSome(char_ckey,var/slot,var/name)
		var/firstletter=copytext(ckey, 1, 2)
		var/DIR = "Saves/[firstletter]/[ckey]/[char_ckey]"
#if DEBUGGING
		var/savefile/F
		if(fexists("[DIR]/savedebug.sav"))
			F = new("[DIR]/savedebug.sav")
		else
			F = new("[DIR]/save.sav")
		var/n
		F["SaveVersion"] >> mob.SV
		F["charname"]>>n
		if(n)
			var/obj/x=new(src)
			F["Image"]>>x
			src<<output(x,"[slot]")
			src<<output("[n]","[name]")
			spawn()
				RemovePortrait(mob,x)
#else
		var/savefile/F = new("[DIR]/save.sav")
		var/n
		F["SaveVersion"] >> mob.SV
		F["charname"]>>n
		if(n)
			var/obj/x=new(src)
			F["Image"]>>x
			src<<output(x,"[slot]")
			src<<output("[n]","[name]")
			spawn()
				RemovePortrait(mob,x)
#endif
datum
	proc
		NeverSave(var/list/L)
			return L
atom
	NeverSave(var/list/L)
		//add what we don't want to save
		L.Add("icon","icon_state","overlays","underlays")
		return ..(L) //return whatever the parent type does.

	Write(savefile/F,var/list/neversave=null)
		if(F)
			if(neversave==null)
				neversave = NeverSave(list())

			var/list/ol
			var/list/ul

			if(overlays!=initial(overlays)&&neversave.Find("overlays"))
				ol = overlays.Copy(1,0)
				overlays = initial(overlays)
				neversave.Remove("overlays")
			if(underlays!=initial(underlays)&&neversave.Find("underlays"))
				ul = underlays.Copy(1,0)
				underlays = initial(underlays)
				neversave.Remove("underlays")

			. = ..(F,neversave)

			if(ol!=null&&ol.len)
				overlays.Add(ol)
			if(ul!=null&&ul.len)
				underlays.Add(ul)

	Read(savefile/F)
		if(F)
			return ..(F)

	movable
		NeverSave(var/list/L)
			L.Add("screen_loc")
			return ..(L)

mob
	var
		Slot
		SV = 0
		tmp/Saving = 0
		tmp/SaveFailed = 0
		tmp/list/Profession = list()
	verb
		ConvertSave()
			var/firstletter=copytext(ckey, 1, 2)
			var/savefile/F = new("Saves/[firstletter]/[ckey]/SlotOne/save.sav")
			var/txtfile = file("Saves/[firstletter]/[ckey]/SlotOne/save.txt")

			fdel(txtfile)
			F.ExportText("Saves/[firstletter]/[ckey]/SlotOne/",txtfile)

			fdel(txtfile)
			F.ExportText("/",txtfile)

			F = new("Saves/[firstletter]/[ckey]/SlotOne/rebirth.sav")
			txtfile = file("Saves/[firstletter]/[ckey]/SlotOne/rebirth.txt")

			fdel(txtfile)
			F.ExportText("Saves/[firstletter]/[ckey]/SlotOne/",txtfile)

			fdel(txtfile)
			F.ExportText("/",txtfile)

			F = new("Saves/[firstletter]/[ckey]/SlotTwo/save.sav")
			txtfile = file("Saves/[firstletter]/[ckey]/SlotTwo/save.txt")

			fdel(txtfile)
			F.ExportText("Saves/[firstletter]/[ckey]/SlotTwo/",txtfile)

			fdel(txtfile)
			F.ExportText("/",txtfile)

			F = new("Saves/[firstletter]/[ckey]/SlotTwo/rebirth.sav")
			txtfile = file("Saves/[firstletter]/[ckey]/SlotTwo/rebirth.txt")

			fdel(txtfile)
			F.ExportText("Saves/[firstletter]/[ckey]/SlotTwo/",txtfile)

			fdel(txtfile)
			F.ExportText("/",txtfile)

	player
		Write(savefile/F,var/list/neversave=null)
			. = ..(F,neversave)
			F.dir.Remove("key")

mob/proc
	FindSaves()
		src<<output("Loading...","Splash.SlotOne")
		src<<output("Loading...","Splash.SlotTwo")
		var/firstletter=copytext(ckey, 1, 2)
		var/DIR = "Saves/[firstletter]/[ckey]/"
#if DEBUGGING
		if(fexists("[DIR]SlotOne/save.sav")||fexists("[DIR]SlotOne/savedebug.sav"))
			client.LoadSome("SlotOne","Splash.SlotOne","Splash.SlotOneName")
		else
			src<<output("Empty","Splash.SlotOne")
			src<<output("","[name]")
		if(fexists("[DIR]SlotTwo/save.sav")||fexists("[DIR]SlotTwo/savedebug.sav"))
			client.LoadSome("SlotTwo","Splash.SlotTwo","Splash.SlotTwoName")
		else
			src<<output("Empty","Splash.SlotTwo")
			src<<output("","[name]")
#else
		if(fexists("[DIR]SlotOne/save.sav"))
			client.LoadSome("SlotOne","Splash.SlotOne","Splash.SlotOneName")
		else
			src<<output("Empty","Splash.SlotOne")
			src<<output("","[name]")
		if(fexists("[DIR]SlotTwo/save.sav"))
			client.LoadSome("SlotTwo","Splash.SlotTwo","Splash.SlotTwoName")
		else
			src<<output("Empty","Splash.SlotTwo")
			src<<output("","[name]")
#endif
		/*var/mob/player/NP = new/mob/player(locate(200,200,3))
		client.mob = NP
		del(src)*/

	Save()
		if(Saving)
			Saving++
			if(Saving > 4)
				Saving = 0
				if(SavedMe())
					return 1
			return 0
		switch(SavedMe())
			if(1)
				SaveFailed = 0
				return 1
			else
				SaveFailed++
				return 0

	SavedMe()
		if(TotalSavePrevention || SavePrevention)
			return

		if(!Slot)
			alert(src,"Your Character seems to be corrupted, but it can be fixed")
			switch(alert(src,"Please select which slot this Character is on, (Note: Choose wisely or it will cause problems)","Which Slot","Slot One","Slot Two"))
				if("Slot One")
					Slot = "SlotOne"
				if("Slot Two")
					Slot = "SlotTwo"
			Repair_Start(src)
		if(!Saving)
			Saving = 1
			if(src && loggedin)
				var/firstletter=copytext(ckey, 1, 2)
				var/DIR = "Saves/[firstletter]/[ckey]/[Slot]"
				var/savefile/F = new("[DIR]/save.sav")
				F["charname"] << trueName
				F["Image"] << SelfImage
				F.cd = "LOC"
				F["x"] << x
				F["y"] << y
				F["z"] << z
				F.cd = "/Mob/"
				F << src
				. = 1
				spawn(10)
					Saving = 0
		else
			. = 0

	Load(char_ckey)
		var/firstletter=copytext(ckey, 1, 2)
		var/DIR = "Saves/[firstletter]/[ckey]/[char_ckey]/"

		var/savefile/F = new("[DIR]/save.sav")
#if DEBUGGING
		if(fexists("[DIR]/savedebug.sav"))
			F = new("[DIR]/savedebug.sav")
#else
		if(fexists("[DIR]/savedebug.sav"))
			fdel("[DIR]/savedebug.sav")
#endif
		F["charname"] >> name
		F["Image"] >> SelfImage
		F.cd = "LOC"
		var/last_x
		var/last_y
		var/last_z
		F["x"] >> last_x
		F["y"] >> last_y
		F["z"] >> last_z
		F.dir.Remove("key")
		F.cd = "/Mob/"
		F.dir.Remove("key")
		var/mob/player/P = null
		var/mob/OG = src
		F>>P
		if(P)
			P.loc = locate(last_x, last_y, last_z)
			P.LoginStuff()
			if(!P.key)
				P.key = key
			del OG
		else
			usr << "Your save failed to load, alert a gm of your key"
client
	Del()
		if(eye != mob)
			eye = mob
		..()

mob/player/Logout()
	if(src in MasterPlayerList)
		if(ElligibleKageList[Village][trueName])
			ElligibleKageList[Village][trueName] = 1
		if(SpyStatus && client)
			client.perspective= MOB_PERSPECTIVE|EDGE_PERSPECTIVE;
			client.eye = client.mob
			SpyStatus = 0
		MasterPlayerList-=src
		overlays = null
		underlays = null;
		icon = null;
		Targeting=null
		if(client)
			if(isTrading)
				CloseTradeWindow(tradingWith)
			client.perspective = MOB_PERSPECTIVE|EDGE_PERSPECTIVE; client.eye = src
		if(loggedin)
			if(BYONDMEMBER) world << "[Brand]<font color=#71C671><b>[trueName]/[key] has logged out!</b></font>"
			else world << "[Brand]<font color=#007bba><b>[trueName]/[key] has logged out!</b></font>"

		if(TempKage)
			SetTempKage(Village)

		if(hospital)
			for(var/obj/Hospital/Bed/BE in loc)
				if(istype(BE,/obj/Hospital/Bed/Head))
					BE.icon_state="head"
				else if(istype(BE,/obj/Hospital/Bed/SecondHeads))
					BE.inuse = 0
			for(var/obj/Hospital/Bed/b in get_step(src,SOUTH))
				b.icon_state="foot"

		if(Kage)
			if(VPEarned < KageVPNeeded)
				if(KageVPFailed >2)
					VPEject = 1
					CheckForKages(Village)
				else
					KageVPFailed++
					KageLastLogged[trueName] = world.realtime
					SetTempKage(Village)
			else
				KageVPFailed = 0
				KageLastLogged[trueName] = world.realtime
				SetTempKage(Village)

		for(var/obj/Scrolls/ChuuninScrolls/S in contents) S.loc=loc
		for(var/obj/Item/parcel/p in contents) del(p)

		for(var/mob/Hittable/Command/Clones/B in MasterBunshinList)
			del(B)

		for(var/mob/Hittable/Responsive/Animal/Pet/Dog/D in world)
			if(D.Master == src)
				del(D)
		var/mob/Hittable/Responsive/Animal/Pet/P=Familiar
		if(P)
			del P

		if(InSawa)
			for(var/atom/A in Bones)
				del A
			Taijutsu -= SawaBoost

		if(mirroring)
			MirrorTarget = 0
			mirroring = 0

			for(var/Mirror in MirrorDome)
				del(Mirror)
			for(var/Mirror in AllMirrors)
				del(Mirror)
		if(Thorn)
			ThornDeactivate()
		if(MirrorTarget)
			MirrorTarget.InMirrors = 0
		if(Giant)
			Akimichi_Revert()
		invisibility = 7
		see_invisible = 7
		for(var/obj/Clay/C in ClayBombs)
			del C
		if(ShiFoClone)
			var/mob/Hittable/Command/Clay/SC = ShiFoClone
			del SC
		for(var/mob/A in EdoCloneList)
			del A
		if(RaitonArmour)
			RaitonArmour = 0
			movespeed += 0.5
			Reflex -= RaitonRFX
			Taijutsu -= RaitonArmourGain
			RaitonArmourGain = 0
			overlays -= 'RaitonYoroi.dmi'
		MarkedThings = list()
		MarkedTargets = list()
		if(Marked)
			for(var/mob/A in MarkedMe)
				A.MarkedTargets -= A.trueName
			MarkedMe = list()
			Marked = 0
		for(var/obj/Clothing/Custom/TestOutfit/IT in contents)
			if(IT.worn)
				overlays -= IT.Overlay
			del IT
		icon_state = ""
		RETRY
		Saving = 0
		if(!Save())
			sleep(1)
			Saving = 0
			goto RETRY
	.=..()
	del(src)