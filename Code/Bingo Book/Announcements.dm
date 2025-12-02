mob/var/tmp/RecentlyNotified
mob/proc/CheckEntry()
	if(!BingoBookAssociations) BingoBookAssociations=new()
	var/delay=5
	for(var/mob/player/m in MasterPlayerList)
		if(InVillage==m.Village&&BingoBookAssociations[m.Village]&&!(m.RecentlyNotified))
			if(m.InVillage!=m.Village) delay+=40
			spawn(delay)
				if(InVillage==m.Village&&BingoBookAssociations[m.Village]&&!(m.RecentlyNotified))
					m<<"<font size=2><b><i>[src] has just been detected entering [m.Village] Village!</i></b></font>"
					if(m.InVillage==m.Village) m<<"<b><i>[src] entered [dir2text(get_dir(m,src))] of your position!</i></b>"
					m.RecentlyNotified=1; spawn(delay) m.RecentlyNotified=0
mob/proc/CheckExit()
	if(!BingoBookAssociations) BingoBookAssociations=new()
	var/delay=5
	for(var/mob/player/m in MasterPlayerList)
		if(InVillage==m.Village&&BingoBookAssociations[m.Village]&&!(m.RecentlyNotified))
			if(m.InVillage!=m.Village) delay+=40
			spawn(delay)
				if(InVillage!=m.Village&&BingoBookAssociations[m.Village]&&!(m.RecentlyNotified))
					m<<"<b><i>[src] has just been detected exiting [m.Village] Village!</i></b>"
					if(m.InVillage==m.Village) m<<"<b><i>[src] exited [dir2text(get_dir(m,src))] of your position!</i></b>"
					m.RecentlyNotified=1; spawn(delay) m.RecentlyNotified=0

mob/proc/dir2text(DIRECTION)
	switch(DIRECTION)
		if(1) return "North"
		if(5) return "North-East"
		if(4) return "East"
		if(6) return "South-East"
		if(2) return "South"
		if(10) return "South-West"
		if(8) return "West"
		if(9) return "North-West"