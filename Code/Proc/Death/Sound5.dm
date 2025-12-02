mob/Hittable/Responsive/NPC/Mission/Sound5/DamageMe(mob/M,DAMAGE,METHOD,hidemessage)
	if(M.protect||dead) return
	var/WOUNDS
	DAMAGE=AssessDamage(DAMAGE,M,METHOD)
	if(DAMAGE=="no damage") return
	resting=0
	Playing=0
	WOUNDS = (DAMAGE/StaminaMax)*73
	if((Stamina-DAMAGE)>=0)
		Stamina-=DAMAGE
	else
		Stamina=0
	Wounds+=WOUNDS
	if(!hidemessage) DamageReport(src,M,DAMAGE,METHOD)
	TextOverlay(src, DAMAGE, "Damage");
	if(Wounds>=250) {Wounds=250; KillMe(M); return}
	if(!(src in M.HitList) && !(istype(M,/mob/Hittable/Responsive))) HitList += M
	if(M)M.ExperienceCheck(WOUNDS,src)

	if(KO) {Wounds+=2}
	else KO_Check(DAMAGE,M)

//-----------------------------------------

mob/Hittable/Responsive/NPC/Mission/Sound5/KO_Check(DAMAGE,mob/M)
	if((Stamina<=0&&Wounds<100))
		KOfrom=M
		KO=1; KO_Actions(); icon_state="KO"
		viewers(src)<<"<b><i>[src] has fallen unconcious with exhaustion!</i></b>"
		if(swimming)
			sleep(2)
			icon_state="Kawarimi"; viewers(src)<<"<b><i>[src] has gone underwater!</i></b>"
			spawn(50) KillMe(src)
		else
			var/R=StaminaTrue*0.1
			if(R>1000) R=1000
			spawn(50)
				if(Wounds<100) {KO=0; icon_state=""; Stamina=R}
				else KillCheck(M)

	else if((Wounds>=150)||(Stamina<=0&&Wounds>=100))
		KOfrom=M
		KO=1; KO_Actions(); icon_state="KO"
		viewers(src)<<"<b><i>[src] has fallen gravely unconcious!</i></b>"
		if(swimming)
			sleep(2)
			icon_state="Kawarimi"; viewers(src)<<"<b><i>[src] has gone underwater!</i></b>"
			spawn(50) KillMe(M)
		else KillCheck(M)


mob/Hittable/Responsive/NPC/Mission/Sound5/KillCheck(mob/M)
	spawn()
		for(var/i=1,i<=4,i++)	//8 second Cooldown until death
			if(Wounds<100) break
			RefreshStats()
			sleep(20)
		if(Wounds>=100) KillMe(M)
		else if(Wounds<100) {KO=0; icon_state=null}

mob/Hittable/Responsive/NPC/Mission/Sound5/KillMe(mob/M)
	if(istype(M,/mob/Hittable/Command/Clones/)) M=M.Creator
	if(istype(M,/mob/Hittable/Responsive/Animal/Pet/)) M=M.Master
	if(!dead)
		if(M) M.Sound5Kills++
		dead=1; Playing=0
		for(var/mob/C in KageBunshinList) del(C)
		//for(var/obj/FluteSound/F in TrailList) del(F)
		if(M&&prob(M.RareChance(1+M.Luck))&&DropsRares) DropRareItem()
		else if(prob(8+M.Luck)) DropItem()
		loc=null
		if(!istype(src,/mob/Hittable/Responsive/NPC/Mission/Sound5/Ukon)) {Sound5KillCount++; SoundCheck(src)}
		SoundList-=src
		spawn(40) del(src)


mob/Hittable/Summon/DamageMe(mob/M, var/D,METHOD,hidemessage)
	if(D<1)D=1
	D=round(D); var/w=(D/StaminaMax)*73
	Stamina-=D; Wounds+=w
	if(!hidemessage) DamageReport(src,M,D,METHOD)
	if(M)M.ExperienceCheck(w,src)
	if(Wounds>=100)
		dead=1
		flick('Smoke.dmi',src); loc=locate(0,0,0)
		spawn(10) del(src)