mob/var
	NarakumiUses=0
	tmp/InNarakumi
obj/SkillCards/Genjutsu/Narakumi
	icon_state="card_Narakumi"
	cmdstring="Narakumi"
	Range=8
	CCost=1000
	Seals=15
	Range = 4
	Cooldown = 3000
	Duration = 60
	DM = 1

	Description = list(
		"about"="Freeze an opponent by showing them an horrific illusion of their own death."
		,"title"="Narakumi no Jutsu"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="A"
//		,"pic"='Narakumi.png'
	)

	UpgradeChoices = list("Increase Duration","Lower Cooldown")

	Activate(mob/U)
		var/mob/M
		if(ismob(U.Targeting)&&!U.Targeting.TreeStump&&get_dist(U.Targeting,U)<= Range)
			M = U.Targeting
		else
			M = U.TargetSelect(Range,1)
		if(M)
			if(GENERICATTACKCHECK(U)) return
			if(M.InIllusion)
				U << "[M] is already under the influence of a mind altering jutsu"
				return
			if(M.Blind)
				U << "[M] was unable to see the genjutsu and remains unaffected"
				return
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("Narakumi",(CooldownCur*U.cooldownmultiplier)+s)) return
			if(ChakraUseCheck()) c *= 4
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				spawn(5)U.firing=0
				spawn(1)U.icon_state=null
				if(prob(U.ChakraControl))
					U.JutsuSeals(s); U.JutsuGen(c);
					U.MoveUses[name]++
					U.JutsuUseChakra(c);
					if(U.PracticeMode || ControlCheck(U))
						U.JutsuMessage(Description["title"])
						return ..()

					spawn(50)
						if(M && !M.Dispel)
							if(istype(M,/mob/Hittable/Responsive)&&!(U in M.HitList)) M.HitList+=U
							if(M.KI_InMission && (U in KI_Participants)) {U<<"They are helping aid with the invasion!"; return;}
							U<<"<b>Narakumi no Jutsu has been used on [M]!</b>"
							var/BlindTime=0
							var/diff=((M.Genjutsu/U.Genjutsu)*100)*DM
							if(diff < 56)
								BlindTime=Duration * 2
							else if(diff < 75)
								BlindTime=Duration * 1.5
							else if(diff < 95)
								BlindTime=Duration
							else if(diff < 120)
								BlindTime= Duration * 0.5
							else //if(diff > 120)
								BlindTime=0
							if(BlindTime)
								M.sight |= BLIND
								M.IsBlinded=1; M.InNarakumi=1
								M.FakeDeathMessage(U)
								M.NarakumiReversalCheck(U,BlindTime)
							else U<<"The jutsu had no effect on [M]"
				else {c-=rand(1,65); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
				..()

mob/proc
	NarakumiReversalCheck(mob/U,DUR)
		spawn(DUR)
			InNarakumi = 0
		while(InNarakumi)
			if(!src)
				return
			if(Dispel)
				InNarakumi=0
				break
			if(ReverseGenjutsu)
				if(U && Genjutsu > (U.Genjutsu * 0.6))
					InNarakumi=0
					U.sight |= BLIND
					U.FakeDeathMessage(src)
					U.InNarakumi=1; U.IsBlinded=1
					U.NarakumiReversalCheck(src,DUR)
					break
				else
					src<<"Their Genjutsu is too strong"
					U<<"[src] tried to reverse the attack, but your Genjutsu is too strong for \him."
					ReverseGenjutsu=0
					break
			sleep(5)

		InNarakumi=0;
		IsBlinded=0

	FakeDeathMessage(mob/killer)
		if(DeathMessages=="own"||DeathMessages=="all")
			src << "<font color=red><B><i>  [src] has been killed by [killer]!</font></b></i>"
		src<<"<i>You were killed!</i>"