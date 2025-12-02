mob/var
	atkspeed=3
	tmp/reset
obj/SkillCards/Starter/Rest
	icon='Card_Icons.dmi'
	icon_state="card_rest"
	JutsuType = "Other"
	cmdstring="Rest"
	CanLevel=0
	VerbIt = 1

	Description = list(
		"about"="Use this to regain your Stamina and Chakra.  You will be very vulnurable while you use this."
		,"title"="Rest"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="E"
		,"pic"='Rest.png'
		)

	Activate(mob/U)
		if(U.RestCheck()) return
		switch(U.resting)
			if(TRUE)
				U.restdelay=1; spawn(18)U.restdelay=0
				U.icon_state=""; U<<"You stop resting."; U.resting=0
			else
				U.icon_state="rest"; U<<"You sit down and rest"
				U.resting=1; spawn(12)U.rest()

mob/proc
	rest()
		while(resting)
			if(Stamina<0) Stamina=1
			if(Chakra<0) Chakra=1
			if(Stamina<StaminaMax)
				if(!Poisoned) Stamina += round(StaminaMax/13)
				if(Stamina>StaminaMax) Stamina=StaminaMax
			var/MC=SetMaxChakra()
			if(!Charging && Chakra < MC)
				Chakra += round(ChakraMax/13)
				if(Chakra>MC) Chakra=MC

			if(Stamina >= StaminaMax&&Chakra>=MC)
				Stamina=StaminaMax; Chakra=MC
				restdelay=1; spawn(20)restdelay=null
				icon_state=null; resting=0
				if(istype(src,/mob/player)) {src<<"You're rested"; Skills()}

			if(istype(src,/mob/player))
				RefreshChakra(); RefreshStamina()
			sleep(9)

		icon_state=null

	RestCheck()
		if(Sleeping||KO||Falling||firing||!icon||restdelay||DorouDoumu||climbing||swimming||kaiten||GMfrozen||frozen||dead||mirroring) return 1
		else if(ShadowCaptured) {src<<"You can't rest while you are inside someones shadow!"; return 1}
		else if(BunshinList.len) {src<<"Cannot rest while using Genjutsu Bunshins.";  return 1}
		else if(SandArmour) {src<<"Cannot rest while using Sand Armour/Suna no Yoroi.";  return 1}
		else if(length(ShadowList)) {src<<"Cannot rest while using Kagemane.";  return 1}
		else if(onwater) {src<<"Cannot rest while Water Walking.";  return 1}
		else if(onwaterfall) {src<<"Cannot rest while Waterfall Walking.";  return 1}
		else if(CS>0) {src<<"Cannot rest when using the Curse Seal.";  return 1}
		else if(InAMirror) {src<<"Cannot rest while inside your own mirror";  return 1}
		else if(InBone) {src<<"Cannot rest while inside your bones";  return 1}
		else if(InSwamp) {src<<"Cannot rest while affect by a swamp";  return 1}
		else if(MySwamp) {src<<"Cannot rest while your swamp exists";  return 1}
		else if(ClayInfection){src<<"Cannot rest while your suffering from Shi Fo";  return 1}
		else if(RaitonArmour){src<<"Cannot rest while using the Raiton no Yoroi";  return 1}
		else if(RaitonCurrent||ShibariHit){src<<"Cannot rest while paralyzed with Lightning";  return 1}
		else if(InFujinHeki){src<<"Cannot rest while using the Fujin Heki";  return 1}
		else if(Gate){src<<"Cannot rest while the Hachimon are open";  return 1}
		else return 0