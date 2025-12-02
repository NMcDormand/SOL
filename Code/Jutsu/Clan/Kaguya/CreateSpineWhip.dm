obj/SkillCards/Clan/Kaguya/Weapons/CreateSpineWhip
	icon_state="card_CreateSpineWhip"
	cmdstring="CreateSpineWhip"
	CCost=150
	Seals=1

	Description = list(
		"about"="Draw out two bones from your skeleton to use as a whip (relates to sword skill)."
		,"title"="Create Spine Whip"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="D"
//		,"pic"='CreateSpineWhip.png'
		)
	Activate(mob/U)
		var/obj/Weapon/Wield/SpineWhip/b = locate() in U.contents
		if(b||GENERICATTACKCHECK(U)) return
		var
			c=CCost;s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(15)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuUseChakra(c/U.KGCModifier)
				U.JutsuSeals(s); U.JutsuTai(c)
				U.MoveUses[name]++
				U<<"You remove your spinal column to use as a weapon."
				var/obj/Weapon/Wield/SpineWhip/W=new/obj/Weapon/Wield/SpineWhip(U)
				W.Durability+=(U.Taijutsu/2); W.MaxDurability+=W.Durability
				U.UpdateInventory()
