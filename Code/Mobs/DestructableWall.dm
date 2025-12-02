obj
obj/Destructable
	density=1
	HEALTH=2000000
	RockyCliffMiddle
		name="C05"
		icon='Terrain1.dmi'
		icon_state="h5"
	RockyCliffBottom
		name="C02"
		icon='Terrain1.dmi'
		icon_state="h2"
	GrassyCliffMiddle
		name="C05"
		icon='Terrain3.dmi'
		icon_state="h5"
	GrassyCliffBottom
		name="C02"
		icon='Terrain3.dmi'
		icon_state="h2"
	Rock
		HEALTH=4000000000000
		name="Rock"

		icon='Misc.dmi'
		icon_state="rock"
	Trunk
		HEALTH=10000000
		bound_height=32
		bound_width=32
		pixel_x = -16
		name="TrunkA"
		icon='Tree3.dmi'
		//icon_state="2"
		//Stamina = 250000
		Del()
			overlays -= Overlay
			..()