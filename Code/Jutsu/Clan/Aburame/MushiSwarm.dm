obj/SkillCards/Clan/Aburame/MushiSwarm
	icon_state="card_MushiSwarm"
	cmdstring="MushiSwarm"
	Range=5
	CCost=250
	ECost=60
	Seals=3
	Cooldown = 500
	CooldownCur = 80
	Speed = 3

	UpgradeChoices = list("Increase Speed","Lower Cooldown","Lower Cost","Track Target")

	Description = list(
		"about"="Send a swarm of bugs out to damage the opponent and drain their chakra."
		,"title"="Mushi Swarm"
		,"type"="Clan-Jutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
		,"Tutorial" = "This creates a projectile to hit your target, face in the right direction and use the skill. If upgraded correctly it will also track whoever you have targeted"
//		,"pic"='MushiSwarm.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		if(U.Konchuuamount<ECost) {U<<"There aren't enough bugs for this jutsu."; return}
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("MushiSwarm",(CooldownCur*U.cooldownmultiplier)+s,1)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			U.icon_state=null
			spawn(2)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuUseChakra(CCost)
				U.JutsuSeals(s); U.JutsuNin(c); U.MoveUses[name]++
				U.JutsuMessage(Description["title"])
				if(ControlCheck(U)) return ..()
				U.Konchuuamount-=ECost;
				if(U.PracticeMode) return ..()
				for(var/i=1 to Shots)
					var/obj/Jutsu/Aburame/Swarm/S=new(U.loc)
					NewProjectile(U,S,src,1,10)
				//CreateProjectile(U,S,,U.loc,U.dir,1,10,1)
				U.StatUpdate_bugs()
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>";}
			..()