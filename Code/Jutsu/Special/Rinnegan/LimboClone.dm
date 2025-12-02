mob/Hittable/Command/Clones/LimboClone
	Cross()
		return 1
	DamageMe(mob/M, var/D,METHOD,hidemessage)
		return
	Del()
		.=..()
		if(!.)
			loc = null

obj/SkillCards/Clan/Rinnegan/LimboHengoku
	icon_state="card_LimboClone"
	cmdstring="LimboHengoku"
	CCost=15000
	Seals=0
	DM = 2
	Cooldown=1500
	CooldownCur=1500

	UpgradeChoices = list("Increase Shadows","Lower Cooldown")

	Description = list(
		"about"="Create shadows of the user, in an invisible world coexisting with the physical world, ordinarily impossible to detect or perceive, to attack your target"
		,"title"="Limbo: Hengoku"
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
		if(U.choosingHoming) return
		var/mob/M
		if(ismob(U.Targeting)&&get_dist(U.Targeting,U)<= Range)
			M = U.Targeting
		else
			M = U.TargetSelect(Range)
		if(M)
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("LimboHengoku",(CooldownCur*U.cooldownmultiplier)+s)) return
			if(ChakraUseCheck()) c *= 4
			U.firing=1
			if(prob(U.ChakraControl))
				U.JutsuSeals(s); U.JutsuTai(c*0.1); U.JutsuNin(c*0.14); U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.JutsuMessage(Description["title"])
				U.firing = 0
				if(U.PracticeMode || ControlCheck(U)) return ..()
				for(var/i=1 to DM)
					if(M)
						U.LimboClone(M)
			else {c-=rand(1,mx/2); U.Chakra-=c; U.icon_state=""; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
		..()

mob
	proc
		LimboClone(mob/M)
			set waitfor = 0
			if(!M)
				return
			var/mob/Hittable/Command/Clones/LimboClone/B=new(loc)
			IDCOPY(B,src)
			B.name=name;
			B.Village=Village;
			B.dir=dir;
			B.movespeed=0.1
			B.Creator=src;
			B.appearance = appearance
			KageBunshinList+=B;

			B.invisibility = 20
			B.Stamina=round(StaminaMax*0.20);
			B.StaminaMax=B.Stamina;
			B.Taijutsu=round(Taijutsu*0.1)
			B.KnifeSkill=KnifeSkill
			B.SwordSkill=SwordSkill;
			B.wielding=wielding;
			B.Reflex = Reflex*0.6
			if(M)
				B.target=M
				B.Status=STATUS_ATTACK
				spawn()
					B.bunatck()
				spawn(160)
					B.Status = STATUS_BLANK
					del B
			else
				del(B)
