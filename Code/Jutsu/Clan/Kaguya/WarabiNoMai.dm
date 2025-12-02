obj/SkillCards/Clan/Kaguya/WarabiNoMai
	icon_state="card_WarabiNoMai"
	cmdstring="WarabiNoMai"

	Range=7
	CCost=8000
	Seals=10
	DM = 2
	Duration = 20

	UpgradeChoices = list("Increase Duration","Increase Damage")

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[CCost*usr.KGCModifier]';DamageAmount.text='[((usr.Ninjutsu*0.5)+(usr.Taijutsu*1.6))*DM] Damage'")

	Description = list(
		"about"="Push your body beyond its limit and annihilate all opponents stuck within your forest"
		,"title"="Warabi no Mai"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
//		,"pic"='SawarabiNoMai.png'
		)

	Activate(mob/U)
		/*if(U.InBone)
			U << "You cant use this technique while inside a bone"
			return*/
		if(!U.InSawa)
			U << "You must first summon the forest"
			return

		if(GENERICATTACKCHECK(U)||U.Gokusamaisou||U.InSawarabi)
			return
		var
			c=(CCost*U.KGCModifier); mx=c; s=U.SS*Seals
		if(U.Chakra<=c)
			U<<"Not enough Chakra."
			return
		if(ChakraUseCheck()) c *= 4
		if(get_dist(U.SawaCentre,U.loc) < 16)
			U<<"You're too far away from the center of the bone forest"
		//if(U.CooldownCheck("Sawarabi",(3000*U.cooldownmultiplier)+s))
		//	return
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(60)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuUseChakra(c)
				U.JutsuSeals(s); U.JutsuTai(c); U.MoveUses[name]++
				if(U.PracticeMode || ControlCheck(U)) return ..()
				U.SawarabiProc(DM,Duration)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

mob/proc/SawarabiProc(D,C)
	set waitfor = 0
	InSawarabi=1

	var/damage=round(((Ninjutsu*0.5)+(Taijutsu*1.6))*D)
	for(var/atom/A in Bones)
		Bones-=A
		del A

	spawn(C)
		InSawa = 0
		InSawarabi = 0
		RefreshStats()

	for(var/turf/A in InSawa)
		spawn()
			new/Effect/Visual/Sawa(A,damage,src,C)

	var/turf/Start = loc
	while(InSawarabi && !KO)
		loc = pick(InSawa)
		sleep(2)
	if(!KO)
		loc = Start

Effect/Visual/Sawa
	var
		Wait = 4
	icon='Sawarabi2.dmi'
	icon_state="1"
	New(where,Pow,mob/P,L)
		set waitfor = 0
		loc = where
		while(P.InSawarabi)
			for(var/mob/M in loc)
				if(IDCHECK(P,M))
					continue
				spawn()
					M.DamageMe(P,Pow,src)
			sleep(Wait)
		spawn(6)
			del src