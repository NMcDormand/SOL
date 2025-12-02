obj/SkillCards/Ninjutsu/KageBunshin
	icon_state="card_kagebunshin"
	cmdstring="KageBunshinnoJutsu"
	CCost=5000
	Seals=2
	DM=25
	IsBunshin = 1
	CanLevel = 0

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[min(CCost,usr.ChakraMax*0.25)]'; DamageAmount.text='[DM]% Bunshin Strength'")

	Description = list(
		"about"="Creates an exact copy of the user.  Unlike regular <i>Bunshin no Jutsu</i>, these clones will have a portion of the user's HP and chakra and can attack others.  Drains chakra."
		,"title"="Kage Bunshin no Jutsu"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="B"
		,"pic"='KageBunshin.png'
		)

	UpgradeChoices = list("Lower Cost","Increase Strength")

	Activate(mob/U)
		if(U.KageBunshinAttackCheck()||!U.icon) return
		if(length(U.MasterBunshinList)>=U.BunshinLimit)
			for(var/mob/Hittable/Command/Clones/B in U.MasterBunshinList)
				if(B) del(B)
				break
		var
			c=round(min(5000,U.ChakraMax*0.25)); mx=c; s=U.SS*2
		if(U.Chakra<c) {U<<"Not enough Chakra"; return}
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			U.icon_state=null
			spawn(12)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuSeals(s); U.JutsuNin(c*0.02);
				U.MoveUses[name]++
				U.JutsuUseChakra(c,0.005)
				U.JutsuMessage(Description["title"])
				if(U.BunshinLimit<1) return
				if(U.PracticeMode) return ..()
				var/NCT = 0
				tryAgain
				var/newLoc = locate(U.x+(rand(-2,2)),U.y+(rand(-2,2)),U.z)
				var/turf/t = newLoc
				if(newLoc == U.loc || t && t.density)
					if(NCT>=10)
						U << "There was no available space for the clone"
						return
					else
						NCT++
						goto tryAgain
				var/mob/Hittable/Command/Clones/KageBunshin/B=new(newLoc)
				if(U.Clan=="Uzumaki")
					var/base=DM*0.01
					var/rates=(base+(U.MoveUses[cmdstring] * 0.000005))
					if(rates >= 0.7) rates=0.7 //We don't want it to be TOO op...
					U.BunshinCreate(B,rates,c*1.25)
				else
					U.BunshinCreate(B,DM*0.01,c)
			else {c=rand(10,49); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()
