mob/Hittable/Responsive/VillageNinjas/DamageMe(mob/M, var/D,METHOD,hidemessage)
	if(M.protect||dead) return
	if(OverWorldKillMe()&&M.FriendlyFireCheck(src)) return
	if(!istype(M,/mob/Hittable/Responsive)) HitList+=M
	var
		d=D; w
	if(Blocking && METHOD != "ClayDeteriorate")D-=(d*0.45)
	if(D<1)D=1
	D=round(D); w=(D/StaminaMax)*73
	Stamina-=D; Wounds+=w
	if(!hidemessage) DamageReport(src,M,D,METHOD)
	TextOverlay(src, D, "Damage");
	if(M)
		M.ExperienceCheck(w,src)
	M.RefreshStats()
	if(Wounds>=200)
		KillMe(M)
	if(Stamina<=0&&Wounds<100)
		if(!KO)
			KO=1
			var/R=500
			icon_state="KO"; viewers(src)<<"<b><i>[src] has fallen unconcious with exhaustion!</i></b>"
			spawn(50)
				if(Wounds<100) {KO=0; icon_state=""; Stamina=R}
				else KillMe(M)
		else Wounds+=2
		M.RefreshStats()
	else if((Wounds>=150)||(Stamina<=0&&Wounds>=100))
		if(!KO)
			KO=1; icon_state="KO"; viewers(src)<<"<b><i>[src] has fallen gravely unconcious!</i></b>"
			spawn(65)KillMe(M)

mob/Hittable/Responsive/VillageNinjas/KillMe(mob/M)
	if(istype(M,/mob/Hittable/Command/Clones/)) M=M.Creator
	if(istype(M,/mob/Hittable/Responsive/Animal/Pet/)) M=M.Master
	if(dead) return
	dead=1
	if(M)
		BingoBook_Check(src,M)
		if(prob(15+M.Luck))
			DropItem()
	loc=null
	SpawnMe(pick(300,400,600),type,respawn)
	del(src)