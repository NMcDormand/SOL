


/*
Done:
	* Boilerplate NPC template

Next:
	* Get movement down

*/

/* Stuff Fry Has To Delete */

var
	/* Attack Target Vars */
	STRONGEST = 1
	LEAST_STRONGER_THAN_ME = 2
	LEAST_WEAKER_THAN_ME = 3
	WEAKEST = 4
	RANDOM = 5

mob/NPC/People
	var
		/*
		AIStrategy is one of
			* Lenient Strongest
		*/
		AISleepTimer 		= 60

		// Taijutsu AI Variables
		AttackRange 		= 15

		// Genjutsu AI Variables
		NehanEvadeProb		= 20
		GenEvadeProb 		= 10

		mob/AITarget
	proc
		Healthy()
			world << "Am I healthy?!?!"
			..()

		PickTarget()
			world << "Picking my target!"
			..()

		AILongRangeNinjutsuAttack()
			world << "Wee long range ninjutsu!"
			..()

		AIShortRangeNinjutsuAttack()
			world << "Wee short range ninjutsu!"
			..()

		AITaijutsuAttack()
			world << "Boo taijutsu!"
			..()

		ApproachEnemy()
			..()
			if(AITarget)
				world << "Attempting step"

				step_towards(src, AITarget)
				/*
				var/turf/TU = get_step(Target,turn(Target.dir,pick(-180,-90,90)))
				if(TU)
					loc.loc.Exited(src)
					loc = TU
					if(loc.loc)
						loc.loc.Entered(src)
				*/


