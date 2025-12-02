obj/SkillCards/Taijutsu/KageBuyou
	icon='Card_Icons.dmi'
	icon_state="card_KageBuyou"
	JutsuType = "Taijutsu"
	cmdstring="KageBuyou"
	Range=1
	VerbIt=1
	CanLevel=0

	Description = list(
		"about"="A targetted kick attack with a Cooldown."
		,"title"="Kage Buyou"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="D"
//		,"pic"='KageBuyou.png'
		)

	Activate(mob/U)
		var/mob/M
		for(var/mob/P in oview(1,U))
			if(IDCHECK(U,P))
				continue
			else
				M = P
				break
		if(!M)
			return
		if(TAICHECKBOTH(U,M)||U.Gokusamaisou) return
		if(RESTRAINEDCHECK(U)||RESTRAINEDLEGS(U)) return
		if(U.CooldownCheck("KageBuyou",1000*U.cooldownmultiplier)) return
		var/taiup=rand(5,10)
		var/dmg = round(U.Taijutsu*1.8-(M.Taijutsu*0.35))
		if(dmg<=round(U.Taijutsu*0.25)) dmg=U.Taijutsu*0.25
		view(4,M)<< "<b>[U]</b>:  Kage Buyou!"
		if(M) U.ApplyEXP(taiup+M.taitraining,"taijutsu")
		U.ApplyEXP(10,"Stamina")
		U.Taiup()
		flick("punch",U)
		if(U.HitCheck(M))
			U.attacking=1; spawn(20)U.attacking=0
			U.dir=(get_dir(U,M))
			M.DamageMe(U,dmg,"kick")
		else
			U.attacking=1; spawn(45)U.attacking=null
			U.Chakra-=1000; U<<"[M] dodged the attack"; M<<"You dodged [U]'s attack"