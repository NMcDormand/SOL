obj/SkillCards/Ninjutsu/Fuuton/Daitoppa
	icon_state="card_daitoppa"
	cmdstring="Daitoppa"

	Range=10
	CCost=100
	Seals=2
	Cooldown = 240

	Description = list(
		"about"="Send a damaging gust of wind at your opponents."
		,"title"="Fuuton: Daitoppa"
		,"type"="Ninjutsu"
		,"Element"="Wind"
		,"weak"="Fire"
		,"rank"="TBC"
//		,"pic"='Daitoppa.png'
		)

	UpgradeChoices = list("Track Target","Lower Cooldown","Improve Tracking","Lower Cost")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U))
			return
		var
			c=CCost; mx=c; s=usr.SS*Seals
		if(usr.Chakra<=c) {usr<<"Not enough Chakra."; return}
		if(usr.CooldownCheck("Daitoppa",(CooldownCur*usr.cooldownmultiplier)+s,1)) return
		if(ChakraUseCheck()) c *= 4
		usr.icon_state="seals"
		usr.firing=1
		spawn(s)
			spawn(1)usr.icon_state=null
			spawn(3)usr.firing=0
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.ElementalUp("Wind")
				if(U.PracticeMode || ControlCheck(U)) return ..()
				var/obj/Jutsu/Fuuton/Daitoppa/F=new(usr.loc)
				NewProjectile(U,F,src,1,1.5)
			else {c-=rand(1,mx/2); usr.Chakra-=c; usr<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()