mob/verb/Surrender()
	Stamina = 10
	hearers(4, usr) << "[src] has surrendered themselves and lowered their defenses"
	RefreshStats()

mob/proc/DamageMe(mob/M,var/D,METHOD,hidemessage)
	..()
mob/proc/KillMe(mob/M)
	..()
mob/proc/KillCheck(mob/M,var/T)
	..()
mob/proc/KO_Check(DAMAGE,mob/M)
	..()

mob/player/DamageMe(mob/M,DAMAGE,METHOD,hidemessage) //M is the attacker, src is the person being hit (and taking dmg)
	//set waitfor = 0
	if(dead||InKamui)
		return
	if(M)
		if(IDCHECK(M,src))
			return
		if(M.Village == Village && M.VillageFriendly && !M.DamagedMe[trueName])
			return
		if(InIzanagi)
			IzanagiClone(M)
			return
		if(InAMirror)
			M << "[src] was protected by \his mirror of ice"
			return
		if(HasHiraishin && M && METHOD != "ClayDeteriorate")
			if(!M.trueName||M.trueName=="")
				M.trueName = M.name
			if(HasHiraishin && !MarkedTargets[M.trueName])
				if(get_dist(M,src) < 2)
					MarkedTargets[M.trueName] = M
					src << "You have placed a Hiraishin Seal on [M]"
					M.MarkedMe += src
					M.Marked = 1
					/*if(HiraishinToggled && HiraishinAutoDodge)
						var/LOC = Get_Rand_DirStep(M)
						if(LOC)
							HiraishinPort(LOC,M)
							M << "[src] disappeared in a flash"
							return*/
			else
				if(HiraishinToggled && HiraishinAutoDodge)
					var/LOC = Get_Rand_DirStep(M)
					if(LOC)
						if(HiraishinPort(LOC,M,3))
							M << "[src] disappeared in a flash"
							return

		if(ThankedJashin && CeremonialVictim)
			var/mob/CerVic=CeremonialVictim
			if(!istype(CerVic,/mob/Hittable/Responsive/Boss/Minato)&&!istype(CerVic,/mob/Hittable/Responsive/Boss/Viole))
				CerVic.DamageMe(src, DAMAGE, "Jashin")
		if(istype(src,/mob/Hittable/Unresponsive/NPC/Panda)) M.KillMe(src); //Don't touch Panda!
		var/WOUNDS
		var/mob/OWNER
		DAMAGE=AssessDamage(DAMAGE,M,METHOD)
		if(DAMAGE=="no damage") {TextOverlay(src, 0, "Miss");return;}
		if(cheater) DAMAGE*=10;
		resting=0
		WOUNDS=(DAMAGE/StaminaMax)*73
		if((Stamina-DAMAGE)>=0) Stamina-=DAMAGE
		else Stamina=0
		Wounds+=WOUNDS
		if(M)
			M.RevengeProtect=0
			Damaged()
			if(M!=src)
				var/DME = M.trueName
				DamagedMe[DME] += DAMAGE
				if(!M.DamagedMe[trueName])
					var/RN = M.trueName
					KageDA[RN] = 1
					spawn(600)
						if(KageDA[RN])
							KageDA -= RN
				else
					InCombat++
					spawn(60)
						if(InCombat)
							InCombat--
				spawn(180)
					if(src)
						DamagedMe[DME] -= DAMAGE
			TextOverlay(src, DAMAGE, "Damage");
			if(!hidemessage) DamageReport(src,M,DAMAGE,METHOD)
			if(!(M in Provoke)&&!(src in M.Provoke)) Provoke+=M
			if(!(src in M.HitList)) HitList += M
			if(istype(M,/mob/Hittable/Command/Clones/)) OWNER=M.Creator
			if(istype(M,/mob/Hittable/Responsive/Animal/Pet/)) OWNER=M.Master
			if(KI_InMission&&(M in KI_Participants))
				M.KonohaInvasionPoints-=(WOUNDS*3)
				M.KonohaInvasionTeamDamage+=(WOUNDS*2)
				if(OWNER) {OWNER.KonohaInvasionTeamDamage+=(WOUNDS*2); OWNER.KonohaInvasionPoints-=(WOUNDS*3)}
				M.Refresh_InvasionScore()
				M.CheckTeamDamage()
			if(M&&M!=src&&!(istype(M,/mob/Hittable/Responsive))) M.ExperienceCheck(WOUNDS,src)
			if(M && OverWorldKillMe() && M.client && Village==M.Village&&M!=src)
				VillageJail_Fines(src,M,"attack",DAMAGE)
		if(Wounds>=250 && !dead && !Gate)
			Wounds=250
			KillMe(M)
			return

		else if(KO) {
			Wounds+=2; RefreshStats()}
		else
			KO_Check(DAMAGE,M)

