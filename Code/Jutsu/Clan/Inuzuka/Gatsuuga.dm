obj/SkillCards/Clan/Inuzuka/Gatsuuga
	icon_state="card_Gatsuuga"
	cmdstring="Gatsuga"
	CCost=250
	Seals=4
	Cooldown = 900
	CooldownCur = 400
	Duration = 45

	UpgradeChoices = list("Increase Duration","Lower Cooldown")

	Description = list(
		"about"="the user and their K9 Companion begin spinning rapidly towards their target as a team"
		,"title"="Gatsuga"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='Gatsuuga.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U))
			return
		var/mob/Hittable/Responsive/Animal/Pet/P=U.Familiar
		if(get_dist(P,U) > 12||MoveCheck(U))
			return
		var {c=CCost; mx=c; s=U.SS*Seals}
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Gatsuga",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(!P&&P.InJuujin)
			U<<"Must use Juujin Bunshin first."
			var/obj/SkillCards/Clan/Inuzuka/JuujinBunshin/JB = locate() in U
			if(JB)
				JB.Activate(U)
				sleep(10)
				if(P&&!P.InJuujin)
					return
			else
				return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(40) U.firing=0
			if(prob(U.ChakraControl))
				if(P)
					U.JutsuSeals(s); U.JutsuTai(c); U.MoveUses[name]++
					U.JutsuUseChakra(c)
					if(U.PracticeMode || ControlCheck(U)) return ..()
					U.GatsuProc(P,Duration)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

mob/proc/GatsuProc(mob/PET,C)
	set waitfor = 0, background = 1
	while(PET && get_dist(PET,src)>1)
		step_to(PET,src,1)
	if(PET)
		var/list/O=overlays.Copy(); overlays=overlays.Remove(overlays)
		JutsuMessage("Gatsuuga")
		InGatsuuga=1; movespeed=1; icon_state="tsuuga"; PET.loc=src
		spawn(C)
			InGatsuuga=0
			firing=0
			icon_state=null
			overlays = O.Copy()
			movespeed=setspeed
			if(PET) PET.loc=loc