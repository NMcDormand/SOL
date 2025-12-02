ibjct/*proc
	GetMapImage(zlevel=1)
		var/icon/img = new('maptemplate.dmi'),turf/T,icon/A,icon/B,X,Y,XX = world.maxx,YY = 570,Map/O,list/Tiles=list(),list/OBs = list()
		img.Crop(1,1,XX*4,YY*4)
		var/BX=1,BY=1
		for(Y=1 to YY)
			BX = 1
			for(X=1 to XX)
				T = locate(X,Y,zlevel)
				A = T.icon
				A.Scale(4,4)
				img.Blend(A,ICON_OVERLAY,BX,BY)
				for(O in T.contents)
					/*if(ismob(O) && !istype(O,/mob/Hittable/Unresponsive/Training/Cactus) &&!istype(O,/mob/Hittable/Unresponsive/Training/Stump))
						continue
					if(isobj(O) && !istype(O,/Map))
						continue*/
					B = new(O.icon,O.icon_state,O.dir)
					B.Scale(4,4)
					//A.Blend(B,ICON_OVERLAY,BX,BY)
					img.Blend(B,ICON_OVERLAY,BX,BY)
				BX+=4
			BY+=4
		return img

mob/verb/TestMap()
    src<<ftp(GetMapImage(zlevel=1),"Map.dmi")
*/

mob/var
	mapon
	GuageOn=1
	tmp
		obj/minimap/pointer/MiniPoint
		obj/minimap/minimap01/MiniMap

mob/proc/RefreshMap()
	set background=1
	if(client)
		var/obj/minimap/pointer/P = MiniPoint
		var/obj/minimap/minimap01/M = MiniMap

		if(z==1)
			if(P && P.dir!=dir)
				P.dir=dir
				if(P.invisibility) P.invisibility=0

			if(M)
				if(M.invisibility) M.invisibility=0
				M.pixel_x=-(x-20)-5
				M.pixel_y=-(y-20)+13
				var/l="32:[M.pixel_x],17:[M.pixel_y]"
				M.screen_loc="minimap:[l]"

		else
			if(M && !M.invisibility) M.invisibility=50
			if(P && !P.invisibility) P.invisibility=50

obj/tracking
	tracker1
		icon='Pointers.dmi'
		icon_state="tracker"
		layer=3
		invisibility=50
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
			if(c)
				c.screen+=src
				c.mob.MiniPoint = src
	minimap01
		icon='NEWminimap.dmi'
		New(client/c)
			screen_loc="minimap:32,17"
			if(c)
				c.screen+=src
				c.mob.MiniMap = src