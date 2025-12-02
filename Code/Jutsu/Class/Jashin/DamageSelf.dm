obj/SkillCards/Class/Jashin/DamageSelf
	icon_state="card_ConsumeBlood"
	cmdstring="DamageSelf"
	JutsuType = "Class"
	Cooldown = 0
	DM = 1

	Description=list(
		"about" = "Injure yourself, combined with the ritual this can be dangerous!",
		,"title" = "Self Damage",
		,"type" ="Ninjutsu",
		,"strong"="N/A",
		,"weak"="N/A",
		,"rank"="A",
		//,"pic"='Bunshin.png',
	)

	UpgradeChoices = list("Increase Damage")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		if(!U.Class["Jashin"])
			U << "This technique is reserved for the glorious followers of the great Jashin"
			return
		if(U.CooldownCheck("DamageSelf",(40*U.cooldownmultiplier),0)) return
		if(!U.ThankedJashin) {U<<"You must give thanks to glorious Jashin before you can do this."; return}
		if(U.CeremonialVictim)
			var/mob/victim=U.CeremonialVictim
			var/dmg=(round((U.Taijutsu-(victim.Taijutsu*0.2)) + (U.Ninjutsu-(victim.Ninjutsu*0.2)))/2)
			if(dmg<2000) dmg=2000
			dmg *= DM
			U.DamageMe(U, dmg, "Self")
			..()