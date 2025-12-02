mob/var/tmp
	ExplosionNoteMOBList=list()
	Explosive
obj/Weapon/Wield/ExplosiveNote
	name="Explosion Note"
	icon='ExplosionNote.dmi'
	icon_state="placed"

obj/Weapon/Wield/ExplosionNote
	name="Explosion Note"
	trueName="Explosion Note"
	icon='ExplosionNote.dmi'
	icon_state="inventory"
	price=10
	Stackable = 1
	NotSellable=1
	amount=1
	tmp/Placed = 0
	Get()
		set src in oview(1)
		if(Placed)
			return
		var/obj/Item/F = locate(type) in usr
		if(!F)
			loc=usr
			usr.UpdateInventory()
		else
			F.amount+=amount; F.Checkamount(); usr.UpdateInventory(); del(src)
	Click()
		..()
		if(src in usr.contents)
			if(OnSpeedRail) return
			else usr.ItemStats(src)
		else
			if(usr.clicked_item) return
			usr.clicked_item = 1
			spawn(10) usr.clicked_item = 0
			Get()
	verb
		AttachToKunai()
			set name="Attach To Kunai"
			var/obj/Weapon/Wield/Kunai/K=locate(/obj/Weapon/Wield/Kunai) in usr.contents
			if(K)
				K.Explosive=1; K.icon_state="Tagged"; K.name="Explosive Kunai"
				amount--; Checkamount()
				if(amount<1) del(src)
				usr.UpdateInventory()
			else {usr<<"There arent any Kunai in your Weapons pocket."; return}

		PlaceNoteOnBunshin(mob/M in oview(1,usr))
			set desc="Place an Explosion note on a bunshin of yours"
			if(TAICHECKBOTH(usr,M)) return
			if(!(M in usr.MasterBunshinList)) {usr<<"They aren't one of your Bunshins!"; return}
			if(M in usr.ExplosionNoteMOBList) {usr<<"They already have an Explosion note on!"; return}
			M.Explosive=1; usr.ExplosionNoteMOBList+=M; usr<<"You placed an Explosion note on the bunshin"
			amount--; Checkamount()
			if(amount<1) del(src)
			usr.UpdateInventory()

		PlaceNoteOnGround()
			set desc="Place an Explosion note on the ground"
			if(GENERICATTACKCHECK(usr)) return
			var/obj/Weapon/Wield/ExplosiveNote/E=new(usr.loc)
			E.Placed = 1
			E.layer = MOB_LAYER-1
			usr<<"You placed the [trueName] on the ground. In 5 seconds it will be activated. it will deteriorate in 2 minutes"
			spawn(50)
				E.Owner=usr
				E.ProximityCheck(usr)
			spawn(1200)
				if(E)
					del(E)
			amount--; Checkamount()
			if(amount<1) {loc=null; spawn(1) del(src)}
			usr.UpdateInventory()

		Drop()
			var/dropno = input("Drop how many Explosion Notes?","Drop",) as num
			dropno=round(dropno); if(dropno<1) return
			for(var/obj/Weapon/Wield/ExplosionNote/S in usr.contents)
				if(dropno>S.amount)
					usr<<"You don't have that many."; return
				else
					S.amount-=dropno; usr<<"You drop [dropno] Explosion Notes."; S.Checkamount()
					var/obj/Weapon/Wield/ExplosionNote/O=new(usr.loc)
					O.amount=dropno; O.Checkamount()
					if(S.amount<=0) del(S)
					usr.UpdateInventory()

obj/proc
	ProximityCheck(mob/O)
		var/found = 0
		while(O && src)
			for(var/mob/M in range(src,3))
				if(M!=O && M.Creator!=O && M)
					found++
					range(4,src)<<"An Explosion Note has been detonated nearby!"
					switch(get_dist(M,src))
						if(3)
							M.DamageMe(O,9000,src)
						if(2)
							M.DamageMe(O,27000,src)
						else
							M.DamageMe(O,45000,src)
			if(found)
				flick('Explode.dmi',src)
				break
			sleep(10)
		del(src)
mob/proc
	ExplosiveBunshin()
		for(var/mob/M in range(3,src))
			if(M!=src)
				switch(get_dist(src,M))
					if(3) M.DamageMe(src,9000,"Explosion")
					if(2) M.DamageMe(src,27000,"Explosion")
					if(1) M.DamageMe(src,45000,"Explosion")
		flick('Explode.dmi',src)
		del(src)