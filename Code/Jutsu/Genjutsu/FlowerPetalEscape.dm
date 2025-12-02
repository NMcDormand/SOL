
obj/SkillCards/Genjutsu/FlowerPetalEscape
	icon_state="card_FlowerPetalEscape"
	cmdstring="FlowerPetalEscape"
	Range=30
	CCost=6000
	Seals=1
	Cooldown = 5000
	Duration = 50

	Description = list(
		"about"="Use an illusion to escape a foe, or perhaps to flank them. Set an escape location and then use it quickly before the effect disappears."
		,"title"="Flower Petal Escape"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="D"
//		,"pic"='FlowerPetalEscape.png'
	)

	UpgradeChoices = list("Lower Cost","Lower Cooldown")

	Activate(mob/U)
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(!U.PetalEscapeLocation)
			if(GENERICATTACKCHECK(U)) {U<<"You can't do this right now."; return}
			if(U.CooldownCheck("PetalEscape",(CooldownCur*U.cooldownmultiplier)+s)) return
			if(ChakraUseCheck()) c *= 4
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				spawn(5)U.firing=0
				spawn(1)U.icon_state=null
				if(U.PracticeMode || ControlCheck(U)) return ..()
				U.PetalEscapeLocation=U.loc
				U<<"<i>Your Petal Escape location has been set; [Duration*0.1] seconds until Jutsu times out.</i>"
				spawn(-1)
					spawn(Duration)
						U.PetalEscapeLocation = 2
					while(U.PetalEscapeLocation)
						if(U.PetalEscapeLocation > 1)
							break
						if(get_dist(U,U.PetalEscapeLocation)>Duration)
							U.PetalEscapeLocation=null
							U<<"<i>Your Petal Escape location is out of range.</i>"
							U.Cooldowns["PetalEscape"] += CooldownCur
							break
						sleep(5)
					if(U.PetalEscapeLocation)
						U<<"<i>Your Petal Escape location has timed out.</i>"
						U.Cooldowns["PetalEscape"] += CooldownCur
						U.PetalEscapeLocation=null
		else
			if(U.EscapeCheck()) {U<<"You cannot escape under these circumstances"; return}
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(prob(U.ChakraControl))
				U.JutsuSeals(s); U.JutsuGen(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c)
				U.JutsuMessage(Description["title"])
				var/mob/PetalEscape/S=new(U.loc)
				S.icon=U.icon
				S.name=U.name
				S.dir=U.dir
				S.overlays=U.overlays
				U.Kawarimi=S
				spawn(40)
					if(S) del(S)
				var/area/Q = U.loc.loc
				if(Q)
					Q.Exited(U)
				U.loc=U.PetalEscapeLocation
				U.PetalEscapeLocation=null; U.EscapeSuccess()
				Q = U.loc.loc
				if(Q)
					Q.Entered(U)
			else {c-=rand(1,65); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
			..()

mob/proc
	EscapeSuccess()
		waterprisoned=0
		IceBlasted=0; overlays-='iceblastcover.dmi'
		resting=0
		JubakuBound=0
		Coffin=0
		Webbed=0
		ShadowCaptured=0
		Kanashibari=0

mob/var/tmp
	PetalEscapeLocation