mob/NPC/Shopkeepers
	RamenChef
		name = "Ramen Chef"
		icon = 'Naruto Bases.dmi'
		icon_state = "chef"
		CantHenge=1
		protect=1
		Action(mob/user)
			if(get_dist(user,src)>2) return
			switch(input("What'll it be?.","Ramen Chef")in list("Ramen {2000}","Sake {500}","Never mind"))
				if("Ramen {2000}")
					if(user.gold>=2000) {user.gold-=2000; user<<"<i>Thankyou very much.</i>"; new/obj/Item/Ramen(user)}
					else user<<"<i>Sorry, you don't have enough gold.</i>"
				if("Sake {500}")
					if(user.gold>=500) {user.gold-=500; user<<"<i>Thankyou very much.</i>"; new/obj/Item/Sake(user)}
					else user<<"<i>Sorry, you don't have enough gold.</i>"
			user.UpdateInventory(); user.StatUpdate_gold()