mob/player/KO_Check(DAMAGE,mob/M)
	if(KO)
		return
	if(Stamina<=0&&Wounds<100)
		if(HasRinnegan && !JutsuList["ShinraTenseiPush"])
			ShinraTensei(5,8)
			EyeIcon = null
			IrisColour = rgb(150,150,150)
			CreationSkin(1)
			Stamina = 1000
			LearnShinraPush()
			return
		KOfrom=M
		if(Giant)
			Akimichi_Revert_DamageMe()

		if(InFakeEnemyView)
			ReleaseFakeEnemy()
		if(InFakeView)
			ReleaseFakeEye()
		if(InIzanami)
			ReleaseIzanami()

		KO=1; KO_Actions(); icon_state="KO"; viewers(src)<<"<b><i>[src] has fallen unconcious with exhaustion!</i></b>"
		if(istype(M,/mob/player)&&KI_InMission&&(M in KI_Participants)&&DAMAGE>=1000)
			M.KonohaInvasionPoints-=100
			M.Refresh_InvasionScore()
		if(swimming)
			sleep(2)
			icon_state="Kawarimi"; viewers(src)<<"<b><i>[src] has gone underwater!</i></b>"
			spawn(50) KillMe(src)
		else
			var/R=StaminaTrue*0.1
			if(R>1000)
				R=1000
			spawn(50)
				if(Wounds<100)
					KO=0
					icon_state=""
					Stamina=R
					src<<"You should think about resting for a while."
				else
					verbs += new/mob/Suicide/verb/Suicide()
					KillCheck(M)

	else if(Wounds>=150 && !Gate||(Stamina<=0&&Wounds>=100))
		KOfrom=M
		if(Giant) Akimichi_Revert_DamageMe()
		KO=1;KO_Actions(); icon_state="KO"; viewers(src)<<"<b><i>[src] has fallen gravely unconcious!</i></b>"

		if(InFakeEnemyView)
			ReleaseFakeEnemy()
		if(InFakeView)
			ReleaseFakeEye()
		if(InIzanami)
			ReleaseIzanami()

		if(istype(M,/mob/player)&&KI_InMission&&(src in KI_Participants)&&DAMAGE>=1000)
			M.KonohaInvasionPoints-=100; M.Refresh_InvasionScore()
		if(StoredChakra>=5000 && !(CooldownCheck("GENESIS",6000*cooldownmultiplier)))
			spawn(0)
				KO = 0
				Rebirth_Revive()
				src<<"<b><font color=green>Your Genesis Seal revived you!</font></b>"

		else if(swimming)
			sleep(2)
			icon_state="Kawarimi"; viewers(src)<<"<b><i>[src] has gone underwater!</i></b>"
			spawn(50) KillMe(M)
		else
			verbs += new/mob/Suicide/verb/Suicide()
			KillCheck(M)
	if(KO)
		for(var/mob/player/p in MasterPlayerList)
			if(!p.HasMangekyou && p.CanLearnMangekyouSharingan && p!=src) //&& TEAMCHECK(p,src))
				if(get_dist(p,src) <= 12 && IDCHECK(src,p))
					p << "Watching [trueName] pass has awakened something within you!"
					p << "You have unlocked the ability to use the <i><b>Mangekyou Sharingan</b></i>!"
					new/obj/SkillCards/Clan/Uchiha/MangekyouSharingan(p)
					p.HasMangekyou = 1

	RefreshStats();
	if(M)
		M.RefreshStats()

