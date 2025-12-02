obj/SkillCards/Clan/Rinnegan/ShinraTenseiPush
	icon_state="card_ShinraPush"
	cmdstring="ShinraTenseiPush"
	CCost=4000
	Seals=0
	DM = 4
	Range = 3
	Cooldown=200
	CooldownCur=200

	UpgradeChoices = list("Increase Range","Increase Push Distance")

	Description = list(
		"about"="Push any targets in range with an insurmountable force"
		,"title"="Shinra Tensei - Push"
		,"type"="Kinjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
	)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		if(!U.HasRinnegan)
			U << "You do not have the power of the Rinnegan to use this technique"
			return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("ShinraTenseiPush",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 4
		U.firing=1
		if(prob(U.ChakraControl))
			U.JutsuSeals(s); U.JutsuTai(c); U.JutsuNin(c); U.MoveUses[name]++
			U.JutsuUseChakra(c);
			U.JutsuMessage("Shinra Tensei")
			U.firing = 0
			if(U.PracticeMode || ControlCheck(U)) return ..()
			U.ShinraTensei(Range,DM)
		else {c-=rand(1,mx/2); U.Chakra-=c; U.icon_state=""; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
		..()

mob
	proc
		ShinraTensei(RNG = 5, DUR = 8)
			new/Effect/Visual/KuchuNejire(loc)
			for(var/mob/A in oview(src,RNG))
				if(IDCHECK(src,A))
					continue
				if(A.dead)
					continue
				if(A.protect)
					continue
				if(istype(A,/mob/Hittable)||A.client)
					if(NINIGNORELIST(A))
						continue
					else
						A.RinneBlowAway(DUR,src)

		RinneBlowAway(d,mob/M)
			set waitfor = 0
			RinneBlown = 1
			spawn(d)
				RinneBlown=null
			var/DIR = dir
			if(!TrueSpeed)
				TrueSpeed = movespeed
			movespeed = 0
			while(RinneBlown && M)
				step_away(src,M)
				dir=DIR
				sleep(1)
			RinneBlown=0
			movespeed = TrueSpeed