/*proc/getturf(var/atom/movable/A)
	while(A && istype(A))
		A = A.loc
	if(isturf(A))
		return A
	return null

proc/isblocked(var/turf/start, var/turf/end)
	start = getturf(start)
	end = getturf(end)
	if(!start || !end || start.z != end.z) return 0
	var/dx = end.x - start.x
	//special case: vertical alignment
	if(dx == 0)
		for(var/turf/T in block(start,end))
			if(T.density)
				return 1
			return 0

	var/dy = end.y - start.y
	var/ratio = abs(dy / dx)
	var/x = start.x
	var/y = start.y
	var/z = start.z
	var/count = 0
	var/turf/curturf
	var/xstep = dx>0?1:-1
	var/ystep = dy>0?1:-1
	do
		curturf = locate(x,y,z)
		if(curturf.density) return 1
		if(count < 1)
			count += ratio
			x += xstep
		else
			y += ystep
			count--
	while(curturf && curturf != end)
	return 0*/

/*
======= THIS IS STUFF TO ADD LATER - DISTANCE FROM MOB AND WHEN THE TARGET LOGS OUT! ========

client
	Move()
		if(ismob(mob.Targeting)&&get_dist(mob.Targeting,mob)>= 9)
			mob.DeleteTarget()
		..()
client/Del()
	..()
	if(ismob(mob.Targeting))
		mob.DeleteTarget()

*/


