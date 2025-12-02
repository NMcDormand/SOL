obj/SkillCards/Clan/Aburame/MushiNoYoroi
	icon_state="card_MushiNoYoroi"
	cmdstring="MushiNoYoroi"

	CCost=350
	ECost=60
	Seals=4
	Cooldown = 400
	CooldownCur = 100

	UpgradeChoices = list("Lower Cost")

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[CCost] per 2 Seconds'")

	Description = list(
		"about"="Create armour out of insects you've collected"
		,"title"="Mushi No Yoroi"
		,"type"="Clan-Jutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
		,"Tutorial" = ""
//		,"pic"='MushiNoYoroi.png'
		)

	Tutorial()
		Description["Tutorial"] = "This will create and armour of insects thinly layering over your skinto reduce incoming damage while allowing you to move. This costs [CCost] chakra every 2 seconds."
		..()

	Activate(mob/U)
		if(U.BugArmour)
			U.BugArmour=0;
			return
		//if(U.SandArmour) {U<<"Release your Sand Armour first."; return}
		if(GENERICATTACKCHECK(U)) return
		if(U.Konchuuamount<ECost)
			U<<"You don't have enough insects for this jutsu."
			return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("MushiNoYoroi",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(20)U.firing=0
			U.icon_state=null
			if(prob(U.ChakraControl))
				U.JutsuSeals(s); U.JutsuNin(c); U.MoveUses[name]++
				U.JutsuUseChakra(CCost)
				U.JutsuMessage(Description["title"])
				if(ControlCheck(U)) return ..()
				U.Konchuuamount-=ECost;
				if(U.PracticeMode) return ..()
				U.BugArmour=1; U.overlays+='BugArmour.dmi'; U.BugArmourDrain(CCost)
				U.StatUpdate_bugs()
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
			..()

mob/proc/BugArmourDrain(C = 80)
	while(BugArmour)
		if(Chakra<C)
			Chakra=1
			BugArmour=0
		else
			Chakra-=C; RefreshChakra()
		sleep(20)

	overlays-='BugArmour.dmi'
	src<<"Your Bug Armour has disappeared."