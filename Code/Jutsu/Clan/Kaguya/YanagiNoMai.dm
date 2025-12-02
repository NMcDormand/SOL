obj/SkillCards/Clan/Kaguya/YanagiNoMai
	icon_state="card_YanagiNoMai"
	cmdstring="YanagiNoMai"

	Range=1
	CCost=800
	Cooldown = 40

	UpgradeChoices = list("Lower Cost")

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[CCost*usr.KGCModifier]';DamageAmount.text='[((usr.Ninjutsu*0.5)+(usr.Taijutsu*1.6))*DM] Damage'")

	Description = list(
		"about"="A combat 'dance' that attacks enemeis on 4 sides using bone kunais."
		,"title"="Yanagi no Mai"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='YanagiNoMai.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		if(U.wielding!="Dual Bone Kunais")
			U<<"Equip Dual Bone Kunais first"
			return
		var
			c=(CCost*U.KGCModifier); mx=c
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.attacking||MoveCheck(U)||U.Blocking||U.reset)
			return
		if(U.CooldownCheck("Yanagi",(CooldownCur*U.cooldownmultiplier))) return
		if(ChakraUseCheck()) c *= 4
		U.attacking=1;spawn(U.atkspeed)U.attacking=0
		U.JutsuUseChakra(c)
		//U.JutsuTai(CCost*0.03)
		U.MoveUses[name]++

		U.icon_state = "Yanagi"
		spawn(4)
			if(U.icon_state != "KO")
				U.icon_state = ""
		if(U.PracticeMode || ControlCheck(U))
			spawn(U.atkspeed+5) U.attacking=0
			return ..()
		if(prob(U.ChakraControl))
			var/hit=0
			for(var/mob/M in orange(1))
				if(IDCHECK(U,M) || M.protect||M.InGatsuuga||M.InMeatTank||M.InTsuuga||M.InGarouga||M.GMfrozen)
					continue
				if(hit>=4)
					sleep(U.atkspeed)
					U.attacking=0
					break
				switch(get_dir(U,M))
					if(NORTH, SOUTH, EAST, WEST)
						hit++
						if(get_dist(U,M)>1) continue
						var/dmg=round(U.Taijutsu*0.8-(M.Taijutsu*0.11))
						dmg+=U.Weapons()
						if(dmg<round(U.Taijutsu*0.1)) dmg=round(U.Taijutsu*0.1)
						if(M.TreeStump)
							if(U.Stamina<=15&&U.reset)
								return
							if(U.Stamina<=15&&!U.reset)
								U<<"Not enough Stamina"
								U.reset=1; spawn(20)U.reset=0
							if(!M.Cactus) {U.TreeStump(M,dmg)}
							else if(M.Cactus) {U.Cactus(M,dmg)}
							spawn(U.atkspeed+3) U.attacking=0
						else if(U.HitCheck(M))
							for(var/obj/Weapon/Wield/W in U.contents)
								if(W.worn) W.DamagetoWeapon(rand(1,5),U)
							var/taiup=rand(2,15)
							U.ApplyEXP(taiup+M.taitraining,"taijutsu")
							U.ApplyEXP(1,"Stamina")
							M.DamageMe(U,dmg,"slices")
							sleep(U.atkspeed+2)
							U.attacking=0
						else
							sleep(U.atkspeed+11)
							U.attacking=null
							U<<"[M] dodged the attack!"; M<<"You dodged [U]'s attack"
				sleep(1)
			if(!hit)
				spawn(U.atkspeed+5) U.attacking=0
		else
			c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"
			sleep(U.atkspeed+11)
			U.attacking=0
		..()