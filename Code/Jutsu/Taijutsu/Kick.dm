mob/var
	Kicks=0; kickspeed=7
obj/SkillCards/Taijutsu/Starter/Kick
	icon='Card_Icons.dmi'
	icon_state="card_kick"
	JutsuType = "Taijutsu"
	cmdstring="Kick"
	VerbIt=1
	CanLevel=0

	Description = list(
		"about"="Slower than the punch, but more powerful. Raising Hand-to-Hand skill will best help this attack."
		,"title"="Kick"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="E"
		,"pic"='Kick.png'
		)

	Activate(mob/U)
		if(U.InKamui)
			flick("kick",U)
			return
		if(U.HiraishinToggled>=3 && U.HiraishinAuto)
			var/mob/T = U.Targeting
			if(T)
				if(get_dist(T, U) > U.HiraishinAutoDist)
					if(!T.HiraishinBlockCheck() && U.MarkedTargets[T.trueName])
						var/LOC = Get_Rand_DirStep(T)
						if(LOC)
							U.HiraishinPort(LOC,T,2)
		var/TADD = 0
		if(U.InHien)
			TADD += U.InHien
		if(U.KyakuCharge)
			TADD += U.KyakuCharge
			U.KyakuCharge = 0
			var/tell=list()
			for(var/mob/player/m in hearers(4,src))
				if((m.ListenToJutsu=="others"&&m!=src)||(m.ListenToJutsu=="all")||(src==m && U.ListenToJutsu=="self"))
					tell+=m
			tell<<"<b>[src]: Tsuuten Kyaku!</b>"
			if(U.KyakuCharging)
				U.KyakuCharging= 0
				U.Charging = 0
		for(var/mob/M in get_step(U,U.dir))
			if(IDCHECK(M,U) || U.NinjaRank != "Academy Student" && M.client && M.NinjaRank == "Academy Student")
				return
			if((!M.TreeStump)&&U.NinjaRank=="Academy Student") {U<<"It isn't safe to attack others yet!"; return}
			if(TAICHECKBOTH(U,M)||U.ShadowList.len||U.Gokusamaisou) return
			if(U.HitCheck(M))
				U.MoveUses[name]++
				U.Kicks++
				var/dmg=round(U.Taijutsu*1.4-(M.Taijutsu*0.11))
				if(dmg<round(U.Taijutsu*0.1)) dmg=round(U.Taijutsu*0.1)
				dmg+=U.Kicks() + TADD
				if(U.Drunk&&!M.TreeStump) {U.attacking=1; spawn(U.kickspeed-3)U.attacking=0}
				else {U.attacking=1; spawn(U.kickspeed)U.attacking=0}
				flick("kick",U)
				if(M.TreeStump)
					if(U.Stamina<=15&&U.reset) return
					if(U.Stamina<=15&&!U.reset)
						U<<"Not enough Stamina"
						U.reset=1; spawn(20)U.reset=0
						return
					if(!M.Cactus) {U.TreeStump(M,dmg); return}
					else if(M.Cactus) {U.Cactus(M,dmg); return}
				else
					M.DamageMe(U,dmg,"kick")
					var/taiup=rand(3,5)
					if(M)
						U.TaijutsuXP+=(taiup+M.taitraining)
						if(!M.trueName||M.trueName=="")
							M.trueName = M.name
						if(U.HasHiraishin && !U.MarkedTargets[M.trueName])
							U.MarkedTargets[M.trueName] = M
							U << "You have placed a Hiraishin Seal on [M]"
							M.MarkedMe += U
							M.Marked = 1
					U.Taiup(); U.Kicks++
					U.ApplyEXP(10,"Stamina")
			else
				U.attacking=1
				spawn(15)U.attacking=null
				U<<"[M] dodged the attack!"; M<<"You dodged [U]'s attack"