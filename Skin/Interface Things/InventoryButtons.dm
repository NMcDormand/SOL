obj/var
	ItemSlot="none"
	OnSpeedRail

var/DragNDropList=list("speedrail.ItemSlot_08","speedrail.ItemSlot_07","speedrail.ItemSlot_06","speedrail.ItemSlot_05","speedrail.ItemSlot_04","speedrail.ItemSlot_03","speedrail.ItemSlot_02","speedrail.ItemSlot_01","Inventory.ItemGrid")

mob/var/SpeedRailSlotsUsed[]
obj
	Click(location,x)
		if((src in usr.contents)&&(x=="Inventory.ItemGrid"))
			usr.ItemStats(src)
		if((src in usr.contents)&&(x=="Trade.grid1"))
			if(usr.tradeitems <= 9)
				usr.undoTradeLock()
				if(amount > 1)
					var/itemAmount=input("How many?","Trade Items") as null|num
					upForTrade+=itemAmount
				else
					upForTrade=1;
				usr.tradeitems++
				usr.updateTradeWindow(usr.tradingWith)
		if((src in usr.contents)&&(x=="Trade.grid2"))
			usr.undoTradeLock()
			usr.tradeitems--
			upForTrade=0
			usr.updateTradeWindow(usr.tradingWith)
		if(x=="Trade.grid3") //If the item isn't yours - leave it be!
			return

	MouseDrop(over_object=src,src_location,over_location, src_control,over_control,params)
		if(!(usr.SpeedRailSlotsUsed))
			usr.SpeedRailSlotsUsed=new()
		if((src in usr.contents) && (src_control in DragNDropList) && (over_control in DragNDropList) && (src_control!=over_control))
			usr.SpeedRailSlotsUsed["[src_control]"]=null

			if(over_control!="Inventory.ItemGrid")	//if placing on SR
				OnSpeedRail=1; usr.SpeedRailSlotsUsed["[over_control]"]=src

			if(over_control=="Inventory.ItemGrid")	//if placing in pack
				OnSpeedRail=0

			ItemSlot="[over_control]"

			for(var/obj/o in usr.contents)
				if(o.ItemSlot==over_control&&o!=src&&over_control!="Inventory.ItemGrid")
					if(src_control!="Inventory.ItemGrid")
						usr.SpeedRailSlotsUsed["[src_control]"]=o
						o.OnSpeedRail=1
					else
						o.OnSpeedRail=0
					o.ItemSlot="[src_control]"
		usr.UpdateInventory()
		..()
mob
	verb
		OpenInventory()
			set hidden=1
			if(usr.TakingExam||!usr.client||!(usr.loggedin)) return
			usr.ShowInventory()

	proc
		ShowInventory()
			if(isTrading) return
			if(client)
				UpdateInventory(0)
				InventoryOpen = 1
				winshow(src,"Inventory",1)

		closeInventory()
			winshow(src,"Inventory",0)
			InventoryOpen = 0

		SpeedRailCheck()
			set waitfor = 0
			for(var/obj/o in contents)
				if(o.OnSpeedRail)
					src<<output(o,"[o.ItemSlot]")

		ItemStats(obj/O)
			if(!O.price)O.price=0
			if(!O.ItemType)O.ItemType="N/A"
			if(!O.Durability)O.Durability=0
			if(!O.MaxDurability)O.MaxDurability=1
			if(!O.Weight)O.Weight=1
			if(!O.Description)O.Description="N/A"
			if(!O.price)O.price=1
			if(!O.amount)O.amount=1
			winset(src,null,"Inventory.ItemType.text='[O.ItemType]'; Inventory.ItemQuantity.text='[O.amount]';\
			Inventory.ItemDurability.text='[(O.Durability/O.MaxDurability)*100]%'; Inventory.ItemWeight.text='[O.Weight]';\
			Inventory.ItemValue.text='[O.price]'; Inventory.ItemDescription.text='[O.Description]'; Inventory.ItemName.text='[O.name]'")
			src << output("\icon [O]", "Inventory.ItemOutput")