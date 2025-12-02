mob/Hittable/Responsive/NPC/KonohaInvasion/Clones/DamageMe(mob/M, var/D,METHOD,hidemessage)
	if(M.protect||dead||istype(M,/mob/Hittable/Responsive/NPC/KonohaInvasion)) return
	if(D<1)D=1
	D=round(D); var/w=(D/StaminaMax)*65
	Stamina-=D; Wounds+=w
	if(!hidemessage) DamageReport(src,M,D,METHOD)
	if(M) {M.ExperienceCheck(w,src); M.RefreshStats()}
	if(Wounds>=100) {dead=1; del(src)}

mob/Hittable/Responsive/NPC/KonohaInvasion/DamageMe(mob/M,DAMAGE,METHOD,hidemessage)
	if(M.protect||dead||istype(M,/mob/Hittable/Responsive/NPC/KonohaInvasion)) return
	var/WOUNDS
	DAMAGE=AssessDamage(DAMAGE,M,METHOD)
	if(DAMAGE=="no damage") return
	resting=0
	WOUNDS=(DAMAGE/StaminaMax)*73
	if((Stamina-DAMAGE)>=0) Stamina-=DAMAGE
	else Stamina=0
	Wounds+=WOUNDS

	M.AttributeDamagePoints(src,WOUNDS)

	if(!NPCDamage) NPCDamage=new()
	if(!HasBeenKO) NPCDamage[M]+=DAMAGE	//this is the damage list

	if(!DamagedRecently) {Damaged(Wounds)}
	healingself=0

	if(!hidemessage) DamageReport(src,M,DAMAGE,METHOD)
	if(!(src in M.HitList)) HitList += M
	if(M&&M!=src&&!(istype(M,/mob/Hittable/Responsive))) M.ExperienceCheck(WOUNDS,src)
	if(Wounds>=250) {Wounds=250; KillMe(M); return}

	if(KO) {Wounds+=2; RefreshStats()}
	else KO_Check(DAMAGE,M)


mob/Hittable/Responsive/NPC/KonohaInvasion/KO_Check(DAMAGE,mob/M)
	if((Stamina<=0&&Wounds<100))
		KOfrom=M
		KO=1; KO_Actions(); icon_state="KO"; viewers(src)<<"<b><i>[src] has fallen unconcious with exhaustion!</i></b>"
		if(!HasBeenKO) {HasBeenKO=M; M.KonohaInvasionPoints+=(KillValue*0.2); M.Refresh_InvasionScore()}

		if(swimming)
			sleep(2)
			icon_state="Kawarimi"; viewers(src)<<"<b><i>[src] has gone underwater!</i></b>"
			spawn(50) KillMe(src)
		else
			var/R=StaminaTrue*0.1
			if(R>1000) R=1000
			spawn(50)
				if(Wounds<100) {KO=0; icon_state=""; Stamina=R}
				else {KillMe(M)}

	else if((Wounds>=150)||(Stamina<=0&&Wounds>=100))
		KOfrom=M
		KO=1; KO_Actions(); icon_state="KO"; viewers(src)<<"<b><i>[src] has fallen gravely unconcious!</i></b>"
		if(!HasBeenKO) {HasBeenKO=M; M.KonohaInvasionPoints+=(KillValue*0.3); M.Refresh_InvasionScore()}

		if(swimming)
			sleep(2)
			icon_state="Kawarimi"; viewers(src)<<"<b><i>[src] has gone underwater!</i></b>"
			spawn(50) KillMe(M)
		else {KillMe(M)}


mob/Hittable/Responsive/NPC/KonohaInvasion/KillMe(mob/M)
	if(istype(M,/mob/Hittable/Command/Clones/)) M=M.Creator
	if(istype(M,/mob/Hittable/Responsive/Animal/Pet/)) M=M.Master
	if(!dead)
		M.AttributeKillPoints(src)
		KonohaInvasionAIList-=src; dead=1
		for(var/mob/C in KageBunshinList) del(C)
		if(M&&prob(M.RareChance(10+M.Luck))&&DropsRares) DropRareItem()	//flag
		else if(prob(8+M.Luck)) DropItem()
		loc=null
		KonohaInvasionCheck_Win()
		if(M)
			if(M.client)
				M.TotalKills++
		spawn(40) del(src)