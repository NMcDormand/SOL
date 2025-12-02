obj/SkillCards/Clan/Kaguya/Weapons/CreateBoneKunai
	icon_state="card_CreateBoneKunais"
	cmdstring="CreateBoneKunai"
	CCost=100
	Seals=1
	Description = list(
		"about"="Draw out two bones from your skeleton to use as kunais."
		,"title"="Create Dual Bone Kunais"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="D"
//		,"pic"='CreateBoneKunais.png'
		)
	Activate(mob/U)
		var/obj/Weapon/Wield/DualBoneKunai/b = locate() in U.contents
		if(b||GENERICATTACKCHECK(U)) return
		var
			c=100;s=U.SS*Seals
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
				U<<"You draw a Dual Bone Kunais out from your forearms."
				var/obj/Weapon/Wield/DualBoneKunai/W = new(U)
				W.Durability+=(U.Taijutsu/2); W.MaxDurability+=W.Durability
				U.UpdateInventory()
