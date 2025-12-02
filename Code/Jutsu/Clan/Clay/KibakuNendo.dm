#if DEBUGGING
mob/verb
	SelfLearnKibakuNendo()
		var/obj/SkillCards/Clan/Clay/KibakuNendo/J = locate(/obj/SkillCards/Clan/Clay/KibakuNendo) in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Kibaku Nendo no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Clay/KibakuNendo(src)
#endif

obj/SkillCards/Clan/Clay/KibakuNendo
	icon_state="card_Nendo"
	cmdstring="KibakuNendo"
	CCost=100
	Seals=2
	CanLevel = 0

	Description= list(
		"about"="This is used to convert Clay into Infused Clay which can be used for explosive techniques"
		,"title"="Kibaku Nendo"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="B"
		,"Tutorial" = "You will collect clay automatically by walking on tiles that have clay within them. Places like dirt are naturally going to have more. You can then convert this clay into Infused clay for explosions by using this tecknique"
		//,"pic"='Bunshin.png'
	)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)||U.Gokusamaisou||U.mirroring|U.InMirrors)
			return
		if(U.ClayInfused >= U.ClayInfusedMax)
			U<<"You cant carry anymore infused Clay!"
			return
		if(U.ClaySkill < round(CLAYMAXSKILL*0.5))
			if(U.ClayCur<5)
				U<<"You don't have enough Clay to infuse!"
				return
		else
			if(U.ClayCur<3)
				U<<"You don't have enough Clay to infuse!"
				return
		U.firing = 1
		spawn(U.SS*3)
			if(U)
				spawn(2)
					U.firing = 0
				U.KibakuNendo()

mob
	proc
		KibakuNendo()
			if(!src)
				return
			JutsuUseChakra(10)
			JutsuNin(10);
			MoveUses["KibakuNendo"]++
			if(ClaySkill < CLAYMAXSKILL)
				if(prob(ClaySkill))
					var/A = pick(3,4,5)
					ClayCur -= A
					ClayInfused+=3
					ClayXPUP(A)
					if(ClayInfused>ClayInfusedMax)
						ClayInfused=ClayInfusedMax
					src<<"You infused some Clay. You now have [ClayInfused] to use on Explosives!"
					if(prob(ClaySkill*0.01))
						ClayInfusedMax++
						ClayMax++
						src << "You can now carry more Clay"
				else
					src<<"You failed to infuse Clay!"
					ClayXPUP(2)
					ClayCur -= 2
			else
				var/A = 3
				if(prob(30))
					A = pick(1,2)
				ClayCur -= A
				ClayInfused+=3
				ClayXPUP(3)
				if(ClayInfused>ClayInfusedMax)
					ClayInfused=ClayInfusedMax
				src<<"You infused some Clay. You now have [ClayInfused] to use on Explosives!"