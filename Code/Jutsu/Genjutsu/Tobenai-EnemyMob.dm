mob/Hittable/Command/Genjutsu/FakeEnemy
	density = 1
	var/list/AttackTarget = list()
	CantHenge = 1
	Del()
		walk(src,0)
		Creator = null
		loc = null
		..()
	DamageMe(mob/M,DAMAGE,METHOD,hidemessage) //M is the attacker, src is the person being hit (and taking dmg)
		set waitfor = 0
		if(!(M in AttackTarget))
			return
		var/WOUNDS
		var/mob/OWNER
		DAMAGE=AssessDamage(DAMAGE,M,METHOD)
		if(DAMAGE=="no damage")
			TextOverlay(src, 0, "Miss")
			return
		else
			DAMAGE=round(DAMAGE * 0.5)
		if(M)
			TextOverlay(src, DAMAGE, "Damage");
			if(!hidemessage) DamageReport(src,M,DAMAGE,METHOD)
			if(istype(M,/mob/Hittable/Command/Clones/)) OWNER=M.Creator
			if(istype(M,/mob/Hittable/Responsive/Animal/Pet/)) OWNER=M.Master

			var/mob/TGT
			if(OWNER)
				TGT = OWNER
			else
				TGT = M

			if(TGT.cheater)
				DAMAGE*=10;
			WOUNDS=(DAMAGE/TGT.StaminaMax)*73
			if((TGT.Stamina-DAMAGE)>=0)
				TGT.Stamina-=DAMAGE
			else
				TGT.Stamina=0
			TGT.Wounds+=WOUNDS

			TGT.Damaged()

			if(TGT.Wounds>=250)
				TGT.Wounds=250
				TGT.KillMe(Creator)
				return

			if(TGT.KO)
				TGT.Wounds+=2
				TGT.RefreshStats()
			else
				TGT.KO_Check(DAMAGE,Creator)

	Cross(A)
		if(ismob(A))
			var/mob/M = A
			if((M in AttackTarget)|| (M.Creator in AttackTarget))
				..()
			else
				return 1
		else if(isobj(A))
			var/obj/O = A
			if(O.Owner in AttackTarget)
				..()
			else
				return 1
		else
			return 1

	AI()
		set background = 1
		set waitfor = 0
		while(src)
			if(sleepy)
				sleepy=0
				DispelProc()
			var/mob/M = pick(AttackTarget)
			if(M)
				if(M.protect || M.dead)
					sleep(20)
				else
					Attack1(M)
			else
				del src

	Attack1(mob/M)
		REDO
		if(M)
			if(!DeathSee&&!Lotus&&!KO&&!MushiKabe&&!fallen&&!Underground&&!frozen&&!GMfrozen&&!resting&&!CantWalk&&!length(AcquiringList))
				if(get_dist(src,M)>1 && !M.UsedArashi && !M.protect)
					step_to(src,M)
					sleep(2)
					goto REDO
				else
					if(M)
						AI_Punch(M)
						sleep(5)

	AI_Punch(mob/TARGET)
		if(TARGET && src)
			if(TAICHECKBOTH(src,TARGET)) return
			var/dmg=round(Taijutsu*0.9-(TARGET.Taijutsu*0.09))
			if(dmg<round(Taijutsu*0.1))
				dmg=round(Taijutsu*0.1)
			if(HitCheck(TARGET))
				attacking=1; spawn(atkspeed)attacking=0
				TARGET.FakeDamageMe(src,dmg,AttackMethod)
			else
				attacking=1
				spawn(15)attacking=null
				TARGET<<"You dodged [src]'s attack"

mob/proc
	FakeDamageMe(mob/M,DAMAGE,METHOD,hidemessage) //M is the attacker, src is the person being hit (and taking dmg)
		set waitfor = 0
		if(InAMirror)
			M << "[src] was protected by \his mirror of ice"
			return
		DAMAGE=AssessDamage(DAMAGE,M,METHOD)
		if(DAMAGE=="no damage") {TextOverlay(src, 0, "Miss");return;}
		if(cheater) DAMAGE*=10;
		resting=0
		if(M)
			M.RevengeProtect=0
			Damaged()
			TextOverlay(src, DAMAGE, "Damage");
			if(!hidemessage) DamageReport(src,M,DAMAGE,METHOD)