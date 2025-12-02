obj/SkillCards/Clan/Lee/Reppuu
	icon_state="card_Reppuu"
	cmdstring="Reppuu"
	Cooldown=100
	DM = 1

	Description = list(
		"about"="Violent wind; sweep an opponent off their feet"
		,"title"="Reppuu"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='Kaiten.png'
		)

	UpgradeChoices = list("Lower Cooldown","Increase Damage")

	Activate(mob/U)
		if(TAIATTACKCHECKSELF(U)||RESTRAINEDCHECK(U)||RESTRAINEDLEGS(U)) return
		if(U.CooldownCheck("Reppuu",(CooldownCur*U.cooldownmultiplier))) return
		for(var/mob/M in get_step(U,U.dir))
			if(TAIATTACKCHECKYOU(M)) return
			flick("sweep",U)
			U.MoveUses[name]++
			U.JutsuMessage(Description["title"])
			if(U.PracticeMode || ControlCheck(U)) return ..()

			var/dmg=round(U.Taijutsu * DM - (M.Taijutsu*0.2))
			dmg+=U.Kicks()
			if(dmg<round(U.Taijutsu*0.1)) dmg=round(U.Taijutsu*0.1)
			U.attacking=1; spawn(U.kickspeed)U.attacking=0
			if(M.TreeStump)
				if(U.Stamina<=15&&U.reset) return
				if(U.Stamina<=15&&!U.reset)
					U<<"Not enough Stamina"
					U.reset=1; spawn(20)U.reset=0
					return
				if(!M.Cactus) {U.TreeStump(M,dmg)}
				else if(M.Cactus) {U.Cactus(M,dmg)}
			else if(U.HitCheck(M))
				M.DamageMe(U,dmg,"sweeps")
				if(M && prob(50))
					flick("fall",M); viewers(4,M)<<"<b>[M] has been knocked of \his feet!<b>"
					if(!M.fallen)
						M.fallen=1
						spawn(10)
							if(M)M.fallen=0
				var/taiup=rand(3,5)
				if(M)
					taiup+=M.taitraining
				U.ApplyEXP(taiup,"taijutsu")
				U.ApplyEXP(10,"Stamina")
			else
				U.attacking=1;
				spawn(15)U.attacking=null
				U<<"[M] dodged the attack!"; M<<"You dodged [U]'s attack"
		..()