mob/Hittable/Command/Clones/DamageMe(mob/M, var/D,METHOD,hidemessage)
	if(!M || IDCHECK(M,src))
		return
	if(D<1)
		D=1
	D=round(D)
	if(!StaminaMax)
		StaminaMax = 1
	var/w=(D/StaminaMax)*65
	Stamina-=D
	Wounds+=w
	if(!hidemessage)
		DamageReport(src,M,D,METHOD)
		TextOverlay(src, D, "Damage");
	if(M)
		M.ExperienceCheck(w,src)
		M.RefreshStats()
	if(Stamina<1) {dead=1; del(src)}
	if(Wounds>=100)
		dead=1
		del(src)

mob/Kawarimi/DamageMe()
	icon_state="log"
	dead=1
	del(src)

mob/PetalEscape/DamageMe()
	dead=1
	del(src)