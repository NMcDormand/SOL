obj/SkillCards/Genjutsu/Kokuangyou
	icon_state="card_Kokuangyou"
	cmdstring="Kokuangyou"
	Range=6
	CCost=2000
	Seals=17
	Cooldown = 3600
	Duration = 90
	DM = 1

	Description = list(
		"about"="Confine your opponent in darkness."
		,"title"="Kokuangyou no Jutsu"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="D"
//		,"pic"='Kokuangyou.png'
	)

	UpgradeChoices = list("Increase Duration","Lower Cooldown")

	Activate(mob/U)
		var/mob/M
		if(ismob(U.Targeting)&&!U.Targeting.TreeStump&&get_dist(U.Targeting,U)<= Range)
			M = U.Targeting
		else
			M = U.TargetSelect(Range)
		if(M)
			if(GENERICATTACKCHECK(U)) return
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(M.InIllusion)
				U << "[M] is already under the influence of a mind altering jutsu"
				return
			if(M.Blind)
				U << "[M] was unable to see the genjutsu and remains unaffected"
				return
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("Kokuangyou",(CooldownCur*U.cooldownmultiplier)+s)) return
			if(ChakraUseCheck()) c *= 4
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				spawn(20)U.firing=0
				spawn(1)U.icon_state=null
				if(!M) return
				if(prob(U.ChakraControl))
					U.JutsuSeals(s); U.JutsuGen(c);
					U.MoveUses[name]++
					U.JutsuUseChakra(c);
					if(U.PracticeMode || ControlCheck(U))
						U.JutsuMessage(Description["title"])
						return ..()
					if(M.KI_InMission&&(U in KI_Participants)) {U<<"They are helping aid with the invasion!"; return;}
					if(istype(M,/mob/Hittable/Responsive)&&!(U in M.HitList)) M.HitList+=U
					var/BlindTime=0
					var/diff=((M.Genjutsu/U.Genjutsu)*100)*DM
					if(M.Clan=="Aburame") diff*=2
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
						SightReversalCheck(U,M,BlindTime)
				else {c-=rand(1,65); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
				..()

proc
	SightReversalCheck(mob/U,mob/M,B)
		if(M.Class["Sensory-Nin"])
			M.sight |= (BLIND|SEE_MOBS)
		else
			M.sight |= (BLIND|SEE_SELF)
		M.IsBlinded=1; M.Darkness=1
		spawn(B)
			if(M && M.IsBlinded && M.Darkness)
				M.Darkness=0
		while(M && M.Darkness)
			if(M.ReverseGenjutsu)
				if(M.Genjutsu>(U.Genjutsu*0.75))
					M.sight=0
					if(U)
						SightReversalCheck(M,U,B)
				else
					M<<"Their Genjutsu is too strong"; U<<"[M] tried to reverse the attack, but your Genjutsu is too strong for \him."
					M.ReverseGenjutsu=0; return

			if(M.Dispel)
				if(U)
					if(M.Genjutsu>(U.Genjutsu*0.65))
						break
				else
					break
			sleep(10)
		if(M)
			M.Darkness=0; M.IsBlinded=0; M.sight=0; M.sight |= SEE_SELF