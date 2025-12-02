mob
	verb
		ShowLocation()
			var
				posX = usr.x-8
				posY = abs(usr.y-570)-8
			winset(usr,"WorldMap.Marker","pos=[posX],[posY]")
mob/proc/TrackBug(mob/T)
	if(T)
		var {x=T.x-8; y=abs(T.y-570)-8}
		return "[x],[y]"
/*
save coords when not on main world
tracking for aburame and inuzuka
players should visually know and have message when being tracked by pee
player names

live tracking

use foomer's gradient thingy to cloud off unXPlored areas

byakugan allowances: shows people within range; colour coded by village.
names for own people?
*/