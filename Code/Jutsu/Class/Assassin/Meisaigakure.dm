#if DEBUGGING
mob/verb
	SelfLearnMeisaigakure()
		var/obj/SkillCards/Class/Assassin/Meisaigakure/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Meisaigakure no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Class/Assassin/Meisaigakure(src)
#endif

obj/SkillCards/Class/Assassin/Meisaigakure
	icon_state="card_Meisaigakure"
	cmdstring="Meisaigakure"
	JutsuType = "Class"
	Cooldown = 800
	CCost=250
	Seals=12
	Duration = 50

	Description= list(
		"about"="Hiding Camouflage Technique"
		,"title"="Meisaigakure no Jutsu"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="B"
		,"pic"='Bunshin.png'
		)

	UpgradeChoices = list("Increase Duration","Lower Cooldown")

	Activate(mob/U)
		if(U.InCamo)
			U.InCamo = 0
			return
		if(GENERICATTACKCHECK(U)||U.InCamo) return
		if(!U.Class["Assassin-Nin"])
			U << "This technique is disabled as you are not currently an Assassin-Nin"
			return
		if(U.InCloak)
			U << "You cannot use this while inside Kakuremino no Jutsu"
			return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("HidingCamouflageTechnique",(CooldownCur)+s,1)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(40)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				if(U.PracticeMode || ControlCheck(U)) return ..()
				U.RemoveAllTargetMe();
				U.InCamo=1;
				U.CamoProc()
				spawn(Duration)
					U.InCamo=0
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

mob/proc
	CamoProc()
		set waitfor = 0
		while(InCamo)
			invisibility +=3
			sleep(15)
			invisibility -=3
			sleep(10)
		usr << "Your invisibility has faded"