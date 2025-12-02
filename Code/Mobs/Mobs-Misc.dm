mob/Kawarimi
	Del()
		overlays=null
		icon='kawarimi.dmi'
		sleep(7)
		..()

mob/PetalEscape
	Del()
		if(icon_state!="petal")
			icon_state="petal"
			spawn(3) overlays=null
		sleep(15)
		..()

mob/NPC/Misc
	Jailer
		name = "Jailer"
		icon = 'Naruto Bases.dmi'
		icon_state = "spawnman"
		protect=1
		CantHenge=1

		Action(mob/user)
			if(get_dist(user,src)>2) return
			user<<"<font color=red><i>Welcome to Jail.</i></font>"
			user<<"<font color=red><i>Use your time here to reflect on what you've done. If you don't, you will be seeing me again</i></font>"
//------------------------------------------------------------------------------------------------------------