mob/player/KillCheck(mob/M)
	set waitfor = 0
	if(dead)
		return
	for(var/i=1,i<=40,i++)	//2 minute Cooldown
		if(Wounds<100) break
		RefreshStats()
		sleep(30)
	RefreshStats(); verbs -= /mob/Suicide/verb/Suicide
	if(Wounds>=100) KillMe(M)
	else if(Wounds<100)
		if(!dead)
			KO=0;icon_state=null; src<<"You have escaped death and regained consciousness."

mob/player/KillMe(mob/M)
	if(dead)
		return
	KO_Actions()
	icon_state=""; overlays-='SpeachBubble.dmi'; overlays-='Neck-Bind.dmi'; removeGateImage(); overlays-='WaterWalk.dmi';

	Exp-=(MXP*0.1); Exp=max(Exp,0)
	if(client)winset(src,"ExpBar","value=[round((Exp/MXP)*100)]")

	var/people=list()
	for(var/mob/player/p in MasterPlayerList)
		if(p.SpyStatus == src && !p.AdminLevel && p.client)
			p.client.perspective= MOB_PERSPECTIVE|EDGE_PERSPECTIVE;
			p.client.eye = p
			p.SpyStatus = 0
		if(p.DeathMessages=="own"&&(p==M||p==src)) people+=p
		else if(p.DeathMessages=="all") people+=p
		if(!p.HasMangekyou && p.CanLearnMangekyouSharingan) //&& TEAMCHECK(p,src))
			if(get_dist(p,src) <= 12 && IDCHECK(src,p))
				p << "Watching [trueName] pass has awakened something within you!"
				p << "You have unlocked the ability to use the <i><b>Mangekyou Sharingan</b></i>!"
				new/obj/SkillCards/Clan/Uchiha/MangekyouSharingan(p)
				p.HasMangekyou = 1
//----------------------------IF SUICIDE----------------------------------------------------------------------
	if(src == M)
		if(KageMob[Village] == src && !Gate && !reaper)
			EjectKage(OffenseOutput("suicide"),1)
		suicides++
		if(swimming) people<<"<font color=red><b>[src] has drowned!</b></font>"
		else if(InZero) people<<"<font color=red><b>[src] has blown \himself up!</b></font>"
		else people<<"<font color=red><b>[src] has killed \himself!</b></font>"
		src<<"<i>You died!</i>"
