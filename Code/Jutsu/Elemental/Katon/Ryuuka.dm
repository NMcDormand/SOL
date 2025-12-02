obj/SkillCards/Ninjutsu/Katon/Ryuuka
	icon_state="card_Ryuuka"
	cmdstring="Ryuuka"
	Range=15
	CCost=500
	Seals=9
	Cooldown = 700
	DM = 15

	Description = list(
		"about"="Send a powerful flame in the direction you're facing."
		,"title"="Katon: Ryuuka"
		,"type"="Ninjutsu"
		,"Element"="Fire"
		,"weak"="Water"
		,"rank"="B"
//		,"pic"='Ryuuka.png'
		)

	UpgradeChoices = list("Increase Damage","Lower Cost ")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(usr.Chakra<=c) {usr<<"Not enough Chakra."; return}
		if(usr.CooldownCheck("Ryuuka",(CooldownCur*usr.cooldownmultiplier)+s,1)) return
		if(ChakraUseCheck()) c *= 4
		usr.icon_state="seals"
		usr.firing=1
		spawn(s)
			spawn(1)usr.icon_state=null
			spawn(4)usr.firing=0
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.ElementalUp("Fire")
				if(U.PracticeMode || ControlCheck(U)) return ..()
				var/obj/Jutsu/Katon/Ryuuka/K=new/obj/Jutsu/Katon/Ryuuka
				NewProjectile(U,K,src,1.2,DM)
			else {c-=rand(1,mx/2); usr.Chakra-=c; usr<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()