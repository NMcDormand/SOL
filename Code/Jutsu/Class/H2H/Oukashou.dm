obj/SkillCards/Class/H2H/Oukashou
	icon_state="card_Oukashou"
	cmdstring="Oukashou"
	JutsuType = "Class"
	Cooldown = 1800
	CooldownCur = 1800
	CCost=1000
	Seals=8
	DM = 1.5

	Description=list(
		"about" = "Slowly Gather chakra in your punch and release it on the next kick for extensive damage",
		,"title" = "Oukashou",
		,"type" ="Taijutsu",
		,"strong"="N/A",
		,"weak"="N/A",
		,"rank"="B",
	)

	UpgradeChoices = list("Increase Damage","Increase Gathering Speed")

	Activate(mob/U)
		if(U.OukashouCharging)
			U.OukashouCharging= 0
			U.Charging = 0
		else if(U.Charging)
			U << "You are already gathering Chakra elsewhere"
			return
		else
			if(GENERICATTACKCHECK(U))
				return
			var
				c=CCost; mx=c;
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("Oukashou",CooldownCur*U.cooldownmultiplier)) return
			if(ChakraUseCheck()) c *= 4
			U.firing=1
			spawn(2)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuTai(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.OukashouChargeStart(c,DM)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()
		/*for(var/mob/M in get_step(usr,usr.dir))
			if(TAICHECKBOTH(src,M)) return
			if(M.Village=="Admin") return
			if(usr.Chakra<150) {usr<<"Not enough chakra."; return}
			if(CooldownCheck("Oukashou",100*usr.cooldownmultiplier)) return
			var/taiup=rand(3,5)
			var/dmg = round(usr.Taijutsu*1.8-(M.Taijutsu*0.2))
			if(dmg<=round(usr.Taijutsu*0.1)) dmg=usr.Taijutsu*0.1
			view(4,usr)<< "<b>[usr]</b>: Oukashou!"
			usr.attacking=1
			spawn(7)
				spawn(20)usr.attacking=0
				if(M)usr.ApplyEXP(taiup+M.taitraining,"taijutsu")
				usr.ApplyEXP(10,"Stamina")
				usr.Taiup()
				flick("punch",usr)
				if(M.TreeStump)
					if(usr.Stamina<=15&&!usr.reset) {usr<<"Not enough Stamina"; usr.reset=1; spawn(20)usr.reset=0; return}
					if(usr.Stamina<=15&&usr.reset) return
					if(!M.Cactus) {usr.TreeStump(M,dmg); return}
					else if(M.Cactus) {usr.Cactus(M,dmg); return}
				if(usr.HitCheck(M))
					if(!M.KnockBack) M.KnockBack=1
					spawn(5)M.KnockBack=0
					Knockback(M)
					M.DamageMe(usr,dmg,"punch")
				else
					usr.attacking=1; spawn(25)usr.attacking=null
					usr.Chakra-=1000; usr<<"[M] dodged the attack"; M<<"You dodged [usr]'s attack"*/

mob
	var
		tmp
			OukashouCharging
			OukashouCharge
	proc
		OukashouChargeStart(C=10,DM=1)
			set waitfor = 0
			OukashouCharging = 1
			Charging = 1
			while(OukashouCharging)
				if(Chakra>C)
					OukashouCharge+= C*DM
					Chakra-=C
				else
					OukashouCharging = 0
					Charging = 0
					Chakra=0
				StatUpdate_chakra()

			src << "You stop gathering Chakra in your fist"