obj/SkillCards/Clan/Lee/Shoufuu
	icon_state="card_Shoufuu"
	cmdstring="Shoufuu"
	Cooldown=300
	DM = 0.7
	Description = list(
		"about"="Rising Wind; chance to disarm opponent"
		,"title"="Shoufuu"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='Kaiten.png'
		)

	UpgradeChoices = list("Lower Cooldown","Increase Damage")

	Activate(mob/U)
		if(TAIATTACKCHECKSELF(U)||RESTRAINEDCHECK(U)||RESTRAINEDLEGS(U)) return
		if(U.CooldownCheck("Shoufuu",(CooldownCur*U.cooldownmultiplier))) return
		for(var/mob/M in get_step(U,U.dir))
			if(TAIATTACKCHECKYOU(M)) return
			flick("highkick",U)
			U.JutsuMessage(Description["title"])
			U.MoveUses[name]++
			if(U.PracticeMode || ControlCheck(U)) return ..()
			var/dmg=round(U.Taijutsu * DM-(M.Taijutsu*0.1))
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
				M.DamageMe(U,dmg,"kick")
				if(prob(5) && M.wielding) M.Disarm(U)
				var/taiup=rand(3,5)
				if(M)
					taiup+=M.taitraining
				U.ApplyEXP(taiup,"taijutsu")
				U.ApplyEXP(10,"Stamina")
			else
				U.attacking=1;
				spawn(30)U.attacking=null
				U<<"[M] dodged the attack!"; M<<"You dodged [U]'s attack"
		..()

mob/proc
	Disarm(mob/M)
		if(wielding)
			for(var/obj/Weapon/Wield/O in contents)
				if(O.worn)
					O.worn=0; wielding=null;  overlays-=O.Overlay
					hearers(6,src)<<"[M] has disarmed [src]"
					if(!O.bones&&!O.rare)
						O.loc=loc;
						O.OnSpeedRail=null; SpeedRailSlotsUsed[O.ItemSlot]=0
						UpdateInventory()