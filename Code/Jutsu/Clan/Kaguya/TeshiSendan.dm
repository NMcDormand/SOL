obj/SkillCards/Clan/Kaguya/TeshiSendan
	icon_state="card_TeshiSendan"
	cmdstring="TeshiSendan"
	Range=7
	CCost=200
	Cooldown = 400
	Seals=2
	Shots = 1
	UpgradeChoices = list("More Shots","More Shots","Lower Cooldown","Track Target")

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[CCost*usr.KGCModifier]'")

	Description = list(
		"about"="Send out your knuckle bones at high velocity."
		,"title"="Teshi Sendan"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='TeshiSendan.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=(CCost*U.KGCModifier); mx=c; s=U.SS*2
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("TeshiSendan",(Cooldown*U.cooldownmultiplier))) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(3)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuUseChakra(c)
				U.JutsuSeals(s); U.JutsuTai(c); U.MoveUses[name]++
				if(U.PracticeMode || ControlCheck(U)) return ..()
				var/N = 0
				while(N<Shots)
					var/obj/Jutsu/Kaguya/TeshiSendan/H=new(U.loc)
					NewProjectile(U,H,src,1.1,1)
					N++
					sleep(1)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()