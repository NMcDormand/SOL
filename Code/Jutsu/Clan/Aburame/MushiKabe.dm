obj/SkillCards/Clan/Aburame/MushiKabe
	icon_state="card_MushiKabe"
	cmdstring="MushiKabe"
	Range=1
	Cooldown = 800
	CooldownCur = 800
	ECost=200
	CCost=6
	Seals=1

	UpgradeChoices = list("Lower Cost","Lower Cooldown")

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[CCost]% per 1 Seconds'")

	Description = list(
		"about"="Surround yourself with a wall of insects to protect you."
		,"title"="Mushi Kabe"
		,"type"="Clan-Jutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
		,"Tutorial" = ""
//		,"pic"='MushiKabe.png'
		)

	Tutorial()
		Description["Tutorial"] = "This will surround you in insects that will reduce all damage while you are able to sustain them wtih Chakra, This costs[CCost]% per second"
		..()

	Activate(mob/U)
		if(U.MushiKabe)
			U.MushiKabe=0; U.overlays-='MushiKabe.dmi'
			spawn(10)U.firing=0
		else
			if(U.MushiKabeAttackCheck()) return
			if(U.Konchuuamount<ECost)
				U<<"You don't have enough insects for this jutsu."
				return
			var/s=U.SS
			var/c = CCost
			if(U.CooldownCheck("MushiKabe",(CooldownCur*U.cooldownmultiplier)+s)) return
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				spawn(1)U.icon_state=null
				if(prob(U.ChakraControl))
					U.JutsuSeals(s); U.MoveUses[name]++
					U.JutsuMessage(Description["title"])
					if(ControlCheck(U))
						U.firing=0
						return ..()
					U.Konchuuamount-=ECost;
					if(U.PracticeMode)
						U.firing=0
						return ..()
					U.MushiKabe=1; U.MushiKabeDrain(CCost*0.01)
					U.StatUpdate_bugs()
				else {c=rand(50,99); U.CCGain(c/50); U.Chakra-=c; U<<"<i>You failed to perform the jutsu.</i>";}
				..()

mob/proc/MushiKabeDrain(CA)
	overlays+='Mushi Kabe.dmi';
	var/C = ChakraMax * CA
	while(MushiKabe)
		if(Chakra<=C)
			if(Chakra < 0)
				Chakra=1
			MushiKabe=0
			src<<"You don't have enough chakra to sustain the Mushi Kabe"
		else
			Chakra -= C
		RefreshChakra()
		sleep(10)

	overlays -= 'Mushi Kabe.dmi';
	firing=0
	overlays-='MushiKabe.dmi'