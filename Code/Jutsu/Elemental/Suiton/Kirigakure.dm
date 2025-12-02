obj/SkillCards/Ninjutsu/Suiton/Kirigakure
	icon_state="card_Kirigakure"
	cmdstring="Kirigakure"
	Range=5
	CCost=600
	Seals=4
	Cooldown = 4000
	Duration = 60

	Description = list(
		"about"="Engulf opponents in a thick fog that has such low visibility they cannot see well enough to move."
		,"title"="Kirigakure no Jutsu"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="Doujutsu"
		,"rank"="C"
//		,"pic"='Kirigakure.png'
		)

	UpgradeChoices = list("Increase Range","Increase Duration")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Kirigakure",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 4
		U.firing=1
		U.icon_state="seals"
		spawn(s)
			spawn(12)U.firing=0
			U.icon_state=null
			if(prob(U.ChakraControl))
				if(!U.onwater && U.WaterElemental<(SuitonOnEarthCheck*0.5) && U.Clan!="Yuki") {U<<"<b>You need to be on water to execute this jutsu</b>."; return}
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.ElementalUp("Water")
				if(U.PracticeMode || ControlCheck(U)) return ..()

				var/obj/Yuki/Kirigakure/S=new/obj/Yuki/Kirigakure
				for(var/turf/T in range(Range,U))
					T.overlays+=S;
					spawn(Duration)
						T.overlays-=S
				Kirigakure_Effect(Duration,U,Range)

			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

proc/Kirigakure_Effect(time,mob/user,RNG)
	var/CENTRE = user.loc
	var/MistList=list()
	while(time && user)
		for(var/mob/m in range(RNG,CENTRE))
			if(IDCHECK(user,m)||m==user||m.InKamui)
				continue
			else
				m.InMist=1
				if(!(m in MistList)) MistList+=m
				if(istype(m,/mob/Hittable/Responsive) && !(user in m.HitList)) m.HitList+=user
		for(var/mob/v in MistList)
			if(get_dist(v,CENTRE)>RNG)
				v.InMist=0; MistList-=v
		time-=2
		sleep(2)
	for(var/mob/V in MistList) {V.InMist=0; MistList-=V}