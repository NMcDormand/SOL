obj/SkillCards/Ninjutsu/MizuBunshin
	icon_state="card_blank"
	cmdstring="MizuBunshin"
	CCost=6000
	Seals=6
	DM = 28
	IsBunshin = 1

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[min(CCost,usr.ChakraMax*0.25)]'; DamageAmount.text='[DM]% Bunshin Strength'")

	Description = list(
		"about"="Creates an exact copy of the user out of water.  These clones will have a portion of the user's HP and chakra and can attack others.  They have elemental bonuses and weaknesses.  Drains chakra."
		,"title"="Mizu Bunshin no Jutsu"
		,"type"="Ninjutsu"
		,"Element"="Water"
		,"weak"="Lightning"
		,"rank"="C"
//		,"pic"='MizuBunshin.png'
	)

	UpgradeChoices = list("Lower Cost","Increase Strength")

	Activate(mob/U)
		if(U.KageBunshinAttackCheck()||!U.icon) return
		if(length(U.MasterBunshinList)>=U.BunshinLimit)
			for(var/mob/Hittable/Command/Clones/B in U.MasterBunshinList)
				if(B) del(B)
				break
		var
			c=min(CCost,U.ChakraMax*0.25); mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			U.icon_state=null
			spawn(20)U.firing=0
			if(prob(U.ChakraControl))
				if(!U.onwater&&U.WaterElemental<SuitonOnEarthCheck&&U.Clan != "Yuki") {U<<"<b>You need to be on water to execute this jutsu</b>."; return}
				U.JutsuSeals(s); U.JutsuNin(c*0.02); U.ElementalUp("Water");
				U.MoveUses[name]++
				U.JutsuUseChakra(c,0.05)
				U.JutsuMessage(Description["title"])
				if(U.PracticeMode || ControlCheck(U)) return ..()
				var/mob/Hittable/Command/Clones/MizuBunshin/B=new(U.loc)
				U.BunshinCreate(B,DM*0.01,c,1,0.5,2)
				B.WaterElemental=U.WaterElemental
			else {c=rand(30,79); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
			..()

