mob/var/tmp
	UsingWaterPrison; waterprisoned

obj/SkillCards/Ninjutsu/Suiton/Suirou
	icon_state="card_WaterPrison"
	cmdstring="Suirou"
	Range=1
	CCost=1000
	Seals=2
	Cooldown = 3000

	Description = list(
		"about"="Surround an opponent in water, immobilising them while you're within 1 tile."
		,"title"="Suiton: Suirou"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="A"
//		,"pic"='Kirigakure.png'
		)

	UpgradeChoices = list("Lower Cost","Lower Cooldown")

	Activate(mob/U)
		var/mob/M = locate() in get_step(usr,usr.dir)
		if(M)
			if(GENERICATTACKCHECK(usr)||InvisibilityCheck(usr,M)) return
			if(IDCHECK(M,U))
				return
			if(!usr.onwater && U.WaterElemental < SuitonOnEarthCheck*3) {usr<<"You must be on water to use this."; return}
			var
				c=CCost; mx=c; s=usr.SS*Seals
			if(usr.Chakra<=c) {usr<<"Not enough Chakra."; return}
			if(usr.CooldownCheck("Suirou",(CooldownCur*usr.cooldownmultiplier)+s,1)) return
			if(ChakraUseCheck()) c *= 4
			usr.icon_state="seals"
			usr.firing=1
			spawn(s)
				spawn(1)usr.icon_state=null
				spawn(70)usr.firing=0
				if(prob(U.ChakraControl))
					usr.CantWalk++; spawn(8)usr.CantWalk--
					U.JutsuMessage(Description["title"])
					U.JutsuSeals(s); U.JutsuNin(c);
					U.MoveUses[name]++
					U.JutsuUseChakra(c);
					U.ElementalUp("Water")
					if(U.PracticeMode || ControlCheck(U)) return ..()

					M<<"You are held by [usr]'s Water Prison!";
					usr<<"You hold [M] with your Water Prison!"
					usr.UsingWaterPrison=1
					M.waterprisoned=1

					M.overlays+='WPrison.dmi'
					usr.waterprison(M,c)
					if(istype(M,/mob/Hittable/Responsive)&&!(usr in M.HitList)) M.HitList+=usr
				else {c-=rand(1,mx/2); usr.Chakra-=c; usr<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

mob/proc/waterprison(mob/M, CCost)
	while(M)
		var/GD = get_dist(src,M)
		if(GD>1 || Chakra < CCost)
			UsingWaterPrison=0; M.waterprisoned=0; M.overlays-='WPrison.dmi'
			break
		else
			Chakra-=CCost
			CCost *= 1.1
			M.Stamina-=(WaterElemental); M.DamageMe(src,0,"Suirou",1); M.RefreshStamina()
			sleep(10)
	UsingWaterPrison=0