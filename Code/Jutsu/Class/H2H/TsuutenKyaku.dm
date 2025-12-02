obj/SkillCards/Class/H2H/TsuutenKyaku
	icon_state="card_TsuutenKyaku"
	cmdstring="TsuutenKyaku"
	JutsuType = "Class"
	Cooldown = 1800
	CooldownCur = 1800
	CCost=0
	Seals=8
	DM = 1

	Description=list(
		"about" = "Slowly Gather chakra in your leg and release it on the next kick for extensive damage",
		,"title" = "Tsuuten Kyaku",
		,"type" ="Taijutsu",
		,"strong"="N/A",
		,"weak"="N/A",
		,"rank"="A",
		//,"pic"='Bunshin.png',
	)

	UpgradeChoices = list("Increase Damage","Lower Cooldown")

	Activate(mob/U)
		if(U.KyakuCharging)
			U.KyakuCharging= 0
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
			if(U.CooldownCheck("Kyaku",CooldownCur*U.cooldownmultiplier)) return
			if(ChakraUseCheck()) c *= 4
			U.firing=1
			spawn(2)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuTai(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.KyakuChargeStart(c,DM)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()
		/*for(var/mob/M in get_step(usr,usr.dir))
			if(TAICHECKBOTH(src,M)||usr.Gokusamaisou) return
			if(usr.Chakra<350) {usr<<"Not enough chakra."; return}
			if(CooldownCheck("Tsuuten",250*usr.cooldownmultiplier)) return
			var/taiup=rand(3,5)
			var/dmg = round(usr.Taijutsu*2.3-(M.Taijutsu*0.2))
			if(dmg<=round(usr.Taijutsu*0.25)) dmg=usr.Taijutsu*0.25
			view(4,usr)<< "<b>[usr]</b>:  Tsuuten Kyaku!"
			usr.attacking=1
			spawn(15)
				spawn(30)usr.attacking=0
				if(M)usr.ApplyEXP(taiup+M.taitraining,"taijutsu")
				usr.ApplyEXP(10,"Stamina")
				usr.Taiup()
				flick("kick",usr)
				if(M.TreeStump)
					if(usr.Stamina<=15&&!usr.reset) {usr<<"Not enough Stamina"; usr.reset=1; spawn(20)usr.reset=0; return}
					if(usr.Stamina<=15&&usr.reset) return
					if(!M.Cactus) {usr.TreeStump(M,dmg); return}
					else if(M.Cactus) {usr.Cactus(M,dmg); return}
				if(usr.HitCheck(M))
					M.DamageMe(usr,dmg,"kick")
				else
					usr.attacking=1; spawn(25)usr.attacking=null
					usr.Chakra-=1000; usr<<"[M] dodged the attack"; M<<"You dodged [usr]'s attack"*/

mob
	var
		tmp
			KyakuCharging
			KyakuCharge
	proc
		KyakuChargeStart(C=10,DM=1)
			set waitfor = 0
			KyakuCharging = 1
			Charging = 1
			while(KyakuCharging)
				if(Chakra>C)
					KyakuCharge+= C*DM
					Chakra-=C
				else
					KyakuCharging = 0
					Charging = 0
					Chakra=0
				StatUpdate_chakra()

			src << "You stop gathering Chakra in your leg"