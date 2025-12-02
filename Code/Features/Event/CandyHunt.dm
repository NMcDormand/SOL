
obj/Event/CandyHunt
	verb
		Get()
			set src in oview(1)
			var/obj/Event/CandyHunt/F= locate() in usr.contents
			if(!F)
				F = new(usr)
				usr.UpdateInventory()
			else
				F.amount+=amount
				F.Checkamount()
				usr.UpdateInventory()
				del(src)
		Drop()
			usr.DropStackedItems(src)
	Candy1
		name="Red Candy"
		trueName="Red Candy"
		icon='Ghost.dmi'
		icon_state="redCandy"
		price=5
		amount=1
		ItemType="Food"
	Candy2
		name="Blue Candy"
		trueName="Blue Candy"
		icon='Ghost.dmi'
		icon_state="blueCandy"
		price=5
		amount=1
		ItemType="Food"
	Candy3
		name="Green Candy"
		trueName="Green Candy"
		icon='Ghost.dmi'
		icon_state="greenCandy"
		price=5
		amount=1
		ItemType="Food"
	Candy4
		name="Large Candy"
		trueName="Large Candy"
		icon='Ghost.dmi'
		icon_state="largeLolly"
		price=500
		amount=1
		ItemType="Food"