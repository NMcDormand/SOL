obj/SkillCards/Clan/Inuzuka/Soutourou
	icon_state="card_Soutourou"
	cmdstring="Soutourou"
	CCost=500
	Seals=3
	Cooldown = 650
	CooldownCur = 150
	Duration = 600
	DM = 0.5
	UpgradeChoices = list("Increase Duration","Increase Buff")

	Description = list(
		"about"="Transform yourself and your companion into a 2 headed beast."
		,"title"="Ryuu Jinjuu Konbi Henge: Soutourou"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='Soutourou.png'
	)
	Activate(mob/U)
		var/mob/Hittable/Responsive/Animal/Pet/P=U.Familiar
		if(!P)
			U<<"You don't seem to have a companion..."
			return
		if(U.InSoutourou)
			U.CreationSkin(1)
			U.Taijutsu=U.TaijutsuMax; U.movespeed=U.setspeed
			U.InSoutourou=0
			if(P) {P.loc=U.loc; P.icon=P.OriginalIcon}
			return

		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(get_dist(U,P)>12) {U<<"[P] is not in range."; return}

		if(P&&!P.InJuujin)
			U<<"Must use Juujin Bunshin first."
			var/obj/SkillCards/Clan/Inuzuka/JuujinBunshin/JB = locate() in U
			if(JB)
				JB.Activate(U)
				sleep(10)
				if(P&&!P.InJuujin)
					return
			else
				return

		if(U.CooldownCheck("Soutourou",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		if(get_dist(P,U)>1) step_to(P,U)
		spawn(s)
			U.icon_state=null
			if(P&&get_dist(P,U)>1) step_to(P,U)
			if(prob(U.ChakraControl))
				U.JutsuSeals(s); U.JutsuNin(c); U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.JutsuMessage(Description["title"])
				if(U.PracticeMode || ControlCheck(U)) return ..()
				U.SoutourouProc(P,Duration,DM)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"; spawn(20) U.firing=0}
			..()

mob/proc/SoutourouProc(mob/M,C,B)
	while(M&&get_dist(M,src)>1)
		step_to(M,src)
		sleep(1)

	if(M)
		InSoutourou=1
		spawn(12) firing=0

		M.loc=contents
		overlays = list()
		icon = 'Soutourou-black.dmi'
		var/icon/I=icon('Soutourou-black.dmi')
		I.Blend(DogColour)
		icon = I
		Taijutsu=round((Taijutsu+M.Taijutsu)*B)
		if(movespeed>1) movespeed=1
		spawn(C)
			if(InSoutourou)
				CreationSkin(1)
				Taijutsu=TaijutsuMax; movespeed=setspeed
				InSoutourou=0
				if(M)
					M.loc=loc
					M.icon=M.OriginalIcon