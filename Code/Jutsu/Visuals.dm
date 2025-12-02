Overlay_Obj
	parent_type=/atom/movable
	mouse_opacity = 0
	name = "OL"
	New(i,L,X=0,Y=0,IState)
		if(i)
			var/icon/I = icon(i)
			icon = I
			if(L)
				layer = L
			if(!X && I.Width() != 32)
				X = (32-I.Width())*0.5
			pixel_x = X
			pixel_y = Y
			if(IState)
				vis_flags = VIS_INHERIT_DIR
				icon_state = IState
			else
				vis_flags = VIS_INHERIT_ICON_STATE|VIS_INHERIT_DIR
	Fog
		icon='Suitons.dmi'
		icon_state="Mist Fog"
		layer = 200

Underlay_Obj
	parent_type=/atom/movable
	mouse_opacity = 0
	//vis_flags = VIS_INHERIT_ICON_STATE|VIS_INHERIT_DIR //VIS_INHERIT_ICON|
	layer = FLOAT_LAYER-10
	name = "UL"
	New(i,L,X=0,Y=0,IState)
		if(i)
			var/icon/I = icon(i)
			icon = icon(I)
			if(L)
				layer = L
			if(!X && I.Width() != 32)
				X = (32-I.Width())*0.5
			pixel_x = X
			pixel_y = Y
			if(IState)
				vis_flags = VIS_INHERIT_DIR
				icon_state = IState
			else
				vis_flags = VIS_INHERIT_ICON_STATE|VIS_INHERIT_DIR

	AirPulse1
		icon='AirPulse1.dmi'
		icon_state = ""
		pixel_x = -32
		pixel_y = -32

Effect
	parent_type=/atom/movable
	invisibility = 5
	var
		tmp/mob/Owner

	Visual
		Trigrams
			icon='PalmsExternal.dmi'
			pixel_x = -32
			pixel_y = -32
			Small
				icon_state = "1"
			Large
				icon_state = "2"
		Dust
			icon = 'DustField.dmi'
			layer = 5
			New(LOC,DEL=1)
				..()
				loc = LOC
				icon_state = "Dust"
				if(DEL)
					spawn(50)
						del src
			Del()
				overlays=null
				icon_state = "DustF"
				sleep(8)
				..()
		KuchuNejire
			icon = 'AirBurst.dmi'
			bounds="160,160"
			pixel_x = -64
			pixel_y = -64
			New(turf/LOC)
				loc=LOC
				..()
				spawn(4)
					del src

		Inazuma
			icon='LightningBurst.dmi'
			bounds="160,160"
			pixel_x = -64
			pixel_y = -64
			New(turf/LOC)
				loc=LOC
				//pixel_y=-8
				..()
				spawn(9)
					del src

		KazanFunka
			icon='Katons96.dmi'
			icon_state = "Explosion"
			pixel_x = -32
			pixel_y = -32
			New(turf/LOC)
				loc=LOC
				//pixel_y=-8
				..()
				spawn(9)
					del src