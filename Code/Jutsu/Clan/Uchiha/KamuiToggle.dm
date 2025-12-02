#if DEBUGGING
mob/verb
	SelfLearnKamuiToggle()
		var/obj/SkillCards/Clan/Uchiha/MS/KamuiToggle/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Kamui</i>!</b></font>"
			new/obj/SkillCards/Clan/Uchiha/MS/KamuiToggle(src)
#endif

obj/SkillCards/Clan/Uchiha/MS/KamuiToggle
	icon_state="card_Kamui"
	cmdstring="Kamui"
	CCost = 1500
	Cooldown = 500
	Seals=1

	Description = list(
		"about"="Make yourself Intangible to avoid any damage, but will be unable to inflict any damage"
		,"title"="Kamui Toggle"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
//		,"pic"='Tsukuyomi.png'
	)

	UpgradeChoices = list("Lower Cost")

	Activate(mob/U)
		if(U.InKamui)
			U << "You are now Tangible, you will be affected by damage"
			U.InKamui = 0
		else
			if(!U.InMangekyou) {U<<"You must activate Mangekyou Sharingan first"; return}
			if(GENERICATTACKCHECK(U))
				return
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("KamuiToggle",500+s)) return
			if(ChakraUseCheck()) c *= 4
			U.firing=1
			spawn(3)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuMessage("Kamui")
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				if(U.PracticeMode || ControlCheck(U))return ..()
				U.Kamui(c)
				if(!U.EternalSharingan && prob(105-Level))
					U.BlindMe("Kamui")
				U << "You are now Intangible, you will not be affect by any damage"
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

mob
	proc
		Kamui(C=3000)
			set waitfor = 0
			InKamui = 1
			while(InKamui)
				if(Chakra >= C)
					Chakra -= C
					JutsuChakra(30);
					StatUpdate_chakra()
					sleep(10)
				else
					InKamui = 0
					src << "You no longer have enough chakra to sustain your Kamui"
					if(Chakra<0)
						Chakra = 0
					StatUpdate_chakra()
					break