mob/Hittable/Responsive/Animal/Pet
	DamageMe(mob/M, var/D,METHOD,hidemessage)
		if(IDCHECK(M,src))
			return
		var/mob/O=Master
		var/w
		O.StatUpdate_dogStuff()

		resting=0
		if(D<1)D=1
		if(!StaminaMax)
			StaminaMax = Stamina
		D=round(D); w=(D/StaminaMax)*73
		Stamina-=D; if(Stamina<0) Stamina=0
		Wounds+=w
		if(!hidemessage) DamageReport(src,M,D,METHOD)
		TakenDamage=world.timeofday+300
		if(M) M.RefreshStats()
		if(Wounds>=220) {Wounds=220; KillMe(M); return}
		if(Stamina<=0&&Wounds<100)
			if(!KO)
				KO=1
				if(swimming)
					O<<"<b>[src] is unconscious and drowining!</b>"
					icon_state="underwater"; viewers(src)<<"<b><i>[src] has fallen unconcious and has gone underwater!</i></b>"
					spawn(60)
						if(swimming) KillMe(src)
						else {icon_state=null; O<<"[src] has regained consciousness."}
				else
					var/R=StaminaTrue*0.1
					if(R>500) R=500
					icon_state="KO"; viewers(src)<<"<b><i>[src] has fallen unconcious with exhaustion!</i></b>"
					spawn(50) {if(Wounds<100) {KO=0; icon_state=""; Stamina=R}}
			else Wounds+=10

		else if((Wounds>=150)||(Stamina<=0&&Wounds>=100))
			if(!KO)
				KO=1; icon_state="KO"; O<<"<b>[src] is dying!</b>"; viewers(src)<<"<b><i>[src] has fallen gravely unconcious!</i></b>"
				KillCheck(M,0)
			else Wounds+=10

	KillCheck(mob/M,var/T)
		var/mob/O=Master
		T++
		if(T>14&&Wounds>=100) KillMe(M)
		else if(Wounds<100) {KO=0; icon_state=null; O<<"[src] has regained consciousness."}
		spawn(36) {if(KO)KillCheck(M,T)}

	KillMe(mob/M)
		if(istype(M,/mob/Hittable/Command/Clones/)) M=M.Creator
		if(istype(M,/mob/Hittable/Responsive/Animal/Pet/)) M=M.Master
		var/mob/O=Master
		O.DeadDog=1; dead=1
		if(src==M)
			if(swimming) O<<"<b><i>[src] has drowned!</i></b>"
			else O<<"<b><i>[src] has been killed!</i></b>"
		else
			if(M!=O) O<<"<b><i>[src] has been killed by [M]!</i></b>"
			else O<<"<b><i>You killed [src]!</i></b>"
		for(var/mob/player/N in world) if(src in N.ShadowList) N.ShadowList-=src
		if(M) M.ShadowList-=src
		for(var/mob/A in world) if(src in A.HitList) A.HitList-=src
		del(src)