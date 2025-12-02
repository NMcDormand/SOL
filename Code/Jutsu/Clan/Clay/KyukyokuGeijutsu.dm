#if DEBUGGING
mob/verb
	SelfLearnKyukyokuGeijutsu()
		var/obj/SkillCards/Clan/Clay/KyukyokuGeijutsu/J = locate(/obj/SkillCards/Clan/Clay/KyukyokuGeijutsu) in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Kyukyoku Geijutsu no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Clay/KyukyokuGeijutsu(src)
#endif

obj/SkillCards/Clan/Clay/KyukyokuGeijutsu
	icon_state="card_KyukyokuGeijutsu"
	cmdstring="KyukyokuGeijutsu"
	CCost=10000
	Seals=1
	Cooldown = 7200
	DM = 0.7
	ECost = 50

	Description= list(
		"about"="User sacrifices himself creating a huge Explosion"
		,"title"="Kyukyoku Geijutsu"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="Lightning"
		,"rank"="S"
		,"Tutorial" = "Self Destruct causing immense damage to any target within range, this will use all the clay you have remaining, use it wisely"
		,"pic"='Bunshin.png'
	)

	UpgradeChoices = list("Increase Damage")

	Activate(mob/U)
		if(U.ClayInfused<50)
			U<<"You don't have enough Clay Infused - You have [U.ClayInfused] (Need: 50)!"
			return
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*2
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("KyukyokuGeijutsu",(CooldownCur*U.cooldownmultiplier)+s,1)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(3)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.ElementalUp("Earth")
				if(U.PracticeMode || ControlCheck(U))
					U.ClayInfused -= ECost
					return ..()
				U.KyukyokuGeijutsu(DM)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

mob
	var
		tmp
			InZero = 0
	proc
		KyukyokuGeijutsu(DM)
			if(!src||InZero)
				return
			var/icon/IC = icon(icon)
			for(var/C in overlays)
				IC.Blend(icon(C:icon),ICON_OVERLAY)
			overlays=null
			underlays = null
			icon=null
			underlays += 'DeidaraHeart.dmi'
			while(InZero<8)
				IC.Blend(rgb(0,0,0,180),ICON_ADD)
				icon = IC
				InZero++
				sleep(3)
			if(FinishMSG)
				hearers(src)<<output("[Brand]<b><font face=verdana color=[VillageColour]>[src]</font> says</b>: [FinishMSG]","Chat")
			sleep(10)
			icon = null
			pixel_x=-32
			pixel_y=-32
			icon_state = "explosion"
			overlays+='Katons96.dmi'
			ClayInfused = 0
			var/dm = (Stamina + Chakra + Ninjutsu + Taijutsu + Genjutsu) * DM
			for(var/mob/A in range(5))
				if(Intangible||!density||A==src||IDCHECK(src,A))
					continue
				if(istype(A,/mob/Hittable/Responsive/Boss))
					A.DamageMe(src,dm*0.5,"ZeroBomb")
					continue
				A.DamageMe(src,dm,"ZeroBomb")
				A.Wounds += 140
			sleep(4)
			KillMe(src)
			//var/obj/Clay/explosion2/U=new/obj/Clay/explosion2(loc)
			//U.owner=src
			//U.defaultDamage=3.2