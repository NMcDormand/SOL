#if DEBUGGING
mob/verb
	SelfLearnMuonSatsujin()
		var/obj/SkillCards/Class/Assassin/MuonSatsujin/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Muon Satsujin no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Class/Assassin/MuonSatsujin(src)
#endif

obj/SkillCards/Class/Assassin/MuonSatsujin
	icon_state="card_MuonSatsujin"
	cmdstring="MuonSatsujin"
	JutsuType = "Class"
	Cooldown = 5010
	CooldownCur = 5010
	CCost=0
	Seals=8
	DM = 1

	Description=list(
		"about" = "Silently do immense damage on the victim's neck, damage is significantly increased if currently using Meisagakure no Jutsu",
		,"title" = "Muon Satsujin no Jutsu",
		,"type" ="Taijutsu",
		,"strong"="N/A",
		,"weak"="N/A",
		,"rank"="S",
		,"pic"='Bunshin.png',
	)

	UpgradeChoices = list("Increase Damage","Lower Cooldown")

	Activate(mob/U)
		if(!U.Class["Assassin-Nin"])
			U << "This technique is disabled as you are not currently an Assassin-Nin"
			return
		if(U.wielding!="Kunai" && U.wielding!="Dual Bone Kunais")
			U<<"You must be wielding a knife to use this."
			return
		for(var/mob/Hittable/M in get_step(U,U.dir))
			if(M.dir==U.dir&&!M.TreeStump)
				if(TAICHECKBOTH(U,M)||InvisibilityCheck(U,M)) return
				if(U.CooldownCheck("MuonSatsujin",CooldownCur*U.cooldownmultiplier)) return
				if(U.HitCheck(M))
					U.JutsuMessage(Description["title"])
					U.MoveUses[name]++
					if(U.PracticeMode || ControlCheck(U)) return ..()
					var/dmg
					if(U.InCamo) dmg=round((U.Taijutsu*18)+(U.KnifeSkill*100))
					else dmg = round((U.Taijutsu*10 - (M.Taijutsu*0.30))+(U.KnifeSkill*50))

					if(dmg<=round(U.Taijutsu*0.30))
						dmg=round(U.Taijutsu*0.30)
					dmg *= DM
					U.ApplyEXP(1,"knife")

					U.attacking=1
					M.resting=0
					flick("punch",U)

					var/taiup=rand(8,20)
					if(M.taitraining)
						taiup+=M.taitraining
					if(M.kaiten||M.MushiKabe)
						view(2,M)<<"[U]'s attack was prevented!"
					else
						M.DamageMe(U,dmg,"throat slit")

					spawn(13)U.attacking=0
					for(var/obj/Weapon/Wield/W in U.contents)
						if(W.worn)
							W.DamagetoWeapon(rand(2,7),U)

					U.ApplyEXP(taiup,"taijutsu")
				else
					U.attacking=1; spawn(10)U.attacking=null
					U<<"[M] dodged the attack."; M<<"You dodged [U]'s attack."