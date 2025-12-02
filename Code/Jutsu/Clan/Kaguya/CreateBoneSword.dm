obj/SkillCards/Clan/Kaguya/Weapons/CreateBoneSword
	icon_state="card_CreateBoneSword"
	cmdstring="CreateBoneSword"
	CCost=120
	Seals=1
	Description = list(
		"about"="Draw out two bones from your skeleton to use as a sword."
		,"title"="Create Bone Sword"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="D"
//		,"pic"='CreateBoneSword.png'
		)
	Activate(mob/U)
		var/obj/Weapon/Wield/BoneSword/b = locate() in U.contents
		if(b||GENERICATTACKCHECK(U)) return
		var
			c=120;s=U.SS*1
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
				U<<"You draw a Bone Sword from your body."
				var/obj/Weapon/Wield/BoneSword/W=new(U)
				W.Durability+=(U.Taijutsu/2); W.MaxDurability+=W.Durability
				U.UpdateInventory()