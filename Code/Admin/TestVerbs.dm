mob/verb/X()
	winset(usr,"Items_Pane.Inventory_Icons",{"cells="5x1""})
	winshow(usr,"NewInventory",1)
	var
		r=1; c=0
	for(var/obj/O in usr.contents)
		if((istype(O,/obj/Items)||istype(O,/obj/weapon)||istype(O,/obj/Fish)||istype(O,/obj/Scrolls)||istype(O,/obj/Clothing)))
			usr << output(O, "Items_Pane.Inventory_Icons:[++c],[r]")
			if(c>7) {c=0; r++}