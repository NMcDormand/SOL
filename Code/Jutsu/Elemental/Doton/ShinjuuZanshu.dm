obj/SkillCards/Ninjutsu/Doton/ShinjuuZanshu
	icon_state="card_shinjuuzanshu"
	cmdstring="ShinjuuZanshu"
	Range=5
	CCost=900
	Seals=3
	Cooldown=500
	DM = 3

	Description = list(
		"about"="Travel through the earth to surprise attack your opponent."
		,"title"="Doton: Shinjuu Zanshu"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='ShinjuuZanshu.png'
		)

	UpgradeChoices = list("Lower Cooldown","Lower Cost","Increase Damage")

	Activate(mob/U)
		if(U.onwater) {U<<"Cannot do this on water."; return}
		if(U.choosingHoming)
			return
		if(GENERICATTACKCHECK(U))
			return
		var/mob/M
		if(ismob(U.Targeting)&&get_dist(U.Targeting,U)<= Range)
			M = U.Targeting
		else
			M = U.TargetSelect(Range)
		if(M)
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("Shinjuu",(CooldownCur*U.cooldownmultiplier)+s,1)) return
			if(ChakraUseCheck()) c *= 4
			U.icon_state="seals"
			U.firing=1
			var/turf/l
			spawn(s)
				spawn(1)U.icon_state=null
				spawn(12)U.firing=0
				if(!M)
					U.Cooldowns -= "Shinjuu"
					return
				if(M.onwater)
					U.Cooldowns -= "Shinjuu"
					U<<"Cannot do this on water."
					return
				if(prob(U.ChakraControl))
					U.JutsuMessage(Description["title"])
					U.JutsuSeals(s); U.JutsuNin(c);
					U.MoveUses[name]++
					U.JutsuUseChakra(c);
					U.ElementalUp("Earth")
					if(U.PracticeMode || ControlCheck(U)) return ..()
					flick("dig",U)
					spawn(5)
						if(!U.KO)
							U.Underground=1;
							U.invisibility += 66
							U.density=0
							spawn(20)
								if(M)
									l=M.loc
									spawn(5)
										if(l)
											U.loc=l;
											U.Underground=0;
											U.density=1;
											U.invisibility -= 66
											flick("undig",U)
											sleep(1)
											if(M && l==M.loc && U.HitCheck(M))
												var/dmg
												dmg=round(U.Taijutsu*DM-(M.Taijutsu*0.10))
												if(dmg<=round(U.Taijutsu*0.20)) dmg=round(U.Taijutsu*0.20)
												U.attacking=1
												M.DamageMe(U,dmg,"shinjuu")
												spawn(U.atkspeed+15)U.attacking=0
											else
												U.attacking=1; M.resting=0
												range(6,M)<<"[M] dodged [U]'s attack!"
												spawn(U.atkspeed+10)U.attacking=0
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()