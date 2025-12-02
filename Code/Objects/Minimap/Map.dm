mob/var
	mapon; GuageOn=1

mob/proc/RefreshMap()
	set background=1
	if(src.client&&src.z==1)
		var/obj/minimap/pointer/P = locate(/obj/minimap/pointer) in src.client.screen
		if(P&&P.dir!=src.dir)
			P.dir=src.dir
			if(P.invisibility) P.invisibility=0


		var/obj/minimap/minimap01/M = locate(/obj/minimap/minimap01) in src.client.screen
		if(M)
			if(M.invisibility) M.invisibility=0
			M.pixel_y=-(src.y-20)+11
			M.pixel_x=-(src.x-20)-5
			var/l="32:[M.pixel_x],17:[M.pixel_y]"
			M.screen_loc="minimap:[l]"

	else if(src.client)
		var/obj/minimap/minimap01/M = locate(/obj/minimap/minimap01) in src.client.screen
		if(M&&!M.invisibility) M.invisibility=1
		var/obj/minimap/pointer/P = locate(/obj/minimap/pointer) in src.client.screen
		if(P&&!P.invisibility) P.invisibility=1

obj/tracking
	tracker1
		icon='Pointers.dmi'
		icon_state="tracker"
		layer=3
		invisibility=1
		New(client/c)
			screen_loc="minimap:31:16,17"
			if(c) c.screen+=src
obj/minimap
	layer=1
	pointer
		layer=3
		icon='Pointers.dmi'
		icon_state="pointer"
		New(client/c)
			screen_loc="minimap:31:16,17"
			if(c) c.screen+=src
	minimap01
		icon='NEWminimap.dmi'
		New(client/c)
			screen_loc="minimap:32,17"
			if(c) c.screen+=src