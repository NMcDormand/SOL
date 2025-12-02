obj/SkillCards/Clan/Aburame/BakuhatsuMushikui
	icon_state="card_MushiSwarm"
	cmdstring="BakuhatsuMushikui"
	Range=5
	Seals=6
	Cooldown=4000
	CooldownCur=4000

	DM = 40000
	XPLGain = 12

	UpgradeChoices = list("Lower Cooldown", "Increase Damage")

	Description = list(
		"about"="Explode all the insects currently placed on enemies."
		,"title"="Bakuhatsu Mushikui"
		,"type"="Clan-Jutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
		,"Tutorial" = "This technique will do damage based on the number of insects all of your targets have placed on them<br>You can place more insects on your targets by using your Mushi Bunshin and Mushi Swarm"
//		,"pic"='MushiSwarm.png'
		)

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"DamageAmount.text='[DM] per insect on targets'")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var/s=U.SS*Seals
		if(U.CooldownCheck("BakuhatsuMushikui",(CooldownCur*U.cooldownmultiplier)+s))
			return
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			U.icon_state=null
			spawn(2)U.firing=0
			U.JutsuSeals(s);U.MoveUses[name]++
			U.JutsuMessage(Description["title"])
			if(U.PracticeMode || ControlCheck(U)) return ..()
			for(var/mob/M in U.BugExplodeList)
				if(M.protect||IDCHECK(U,M))
					continue
				var/DT = (M.HasKonchuu[U.ckey]*DM)
				M.HasKonchuu-=U.ckey
				M.DamageMe(U,DT,src)
			U.BugExplodeList = list()
			..()