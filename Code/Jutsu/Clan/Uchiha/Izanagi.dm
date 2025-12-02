#if DEBUGGING
mob/verb
	SelfLearnIzanagi()
		var/obj/SkillCards/Clan/Uchiha/MS/Izanagi/J=locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Izanagi no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Uchiha/MS/Izanagi(src)
#endif

obj/SkillCards/Clan/Uchiha/MS/Izanagi
	icon_state="card_Izanagi"
	cmdstring="Izanagi"
	CCost=30000
	Seals=0
	Duration = 50
	Cooldown = 8000

	Description = list(
		"about"="Bends reality to the users will, preventing any damage for a time. This will block your Sharingan from being used fpr a large amount of time"
		,"title"="Izanagi"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
//		,"pic"='Dispel.png'
	)

	UpgradeChoices = list("Lower Cost","Increase Duration")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U))
			return
		var
			c=CCost; mx=c;
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Izanagi",(CooldownCur*U.cooldownmultiplier))) return
		U.Cooldowns["Sharingan"] = world.time+4000
		if(ChakraUseCheck()) c *= 3
		U.firing=1
		spawn(2)U.firing=0
		if(prob(U.ChakraControl))
			U.JutsuGen(c*0.2);
			U.MoveUses[name]++
			U.JutsuUseChakra(c,0.1);
			if(U.PracticeMode || ControlCheck(U))
				U.JutsuMessage(Description["title"])
				return ..()
			if(U.GenjutsuTrue < 50000)
				U.JutsuMessage(Description["title"])
			else
				U << "You used [Description["title"]]"
			U.InIzanagi = 1
			U.SetTimer(Duration*0.1,name)
			spawn(Duration)
				U.InIzanagi = 0
			U.InSharingan = 0
			U.InMangekyou=0
			U.Reflex=U.ReflexTrue
			U.overlays -= U.DouEyes
			U.DouEyes = null
			if(!U.EternalSharingan && prob(135-Level))
				U.BlindMe("Izanagi")
		else
			c-=rand(1,mx/2); U.Chakra-=c
			U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"
			return
		..()

mob
	var/tmp/InIzanagi
	IzanagiClone
		DamageMe()
			return
		Cross()
			return 1
	proc
		IzanagiClone(mob/V)
			var/turf/T = Get_Rand_DirStep(src)
			if(!T)
				T = loc
			var/mob/IzanagiClone/M = new(loc)
			M.appearance = appearance
			M.name = name
			loc = T
			if(V)
				dir = get_dir(src,V)
			spawn(-1)
				spawn()
					animate(M,alpha = 0, 4, 8)
				sleep(32)

				M.loc = null
				spawn(30)
					if(M)
						del M