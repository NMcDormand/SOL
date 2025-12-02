obj/SkillCards/Clan/Hyuuga/Byakugan_Search
	icon_state="card_Byakugan_Search"
	cmdstring="Byakugan_Scan"
	Range=32
	CanLevel = 0
	Description = list(
		"about"="Using the Byakugan, scan the area for targets"
		,"title"="Byakugan Search"
		,"type"="Doujutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='Byakugan.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		if(!U.InByakugan)
			U<<"You must activate Byakuagan first"
			return
		for(var/obj/Jutsu/Hyuuga/ByakuganTracker/T in U.client.screen)
			del(T)
		U.ByakuganLocate()

	verb/Byakugan_Look()
		set category="TECHNIQUES"
		set src in usr.contents
		var/mob/U = usr
		if(U.Searching)
			U.client.eye=U; U.Searching=0
		else
			if(GENERICATTACKCHECK(U)) return
			if(!U.InByakugan) {U<<"You must activate Byakuagan first"; return}
			var/obj/Jutsu/Hyuuga/ByakSearch/Byak=new(get_step(U,U.dir))
			Byak.Owner=U; U.Searching=1; U.client.eye=Byak; U.client.perspective=EYE_PERSPECTIVE; walk(Byak,U.dir)
			spawn(U.ByakuganRange)
				if(Byak) Byak.freeze=1
			spawn(U.ByakuganRange+10)
				if(Byak)
					del(Byak)
					U.client.eye=U
					U.Searching=0

obj
	Jutsu/Hyuuga
		ByakuganTracker
			icon='Pointers.dmi'
			icon_state="byakugan_tracker"
			layer=3
			New(client/c)
				screen_loc="minimap:31:16,17"
				if(c)
					c.screen+=src
				spawn(120)
					del src
		ByakSearch
			New()
				spawn(3) SearchCheck(Owner)

	proc
		SearchCheck(mob/M)
			while(M && M.Searching)
				sleep(1)
			del(src)

mob/proc/ByakuganLocate()
	set waitfor = 0
	for(var/mob/M in range(ByakuganRange,src))
		if(M!=src && M.Creator!=src && (istype(M,/mob/player) || istype(M,/mob/Hittable/Responsive) || istype(M,/mob/Hittable/Command/Clones)))
			var/obj/Jutsu/Hyuuga/ByakuganTracker/T = new/obj/Jutsu/Hyuuga/ByakuganTracker(client)
			if(T)
				if(istype(M,/mob/Hittable/Responsive))
					T.icon_state="NPC_tracker"
				TrackLocation(T,M)
				spawn(50)
					if(T)
						del T


mob/proc/TrackLocation(obj/T,mob/m)
	set waitfor = 0
	while(T)
		if(src && m)
			var
				mob_x = min(abs(x-m.x),64)
				mob_y = min(abs(y-m.y),64)
			if(mob_x>ByakuganRange||mob_y>ByakuganRange) T.invisibility=1
			else T.invisibility=0
			if(x>m.x) mob_x = -mob_x
			if(y>m.y) mob_y = -mob_y
			T.pixel_x = mob_x+16
			T.pixel_y = mob_y
			var/L="31:[T.pixel_x],17:[T.pixel_y]"
			T.screen_loc = "minimap:[L]"
			sleep(2)
		else
			break