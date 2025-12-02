mob/verb/HotbarSlotTwo()
	for(var/obj/SkillCards/S in usr)
		if(!S.slot)
			S.slot = list()
		if(S.slot["HotBar"]=="2")
			var/f=/mob/VerbHolder/Admin/Level2/verb/Teleport
			call(src, f)()

/*
mob/verb/HotbarSlotTwo()
	for(var/obj/SkillCards/S in usr)
		if(HB_Slot=="2") S.USE()

obj/SkillCards/Attack
	name="Punch"
	cmdstring="attack-fist"
	HB_slot="2"
	Click(x,y)
		if((src in usr)&&(findtext("[y]","HotBar"))) attack_fist()	//if the object is in a certain window control, execute a certain verb
		else ..()
	verb
		USE()
			usr.attack_fist()
		attack_fist()
			//verb stuff here
*/
