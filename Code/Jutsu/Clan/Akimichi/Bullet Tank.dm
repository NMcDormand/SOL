obj/SkillCards/Clan/Akimichi/NikudanSensha
	//icon_state="card_Kaiten"
	cmdstring="NikudanSensha" //Expansion Jutsu

	CCost=2000
	Seals=4
	Cooldown=500
	CooldownCur=500

	UpgradeChoices = list("Allow Water Tiles","Lower Cost","Lower Cooldown")

	Description = list(
		"about"="The user tucks into a ball, and rolls to run over their oppenents. Better with more calories!"
		,"title"="Nikudan Sensha"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="A"
		,"Tutorial" = "After using this technique you will grow and size and causes damage to anything you run into, walk run towards your target to cause damage"
//		,"pic"='Kaiten.png'
	)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		if(U.onwater && !WaterUsage) {U<<"You cannot be on water and use this attack."; return}
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(!U.Giant) {U<<"You can't do this without expanding first!"; return}
		if(U.CooldownCheck("NikudanSensha",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(40) U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuSeals(s); U.JutsuTai(c*0.1); U.JutsuNin(c*0.14); U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.JutsuMessage(Description["title"])
				if(U.PracticeMode || ControlCheck(U)) return ..()
				U.meatTankProc()
			else {c-=rand(1,mx/2); U.Chakra-=c; U.icon_state=""; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
			..()

mob/proc/meatTankProc()
	overlays=overlays.Remove(overlays)
	icon=null
	InMeatTank=1; movespeed=1;
	Akimichi_Grow(1, 0)
	overlays+=/obj/Akimichi/BALL

	spawn(50)
		if(InMeatTank)
			InMeatTank=0;
			firing=0
			overlays-=/obj/Akimichi/BALL
			Akimichi_Grow(3, 0)
			CreationSkin(1)
			icon_state=null

			movespeed=setspeed
			InMeatTank=0;
		//movespeed=setspeed