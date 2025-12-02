obj/SkillCards/Ninjutsu/TajuuKageBunshin
//obj/SkillCards/Clan/Uzumaki
	icon_state="card_kagebunshin"
	cmdstring="TajuuKageBunshinnoJutsu"
	Cooldown=3600
	CCost=70000
	Seals=2
	XPLGain = 100

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			var/A = 0.05 + (usr.MoveUses["KageBunshin"] * 0.00005)
			if(A>0.6)
				A = 0.6
			winset(usr,null,"ChakraCost.text='[round(min(CCost,usr.ChakraMax*0.8))]'; DamageAmount.text='[A*100]% Bunshin Strength'")

	Description = list(
		"about"="Creates exact copies of the user.  Unlike regular <i>Kage Bunshin no Jutsu</i>, This will create double max bunshins instantly.  Drains chakra."
		,"title"="Tajuu Kage Bunshin no Jutsu"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
		//,"pic"='KageBunshin.png'
		)

	UpgradeChoices = list("Lower Cooldown","Lower Cost")

	Activate(mob/U)
		if(U.KageBunshinAttackCheck()) return
		var
			c=round(min(CCost,U.ChakraMax*0.8)); mx=c; s=U.SS*Seals
		if(U.MasterBunshinList.len >= U.BunshinLimit*2)
			for(var/mob/Hittable/Command/Clones/B in U.MasterBunshinList)
				if(B) del(B)
				break
		if(U.Chakra<c) {U<<"Not enough Chakra"; return}
		if(U.CooldownCheck("Tajuu",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 2
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			U.icon_state=null
			spawn(12)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuUseChakra(CCost)
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s); U.JutsuNin(c*0.1);
				U.MoveUses[name]++
				if(U.BunshinLimit<1) return
				if(U.PracticeMode || ControlCheck(U)) return ..()
				var/base=0.05
				var/rates=(base+(U.MoveUses["KageBunshin"]* 0.00005))
				if(rates >= 0.6) rates=0.6 //We don't want it to be TOO op...
				var/CLimit = (U.BunshinLimit*2) - length(U.MasterBunshinList)
				for(var/i = 1 to CLimit)
					spawn()
						var/Failed = 0
						tryAgain
						var/newLoc = locate(U.x+(rand(-4,4)),U.y+(rand(-4,4)),U.z)
						var/turf/t = newLoc
						if(Failed >4)
							return
						if(newLoc == U.loc || t.density||!t)
							Failed++
							goto tryAgain
						var/mob/Hittable/Command/Clones/KageBunshin/B=new(newLoc)
						U.BunshinCreate(B,rates*0.1,c*1.25)
						if(U.Targeting)
							B.target=U.Targeting
							if(B.Status!=STATUS_ATTACK)
								B.Status=STATUS_ATTACK
								spawn()
									B.bunatck()

			else {c=rand(10,49); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()