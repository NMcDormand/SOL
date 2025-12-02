var/list/SpecialMobs = list()

//********************************NPC ATTACK**************************************************************
mob/
	var
		HigherEvade = 0
		HasHiraishin = 0
		EvadeChance = 0
		HuntList=list()
		tmp
			Serious = 0
			Knives
			HEvade = 0
			StepFailed
			ATKWAit = 5
			DamWait = 0
			NotFinishMSG = 0
			PursuitMSG = 0
			InactiveList = list()

proc
	SpawnMe(Wait=0,T,LOC)
		set waitfor = 0, background = 1
		spawn(Wait)
			new T(LOC)
mob/proc
	FreeMe()
		..()
	GetSerious()
		..()
	AI_Attack(mob/M, var/AttackTime, var/d)
		..()
	Attack1(mob/M)
		..()
	Attack2(mob/M)
		..()
	AI(mob/M)
		..()
	LocateTarget(mob/M)
		..()
	AI_KO(mob/M)
		..()

	AI_Punch(mob/TARGET)
		if(TARGET)
			if(TAICHECKBOTH(src,TARGET)) return
			if(inchidori){ChidoriPunch(TARGET); return}
			if(inrasengan) {RasenganPunch(TARGET); return}
			var/dmg=round(Taijutsu*0.9-(TARGET.Taijutsu*0.09))
			if(istype(src,/mob/Hittable/Command/Clones))
				dmg+=BunshinWeapons(TARGET)
			else
				dmg+=NPCWeapons(TARGET)
			if(dmg<round(Taijutsu*0.1)) dmg=round(Taijutsu*0.1)
			flick("punch",src)
			if(HitCheck(TARGET))
				attacking=1; spawn(atkspeed)attacking=0
				TARGET.DamageMe(src,dmg,AttackMethod)
			else
				attacking=1
				spawn(atkspeed*4)attacking=null
				TARGET<<"You dodged [src]'s attack"

	AI_Kick(mob/M)
		if(M)
			var/dmg=round(usr.Taijutsu*1.4-(M.Taijutsu*0.11))
			dmg+=usr.Kicks(); flick("kick",usr)
			if(dmg<round(usr.Taijutsu*0.1)) dmg=round(usr.Taijutsu*0.1)
			usr.attacking=1; spawn(usr.kickspeed)usr.attacking=0
			M.DamageMe(src,dmg,"kick")

	BunshinAttack(mob/M)
		var/mob/O=Creator
		if(M==O) return
		if(istype(M,/mob/Hittable/Unresponsive/NPC/Panda))
			Del(src); //Don't touch Panda!
		if(TAICHECKBOTH(src,M)) return
		if(inchidori) {ChidoriPunch(M); return}
		if(inrasengan) {RasenganPunch(M); return}
		var/dmg=round(Taijutsu*0.9-(M.Taijutsu*0.09))
		dmg+=BunshinWeapons(M)
		if(dmg<round(Taijutsu*0.1)) dmg=round(Taijutsu*0.1)
		if(M.TreeStump)
			attacking=1; spawn(atkspeed)attacking=0
			if(Stamina<=15&&reset) return
			if(Stamina<=15&&!reset)
				reset=1; spawn(20)reset=0
				return
			flick("punch",src);
			if(StaminaXP>=StaminaMXP)
				StamUpTree()
			ApplyEXP(8,"taijutsu")
			if(!M.Cactus) {TreeStump(M,dmg); return}
			else if(M.Cactus) {Cactus(M,dmg); return}
		flick("punch",src)
		if(istype(M,/mob/NPC)&&!(Creator in M.HitList)) M.HitList+=Creator
		if(HitCheck(M))
			if(Drunk) {attacking=1; spawn(atkspeed-1)attacking=0}
			else {attacking=1; spawn(atkspeed)attacking=0}
			M.DamageMe(src,dmg,AttackMethod)
			if(istype(src,/mob/Hittable/Command/Clones/MushiBunshin))
				if(prob(1))
					if(!M.HasKonchuu[O.ckey])
						M.HasKonchuu[O.ckey] = 0
					M.HasKonchuu[O.ckey] += 1
					if(!(M in O.BugExplodeList))
						O.BugExplodeList +=M

			var/taiup=rand(5,9)
			if(M) ApplyEXP(((taiup+M.taitraining)*5),"taijutsu")
		else
			attacking=1
			spawn(15)attacking=null
			M<<"You dodged [src]'s attack"

