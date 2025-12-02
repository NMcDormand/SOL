obj/SkillCards/Genjutsu/NehanSouja
	icon_state="card_NehanSouja"
	cmdstring="NehanSouja"
	Range=6
	CCost=500
	Seals=8
	Cooldown = 2100
	Duration = 90

	Description = list(
		"about"="Send opponents to sleep."
		,"title"="Nehan Souja no Jutsu"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='NehanSouja.png'
		)

	UpgradeChoices = list("Increase Range","Increase Duration")

	Activate(mob/U)
		if(U.ShadowList.len||GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Nehan",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(20)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuSeals(s); U.JutsuGen(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				if(U.PracticeMode || ControlCheck(U))
					U.JutsuMessage(Description["title"])
					return ..()

				for(var/mob/M in range(Range,U))
					if(istype(M,/mob/Hittable/Unresponsive/Inanimate) || M.TreeStump || IDCHECK(U,M) || M.KI_InMission && (U in KI_Participants) || M==U || M.protect || M.Dispel)
						continue

					if(!M.Sleeping && !M.sleepy && (U.Genjutsu>M.Genjutsu * 0.3))
						M << "<b><i>You start feeling very sleepy...</i></b>"
						M.sleepy=1; M.overlays+='Nehan.dmi'
						if(istype(M,/mob/Hittable/Responsive)&&!(U in M.HitList)) M.HitList+=U
						M.NehanProcedure(U, Duration)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
			..()

mob/proc
	NehanProcedure(mob/M, DUR = 30)
		var/count=0
		if(Sleeping) return
		while(sleepy && count<10)
			count++
			if(Dispel && Genjutsu>(M.Genjutsu*0.2))
				sleepy=0;
				break
			sleep(5)

		overlays-='Nehan.dmi'
		if(!Sleeping && sleepy)
			sleepy=0; src << "<b><i>You've fallen asleep.</i></b>"; Sleeping=1; icon_state="KO"
			spawn(DUR)
				if(Sleeping)
					Sleeping=0; icon_state=null