obj/SkillCards/Clan/Lee/DaiSenpuu
	icon_state="card_DaiSenpuu"
	cmdstring="DaiSenpuu"
	Cooldown=200
	Range=1
	DM = 1.5

	Description = list(
		"about"="Great Whirlwind; Deliver a powerful spinning kick"
		,"title"="Dai Senpuu"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='Kaiten.png'
		)

	UpgradeChoices = list("Lower Cooldown","Increase Damage","Lower Cooldown","Increase Range")

	Activate(mob/U)
		if(TAIATTACKCHECKSELF(U)||RESTRAINEDCHECK(U)||RESTRAINEDLEGS(U)) return
		if(U.CooldownCheck("daisenpuu",(CooldownCur*U.cooldownmultiplier))) return
		flick("spinkick",U)
		U.MoveUses[name]++
		U.JutsuMessage(Description["title"])
		if(U.PracticeMode || ControlCheck(U)) return ..()
		U.attacking=1; spawn(U.kickspeed*2)U.attacking=0
		for(var/mob/M in orange(U,Range))
			if(TAIATTACKCHECKYOU(M))
				continue
			var/dmg=round(U.Taijutsu*DM-(M.Taijutsu*0.2))
			dmg+=U.Kicks()
			if(dmg<round(U.Taijutsu*0.1)) dmg=round(U.Taijutsu*0.1)
			if(M.TreeStump)
				if(U.Stamina<=15&&U.reset) continue
				if(U.Stamina<=15&&!U.reset)
					U<<"Not enough Stamina"
					U.reset=1; spawn(20)U.reset=0
					continue
				if(!M.Cactus) {U.TreeStump(M,dmg)}
				else if(M.Cactus) {U.Cactus(M,dmg)}
			else
				if(U.HitCheck(M))
					spawn()
						M.DamageMe(U,dmg,"kick");
					if(!istype(M,/mob/Hittable/Unresponsive/Training) && !istype(M,/mob/Hittable/Unresponsive/Inanimate))
						step_away(M,U)
					var/taiup=rand(3,5)
					U.ApplyEXP(taiup+M.taitraining,"taijutsu")
					U.ApplyEXP(10,"Stamina")
				else
					U.attacking=1; spawn(15)U.attacking=null
					U<<"[M] dodged the attack!"; M<<"You dodged [U]'s attack"
		..()