//----------------------------IF homicide---------------------------------------------------------------------
	else
		for(var/mob/N in range(src,20))
			if(N.HitList)
				N.HitList -= src
		if(M)
			if(istype(M,/mob/Hittable))
				M.HitList -= src
				if(istype(M,/mob/Hittable/Command/Clones/)) M=M.Creator
				if(istype(M,/mob/Hittable/Responsive/Animal/Pet/)) M=M.Master
				if(istype(M,/mob/Hittable/Responsive/Boss/Minato))
					var/mob/Hittable/Responsive/Boss/Minato/MI = M
					MI.Touched -= trueName
					if(!length(M.HitList))
						M.DamWait = 0
				if(istype(M,/mob/Hittable/Responsive/Boss/Viole))
					if(!length(M.HitList))
						M.DamWait = 0
		if(M && OverWorldKillMe() && M.client)
			M.CurrentKills++

			if(client && client.address != M.client.address)
				M.PlayerKills++
				M.TotalKills++
				M.Medal_MassMurderer()
				M.RatioCheck()

			deaths++

			if(Village == M.Village)
				if(!(BingoBookAssociations[M.Village]) && !KageDA[M.trueName])
					M.VillageKills++
					if(!DisgracedKage)
						if(VillageKills > KageKillEject)
							M << "You have killed a member of the [M.Village] village without provocation, you will no longer have the privilege of becoming the Village Leader"
							DisgracedKage = 1
						else
							M << "You have now Killed [M.VillageKills] village without provocation, if you harm [KageKillEject - VillageKills] more you will no longer be able to become the Village Leader"

					VillageJail_Fines(src,M,"murder")
			else
				BingoBook_Check(src,M)
				if(Village != InVillage)
					var/VP = VillagePoints[Village]
					if(VP > 0)
						var/VS = Rank2Num(M.NinjaRank)
						if(VS>VP)
							M.AwardVP(VP)
							VillagePoints[Village] = 0
						else
							M.AwardVP(VS)
							VillagePoints[Village] -= VS


			if(KI_InMission && M.KI_InMission)
				M.RemoveFromKonohaInvasion()

			/*if(KageMob[M.Village]==src)
				if(Village == InVillage)
					M.DisgracedKage*/

			if(KageMob[Village]==src)
				if(M.Village == Village)
					if(Village != InVillage)
						KageDeaths++
				else
					KageDeaths++
				if(KageDeaths >= KageDeathEject)
					EjectKage(OffenseOutput("homicide",M,M.Village)) //If the kage is the one that dies, kick them out for homicide
					CheckForKages()
				else
					src << "You have been killed, you will lose your [NinjaRank] title if you are killed [KageDeathEject - KageDeaths] more time"

			else if(KageMob[Village]==M)
				if(!KageDA[M.trueName] && !(BingoBookAssociations[M.Village]))
					M.VillageKills++
					if(M.VillageKills > KageKillEject)
						M.EjectKage(OffenseOutput("murder",src,Village),1) //If the kage of this victim is the killer, kick them out
						CheckForKages()
					else
						M << "You have killed a member of the [M.Village] without provocation, you will lose your [M.NinjaRank] title if you harm [KageKillEject - M.VillageKills] more"

			if(M.KageDA[trueName])
				M.KageDA -= trueName

			if(gold>=10)
				var/obj/gold/G=new(loc)
				var/q=round(gold*0.25)
				if(q>25000)q=25000
				G.gold=q; gold-=q; StatUpdate_gold()

		//needs to be embedded in the chuunin loop, not death
		if(M&&M.ChuuninBattle)
			M.onwater=0; M<<"<b>You won your Chuunin fight!</b>"; world<<"[M] won \his Chuunin round"; M.ChuuninBattle=0
		if(ChuuninBattle)
			eliminated=1; ChuuninBattle=0; src<<"<b>You lost your Chuunin fight and have been eliminated from examinations!</b>"

		people << "<font color=red><B><i>  [src] has been killed by [M]!</font></b></i>"; src<<"<i>You were killed!</i>"

	Death_Ejection()//remove from various mob & world lists
	Death_Verbs()//remove various verbs
	Death_ResetVariables()
	Afterlife()

