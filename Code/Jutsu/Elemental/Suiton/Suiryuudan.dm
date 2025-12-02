obj/SkillCards/Ninjutsu/Suiton/Suiryuudan
	icon_state="card_suiryuudan"
	cmdstring="Suiryuudan"
	Range=8
	CCost=1000
	Seals=8
	Cooldown = 900
	Speed = 2
	DM = 0.5

	Description = list(
		"about"="Send a powerful homing water projectile at opponents."
		,"title"="Suiton: Suiryuudan"
		,"type"="Ninjutsu"
		,"Element"="Fire"
		,"weak"="Lightning"
		,"rank"="B"
//		,"pic"='Suiryuudan.png'
	)

	UpgradeChoices = list("Increase Damage","Increase Speed","Lower Cooldown")

	Activate(mob/U)
		if(U.choosingHoming) return
		var/mob/M
		if(ismob(U.Targeting)&&get_dist(U.Targeting,U)<= Range)
			M = U.Targeting
		else
			M = U.TargetSelect(Range)
		if(M)
			spawn(10)if(U)U.choosingHoming=0
			if(GENERICATTACKCHECK(U)) return
			if(!U.onwater&&U.WaterElemental<SuitonOnEarthCheck && U.Clan!="Yuki") {U<<"You must be on water to use this."; return}
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("Suiryuudan",(CooldownCur*U.cooldownmultiplier)+s,1)) return
			if(U.CooldownCheck("Homing",(100*U.cooldownmultiplier)+s,1)) return
			if(ChakraUseCheck()) c *= 4
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				spawn(2)U.firing=0
				U.icon_state=null
				if(prob(U.ChakraControl))
					U.JutsuMessage(Description["title"])
					U.JutsuSeals(s); U.JutsuNin(c);
					U.MoveUses[name]++
					U.JutsuUseChakra(c);
					U.ElementalUp("Water")
					if(U.PracticeMode || ControlCheck(U)) return ..()
					var/obj/Jutsu/Suiton/Suiryuudan/S=new/obj/Jutsu/Suiton/Suiryuudan
					S.Ninjutsu=U.Ninjutsu*(DM*0.5); S.WaterElemental=U.WaterElemental*DM
					S.loc=U.loc; S.dir=U.dir; S.target=M; S.Owner=U
					S.BetterHoming(M,M.loc)
					spawn(16)del(S)
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()