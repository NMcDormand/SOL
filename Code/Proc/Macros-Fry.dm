#define DEFAULTMACS list("A"="A","B"="B","C"="C","D"="D","E"="E","F"="F","G"="G","H"="H","I"="I","J"="J","K"="k","L"="L","M"="M","N"="N","O"="O","P"="P","Q"="Q","R"="R","S"="S","T"="T","U"="U","V"="V","W"="W","X"="X","Y"="Y","Z"="Z","F1"="F1","F2"="F2","F3"="F3","F4"="F4","F5"="F5","F6"="F6","F7"="F7","F8"="F8","F9"="F9","F10"="F10","F11"="F11","F12"="F12","1"="1","2"="2","3"="3","4"="4","5"="5","6"="6","7"="7","8"="8","9"="9","0"="0","North"="North","South"="South","East"="East","West"="West","Northeast"="Northeast","Northwest"="Northwest","Southeast"="Southeast","Southwest"="Southwest","Escape"="Escape","Center"="Center","Pause"="Pause","Insert"="Insert","="="=","-"="-","Divide"="Divide","Multiply"="Multiply","Space"="Space","Tab"="Tab","Return"="Return","Add"="Add","Subtract"="Subtract","Delete"="Delete","`"="`",","=",","."="","/"="/",";"=";","'"="'","\["="\[","]"="]","\\"="\\","Numpad1"="Numpad1","Numpad2"="Numpad2","Numpad3"="Numpad3","Numpad4"="Numpad4","Numpad5"="Numpad5","Numpad6"="Numpad6","Numpad7"="Numpad7","Numpad8"="Numpad8","Numpad9"="Numpad9","Numpad0"="Numpad0","Capslock"="Capslock","Decimal"="Decimal")
#define AVAILABLE_KEYS list("A","B","C","D","E","F","G","H","I","J","k","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","1","2","3","4","5","6","7","8","9","0","North","South","East","West","Northeast","Northwest","Southeast","Southwest","Escape","Center","Pause","Insert","=","-","Divide","Multiply","Space","Tab","Return","Add","Subtract","Delete","`",",",".","/",";","'","\[","]","\\","Numpad1","Numpad2","Numpad3","Numpad4","Numpad5","Numpad6","Numpad7","Numpad8","Numpad9","Numpad0","Capslock","Decimal")
#define DEFAULTCMDS list("North","Northeast","Northwest","South","Southeast","Southwest","East","West")
var/list/Movers = list()
client
	verb
		MoveKey(Button as text|null,state as num)
			set instant = 1
			set hidden = 1
			//if(istype(mob,/mob/creation))
			//	return
			var/mob/player/M = mob
			sleep(-1)
			if(state)//turn on
				if(M.falling)
					return
				switch(Button)
					if("North")//1
						M.move_keys += 1
					if("South")//2
						M.move_keys += 2
					if("East")//4
						M.move_keys += 4
					if("West")//8
						M.move_keys += 8
					if("Northeast")//5
						M.move_keys += 5
						M.DiagHeld = 5
					if("Southeast")//6
						M.move_keys += 6
						M.DiagHeld = 6
					if("Northwest")//9
						M.move_keys += 9
						M.DiagHeld = 9
					if("Southwest")//10
						M.move_keys += 10
						M.DiagHeld = 10

				M.MoveBut++
				if(!(M in Movers))
					Movers+=M //Adds to global proc move list
				if(!MoveRunning)
					world.Movethem()
				return

			else//turn off
				switch(Button)
					if("North")//1
						M.move_keys -= 1
					if("South")//2
						M.move_keys -= 2
					if("East")//4
						M.move_keys -= 4
					if("West")//8
						M.move_keys -= 8
					if("Northeast")//5
						M.move_keys -= 5
						M.DiagHeld = 0
					if("Southeast")//6
						M.move_keys -= 6
						M.DiagHeld = 0
					if("Northwest")//9
						M.move_keys -= 9
						M.DiagHeld = 0
					if("Southwest")//10
						M.move_keys -= 10
						M.DiagHeld = 0

				M.MoveBut--
				if(M.MoveBut <= 0)
					Movers -= M
					M.move_keys=0
					M.MoveBut = 0
