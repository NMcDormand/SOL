mob/proc
	GiveShuriken()
		var/counter=0
		for(var/obj/Weapon/Thrown/Shuriken/S in contents)
			counter++
		if(counter<=0)
			var/obj/Weapon/Thrown/Shuriken/X=new(src)
			X.amount=2
		else
			for(var/obj/Weapon/Thrown/Shuriken/S in contents)
				S.amount+=2
				S.Checkamount()
		UpdateInventory()
	GiveBandages()
		var/counter=0
		for(var/obj/Item/Bandages/S in contents) counter++
		if(counter<=0)
			var/obj/Item/Bandages/X=new(src); X.amount=5;
		else
			for(var/obj/Item/Bandages/S in contents)
				S.amount+=5; S.Checkamount();
		UpdateInventory()
proc/Engrave(mob/crafter)
	return "[crafter.Slot]|[crafter.ckey]"