mob/NPC/People/Zabuza
	name				= "Zabuza"
	icon				= 'Zabuza.dmi'
	Village				= "Seven Legendary Swordsmen"
	NinjaRank			= "Jounin"

	Level				= 350

	AISleepTimer		= 20
	Aggressive			= 0
	AttackRange			= 15
	NehanEvadeProb		= 80
	GenEvadeProb		= 45

	WW 					= 1
	BunshinLimit 		= 4
	protect 			= 0

	Stamina				= 2500000
	StaminaMax			= 2500000
	Chakra				= 55000
	ChakraMax			= 55000

	Taijutsu			= 55000
	TaijutsuMax			= 55000

	Genjutsu			= 25000
	GenjutsuMax			= 25000

	Ninjutsu			= 65000
	NinjutsuMax			= 65000

	WindElemental		= 30000
	FireElemental		= 100
	LightningElemental	= 100
	WaterElemental		= 70000
	EarthElemental		= 100

	Reflex				= 120
	ReflexTrue			= 120

	movespeed			= 1.4
	atkspeed			= 7

	gender="male"

	// HasHiraishin = 1
	// EvadeChance = 10
	var/list/Touched = list()

	Action(mob/user)
		if(get_dist(user,src)>2) return
		if(user.GMfrozen||user.choosing)
			return
		else
			// TODO: Make him give technique for Executioner Blade usage.
			user<<"When I was your age, my hands were already soaked in blood..."

	New()
		//del src
		//return

		src.respawn=src.loc
		spawn(66) AI()

	FreeMe()
		if(waterprisond)
			//if(LightningElemental)
			//	Inazuma() //Lightning Field
			// TODO: MizuBunshin Subtitution Evade
			waterprisond = 0
			overlays -= 'WPrison.dmi'

		if(JubakuBound)
			// TODO: MizuBunshin Subtitution Evade
			JubakuBound = 0
		..()

	GetSerious()
		Serious = 1
		atkspeed = 2
		EvadeChance = 40
		ATKWAit = 3

	PickTarget()
		world << "Picking a target."
		var/mob
			M; t

		src.HuntList=new/list
		for(M in HitList)
			if(M == src || M in src.KageBunshinList)
				HitList -= M
				continue

			if(M.dead)
				HitList -= M
				continue

			if(M.protect)
				continue

			if(get_dist(M,src) > AttackRange)
				HitList -= M
				continue

			if(M.KO)
				target = M
				break
			else
				HuntList+=M
				for(var/mob/Clones/C in M.KageBunshinList)
					if(!(C in src.HitList))
						src.HuntList+=C

			if(!t && length(src.HuntList))
				t=pick(HuntList)
			if(t)
				AITarget=t

	AI()
		set waitfor = 0
		while(!dead)
			sleep(AISleepTimer)

			PickTarget()
			while(AITarget)
				sleep(AISleepTimer)

				if(!Healthy())
					sleep(10)
					continue

				// If we have a target, go after them
				if(AITarget)
					if(get_dist(src, AITarget) < 2)
						AITaijutsuAttack(AITarget)
					else if(get_dist(src,AITarget) > 5)
						if(prob(15))
							AILongRangeNinjutsuAttack(AITarget)
						else
							ApproachEnemy(AITarget)
					else
						if(prob(5))
							AIShortRangeNinjutsuAttack(AITarget)
						else
							ApproachEnemy(AITarget)

	Healthy()
		return (src.Stamina>0&&!dead&&!DeathSee&&!Lotus&&!KO&&!MushiKabe&&!fallen&&!Underground&&!frozen&&!GMfrozen&&!resting&&!src.cantwalk&&!length(src.AcquiringList))

	Attack1(mob/M)
		if(sleepy&&prob(98))
			sleepy=0;
			DispelProc()
		if(M)
			if(M.KO)
				AI_KO(M)
			else if(M.dead)
				HitList -= M
			else
				if(waterprisond||JubakuBound)
					FreeMe()
				if(src.Stamina>0&&!dead&&!DeathSee&&!Lotus&&!KO&&!MushiKabe&&!fallen&&!Underground&&!frozen&&!GMfrozen&&!resting&&!src.cantwalk&&!length(src.AcquiringList))
					if(get_dist(src,M)>2 && !M.UsedArashi && !M.InFujinHeki)
						sleep(ATKWAit)
						if(KO)
							return
						if(M)
							if(M.protect)
								HitList -= M
								return
							if((M in Touched)) // && !(M.PortBlockCheck()))
								var/turf/TU = get_step(M,turn(M.dir,pick(-180,-90,90)))
								if(TU)
									//var/turf/HL = loc
									//HL.overlays += 'Hiraishin.dmi'
									//spawn(4)
									//	HL.overlays -= 'Hiraishin.dmi'
									loc.loc.Exited(src)
									loc = TU
									if(loc.loc)
										loc.loc.Entered(src)
							if(!length(src.KageBunshinList) && prob(23))
								src.ShadowClone(M)
								src.ShadowClone(M)
								src.ShadowClone(M)
							else if(M.icon_state=="seals"&&prob(90))
								Evade1(M)
							else if(firing&&!M.kaiten&&!M.MushiKabe)
								src.AI_Attack(M,11)
							else if(!src.firing)
								Move_In1(M);
								spawn(5)
									//src.Mugen()
									src.Ryuuka()
							else
								src.AI_Attack(M,10)
					else
						sleep(ATKWAit)
						if(KO)
							return
						if(M)
							if(!M.kaiten&&!M.MushiKabe)
								src.AI_Attack(M,12)
							else
								src.AI_Attack(M,10)

	AI_Attack(mob/M, var/AttackTime)
		while(AttackTime)
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
						if((M in Touched)) // && !(M.PortBlockCheck()))
							var/turf/TU = get_step(M,turn(M.dir,pick(-180,-90,90)))
							if(TU)
								//var/turf/HL = loc
								//HL.overlays += 'Hiraishin.dmi'
								//spawn(4)
								//	HL.overlays -= 'Hiraishin.dmi'
								loc.loc.Exited(src)
								loc = TU
								if(loc.loc)
									loc.loc.Entered(src)
						else
							if(!step_to(src,M))
								StepFailed++
							else
								StepFailed = 0
							sleep(movespeed)
							if(!src || !M)
								return
				if(KO)
					break
				if(get_dist(src,M)<2)
					if(!(M in Touched))
						Touched +=M
					dir = get_dir(src,M)
					src.AI_Punch(M)
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
				if((M in Touched))
					var/turf/TU = get_step(M,turn(M.dir,pick(-180,-90,90)))
					if(TU)
						//var/turf/HL = loc
						//HL.overlays += 'Hiraishin.dmi'
						//spawn(4)
						//	HL.overlays -= 'Hiraishin.dmi'
						loc.loc.Exited(src)
						loc = TU
						if(loc.loc)
							loc.loc.Entered(src)
				else
					if(!step_to(src,M))
						StepFailed++
						/*if(StepFailed>30)
							Stamina = StaminaMax
							Wounds = 0
							SageModeDispel()
							Serious = 0
							Serious = 0
							movespeed=1
							atkspeed=4
							IKunai = 18
							ATKWAit = 5
							hearers(8,src)<<output("<b><font face=verdana color=\"#9999FF\">Minato Namikaze</font> says:</b> with this chance ill bandage my wounds", "Chat")
							if(loc.loc)
								loc.loc.Exited(src)
							loc=respawn
							dir=SOUTH
							FEvade = initial(FEvade)
							HasKonchuu = list()
							DamagedMe = list()
							HitList = list()
							HuntList = list()
							DamWait = 1800
							if(loc.loc)
								loc.loc.Entered(src)
							break*/
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
					src.dir=get_dir(src,M)
					if(src.TaiAttackCheck(M))
						KOChase = 0
						return
					if(!M.KO && !M.dead)
						if(Serious)
							hearers(8,src)<<output("<b><font face=verdana color=\"#9999FF\">Minato Namikaze</font> says:</b> You're forcing this on me", "Chat")
						else
							if(M.Village == "Leaf")
								hearers(8,src)<<output("<b><font face=verdana color=\"#9999FF\">Minato Namikaze</font> says:</b> The will of fire burns strong in you", "Chat")
							else
								hearers(8,src)<<output("<b><font face=verdana color=\"#9999FF\">Minato Namikaze</font> says:</b> I may need to take you more seriously", "Chat")
					else
						if(!M.dead)
							hearers(8,src)<<output("<b><font face=verdana color=\"#9999FF\">Minato Namikaze</font> says:</b>  If a person hasn't discovered something that they will die for, they arent fit to live.", "Chat")
							src.attacking=1
							spawn(src.atkspeed+3)
								if(src)
									src.attacking=0
							flick("punch",src)
							M.Wounds+=150
							// M.KillMe(src)
							HitList -= M
				KOChase = 0

	AI_Punch(mob/TARGET)
		if(TARGET)
			if(src.TaiAttackCheck(TARGET)) return
			if(src.inchidori)	{src.ChidoriPunch(TARGET); return}
			if(src.inrasengan) {src.RasenganPunch(TARGET); return}
			var/dmg=round(src.Taijutsu*0.9-(TARGET.Taijutsu*0.09))
			dmg+=src.BunshinWeapons(TARGET)
			if(dmg<round(src.Taijutsu*0.1)) dmg=round(src.Taijutsu*0.1)
			flick("punch",src)
			if(src.HitCheck(TARGET))
				src.attacking=1; spawn(src.atkspeed)src.attacking=0
				TARGET.DamageMe(src,dmg,src.AttackMethod)
				if(TARGET.KO)
					AI_KO(TARGET)
			else
				src.attacking=1
				spawn(atkspeed*4)src.attacking=null
				TARGET<<"You dodged [src]'s attack"

	DamageMe(mob/M, var/D,METHOD,hidemessage)
		if(src.dead || M == src || M.protect)
			return
		if(get_dist(M,src) < 2)
			if(!istype(M,/mob/NPC) && ismob(M))
				if(!(M in src.HitList))
					src.HitList+=M
		if(!istype(M,/mob/NPC) && ismob(M))
			if(!(M in src.HitList))
				src.HitList+=M
			if(!DamagedMe[M.trueName])
				DamagedMe[M.trueName] = D
			else
				DamagedMe[M.trueName] += D
		var
			w
		if(D<1)
			D=1
		D=round(D); w=(D/src.StaminaMax)*65
		src.Stamina-=D;

		if(M)
			if(!DamagedRecently || !DamWait)
				DamWait = 1800
				DamageTimer(DamWait)
			else
				DamWait = 1800
			src.Damaged(1)
			if(!hidemessage)
				DamageReport(src,M,D,METHOD)

			M.ExperienceCheck(w,src)
			M.RefreshStats()
			if(src.Stamina<=0&&src.Wounds<100)
				if(!src.KO)
					src.KO=1
					var/R=50000
					for(var/mob/b in src.KageBunshinList)
						del(b)
					src.icon_state="KO"; range(src)<<"<b><i>[src] has fallen with exhaustion!</i></b>"
					spawn(50)
						if(src.Wounds<100)
							src.KO=0
							src.icon_state=""
							src.Stamina=R
						else
							src.KillMe(M)
				else src.Wounds+=5
			else if((src.Wounds>=150)||(src.Stamina<=0&&src.Wounds>=100))
				if(!src.KO)
					src.KO=1; src.icon_state="KO"; range(src)<<"<b><i>[src] has fallen gravely unconcious!</i></b>"
					spawn(50)if(M&&!M.dead)src.KillMe(M)