//------------------------------------------------------------------------

	Move_Away_To_Aim1(mob/M)
		var/delay=5
		spawn(max(movespeed-1,1))
			if(M)
				step_away(src,M)
			spawn(movespeed+1)
				if(M) step_away(src,M)
			spawn((movespeed*2)+2)
				if(M) step_away(src,M)
			spawn((movespeed*3)+4)
				if(M) step_to(src,M)
		delay=(max(movespeed-1,1))+(movespeed*3)+5
		return delay

	Move_Away_To_Aim2(mob/M)
		var/delay=5
		spawn(max(movespeed-1,1))
			if(M)
				step_away(src,M)
			spawn(movespeed+1)
				if(M) step_away(src,M)
			spawn((movespeed*2)+3)
				if(M) step_towards(src,M)
		delay=(max(movespeed-1,1))+(movespeed*2)+4
		return delay

	Evade1(mob/M)
		if(M)
			spawn(movespeed-1)
				step_away(src,M)
			spawn(movespeed*2+1)
				if(get_dir(src,M)==NORTH|SOUTH) pick(step(src,WEST),step(src,EAST))
				if(get_dir(src,M)==EAST|WEST) pick(step(src,NORTH),step(src,SOUTH))
				if(get_dir(src,M)==NORTHEAST|SOUTHWEST) pick(step(src,NORTHWEST),step(src,SOUTHEAST))
				if(get_dir(src,M)==NORTHWEST|SOUTHEAST) pick(step(src,SOUTHWEST),step(src,NORTHEAST))
			spawn(movespeed*3+2) step(src,dir)
			spawn(movespeed*4+3) step(src,dir)
			spawn(movespeed*5+4) {if(M) step_away(src,M)}
		sleep(2+(movespeed*6+5))

	Evade2(mob/M)
		if(M)
			spawn(movespeed-1)
				step_away(src,M)
				spawn(movespeed+1) step_away(src,M)
				spawn(movespeed*2+2) step_away(src,M)
				spawn(movespeed*3+3) step_away(src,M)
				spawn(movespeed*4+4)
					var/d=get_dir(src,M)
					if(d==NORTHEAST) dir=pick(NORTH,EAST)
					else if(d==NORTHWEST) dir=pick(NORTH,WEST)
					else if(d==SOUTHEAST) dir=pick(SOUTH,EAST)
					else if(d==SOUTHWEST) dir=pick(SOUTH,WEST)
					else dir=d
					DoryuuHeki()
		sleep(2+(movespeed*6+5))

	Evade3(mob/M)
		if(M)
			spawn(movespeed-1)
				step_away(src,M)
				sleep(movespeed+1)
				if(M) step_away(src,M)
				sleep(movespeed*2+2)
				if(M) step_away(src,M)
				sleep(movespeed*3+3)
				if(M) step_away(src,M)
				sleep(movespeed*4+4)
				if(M)
					dir=get_dir(src,M)
					if(wielding=="Fan"&&!CooldownCheck("Daikamaitachi",(90*cooldownmultiplier),1)) Fuuton_DaiKamaitachi()
					else if(wielding=="Fan"&&!CooldownCheck("Kamaitachi",(90*cooldownmultiplier),1)) Fuuton_Kamaitachi()
					else
						Blocking=1; icon_state="block"
						spawn()
							while(M.icon_state=="seals")
								sleep(2)
							spawn(18) {Blocking=0; icon_state=null;}

	Evade4(mob/M)
		if(Chakra>300&&!onwater)
			icon_state="seals"; spawn(6) icon_state=null
			overlays+='SunaNoMayu.dmi'
			spawn(5)
				SunaNoMayu=1; spawn(1)SunaNoMayuDrain()
				while(M&&(M.icon_state=="seals"||M.mirroring))
					if(!SunaNoMayu) {return}
					sleep(5)
				for(var/i=1,i<=5,i++)
					if(!SunaNoMayu) {return}
					sleep(10)
				SunaNoMayu=0;
		else Evade3(M)

	Move_In(mob/M)
		var/delay=5
		var/STEPS = 0
		while(M && get_dist(src,M)>1 && STEPS < 4)
			if(STEPS == 1)
				step(src,turn(dir,pick(45,-45)))
			else
				step_to(src,M)
			STEPS++
			delay += movespeed
			sleep(movespeed)
		return delay

	Move_Away(mob/M)
		var/delay=5
		var/STEPS = 0
		while(M && get_dist(src,M)>1 && STEPS < 4)
			step_away(src,M)
			STEPS++
			delay += movespeed
			sleep(movespeed)
		dir = get_dir(src,M)
		return delay

	Move_Aim(mob/M,Distance=0)
		if(Distance)
			walk_away(src,M,3,movespeed)
			sleep(movespeed)
		var/Ready=0
		var/StillTry = 1
		spawn(20)
			StillTry=0
		while(!Ready && M && StillTry)
			var/DIR = get_dir(src,M)
			if(DIR == NORTHEAST||DIR == NORTHWEST||DIR == SOUTHEAST||DIR == SOUTHWEST)
				var/VDIR = DIR & (NORTH|SOUTH)
				if(!step(src,VDIR))
					var/HDIR = DIR & (WEST|EAST)
					step(src,HDIR)
				sleep(movespeed)
			else
				Ready = 1
		walk(src,0)
		if(M && Ready)
			dir = get_dir(src,M)
			return 1
		else
			return 0


	Move_In1(mob/M)
		var/delay=5
		if(M)
			step_towards(src,M)
			spawn(movespeed+1)
				if(M&&get_dir(src,M)==NORTH|SOUTH)
					pick(step(src,WEST),step(src,EAST))
				else if(M&&get_dir(src,M)==EAST|WEST)
					pick(step(src,NORTH),step(src,SOUTH))
				else if(M&&get_dir(src,M)==NORTHEAST|SOUTHWEST)
					pick(step(src,NORTHWEST),step(src,SOUTHEAST))
				else if(M&&get_dir(src,M)==NORTHWEST|SOUTHEAST)
					pick(step(src,SOUTHWEST),step(src,NORTHEAST))
			spawn(movespeed*2+2)
				if(M)
					step_towards(src,M)
			spawn(movespeed*3+4)
				if(M)
					step_towards(src,M)
			delay=(movespeed*3)+4
		return delay