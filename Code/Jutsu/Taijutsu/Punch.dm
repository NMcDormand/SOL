obj/SkillCards/Taijutsu/Starter/Punch
	icon='Card_Icons.dmi'
	icon_state="card_punch"
	JutsuType = "Taijutsu"
	cmdstring="Attack"
	VerbIt=1
	CanLevel=0

	Description = list(
		"about"="Your primary form of attack as punches. Can also be combined with weapons such as Kunai. Toggle Practice Mode to spar."
		,"title"="Attack"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="E"
		//,"pic"='Punch.png'
		)

	Activate(mob/U)
		if(U.choosing)
			return
		if(U.InKamui)
			if(!U.icon_state)
				flick("punch",U)
			return
		if(U.wielding == "Gunbai")
			if(U.FanSkill > 3000 && !U.PracticeMode)
				if(!U.firing)
					U.firing = 1
					spawn(U.atkspeed*3)
						U.firing = 0
					var/obj/Jutsu/Class/Fan/Ookamaitachi/F=new(U.loc, U, U.WindElemental*0.5, U.Ninjutsu * 0.05)
					F.movespeed=0
					walk(F,U.dir)
		var/TADD = 0
		if(U.InHien)
			TADD += U.InHien
		if(U.OukashouCharge)
			TADD += U.OukashouCharge
			U.OukashouCharge = 0
			var/tell=list()
			for(var/mob/player/m in hearers(4,src))
				if((m.ListenToJutsu=="others"&&m!=src)||(m.ListenToJutsu=="all")||(src==m && U.ListenToJutsu=="self"))
					tell+=m
			tell<<"<b>[src]: Oukashou!</b>"
			if(U.OukashouCharging)
				U.OukashouCharging= 0
				U.Charging = 0
		if(U.Giant)
			if(U.icon_state=="seals"||U.ShadowList.len||U.Sleeping||U.Kanashibari||U.MushiKabe||U.InNarakumi||U.DeathSee||U.dead||U.mirroring||U.ShadowCaptured||U.EventLock||U.Webbed||U.frozen||U.Blocking||U.KO||U.throwing||U.GMfrozen||U.Tsukuyomi||U.jailed||U.attacking||U.swimming||U.resting||U.kaiten||U.IceBlasted||U.waterprisoned||U.Coffin)
				return
			//Create list of targets
			var/list/targets=list()

			for(var/mob/T in get_step(U, U.dir)) //Attack directly ahead
				if(IDCHECK(T,U))
					continue
				if(istype(T,/mob/player)||istype(T,/mob/Hittable))
					targets+=T
			for(var/mob/T in get_step(U, turn(U.dir,-45))) //Left tile of ahead
				if(IDCHECK(T,U))
					continue
				if(istype(T,/mob/player)||istype(T,/mob/Hittable))
					targets+=T
			for(var/mob/T in get_step(U,turn(U.dir,45))) // Right tile of ahead
				if(IDCHECK(T,U))
					continue
				if(istype(T,/mob/player)||istype(T,/mob/Hittable))
					targets+=T

			if(targets.len<1)
				return //If there isn't anyone to attack
			//Attack players
			flick("punch",U)
			U.attacking=1
			spawn(U.atkspeed){if(!U.meditating)U.attacking=0}
			//If we are below Stamina limit, damage player
			if(U.Stamina<=15) {
				U.Wounds+=2; U.RefreshWounds()
				if(U.Wounds>100) U.DamageMe(U,1,"punch",1) //Kill user
			}
			//Check each player in list
			for(var/mob/M in targets)
				if(istype(M,/mob/Hittable/Unresponsive/NPC/Panda))
					U.KillMe(M); //Don't touch Panda!
				if(M&&(M.protect||M.InGatsuuga||M.InMeatTank||M.InTsuuga||M.InGarouga||M.GMfrozen)) continue;
				//Check if we can hit the player
				if(U.HitCheck(M))
					if(M.TreeStump) {continue;}
					var/dmg=round((U.Taijutsu*1.3)-(M.Taijutsu*0.09))
					if(dmg<round(U.Taijutsu*0.2))
						dmg=round(U.Taijutsu*0.2)
					dmg += TADD + (U.Calories*10) + U.Weapons(M)

					for(var/obj/Weapon/Wield/W in U.contents)
						if(W.worn) W.DamagetoWeapon(rand(1,5),U)

					M.DamageMe(U,dmg,U.AttackMethod)
					//world<<"Step 6";
					//if(M) U.ApplyEXP(taiup,"taijutsu")
					//U.ApplyEXP(stamup,"Stamina")
				else
					U<<"[M] dodged the attack!"; M<<"You dodged [U]'s attack"
			return //Return so we don't basic attack or spar
		else
			if(U.HiraishinToggled>=3 && U.HiraishinAuto && !U.ShadowList.len)
				var/mob/T = U.Targeting
				if(T)
					if(get_dist(T, U) > U.HiraishinAutoDist)
						if(!T.HiraishinBlockCheck() && U.MarkedTargets[T.trueName])
							var/LOC = Get_Rand_DirStep(T)
							if(LOC)
								U.HiraishinPort(LOC,T,2)
			for(var/mob/M in get_step(U,U.dir))
				if(istype(M,/mob/player)||istype(M,/mob/Hittable))
					//Check if you are practicing and it's your clone.
					if(U.PracticeMode && istype(M,/mob/Hittable/Command/Clones/))
						if(U.Stamina<=100) {U<<"You are too low on Stamina to continue sparring"; return}
						if(U.inrasengan) {U.RasenganPunch(M); return}
						var/mob/Hittable/Command/Clones/C = M
						if(U == C.Creator) // Check to see if it's our clone
							if(TAICHECKBOTH(U,C)) return
							C.dir=turn(U.dir,180)
							U.attacking=1; spawn(6){if(!U.meditating)U.attacking=0}
							if(!U.firing){U.firing=1; spawn(6)U.firing=0}
							var/stamLoss=(U.StaminaTrue-U.TaijutsuTrue)*0.1
							if(stamLoss >= (U.StaminaTrue * 0.04)) {stamLoss = (U.StaminaTrue *0.05)}
							U.Stamina-=stamLoss
							var/SparEXP=6
							var/SparTai=rand(2,12)
							//new var = mod true tai by 8k, multiply sparTai by the remaining.
							if(U.weights) {SparEXP+=(U.extraweight*2); SparTai+=(U.extraweight*1.5);}
							U.ApplyEXP(SparEXP,"reflex")
							U.HitCount++
							if(U.HitCount>=50)
								U<<"You feel nimbler and more agile."
								if(U.ReflexTrue<RFXMax) U.ApplyEXP(400,"reflex")
								U.HitCount=0
							U.icon_state="punch"; spawn(4) U.icon_state=""
							if(C)
								C.icon_state="punch";
								if(C)
									spawn(4)
										if(C)
											C.icon_state=""
							//flick("punch",C); flick("punch",U.client.mob)

					//Check if both you and the other person are in practice mode
					else if(U.PracticeMode && M.PracticeMode)
						if(U.Stamina<=100) {U<<"You are too low on Stamina to continue sparring"; return}
						if(U.NinjaRank=="Academy Student") {U<<"You must be Genin or above to spar"; return}
						if(U.inrasengan) {U.RasenganPunch(0); return}
						var/mob/player/P=M
						if(TAICHECKBOTH(U,P)||P.resting) return
						var/arenaBoost=1
						if(U.InSparArea && P.InSparArea) {arenaBoost=1.5;} //If both players are in the spar arena, increase gains by 1.5x
						U.attacking=1; spawn(5){if(!U.meditating)U.attacking=0}
						if(!U.firing)
							U.firing=1; spawn(5)U.firing=0
						var/difference=round(P.TaijutsuTrue/U.TaijutsuTrue)*100
						var/SparTai
						if(difference == 100)
							SparTai=200
						else if(difference in 98 to 102)
							SparTai=rand(50,120)
						else if(difference<98)
							if(difference in 80 to 97) SparTai=rand(18,42)
							else if(difference in 70 to 79) SparTai=35
							else SparTai=rand(8,18)
						else if(difference>102)
							if(difference in 103 to 115) SparTai=rand(15,35)
							else if(difference in 116 to 121) SparTai=30
							else SparTai=rand(5,15)
						var/dmg=round(U.TaijutsuTrue*0.33)
						var/sparEXP=(6*arenaBoost)
						if(dmg<(P.StaminaMax*0.01)) dmg = P.StaminaMax*0.01
						if(U.weights) {SparTai+=(U.extraweight*2); sparEXP+=(U.extraweight*3);}
						if(!U.SparPunch) {U.SparPunch=1; spawn(15)U.SparPunch=0}
						U.SparringWith=P; U.HitCount++
						if(U.SparPunch&&P.SparPunch&&P.SparringWith==U)
							U.DamagedRecently++
							spawn(20)
								if(U.DamagedRecently)
									U.DamagedRecently--
							if(U.ReflexTrue<RFXMax)
								if(U.Clan=="Kaguya")  U.ApplyEXP((sparEXP*0.5),"reflex")
								U.ApplyEXP(sparEXP,"reflex")
							if(difference == 100) {U.ApplyEXP(SparTai+P.taitraining,"taijutsuStatic")}
							else {U.ApplyEXP(SparTai+P.taitraining,"taijutsu")}
							if(U.HitCount>=40)
								U<<"You feel nimbler and more agile."
								if(U.ReflexTrue<RFXMax) U.ApplyEXP(400,"reflex")
								if(difference == 100) {U.ApplyEXP((SparTai*40)+P.taitraining,"taijutsuStatic")}
								else {U.ApplyEXP((SparTai*40)+P.taitraining,"taijutsu")}
								U.HitCount=0
						flick("punch",U.client.mob)

						P.Stamina-=round(dmg)
						if(P.Stamina<1) P.Stamina=1
						U.RefreshStats()

					//else attack the other person
					else
						if(IDCHECK(M,U) || U.NinjaRank != "Academy Student" && M.client && M.NinjaRank == "Academy Student")
							return
						//Attack
						if(U.NinjaRank=="Academy Student")
							if(!istype(M,/mob/Hittable/Responsive/Animal/Wild/Bird) && !M.TreeStump)
								U<<"It isn't safe to attack others yet!"
								return
						if(istype(M,/mob/Hittable/Unresponsive/NPC/Panda))
							U.KillMe(M)//Don't touch Panda!
						if(U.icon_state=="seals"||U.ShadowList.len||U.Sleeping||U.Kanashibari||U.MushiKabe||U.InNarakumi||U.DeathSee||U.dead||U.mirroring||U.ShadowCaptured||U.EventLock||U.Webbed||U.frozen||U.Blocking||U.KO||U.throwing||U.GMfrozen||U.Tsukuyomi||U.jailed||U.attacking||U.swimming||U.resting||U.ShadowCaptured||U.kaiten||U.IceBlasted||U.waterprisoned||U.Coffin) return;
						else if(M&&(M.protect||M.InGatsuuga||M.InMeatTank||M.InTsuuga||M.InGarouga||M.GMfrozen)) return;
						if(U.inchidori) {U.ChidoriPunch(M); return}
						if(U.inrasengan) {U.RasenganPunch(M); return}
						if(U.InShinwon == 2)
							U.ShinwonPunch()
						if(U.HitCheck(M))
							if(U.Stamina<=15) {
								U.Wounds+=2; U.RefreshWounds()
								if(U.Wounds>100) U.DamageMe(U,1,"punch",1) //Kill user
							}
							if(U.Class["Hand2Hand-Nin"])
								U.H2HHits++
							var/dmg=round(U.Taijutsu*0.9-(M.Taijutsu*0.09))
							dmg=max(dmg,round(Taijutsu*0.08)) // 8% of damage is the lowest you can go...
							if(dmg<round(U.Taijutsu*0.1)) dmg=round(U.Taijutsu*0.1)
							dmg+=U.Weapons(M)
							dmg += TADD
							if(U.Drunk&&!M.TreeStump) {U.attacking=1; spawn(U.atkspeed-1)U.attacking=0}
							else {U.attacking=1; spawn(U.atkspeed){if(!U.meditating)U.attacking=0}}
							if(!M.trueName||M.trueName=="")
								M.trueName = M.name
							if(U.HasHiraishin && !U.MarkedTargets[M.trueName])
								U.MarkedTargets[M.trueName] = M
								M.MarkedMe += U
								M.Marked = 1
								U << "You have placed a Hiraishin Seal on [M]"

							flick("punch",U)

							if(M.TreeStump)
								if(U.Stamina<=15&&U.reset) return
								if(U.Stamina<=15&&!U.reset)
									U<<"<font face=verdana color=red><b>Your Stamina is low! Use Rest.</b></font>"
									U.reset=1; spawn(60)U.reset=0 //Only display this message every now and again if they keep going.
									return
								U.StamUpTree()
								if(U.H2HHits>3){
									U.H2HHits=0
									dmg*=1.8
									U.StamUpTree()//Proc it a second time for more training!
									if(!M.Cactus) {U.TreeStump(M,dmg,1); return}
									else if(M.Cactus) {U.Cactus(M,dmg,1); return}
								}
								else
									if(M.Cactus) {U.Cactus(M,dmg); return}
									else {U.TreeStump(M,dmg); return}
							else if(istype(M,/mob/Hittable/Unresponsive/Training/Stump/Tree))
								if(U.Stamina<=15)
									if(!U.reset)
										U<<"<font face=verdana color=red><b>Your Stamina is low! Use Rest.</b></font>"
										U.reset=1; spawn(60)U.reset=0 //Only display this message every now and again if they keep going.
									return
								U.StamUpTree()
								if(U.H2HHits>3)
									U.H2HHits=0
									dmg*=1.8
									U.StamUpTree()//Proc it a second time for more training!
									U.Tree(M,dmg,1)
								else
									U.Tree(M,dmg)

							else
								for(var/obj/Weapon/Wield/W in U.contents)
									if(W.worn) W.DamagetoWeapon(rand(1,5),U)
								var/taiup=rand(3,5)
								var/stamup=10
								if(U.H2HHits>3)
									U.H2HHits=0
									taiup*=1.6
									stamup*=1.6
									U.ApplyEXP(5,"unarmed")
									dmg*=1.8
									M.DamageMe(U,dmg,"doublePunch")
								else
									M.DamageMe(U,dmg,U.AttackMethod)
								if(M) U.ApplyEXP(taiup+M.taitraining,"taijutsu")
								U.ApplyEXP(stamup,"Stamina")

								if(U.Class["Jashin"] && U.wielding=="Scythe") U.AquireBlood(M) //Also add if scythe is equipped!.. or maybe just change it to that in the first place...
						else
							U.attacking=1
							spawn(15)U.attacking=null
							U<<"[M] dodged the attack!"; M<<"You dodged [U]'s attack"