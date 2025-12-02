#if DEBUGGING
mob/verb
	SelfLearnRaitonYoroi()
		var/obj/SkillCards/Ninjutsu/Raiton/RaitonYoroi/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Raiton no Yoroi</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Raiton/RaitonYoroi(src)
#endif

obj/SkillCards/Ninjutsu/Raiton/RaitonYoroi
	cmdstring="RaitonYoroi"
	icon_state="card_RaitonYoroi"
	CCost=2000
	Seals=1
	Cooldown = 1200
	DM = 0.05

	Description= list(
		"about"="The user wraps their body in a layer of lightning chakra to increase their physical stats"
		,"title"="Raiton no Yoroi"
		,"type"="Ninjutsu"
		,"Element"="Lightning"
		,"weak"="Earth"
		,"rank"="A"
		//,"pic"='Bunshin.png'
	)

	UpgradeChoices = list("Increase Buff","Lower Cost")

	Activate(mob/U)
		if(U.RaitonArmour)
			U.RaitonArmour = 0
		else
			if(GENERICATTACKCHECK(U))
				return
			if(!MultiBuffs && U.InBoost)
				U << "You already using a Buff of some kind"
				return
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("RaitonYoroi",(CooldownCur*U.cooldownmultiplier)+s)) return
			if(ChakraUseCheck()) c *= 4
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				spawn(1)U.icon_state=null
				spawn(3)U.firing=0
				if(prob(U.ChakraControl))
					U.JutsuMessage(Description["title"])
					U.JutsuSeals(s); U.JutsuNin(c);
					U.MoveUses[name]++
					U.JutsuUseChakra(c);
					U.ElementalUp("Lightning")
					if(U.PracticeMode || ControlCheck(U)) return ..()
					U.RaitonArmour(DM,c,CooldownCur)
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

mob
	var/tmp
		RaitonArmourGain = 0
		RaitonRFX = 0
	proc
		RaitonArmour(DM,CCOST,CD)
			set waitfor = 0
			RaitonArmour = 1
			var/A = round((Taijutsu*DM)+LightningElemental)
			var/B = round(LightningElemental*DM)
			if(B>50)
				B = 50

			Taijutsu += A
			Reflex += B
			RaitonArmourGain = A
			RaitonRFX = B
			movespeed-=0.7

			overlays += 'RaitonYoroi.dmi'
			src<<"You shroud yourself in the Raiton no Yoroi!"
			StatUpdate_taijutsu(); StatUpdate_reflexes(); StatUpdate_movespeed()

			while(RaitonArmour)
				if(Chakra >= CCOST)
					Chakra -= CCOST
					JutsuChakra(30);
					StatUpdate_chakra()
					sleep(10)
				else
					RaitonArmour = 0
					if(Chakra<0)
						Chakra = 0
					break

			Cooldowns["RaitonYoroi"] = world.time+CD
			movespeed += 0.7
			if(movespeed>setspeed)
				movespeed = setspeed
			InBoost = 0
			Reflex -= RaitonRFX
			Taijutsu -= RaitonArmourGain
			RaitonArmourGain = 0
			StatUpdate_taijutsu(); StatUpdate_reflexes(); StatUpdate_movespeed()
			overlays -= 'RaitonYoroi.dmi'
			src<<"The Raiton no Yoroi has disappeared"