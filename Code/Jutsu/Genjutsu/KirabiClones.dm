mob/Hittable/Command/Genjutsu/KirabiClone
	density = 1
	CantHenge = 1
	var/mob/AttackTarget = list()
	Del()
		walk(src,0)
		Creator = null
		loc = null
		..()
	Cross(A)
		if(ismob(A))
			var/mob/M = A
			if(M == Creator||M.Creator == Creator)
				return 1
		else if(isobj(A))
			var/obj/O = A
			if(O.Owner == Creator)
				return 1
		..()
	DamageMe(mob/M,DAMAGE,METHOD,hidemessage) //M is the attacker, src is the person being hit (and taking dmg)
		set waitfor = 0
		if(M==Creator)
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
			del src

	AI()
		while(src)
			if(sleepy)
				sleepy=0
				DispelProc()
			var/mob/M = pick(AttackTarget)
			if(M.protect || M.dead)
				sleep(20)
			else if(M)
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
		if(TARGET)
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