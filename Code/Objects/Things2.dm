obj/Items
	parcel
		name="Parcel"
		icon='MissionItems.dmi'
		icon_state="Parcel"
obj
	proc
		Checkamount()
			src.name= "[src.name1] ([src.amount])"

		Check_Durability(mob/M)
			if(!M.client) return
			if(src.Durability<=0)
				if(src.worn)
					M.overlays-=src.icon
					M.wielding=null
					M.atkspeed=3
				if(M.fishing)
					M.overlays-='Rod.dmi'
					M.fishing=0
					M.cantwalk--
				M<<"Your [src.name] shattered!"
				if(src.bones) {src.loc=null; M.UpdateInventory(); del(src)}
				else {src.icon_state="broken"; M.EquipRemove_Weapon(src,src.icon); M.UpdateInventory()}
mob/var/tmp
	TakenDamage; UsingBandages=0

obj
	Del()
		src.loc=null
		sleep(10)
		..()
obj/proc/Destroy(DAMAGE,mob/M)
	if(DAMAGE>0&&src.Owner!=M)
		src.HEALTH-=DAMAGE
		if(src.HEALTH<=0) del(src)