obj/SkillCards/Clan/Sand/SabakuSoso
	icon_state="card_SabakuSoso"
	cmdstring="SabakuSoso"
	CCost=500
	Seals=0
	Cooldown = 8000
	DM = 15
	ECost = 0
	XPLGain = 200

	Description = list(
		"about"="Using the sand trapping a victim from Sabaku Kyou, the user compresses the sand crushing the victim trapped inside"
		,"title"="Sabaku Soso"
		,"type"="Ninjutsu"
		,"Element"="Sand"
		,"weak"="N/A"
		,"rank"="A"
		//,"pic"='Chidori.png'
	)

	UpgradeChoices = list("Increase Damage","Lower Cooldown")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c;
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Funeral",(CooldownCur*U.cooldownmultiplier))) return
		if(ChakraUseCheck()) c *= 4
		for(var/mob/C in U.CoffinList)
			if(!C.TreeStump)
				if(get_dist(U,C)>10) {U<<"You are too far away!"; return}
				U.icon_state="seals"
				U.firing=1
				spawn(2)
					U.icon_state=null
					spawn(20)U.firing=0
					if(U.PracticeMode || ControlCheck(U)) return ..()
					if(C)
						if(prob(U.ChakraControl))
							U.JutsuMessage(Description["title"])
							U.JutsuNin(c);
							U.MoveUses[name]++
							U.JutsuUseChakra(c);
							//U.ElementalUp("Sand")
							if(U.PracticeMode || ControlCheck(U)) return ..()
							spawn(5)
								if(C)
									C.overlays-=C.KyouOverlay;
									C.KyouOverlay = 0
									var/FO = new/Overlay_Obj(icon('desertburial.dmi'),MOB_LAYER+9,0,-4)
									C.overlays += FO
									spawn(8)
										if(C)
											C.DamageMe(U,((U.Ninjutsu*DM)-C.Taijutsu),"SoSo",1)
											spawn(5)
												if(C)
													C.overlays -= FO
						else{c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
						..()