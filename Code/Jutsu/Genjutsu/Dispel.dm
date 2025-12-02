obj/SkillCards/Genjutsu/Dispel
	icon_state="card_Dispel"
	cmdstring="Dispel"
	CCost=10
	Seals=3
	Cooldown = 600
	XPLGain = 30
	Duration = 60

	Description = list(
		"about"="Dispel the effects of a Genjutsu attack if your Genjutsu is strong enough..."
		,"title"="Dispel"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="D"
//		,"pic"='Dispel.png'
	)

	UpgradeChoices = list("Lower Cost","Lower Cooldown")

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[CCost]%'")

	Activate(mob/U)
		if(DISPELCHECK(U))return
		U.Dispelling=1; spawn(50) U.Dispelling=0
		var
			c=round(U.ChakraMax*(CCost * 0.01)); mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Dispel",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 2
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(30)U.firing=0
			spawn(1)U.icon_state=null
			if(prob(U.ChakraControl))
				U.JutsuUseChakra(c)
				U.DispelProc(U,Duration)
				U.meditating=0;U.attacking=0;U.MeditationPoints=0
			else
				c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>";
				spawn(12) U.firing=0; U.meditating=0;
		..()

	verb/Dispel_Other()
		var/mob/U = locate() in get_step(usr,usr.dir)
		if(U)
			if(DISPELCHECK(U))
				return
		U.Dispelling=1;
		spawn(50)
			if(U)
				U.Dispelling=0
		var
			c=round(U.ChakraMax*(CCost * 0.01)); mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Dispel",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 2
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(30)U.firing=0
			spawn(1)U.icon_state=null
			if(prob(U.ChakraControl))
				U.JutsuUseChakra(c)
				U.JutsuMessage(Description["title"])
				U.DispelProc(usr,Duration)
				U.meditating=0;U.attacking=0;U.MeditationPoints=0
			else
				c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>";
				spawn(12) U.firing=0; U.meditating=0;

mob/proc
	DispelProc(mob/U = src, DUR = 40)
		firing=1; spawn(10)firing=0
		hearers(4,src) << "<b>[src]: Dispel!</b>"
		Dispel=1; spawn(DUR)Dispel=0
		if(InFakeView * 0.7 < U.Genjutsu)
			ReleaseFakeEye()
		if(InFakeEnemyView * 0.7 < U.Genjutsu)
			ReleaseFakeEnemy()
		if(SenKazeBreak * 0.7 < U.Genjutsu)
			InSenKaze = 0
			SenKazeBreak = 0
			SenshokuDispel = 1
		if(InNarakumi)
			InNarakumi=0
		if(JubakuBound == 1)
			JubakuBound = 0