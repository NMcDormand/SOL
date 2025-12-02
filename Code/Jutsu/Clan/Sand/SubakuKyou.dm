obj/SkillCards/Clan/Sand/SabakuKyou
	icon_state="card_SabakuKyou"
	cmdstring="SabakuKyou"
	CCost=4000
	Seals=0
	Cooldown = 2000
	DM = 1
	ECost = 85
	Duration = 40

	Description = list(
		"about"="The user gathers Chakra infused sand to restrain the target"
		,"title"="Sabaku Kyou"
		,"type"="Ninjutsu"
		,"Element"="Sand"
		,"weak"="N/A"
		,"rank"="A"
		//,"pic"='Chidori.png'
	)


	UpgradeChoices = list("Increase Duration","Lower Cost")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		if(U.SandCollected<ECost&&!U.onsand) {U<<"You do not have enough sand in your gourd."; return}
		var/mob/M = locate() in get_step(U,U.dir)
		if(InvisibilityCheck(U,M))
			return
		var
			c=CCost; mx=c;
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("SabakuKyou",(CooldownCur*U.cooldownmultiplier))) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(20)U.firing=0
		if(get_dist(U,M)>1) {U<<"Target is too far away."; return}
		if(prob(U.ChakraControl))
			if(!U.CoffinList)
				U.CoffinList=list()
			if(!U.onsand) U.SandCollected-=ECost
			U.JutsuMessage(Description["title"])
			U.JutsuNin(c);
			U.MoveUses[name]++
			U.JutsuUseChakra(c);
			//U.ElementalUp("Sand")
			if(U.PracticeMode || ControlCheck(U)) return ..()
			CoffinTimer(M,U,Duration)
		else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
		..()

proc
	CoffinTimer(var/mob/M,var/mob/B,DUR=140)
		set waitfor = 0
		if(M.HigherEvade && M.LightningElemental)
			return

		M<< "<i>You are trapped in sand.</i>"
		B<< "<i>[M] is trapped in sand.</i>"

		B.CoffinList+=M;
		M.KyouOverlay = new/Overlay_Obj(icon('desertcoffin.dmi'),MOB_LAYER+9,0,-4)
		M.overlays += M.KyouOverlay
		M.Coffin++
		spawn(DUR)
			if(M)
				M.overlays -= M.KyouOverlay
				M.KyouOverlay = null
				if(M.Coffin>0)
					M.Coffin--
			if(B)
				B.CoffinList-=M