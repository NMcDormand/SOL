obj/SkillCards/Class/Sword/Mikazuki
	icon_state="card_Mikazuki"
	cmdstring="Mikazuki"
	CCost=0
	Seals=0
	Cooldown = 400
	Range = 1
	DM = 1.5

	Description = list(
		"about"="Perform a pincer attack with a sword"
		,"title"="Mikazuki no Mai"
		,"type"="Taijutsu"
		,"weak"="N/A"
		,"rank"="C"
		//,"pic"='Chidori.png'
	)

	UpgradeChoices = list("Increase Range","Increase Damage")

	Activate(mob/U)
		if(!U.Class["Sword-Nin"])
			U << "This technique is disabled as you are not currently a Sword-Nin"
			return
		for(var/mob/M in oview(Range,U))
			if(TAICHECKBOTH(U,M)) return
			if(U.wielding!="Katana"&&U.wielding!="Bone Sword"&&U.wielding!="Broad Sword"&&U.wielding!="Broad Whip"&&U.wielding!="Samehada"&&U.wielding!="Samehada(Unwrapped)"&&U.wielding!="Executioner Blade"&&U.wielding!="Shibuki"&&U.wielding!="Nuibari")
				U<<"<i>You must equip a sword to use this.</i>"
				return
			U.attacking=1; spawn(10)U.attacking=null
			if(U.CooldownCheck("Mikazuki",CooldownCur*U.cooldownmultiplier,1)||U.inrasengan||U.inchidori) return
			var/dmg = round(U.Taijutsu*DM-(M.Taijutsu*0.20))
			if(dmg<=round(U.Taijutsu*0.20)) dmg=U.Taijutsu*0.20

			if(U.wielding=="Katana") dmg+=round(U.SwordSkill*20)
			if(U.wielding=="Broad Sword") dmg+=round(U.SwordSkill*23)
			if(U.wielding=="Bone Sword") dmg+=round(U.SwordSkill*24)
			if(U.wielding=="Spine Whip") dmg+=round(U.SwordSkill*26)
			if(U.wielding=="Samehada") dmg+=round(U.SwordSkill*34)
			if(U.wielding=="Executioner Blade") dmg+=round(U.SwordSkill*34)
			U.ApplyEXP(1,"sword")
			U.MoveUses["Mikazuki"]++
			if(M.TreeStump)
				if(U.Stamina<=15&&U.reset) return
				if(U.Stamina<=15&&!U.reset)
					U<<"Not enough Stamina"
					U.reset=1; spawn(20)U.reset=0
					return
				if(!M.Cactus) {U.TreeStump(M,dmg); return}
				else if(M.Cactus) {U.Cactus(M,dmg); return}
			if(U.HitCheck(M))
				dmg += U.Weapons(M)
				M.DamageMe(U,dmg,U.AttackMethod)
				for(var/obj/Weapon/Wield/W in U.contents)
					if(W.worn) W.DamagetoWeapon(rand(2,10),U)
				var/taiup=rand(3,5)
				U.ApplyEXP(taiup,"taijutsu")
				if(M)
					U.ApplyEXP(M.taitraining,"taijutsu")
				U.ApplyEXP(10,"Stamina")
			else
				U.attacking=1
				spawn(15)U.attacking=null
				U<<"[M] dodged the attack!"; M<<"You dodged [U]'s attack"
			..()