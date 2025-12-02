var/feathers = 1
var/partyActive = 0

proc/x3Respawn(L)
	var/r=list()
	for(var/turf/R in range(1,L)) r+=R
	var/turf/respawn=pick(r)
	if(respawn.density) return L
	else return respawn

mob/VerbHolder/Admin/Creator/verb
	ChickenParty()
		if(!partyActive)
			partyActive = 1
			world<<"<font color=red><b>[usr] has started a chicken party!</b></font>"
			feathers = 3
			spawn(4200)
				if(partyActive)
					world<<"<font color=red>Farmers are angry and have stopped the chicken party!</b></font>"
					partyActive = 0
					feathers = 1

		else
			partyActive = 0
			world<<"<font color=red><b>[usr] has stopped the chicken party!</b></font>"
			feathers = 1


