//TESTIT may not work right when using the verb

obj/SkillCards/Clan/Aburame/PlaceBug
	icon_state="card_PlaceBug"
	cmdstring="PlaceBug"
	Cooldown = 450
	CooldownCur = 50
	CanLevel = 0
	Range=2
	CCost=5
	ECost=1

	Description = list(
		"about"="Place an insect on a person.  You will be able to track this person thereafter, as well as listen to their private conversations."
		,"title"="Place Insect"
		,"type"="Clan-Jutsu"
		,"type"="X"
		,"weak"="N/A"
		,"rank"="N/A"
		,"Tutorial" = "Place an insect on a target within 2 tiles, this will allow you to track this target in the future and will count towards your bug explode damage if the skill is used"
//		,"pic"='MushiYose.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U))
			return
		var/mob/M
		if(ismob(U.Targeting)&&get_dist(U.Targeting,U)<= Range)
			M = U.Targeting
		else
			M = U.TargetSelect(Range)
		if(M)
			if(M.protect||M.TreeStump) return
			if(U.Konchuuamount<1) {U<<"You don't have any bugs."; return}
			var
				c=CCost; s=U.SS*1
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			U.firing=1
			spawn(s)
				spawn(10)U.firing=0
				U.Chakra-=c;
				U.MoveUses[name]++
				if(!(U.KonchuuList))
					U.KonchuuList=list()
				if(!M.BuggedList)
					M.BuggedList = list()

				if(!(U in M.BuggedList))
					M.BuggedList+=U
				if(M in U.KonchuuList)
					U<<"You've already placed an insect on [M]."; return
				else //if(!("[M.trueName][M.ckey]" in U.KonchuuList))
					U.KonchuuList+=M
					U<<"You place a Bug on [M]."; U.Konchuuamount--
					U.StatUpdate_bugs()
					spawn(18000)
						RemoveBug(M,U)

proc/RemoveBug(mob/target,mob/user)
	if(user && (target in user.KonchuuList))
		user.KonchuuList-=target
	if(target && (user in target.BuggedList))
		target.BuggedList-=user