obj/hudMeters
	GuageBackground
		layer=97
		G_01
			icon='GBG.png'
			New(client/c)
				screen_loc="GaugeMap:1,1"
				if(c) c.screen+=src

		G_02
			icon='GBG.png'
			New(client/c)
				screen_loc="GaugeMap:2,1"
				if(c) c.screen+=src
		G_03
			icon='GBG.png'
			New(client/c)
				screen_loc="GaugeMap:1,2"
				if(c) c.screen+=src
		G_04
			icon='GBG.png'
			New(client/c)
				screen_loc="GaugeMap:2,2"
				if(c) c.screen+=src
	Guage
		layer=100
		G_01
			icon='Guage1.png'
			New(client/c)
				screen_loc="GaugeMap:1,1"
				if(c) c.screen+=src

		G_02
			icon='Guage2.png'
			New(client/c)
				screen_loc="GaugeMap:2,1"
				if(c) c.screen+=src
		G_03
			icon='Guage3.png'
			New(client/c)
				screen_loc="GaugeMap:1,2"
				if(c) c.screen+=src
		G_04
			icon='Guage4.png'
			New(client/c)
				screen_loc="GaugeMap:2,2"
				if(c) c.screen+=src
	Stamina
		layer=99
		health_01
			icon='Stamina1.dmi'
			icon_state="0"
			New(client/c)
				screen_loc="GaugeMap:1,1"
				if(c) c.screen+=src

		health_02
			icon='Stamina2.dmi'
			icon_state="0"
			New(client/c)
				screen_loc="GaugeMap:2,1"
				if(c) c.screen+=src
		health_03
			icon='Stamina3.dmi'
			icon_state="0"
			New(client/c)
				screen_loc="GaugeMap:1,2"
				if(c) c.screen+=src
		health_04
			icon='Stamina4.dmi'
			icon_state="0"
			New(client/c)
				screen_loc="GaugeMap:2,2"
				if(c) c.screen+=src
	Wounds
		layer=101
		wounds_01
			New(client/c)
				screen_loc="GaugeMap:1,2"
				pixel_y-=16
				if(c) c.screen+=src
		wounds_02
			New(client/c)
				screen_loc="GaugeMap:2,2"
				pixel_y-=16
				if(c) c.screen+=src
		wounds_03
			New(client/c)
				screen_loc="GaugeMap:1,1"
				pixel_y-=16
				if(c) c.screen+=src
		wounds_04
			New(client/c)
				screen_loc="GaugeMap:2,1"
				pixel_y-=16
				if(c) c.screen+=src

	Chakra
		layer=98
		chakra_01
			icon='Chakra1.dmi'
			icon_state="0"
			New(client/c)
				screen_loc="GaugeMap:1,1"
				if(c) c.screen+=src
		chakra_02
			icon='Chakra2.dmi'
			icon_state="0"
			New(client/c)
				screen_loc="GaugeMap:1,2"
				if(c) c.screen+=src
		chakra_03
			icon='Chakra3.dmi'
			icon_state="0"
			New(client/c)
				screen_loc="GaugeMap:2,2"
				if(c) c.screen+=src