obj/SkillCards/Clan/Hyuuga/Kaiten
	icon_state="card_Kaiten"
	cmdstring="Kaiten"
	Seals=2
	CCost=10
	Cooldown=300
	CooldownCur=300

	UpgradeChoices = list("Lower Cost")

	Description = list(
		"about"="The ultimate defence for Hyuugas"
		,"title"="Hakkekyushou Kaiten"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='Kaiten.png'
		)

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[CCost * 0.01]% per second';")

	Activate(mob/U)
		if(U.kaiten)
			U.kaiten=0
		else
			if(GENERICATTACKCHECK(U)||RESTRAINEDCHECK(U)) return
			if(!U.InByakugan)
				U << "You cannot use Kaiten unless you use Byakugan"
				return
			var
				c = U.ChakraMax*(CCost * 0.01); mx=c; s=U.SS*Seals
			if(U.Chakra < c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("Kaiten",(CooldownCur*U.cooldownmultiplier)+s)) return
			if(ChakraUseCheck()) c *= 4
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				spawn(1)U.icon_state=null
				if(prob(U.ChakraControl))
					U.JutsuSeals(s); U.JutsuTai(c);
					U.MoveUses[name]++
					U.JutsuUseChakra(c)
					U.JutsuMessage(Description["title"])
					if(U.PracticeMode || ControlCheck(U))
						U.firing=0
						return ..()
					U.kaiten=1; U.overlays+='kaiten.dmi'
					U.kaitendrain(c)
				else
					U.firing=0
					c-=rand(1,mx/2)
					U.CCGain(c)
					U.Chakra-=c
					U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"
				..()

mob/proc
	kaitendrain(C)
		set waitfor = 0
		while(kaiten)
			if(Chakra>C)
				Chakra -= C
			else
				if(Chakra<=0)
					Chakra=0;
				src<<"You no longer have enough Chakra to sustain Kaiten"
				break
			RefreshChakra()
			sleep(10)

		kaiten=0
		spawn(20)
			firing=0
		overlays-='kaiten.dmi'