obj/SkillCards/Clan/Rinnegan/ShinraTenseiPull
	icon_state="card_ShinraPull"
	cmdstring="ShinraTenseiPull"
	CCost=4000
	Seals=0
	DM = 4
	Range = 4
	Cooldown=400
	CooldownCur=400

	UpgradeChoices = list("Increase Range","Lower Cooldown")

	Description = list(
		"about"="Pull any targets in range with an insurmountable force"
		,"title"="Shinra Tensei - Pull"
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
		if(U.CooldownCheck("ShinraTenseiPull",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 4
		U.firing=1
		if(prob(U.ChakraControl))
			U.JutsuSeals(s); U.JutsuTai(c*0.1); U.JutsuNin(c*0.14); U.MoveUses[name]++
			U.JutsuUseChakra(c);
			U.JutsuMessage("Shinra Tensei")
			U.firing = 0
			if(U.PracticeMode || ControlCheck(U)) return ..()
			U.ShinraTenseiPull(Range)
		else {c-=rand(1,mx/2); U.Chakra-=c; U.icon_state=""; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
		..()

mob
	proc
		ShinraTenseiPull(RNG = 5)
			for(var/mob/A in oview(RNG, src))
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
						A.RinnePull(16,src)

		RinnePull(d,mob/M)
			set waitfor = 0
			RinneBlown = 1
			spawn(d)
				RinneBlown=null
			if(!TrueSpeed)
				TrueSpeed = movespeed
			movespeed = 0
			while(RinneBlown && M)
				step_towards(src,M)
				sleep(1)
			RinneBlown=0
			movespeed = TrueSpeed