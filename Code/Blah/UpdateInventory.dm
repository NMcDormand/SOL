mob
	var
		InventoryOpen = 0

mob/proc
	UpdateInventory(SaveMe=1)
		set waitfor = 0
		if(!InventoryOpen) return
		if(!client) return
		if(!(SpeedRailSlotsUsed)) SpeedRailSlotsUsed=new()
		var/items=0

		//If player is in trade, display items within the trade window, otherwise show inventory
		if(!isTrading)
			for(var/obj/O in src)
				if((!O.OnSpeedRail) && (O.amount>0) && (istype(O,/obj/Item) || istype(O,/obj/Clothing/Head/KageHat) || istype(O,/obj/Weapon/Wield) || istype(O,/obj/Weapon/Thrown) || istype(O,/obj/Fish) || istype(O,/obj/Scrolls) || istype(O,/obj/Clothing) || istype(O,/obj/Event)))
					winset(src, "Inventory.ItemGrid", "current-cell=[++items]")
					src << output(O, "Inventory.ItemGrid")
				if(O.Stackable)
					O.Checkamount()
			winset(src, "Inventory.ItemGrid", "cells=[items]")
			if(SaveMe && !Saving)
				Save()

		for(var/slot in SpeedRailSlotsUsed)
			if(!(SpeedRailSlotsUsed["[slot]"])&&slot!="Inventory.ItemGrid")//if not used
				src<<output(null,"[slot]")
				Label_QTY(,slot)
			else if(SpeedRailSlotsUsed["[slot]"]&&slot!="Inventory.ItemGrid")
				var/obj/o=SpeedRailSlotsUsed["[slot]"]
				src<<output(o,"[slot]")
				Label_QTY(o,slot)

	Label_QTY(obj/ITEM,SLOT)
		switch(SLOT)
			if("speedrail.ItemSlot_01") SLOT = "speedrail.QTY1"
			if("speedrail.ItemSlot_02") SLOT = "speedrail.QTY2"
			if("speedrail.ItemSlot_03") SLOT = "speedrail.QTY3"
			if("speedrail.ItemSlot_04") SLOT = "speedrail.QTY4"
			if("speedrail.ItemSlot_05") SLOT = "speedrail.QTY5"
			if("speedrail.ItemSlot_06") SLOT = "speedrail.QTY6"
			if("speedrail.ItemSlot_07") SLOT = "speedrail.QTY7"
			if("speedrail.ItemSlot_08") SLOT = "speedrail.QTY8"
			else SLOT=null
		if(ITEM && ITEM.amount>0 && client) winset(src, "[SLOT]", "text=[ITEM.amount]")
		else if(client) winset(src, "[SLOT]", "text=")

mob/verb/Fix_Inventory()
	for(var/obj/O in usr.contents)
		O.OnSpeedRail=0; O.ItemSlot="Inventory.ItemGrid"
	usr.SpeedRailSlotsUsed=new()
	usr.SpeedRailSlotsUsed["speedrail.ItemSlot_01"]=null
	usr.SpeedRailSlotsUsed["speedrail.ItemSlot_02"]=null
	usr.SpeedRailSlotsUsed["speedrail.ItemSlot_03"]=null
	usr.SpeedRailSlotsUsed["speedrail.ItemSlot_04"]=null
	usr.SpeedRailSlotsUsed["speedrail.ItemSlot_05"]=null
	usr.SpeedRailSlotsUsed["speedrail.ItemSlot_06"]=null
	usr.SpeedRailSlotsUsed["speedrail.ItemSlot_07"]=null
	usr.SpeedRailSlotsUsed["speedrail.ItemSlot_08"]=null
	usr.UpdateInventory()