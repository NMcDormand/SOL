SavedLoc
	var
		x
		y
		z

	New(turf/A)
		if(A)
			x = A.x
			y = A.y
			z = A.z

	proc
		SaveMe(turf/A)
			if(A)
				x = A.x
				y = A.y
				z = A.z
		FindMe()
			var/turf/A = locate(x,y,z)
			return A