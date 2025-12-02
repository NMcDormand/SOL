#define TILE_WIDTH 32
#define TILE_HEIGHT 32

world
    icon_size = 32

mob
	var
		Max_Tile_View =  2000

client
	var
		view_width
		view_height
		buffer_x
		buffer_y
		map_zoom
	verb
		onResize()
			set hidden = 1
			set waitfor = 0
			var/sz = winget(src,"MainMap","size")
			var/map_width = text2num(sz)
			var/map_height = text2num(copytext(sz,findtext(sz,"x")+1,0))
			map_zoom = 1
			view_width = floor(map_width/TILE_WIDTH)
			if(!(view_width%2)) ++view_width
			view_height = floor(map_height/TILE_HEIGHT)
			if(!(view_height%2)) ++view_height
			var/MVT = mob.Max_Tile_View
			while(view_width*view_height>MVT)
				view_width = floor(map_width/TILE_WIDTH/++map_zoom)
				if(!(view_width%2)) ++view_width
				view_height = floor(map_height/TILE_HEIGHT/map_zoom)
				if(!(view_height%2)) ++view_height

			buffer_x = floor((view_width*view_width - map_width/map_zoom)/2)
			buffer_y = floor((view_height*view_height - map_height/map_zoom)/2)

			view = "[view_width]x[view_height]"
			winset(src,"MainMap","zoom=[map_zoom];")