obj/var/grabbed
var/list/CatsSpawned = list()
obj/Item/Cat
	name="Cat"
	icon='CatNew.dmi'
	density=1
	var/Coord
	Drop()
		set src in usr.contents
		usr << "Wherefore wouldst thee dropeth this carnivorous mammal?"
	Get()
		set src in orange(1)
		CatsSpawned -= src
		grabbed=1; loc=usr; usr.UpdateInventory(); SpawnAnotherCat()
	New()
		..()
		spawn()
			pick(CatWander1(),CatWander2(),CatWander3())
		trueName = name
		icon=icon(pick('BlackCat.dmi','BrownCat.dmi','WhiteCat.dmi'))
		if(loc)
			Coord = loc.loc.name
			CatsSpawned += src

obj/proc/
	CatWander1()
		set background=1,waitfor = 0
		while(!grabbed)
			step_rand(src)
			sleep(17)
	CatWander2()
		set background=1,waitfor = 0
		while(!grabbed)
			step_rand(src)
			sleep(17)
	CatWander3()
		set background=1,waitfor = 0
		while(!grabbed)
			step_rand(src)
			sleep(17)

proc/SpawnAnotherCat()
	var/area/A=pick(AreaList)
	var/list/R=list()
	for(var/turf/T in A)
		if(!istype(T,/turf/terrain/Water) && !T.density && !T.contents.len)
			R+=T
	if(R.len)
		var/turf/Z=pick(R)
		new/obj/Item/Cat(Z)
		new/obj/Item/Cat(pick(R))

mob/proc/TrackCat(obj/T)
	if(T&&!T.grabbed&&T.z==1&&z==1)
		var
			Cat_X=min(abs(x-T.x),64)
			Cat_Y=min(abs(y-T.y),64)
		if(x>T.x) Cat_X=-Cat_X
		if(y>T.y) Cat_Y=-Cat_Y
		var/obj/tracking/tracker1/P = locate(/obj/tracking/tracker1) in client.screen
		if(P)
			P.invisibility=7
			if(abs(Cat_X)==64||abs(Cat_Y)==64)
				P.icon_state="tracker_dir"
				if(Cat_X==64)
					if(Cat_Y==64) P.dir=5
					else if(Cat_Y==-64) P.dir=6
					else P.dir=4
				else if(Cat_X==-64)
					if(Cat_Y==64) P.dir=9
					else if(Cat_Y==-64) P.dir=10
					else P.dir=8
				else if(Cat_Y==64)
					P.dir=1
				else if(Cat_Y==-64)
					P.dir=2
			else
				P.icon_state="tracker"
			P.pixel_y=Cat_Y
			P.pixel_x=Cat_X+16
			var/l="31:[P.pixel_x],17:[P.pixel_y]"
			P.screen_loc="minimap:[l]"
	spawn(3)
		if(Tracking&&T&&!T.grabbed&&z==1)
			TrackCat(T)
		else
			Tracking=0
			var/obj/tracking/tracker1/t = locate(/obj/tracking/tracker1) in client.screen
			if(t) t.invisibility=50

