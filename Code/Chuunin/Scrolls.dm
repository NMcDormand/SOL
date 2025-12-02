obj/Scrolls/ChuuninScrolls
	HeavenScroll
		name="Heaven Scroll"
		icon='HEscrolls.dmi'
		icon_state="Heaven"
		Get()
			set src in oview(1)
			if(usr.KO) return
			if(!usr.HasHeaven)
				loc=usr; usr.HasHeaven=1; usr.UpdateInventory()
				usr<<"You get the Heaven Scroll!"; return
			else {usr<<"You already have a Heaven Scroll!"; return}

	EarthScroll
		name="Earth Scroll"
		icon='HEscrolls.dmi'
		icon_state="Earth"
		Get()
			set src in oview(1)
			if(usr.KO) return
			if(!usr.HasEarth)
				loc=usr; usr.HasEarth=1; usr.UpdateInventory()
				usr<<"You get the Earth Scroll!"; return
			else {usr<<"You already have an Earth Scroll!"; return}