#if DEBUGGING
mob/verb
	SelfLearnKakuremino()
		var/obj/SkillCards/Class/Assassin/Kakuremino/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Kakuremino no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Class/Assassin/Kakuremino(src)
#endif

obj/SkillCards/Class/Assassin/Kakuremino
	icon_state="card_Kakuremino"
	cmdstring="Kakuremino"
	JutsuType = "Class"
	Cooldown = 800
	CCost=400
	Seals=8

	Description= list(
		"about"="Cloak of Invisibility Technique"
		,"title"="Kakuremino no Jutsu"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
		,"pic"='Bunshin.png'
	)

	UpgradeChoices = list("Lower Cost","Lower Cooldown")

	Activate(mob/U)
		if(U.InCloak)
			U.InCloak=0
			return
		if(!U.Class["Assassin-Nin"])
			U << "This technique is disabled as you are not currently an Assassin-Nin"
			return
		if(U.InCamo)
			U << "You cannot use this while inside Meisaigakure no Jutsu"
			return
		if(GENERICATTACKCHECK(U)||U.InCloakDelay) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Kakuremino",(CooldownCur*U.cooldownmultiplier)+s,1)) return
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
				U.InCloakDelay=1;
				spawn(40)
					U.InCloakDelay=null
				U.RemoveAllTargetMe()
				U.InCloak=1
				U.invisibility+=2
				U.CloakProc(c)
			else
				c-=rand(1,mx/2)
				U.Chakra-=c
				U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"
				return

mob
	proc
		CloakProc(C)
			set waitfor = 0
			while(InCloak)
				if(Chakra<=C)
					Chakra=0
					InCloak=0
					break
				else
					Chakra-=C
				StatUpdate_chakra()
				sleep(20)
			invisibility -=2
			src << "Your Kakuremino has faded"