//--------------------------------------------------------
	proc
		DamageTimer(A)
			set waitfor = 0
			while(DamWait)
				if(src)
					DamWait-=60
					sleep(60)
				else
					return
			if(src)
				if(!dead && !KO)
					if(!DamagedRecently && Stamina < StaminaMax)
						Stamina = StaminaMax
						Wounds = 0
						//SageModeDispel()
						Serious = 0
						movespeed=1
						atkspeed=4
						ATKWAit = 5
						hearers(8,src)<<output("<b><font face=verdana color=\"#9999FF\">Minato Namikaze</font> says:</b> with this chance ill bandage my wounds", "Chat")
						if(loc.loc)
							loc.loc.Exited(src)
						loc=respawn
						dir=SOUTH
						FEvade = initial(FEvade)
						HasKonchuu = list()
						DamagedMe = list()
						var/NOLOC = 0
						for(var/mob/MO in HitList)
							if(MO == src)
								HitList -= MO
								continue
							if(MO.z == z && get_dist(MO, src) <= 8)
								NOLOC = 1
						if(!NOLOC)
							HitList = list()
							HuntList = list()
							loc = respawn

/*
		HiraishinBarrage()
			hearers(8,src)<<output("<b><font face=verdana color=\"#9999FF\">Minato Namikaze</font> says:</b> This will be over in an...", "Chat")

			var/list/PList = list()
			var/turf/FStep = loc
			for(var/turf/A in range(10))
				PList += A
			for(var/mob/A in HitList)
				if(A == src)
					HitList -= A
					continue
				if(A in Touched)
					spawn()
						var/s
						for(var/turf/B in orange(A,1))
							s = pick(0,1,2,3,4,5)
							spawn(s)
								var/turf/OL = loc
								OL.overlays += 'Hiraishin.dmi'
								B.overlays += 'Hiraishin.dmi'
								spawn(4)
									OL.overlays -= 'Hiraishin.dmi'
									B.overlays -= 'Hiraishin.dmi'
								loc = pick(PList)
						A.DamageMe(src,(Taijutsu*18)*0.2,"HiraishinBarrage")
			loc = FStep

			hearers(8,src)<<output("<b><font face=verdana color=\"#9999FF\">Minato Namikaze</font> says:</b> ...Instant", "Chat")

mob/proc
	Mugen()
		set waitfor = 0
		if(src.GenericAttackCheck()) return
		src.firing=0

		if(usr.CooldownCheck("Mugen",(300*usr.cooldownmultiplier)))

		else
			hearers(8,src)<<output("<b><font face=verdana color=\"#9999FF\">Minato Namikaze</font> says:</b> Fuuton: Mugen Sajin Daitoppa!", "Chat")
			var/obj/Jutsu/Fuuton/MugenSajin/F1=new/obj/Jutsu/Fuuton/MugenSajin(get_step(usr,usr.dir))
			var/obj/Jutsu/Fuuton/MugenSajin/F2=new/obj/Jutsu/Fuuton/MugenSajin
			var/obj/Jutsu/Fuuton/MugenSajin/F3=new/obj/Jutsu/Fuuton/MugenSajin

			CreateProjectile(usr,F1,"Wind",usr.loc,usr.dir,0,15,1,1.4)
			spawn(1)
				CreateProjectile(usr,F2,"Wind",(get_step(usr,turn(usr.dir,90))),usr.dir,0,15,1,0.7)
				CreateProjectile(usr,F3,"Wind",(get_step(usr,turn(usr.dir,-90))),usr.dir,0,15,1,0.7)
				F2.loc = get_step(F2,usr.dir); F3.loc = get_step(F3,usr.dir)
*/