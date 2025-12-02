obj/SkillCards/Clan/Hyuuga/HakkeHyakunijyuhachiShou
	icon_state="card_HakkeHyakunijyuhachiShou"
	cmdstring="HakkeHyakunijyuhachiShou"
	Range=1
	CCost=2000
	SCost=2000
	Cooldown=4000
	CooldownCur=4000
	DM = 7

	UpgradeChoices = list("Lower Cost", "Lower Cooldown")

	Description = list(
		"about"="Unleash a barrage of 128 Jyuken palms on your opponents, damage will be divided between those that surround you."
		,"title"="Hakke Hyakunijyuhachi Shou"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='HakkeHyakunijyuhachiShou.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=SCost
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.Stamina<=s) {U<<"Not enough Stamina."; return}
		if(usr.wielding && usr.wielding != "Gauntlet") {U<<"This technique can only be used with bare fists or gauntlets"; return}
		if(!U.InByakugan) {U<<"You must activate Byakuagan first"; return}
		if(U.CooldownCheck("128Palms",CooldownCur*U.cooldownmultiplier)) return
		if(ChakraUseCheck()) c *= 4
		if(prob(U.ChakraControl))
			U.MoveUses[name]++;
			U.JutsuUseChakra(c)
			U.JutsuUseStamina(c)
			U.JutsuMessage(Description["title"])
			if(U.PracticeMode || ControlCheck(U)) return ..()
			var/B = new/Effect/Visual/Trigrams/Large(U.loc)
			U.Palms(7,Range)
			spawn(10)
				del B
		else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
		..()

mob/proc/Palms(WAVES,R=1)
	flick("punch",src)
	var
		STRIKES=2; dmg=1; Skill_DMG=1
	CantWalk++
	firing=1
	attacking=1
	for(var/WAVE=1 to WAVES)
		//world<<"Wave [WAVE]"
		var/TARGETS = list()
		for(var/mob/M in oview(R,src))
			//world<<"Added [M] to the list..."
			dmg = round((Taijutsu*0.2)-(M.Taijutsu*0.1))
			dmg=max(dmg,round(Taijutsu*0.05))
			Skill_DMG=Weapons(); dmg+=(Skill_DMG*0.4)
			TARGETS[M]=dmg
			//var/testme = length(TARGETS)
			//world<<"Length of targets: [testme]"
			if(length(TARGETS)>=STRIKES) break

		for(var/mob/V in TARGETS)
			if(HitCheck(V))
				var/Damage_Per_Palm = TARGETS[V]
				var/Pain_Each = (STRIKES*Damage_Per_Palm)/length(TARGETS)
				V.DamageMe(src,round(Pain_Each),"palms")
				if(V)
					V.BlockedTenketsu=1
				spawn(60)
					if(V)
						V.BlockedTenketsu=0
		STRIKES*=2
		sleep(3)
	CantWalk--
	spawn(18) firing=0
	spawn(6) attacking=0