mob/proc
	SpawnWhere(PLACE)
		if(!PLACE)
			PLACE=Village
		if(PLACE)
			RecentlySpawned=1
			TempID = 0
			REDO
			var/obj/list/Beds=new/list
			for(var/obj/Hospital/Bed/SecondHeads/b in HOSPITALBEDLIST)
				if(b.Village==PLACE && !b.inuse)
					Beds.Add(b)
			if(Beds.len)
				var/obj/SPAWN=Beds[rand(1,Beds.len)]
				HospitalRespawn(SPAWN)
				ZCoord="[PLACE] Hospital"
				ZCoordProc(ZCoord)
			else
				src<<"There are currently no beds for you to use; please wait as one is made available."
				spawn(60)
					goto REDO

	ReSpawn()
		for(var/area/A in oview(0,src)) A.Entered(src)

		loc=SavedLocation; ZCoord=SavedPlace; ZCoordProc(ZCoord)

	HospitalRespawn(obj/o)

		src<<"You open your eyes, vision blurred; and you realise you are in hospital."; loc=o.loc
		for(var/area/A in oview(0,src)) A.Entered(src)
		o.InHospital(src)

	ExitAcademy()
		protect=0
		switch(Village)
			if("Leaf") loc=locate(479,163,1)
			if("Mist") loc=locate(876,115,1)
			if("Sand") loc=locate(31,8,1)
			if("Rock") loc=locate(148,470,1)
			if("Sound") loc=locate(494,467,1)
			if("Cloud") loc=locate(825,520,1)
			if("Grass") loc=locate(286,298,1)
			if("Rain") loc=locate(44,301,1)
			if("Waterfall") loc=locate(77,142,2)
			if("Admin") loc=locate(2,2,2)
		InVillage=Village

	ExitArena()
		protect=0

		switch(InVillage)
			if("Leaf")loc=locate(436,129,1)
			if("Mist") loc=locate(903,149,1)
			if("Sand") loc=locate(21,55,1)
			if("Rock") loc=locate(185,468,1)
			if("Sound") loc=locate(471,473,1)
			if("Cloud") loc=locate(839,542,1)
			if("Grass") loc=locate(272,305,1)
			if("Rain") loc=locate(56,262,1)
			if("Waterfall") loc=locate(62,132,2)
			if("Admin") loc=locate(2,2,2)
		ZCoord="[InVillage] Village"; ZCoordProc(ZCoord)

	Damaged()
		DamagedRecently++
		spawn(300)
			if(DamagedRecently)
				DamagedRecently--

	Afterlife()
		loc=null; ZCoord="K.I.A"; ZCoordProc(ZCoord)
		protect=1
		if(ForcedRebirth)
			if(NinjaRank != "Academy Student" && NinjaRank != "Genin")
				if(deaths && !Brand && !jailed)
					if(ForcedRebirth == deaths)
						src << "This is the end of your story, perhaps your next will be more grand"
						RebirthData.Commence(src)
						return
			/*else
				var/DE = deaths/RebirthOffer
				var/DF = round(DE)
				if(DE == DF)
					DEREDO
					switch(alert(src,"You see a glittering light, would you like to walk towards it?","Rebirth","Yes","No","what?"))
						if("Yes")
							if(alert(src,"Are you sure? (This will trigger a rebirth)","Rebirth","Yes","No") == "Yes")
								RebirthData.Commence(src)
								return
						if("No")
							src << "You step away from the light"
						if("What?")
							alert(src,"This is the offer to trigger a rebirth, this will delete your character and allow you to enhance your next dependant on how you played this one")
							goto DEREDO*/
		CreationSkin(1)
		spawn(100)
			ChakraMax=ChakraTrue
			Chakra=ChakraMax
			Ninjutsu=NinjutsuTrue
			Genjutsu=GenjutsuTrue
			Taijutsu=TaijutsuTrue
			StaminaMax=StaminaTrue
			Reflex=ReflexTrue;
			dead=0
			SpawnWhere()

	AssessDamage(DAMAGE,mob/M,METHOD)
		//need to verify lightning damage on suna no mayu when its coded in! (chidori =100%, raitons=50%, else = 0%)
		var/damage=DAMAGE
		if(!M || M == src)
			return
		else
			if(M.protect||protect||GMfrozen||(M.NinjaRank !="Academy Student" && client && NinjaRank=="Academy Student"))
				return "no damage"
			if(METHOD == "drowning")
				return round(DAMAGE)
			if(RevengeProtect && M.client)
				M.CantWalk++; M.firing=1; M<<"A mystical force binds you."; M.overlays+='HospKill.dmi'
				spawn(100)
					if(M)
						M.CantWalk--; M.firing=0; M<<"You are free to move."; M.overlays-='HospKill.dmi'
				return "no damage"
			if(client)
				var/Rebirth/THISGUY = RebirthData
				if(THISGUY)
					if(!THISGUY.Total)
						var/mob/R = M
						if(istype(M,/mob/Hittable/Command)||istype(M,/mob/Hittable/Responsive/Animal/Pet))
							R = M.Creator
						if(RankProtection)
							if(istype(R,/mob/player) && !R.DamagedMe[trueName])
								if(R.Level - Level >= 200 || Rank2Num(R.NinjaRank) - Rank2Num(NinjaRank) >= RankProtection)
									R.CantWalk++; R.firing=1; R << "A mystical force binds you."; R.overlays+='HospKill.dmi'
									spawn(30)
										if(R)
											R.CantWalk--; R.firing=0; R<<"You are free to move."; R.overlays-='HospKill.dmi'
									return "no damage"

			var/reflect= 0
			if(istype(M,/mob/Hittable/Command/Clones/))
				if(KI_InMission&&(M.Creator in KI_Participants))
					return "no damage"
			if(istype(M,/mob/Hittable/Responsive/Animal/Pet/))
				if(KI_InMission&&(M.Master in KI_Participants))
					return "no damage"
			if(SunaNoMayu)
				return "no damage"

			switch(METHOD)
				if("BunshinExplode","own sawarabi","suna shuriken","Dorou Doumu","electricrecoil","Explosion","reflect","shock","Inazuma","KazanFunka","KuchuNejire","neck bind","Samehada Self","RasenShuriken","Jashin","tsukuyomi","RetsudoTensho","ClayDeteriorate","ClayBomb","ZeroBomb","Shibari","Sound","ShikiFujin","Shinwonryu","ShinsuForce","FuujinHeki","Suirou","SoSo","TengaShinsei")
					if(kaiten)
						DAMAGE *= 0.3
					else if(MushiKabe)
						DAMAGE *= 0.4
					else if(InKaramatsu)
						DAMAGE *= 0.75
					else if(BugArmour)
						DAMAGE *= 0.8
					//if(InSawa) DAMAGE *= 0.9-(SawaLevel*0.1)
					else if(SandArmour)
						DAMAGE *= 0.60
					if(Blocking)
						DAMAGE *= 0.85

				if("Samehada Self","Self","own sawarabi")
					DAMAGE *= 1.3

				if("ClayDeteriorate")
					if(RaitonArmour||RaitonCurrent)
						return "no damage"

				else
					if(kaiten)
						DAMAGE *= 0.3
						if(!isobj(METHOD))
							reflect="kaiten"
					else if(MushiKabe)
						DAMAGE *= 0.4
						if(!isobj(METHOD))
							reflect="kabe"
					else if(InKaramatsu)
						DAMAGE *= 0.75
						if(!isobj(METHOD))
							reflect="karamatsu"
					else if(BugArmour)
						DAMAGE *= 0.8
					//if(InSawa) DAMAGE *= 0.9-(SawaLevel*0.1)
					else if(SandArmour)
						DAMAGE *= 0.60
					if(Blocking)
						DAMAGE *= 0.85

			if(reflect)
				M.Reflect(src,damage,reflect,METHOD)

			if(istype(M,/mob/player))
				if(KI_InMission&&(M in KI_Participants))
					DAMAGE=1 //do 25% damage to allies in Invasion of Konoha
				if(OverWorldKillMe() && FriendlyFireCheck(src))
					DAMAGE=1 //friendly fire, do 8% damage

			if(DAMAGE<=1)
				return "no damage"
		return round(DAMAGE)

	Reflect(mob/shielded,damage,reflect,METHOD)
		if(METHOD=="tsukuyomi") return
		if(METHOD=="neck bind") return
		var/WOUNDS
		switch(reflect)
			if("karamatsu")
				damage = (damage*0.15)
				Wounds++
			if("kabe")
				damage = (damage*0.40)
			if("kaiten")
				damage = (damage*0.60)
		WOUNDS=(damage/StaminaMax)*73
		if((Stamina-damage)>=0) Stamina-=damage
		else Stamina=0

		Wounds+=WOUNDS
		Damaged()
		DamageReport(shielded,src,damage,"reflect")
		RefreshStamina(); RefreshWounds()
		if(!(KO)) KO_Check(damage,shielded)

	KO_Actions()
		for(var/obj/Scrolls/ChuuninScrolls/X in src)
			viewers(5,src)<<"<b>[src] dropped \an [X.name]</b>"
			X.loc=loc; HasHeaven=0; HasEarth=0;
		for(var/obj/Item/parcel/P in contents)
			del(P)
		UpdateInventory()
		for(var/mob/Hittable/Command/Clones/B in MasterBunshinList) del(B)
		if(CS) {CS=0; Revert()}
		BugArmour=0
		InKaramatsu=0
		SandArmour=0
		SageMode = 0
		if(Thorn)
			ThornDeactivate()
		if(InShinwon)
			InShinwon = 0
			overlays-=icon('Shinwonryu.dmi')

	Death_Ejection()
		if(src in EventParticipants)
			EventParticipants-=src
			src<<"<B>You have been knocked out of the tournament!</b>"
			for(var/mob/m in EventParticipants)
				m<<output("<i>[src] is eliminated!</i>","ann")
			if(InRoyale)
				InRoyale = 0
				RoyaleCount--
		if(src in GuildWarList) {GuildWarList-=src; src<<"You have been knocked out of the Guild War!"}
		if(src in BattleList) BattleList-=src
		if(src in KI_Participants)
			KI_Participants-=src
			if(!length(KI_Participants))
				for(var/mob/A in KonohaInvasionAIList) del(A)
		for(var/mob/A in MasterPlayerList)
			if(src in A.ShadowList) A.ShadowList-=src
			if(src in A.HitList) A.HitList-=src
			if(src in A.Provoke) A.Provoke-=src
		if(src in SoundMissionaries)
			src<<"You failed to defeat the <i>Sound 5</i>."
			Sound5Deaths++
			//SoundMissionaries -= src
		if(Sound5Deaths >= length(SoundMissionaries))
			for(var/mob/player/M2 in SoundMissionaries)
				SoundMissionaries -= M2
				M2.Sound5Kills = 0
				M2 << "The Sound 5 remain at large"
			SoundForestClosed = 0
			Sound5Entrants = 0
			Sound5Deaths = 0
			for(var/mob/Hittable/Responsive/NPC/Mission/Sound5/S in SoundList)
				del S
		for(var/mob/A in range(10))
			A.HitList -= A.trueName
			A.HitList -= A

	Death_Verbs()
		verbs -= /mob/Suicide/verb/Suicide

	Death_ResetVariables()
		CantWalk = 0
		dead=1; KO=0; Stamina=0; Wounds=0;
		KonohaInvasionPoints=0; Hide_InvasionScore()
		movespeed=setspeed; WeightSpeed()
		attacking=0; firing=0; swimming=0; KOfrom=null
		onwater=0; onwaterfall=0; onmountain=0; onsand=0; InSparArea=0; onsandTile=0
		InSharingan=0; InMangekyou=0; Tsukuyomi=0
		InByakugan=0
		InSoutourou=0
		DamagedRecently=0
		DaibaSmother=0; meditating=0; meditatetime=0; frozen=0; Poisoned=0; HasKonchuu=list()
		DeliverTo=0; KI_InMission=0
		Wager=0; Arena=0

		GateStam = 0
		GateTai = 0
		GateSpeed = 0
		GateRFX = 0

		Gate = 0
		GateTime = 0

		SkillTime = 0
		SetTimer(0,0,"SkillTimer")
		EventTime = 0
		SetTimer(0,0,"EventTimer")

		InZero = 0;
		Grown = 0
		ShifoICon = 0
		ClayInfection = 0
		ShiFoClone = 0

		InSenKaze = 0
		InIllusion = 0
		SenshokuDispel = 0

		RefreshStats()
		spawn(20)
			invisibility = 7
			see_invisible = 7

		pixel_x = 0
		pixel_y = 0

		//if(Clan=="Akimichi") Calories=50;
		if(reaper)
			reaper=0
		if(Giant)
			Akimichi_Revert_DamageMe()

		HasKonchuu = list()
		if(length(BugExplodeList))
			for(var/mob/A in BugExplodeList)
				A.HasKonchuu -= ckey
			BugExplodeList = list()
		MirrorCreationMode=0
		if(usingMirrors)
			EndMirrors()
			InAMirror = 0
			EnteredOBJ = 0
			for(var/mob/Hittable/Unresponsive/Inanimate/Break/DemonMirror/A in AllMirrors)
				del A
		if(InSawa)
			for(var/mob/Hittable/Unresponsive/Inanimate/Break/Bone/A in Bones)
				del A
			Taijutsu -= usr.SawaBoost
			SawaBoost = 0
			InSawa = 0
			EnteredOBJ = 0
		if(InFakeEnemyView)
			ReleaseFakeEnemy()
		if(InIzanami)
			ReleaseIzanami()
		if(RaitonArmour)
			RaitonArmour = 0
		if(InFakeView)
			ReleaseFakeEye()
		if(Thorn)
			ThornDeactivate()
		if(Marked)
			for(var/mob/A in MarkedMe)
				A.MarkedTargets -= A.trueName
			MarkedMe = list()
			Marked = 0
		if(RinneBlown)
			RinneBlown = 0
		if(InHien)
			InHien = 0