mob/Hittable/Responsive/Boss/MadaraFake
	name="Madara"
	icon='Base_Pale.dmi'
	Village="Event"
	NinjaRank="Ancestor"
	WW = 1
	Level = 0
	Taijutsu=90500
	Ninjutsu=200500
	Genjutsu=90500
	TaijutsuMax=90500
	NinjutsuMax=200500
	GenjutsuMax=90500
	Stamina=9500000
	StaminaMax=9500000
	ChakraMax=80000
	WindElemental=1000
	FireElemental=1000
	LightningElemental=1000
	WaterElemental=1000
	EarthElemental=1000
	VillageColour = "#990000"
	Reflex=45
	ReflexTrue=45
	gender="male"
	movespeed=2
	atkspeed=6
	protect=0

	EvadeChance = 10
	BunshinLimit = 16
	PursuitMSG = "What little light you had has now faded"

/*	Action(mob/user)
		if(get_dist(user,src)>2) return
		if(user.GMfrozen||user.choosing)
			return
		else
			if(!user.GaveSpecialScroll)
				var/obj/Item/Scroll/Special_Scroll/OB = locate() in user.contents
				if(OB)
					if(user.TaijutsuTrue > 120000 && user.NinjutsuTrue > 80000)
						user << "I see Jiraiya has given you his blessing, I cant teach you everything but this will go a long way"
						del OB
						user.GaveSpecialScroll = 1
					else
						user << "I see you have the blessing but you lack the skill for this technique"
*/
	New()
		//del src
		//return
		//overlays += icon('SharinganEyes.dmi')
		..()
		overlays += icon('Shoes.dmi')
		overlays += icon('Pants.dmi')
		overlays += icon('UchiShirt.dmi')
		overlays += icon('Madara-Chest.dmi')
		overlays += icon('Hair_Madara.dmi')

		respawn=loc
		SpecialMobs["Madara"] = src
		spawn(10) AI()

	GetSerious()
		Serious = 1
		atkspeed = 4
		ATKWAit = 8
		Stamina += 1000000
		Wounds = 0
		hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> this is a sample of my skill", "Chat")

		DouEyes = new/Overlay_Obj('SharinganEyes.dmi',EYE_LAYER)
		overlays+=DouEyes
		InSharingan=3;

		new/obj/SharEye(src,"S3")
		Reflex+=10

		if(!Projection)
			see_invisible += InSharingan

	AI()
		set waitfor = 0
		while(!dead)
			if(RinneBlown)
				sleep(movespeed)
				continue
			if(KO)
				sleep(10)
				continue

			var/mob/t
			var/list/ppl = list()
			var/list/Clones = list()
			for(var/H in HitList)
				var/mob/M = HitList[H]
				if(!M)
					InactiveList[H] = 1
					HitList -= H
					continue
				if(M == src)
					HitList -= H
					continue
				if(M.dead)
					HitList -= H
					continue
				if(M.protect)
					continue
				if(get_dist(M,src) > 15 || z != M.z)
					continue
				if(invisibility > see_invisible)
					continue
				else// if(M in YieldList)
					if(M.KO)
						t = M
						if(PursuitMSG)
							hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b>  [PursuitMSG]", "Chat")
						break
					else
						if(istype(M,/mob/Hittable/Command/Clones))
							Clones += M
						else if(istype(M,/mob/Hittable/Command/EdoClone))
							Clones += M
							for(var/mob/Hittable/Command/Clones/C in M.KageBunshinList)
								Clones += C
						else
							ppl+=M
							for(var/mob/Hittable/Command/Clones/C in M.KageBunshinList)
								Clones += C
							for(var/mob/Hittable/Command/EdoClone/C in M.EdoCloneList)
								Clones += C
							if(M.Familiar)
								Clones+=M.Familiar
			if(!t)
				if(RESTRAINEDCHECK(src))
					sleep(10)
					continue
				var/P,C
				if(ppl.len)
					P = 1
				if(Clones.len)
					C = 1
				if(P&&C)
					if(prob(80))
						t = pick(ppl)
					else
						t = pick(Clones)
				else if(P)
					t = pick(ppl)
				else if(C)
					t = pick(Clones)
			if(t)
				Attack1(t)

			sleep(5)
			CHECK_TICK

	Attack1(mob/M)
		if(M)
			if(M.KO)
				AI_KO(M)
			else if(M.dead)
				HitList -= M.trueName
			else
				if(Stamina>0&&!dead&&!DeathSee&&!Lotus&&!KO&&!MushiKabe&&!fallen&&!Underground&&!frozen&&!GMfrozen&&!resting&&!CantWalk&&!length(AcquiringList))
					if(get_dist(src,M)>=2)
						sleep(ATKWAit)
						if(KO)
							return
						if(M)
							if(M.protect)
								return
							if(firing)
								AI_Attack(M,11)
							else if(!firing)
								Move_In(M);
								spawn(5)
									Ryuuka()
									sleep(2)
									Mugen()
							else
								AI_Attack(M,10)
					else
						sleep(ATKWAit)
						if(KO)
							return
						if(M)
							AI_Attack(M,12)

	AI_Attack(mob/M, var/AttackTime)
		while(AttackTime>0)
			if(KO)
				break
			if(!Serious)
				if((Stamina < StaminaMax * 0.5) && !KO)
					GetSerious()
			AttackTime--
			if(!M || M.protect || M.dead)
				break
			else
				var/A = get_dist(src,M)
				if(A>=20)
					break
				if(A>1)
					while(get_dist(src,M) > 1)
						if(KO)
							break
						step_to(src,M)
						sleep(movespeed)
						if(!src || !M)
							return
				if(KO)
					break
				if(get_dist(src,M)<2)
					dir = get_dir(src,M)
					AI_Punch(M)
					sleep(atkspeed)
		AttackTime = 0

	AI_KO(mob/M)
		if(KO || M.dead || KOChase)
			return
		if(M)
			KOChase = 1
			while(get_dist(src,M) > 1)
				if(KO)
					KOChase = 0
					return
				if(!step_to(src,M))
					StepFailed++
				else
					StepFailed = 0
				sleep(movespeed)
				if(!src || !M)
					KOChase = 0
					return
			sleep(5)
			if(KO)
				KOChase = 0
				return
			if(src)
				if(M)
					dir=get_dir(src,M)
					if(TAICHECKBOTH(src,M))
						KOChase = 0
						return
					if(!M.KO && !M.dead)
						if(Serious)
							hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> Power is the only true necessity", "Chat")
						else
							hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> It seems that you still want to dance", "Chat")
					else
						if(!M.dead)
							hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> Wake up to reality! Nothing ever goes as planned in this world.", "Chat")
							attacking=1
							spawn(atkspeed+3)
								if(src)
									attacking=0
							flick("punch",src)
							M.Wounds+=150
							M.KillMe(src)
							HitList -= M.trueName
				KOChase = 0

	AI_Punch(mob/TARGET)
		if(TARGET)
			if(TAICHECKBOTH(src,TARGET)) return
			var/dmg=round(Taijutsu*0.9-(TARGET.Taijutsu*0.09))
			dmg+=NPCWeapons(TARGET)
			if(dmg<round(Taijutsu*0.1)) dmg=round(Taijutsu*0.1)
			//flick("punch",src)
			icon_state = "punch"
			spawn(4)
				if(icon_state == "punch")
					icon_state = null
			if(HitCheck(TARGET))
				attacking=1; spawn(atkspeed)attacking=0
				TARGET.DamageMe(src,dmg,AttackMethod)
				if(TARGET.KO)
					AI_KO(TARGET)
			else
				attacking=1
				spawn(atkspeed*4)attacking=null
				TARGET<<"You dodged [src]'s attack"

	DamageMe(mob/M, var/D,METHOD,hidemessage)
		if(dead || M == src || M && M.protect)
			return
		var
			w
		if(D<1)
			D=1
		D=round(D);
		w=(D/StaminaMax)*65
		Stamina-=D;

		//if(D>100000000)
		//	hearers(8,src)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> I, Uchiha Madara, acknowledge your Power!", "Chat")
		if(M)
			M.Damaged()
			if(!istype(M,/mob/NPC) && ismob(M))
				if(!M.trueName)
					M.trueName = M.name
				if(!HitList[M.trueName])
					HitList[M.trueName] = M
				if(!DamagedMe[M.trueName])
					DamagedMe[M.trueName] = D
				else
					DamagedMe[M.trueName] += D
			Damaged()
			if(!hidemessage)
				DamageReport(src,M,D,METHOD)

			M.ExperienceCheck(w,src)
			M.RefreshStats()
			if(Stamina<=0&&Wounds<100)
				if(!KO)
					KO=1
					var/R=50000
					for(var/mob/b in KageBunshinList)
						del(b)
					icon_state="KO"; range(src)<<"<b><i>[src] has fallen with exhaustion!</i></b>"
					spawn(50)
						if(Wounds<100)
							KO=0
							icon_state=""
							Stamina=R
						else
							KillMe(M)
				else Wounds+=5
			else if((Wounds>=150)||(Stamina<=0&&Wounds>=100))
				if(!KO)
					KO=1; icon_state="KO"; range(src)<<"<b><i>[src] has fallen gravely unconcious!</i></b>"
					spawn(50)if(M&&!M.dead)KillMe(M)

	KillMe(mob/M)
		..()
		if(istype(M,/mob/Hittable/Command/Clones/)) M=M.Creator
		if(istype(M,/mob/Hittable/Responsive/Animal/Pet/)) M=M.Master
		if(dead) return
		dead=1
		//if(M)
			//var/mob/Hittable/Responsive/Boss/Madara/RM = new(loc)
			//SpecialMobs["Madara"] = RM
			//RM.HitList[M.trueName] = M
		flick('Smoke.dmi',src)
		spawn(5)
			invisibility = 100
		sleep(10)
		new/Effect/Visual/KuchuNejire(loc)
		var/mob/Hittable/Responsive/Boss/Madara/TM = new()

		new/Effect/Visual/TengaiShinsei(loc,TM,1)
		sleep(10)
		del src