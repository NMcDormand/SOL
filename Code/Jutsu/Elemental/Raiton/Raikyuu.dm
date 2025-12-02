obj/SkillCards/Ninjutsu/Raiton/Raikyuu
	icon_state="card_Raikyuu"
	cmdstring="Raikyuu"
	Range=9
	CCost=120
	Cooldown = 450
	Seals=5
	DM=9

	Description = list(
		"about"="Launch a ball of lightning at your opponent."
		,"title"="Raiton: Raikyuu"
		,"type"="Ninjutsu"
		,"Element"="Lightning"
		,"weak"="Earth"
		,"rank"="B"
//		,"pic"='Raikyuu.png'
		)

	UpgradeChoices = list("Increase Damage","Lower Cooldown")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U))
			return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Raikyuu",(CooldownCur*U.cooldownmultiplier)+s,1)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(3)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.ElementalUp("Lightning")
				if(U.PracticeMode || ControlCheck(U)) return ..()
				var/obj/Jutsu/Raiton/Raikyuu/R=new/obj/Jutsu/Raiton/Raikyuu
				NewProjectile(U,R,src,1,DM)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()