obj/SkillCards/Clan/Lee/GourikiSenpuu
	icon_state="card_GourikiSenpuu"
	cmdstring="GourikiSenpuu"
	Cooldown=140
	DM = 2.5

	Description = list(
		"about"="Strong Whirlwind; Deliver a powerful roundhouse kick"
		,"title"="Gouriki Senpuu"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='Kaiten.png'
		)

	UpgradeChoices = list("Lower Cooldown","Increase Damage")

	Activate(mob/U)
		if(TAIATTACKCHECKSELF(U)||RESTRAINEDCHECK(U)||RESTRAINEDLEGS(U)) return
		if(U.CooldownCheck("Gouriki",(CooldownCur*U.cooldownmultiplier))) return
		flick("spinkick",U)
		for(var/mob/M in get_step(U,U.dir))
			if(TAIATTACKCHECKYOU(M)) return
			U.JutsuMessage(Description["title"])
			U.MoveUses[name]++
			if(U.PracticeMode || ControlCheck(U)) return ..()
			U.attacking=1; spawn(U.kickspeed*3)U.attacking=0
			var/dmg=round(U.Taijutsu*DM-(M.Taijutsu*0.15))
			dmg+=U.Kicks()
			if(dmg<round(U.Taijutsu*0.1)) dmg=round(U.Taijutsu*0.1)
			if(M.TreeStump)
				if(U.Stamina<=15&&U.reset) return
				if(U.Stamina<=15&&!U.reset)
					U<<"Not enough Stamina"
					U.reset=1; spawn(20)U.reset=0
					return
				if(!M.Cactus) {U.TreeStump(M,dmg)}
				else if(M.Cactus) {U.Cactus(M,dmg)}
			else
				if(U.HitCheck(M))
					M.DamageMe(U,dmg,"kick")
					var/taiup=rand(3,5)
					if(M)
						taiup+= M.taitraining
					U.ApplyEXP(taiup,"taijutsu")
					U.ApplyEXP(10,"Stamina")
				else
					U.attacking=1; spawn(15)U.attacking=null
					U<<"[M] dodged the attack!"; M<<"You dodged [U]'s attack"
		..()