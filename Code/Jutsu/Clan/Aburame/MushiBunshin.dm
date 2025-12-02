obj/SkillCards/Clan/Aburame/MushiBunshin
	icon_state="card_MushiBunshin"
	cmdstring="MushiBunshin"

	CCost=3000
	ECost=80
	Seals=4
	IsBunshin = 1
	DM = 30

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[min(CCost,usr.ChakraMax*0.25)]'; DamageAmount.text='[DM]% Bunshin Strength'")


	Description = list(
		"about"="Create a clone of yourself that utilises bugs."
		,"title"="Mushi Bunshin no Jutsu"
		,"type"="Clan-Jutsu"
		,"weak"="N/A"
		,"rank"="N/A"
		,"Tutorial" = ""
//		,"pic"='MushiYose.png'
		)

	UpgradeChoices = list("Lower Cost","Increase Strength")

	Tutorial()
		Description["Tutorial"] = "Create a clone made out of Insects, this will cost [min(CCost,usr.ChakraMax*0.25)] Chakra per second, They will be equal to [DM]% of your strength"
		..()

	Activate(mob/U)
		if(U.KageBunshinAttackCheck()) return
		var
			c=min(CCost,U.ChakraMax*0.25); mx=c; s=U.SS*Seals
			b = ECost
		if(U.Chakra<=c) {U<<"Not enough Chakra.<br>You needed [c] chakra for this one"; return}
		if(U.Konchuuamount<b) {U<<"You need [b] insects for this jutsu."; return}
		if(ChakraUseCheck()) c *= 4
		if(length(U.MasterBunshinList)>=U.BunshinLimit)
			for(var/mob/Hittable/Command/Clones/B in U.MasterBunshinList)
				del(B)
				break
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			U.icon_state=null
			spawn(20)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuUseChakra(CCost)
				U.JutsuSeals(s); U.JutsuNin(c/b); U.MoveUses[name]++
				U.JutsuMessage(Description["title"])
				if(ControlCheck(U)) return ..()
				U.Konchuuamount-=b;
				if(U.PracticeMode) return ..()
				var/mob/Hittable/Command/Clones/MushiBunshin/B=new(U.loc)
				var/PER = DM*0.01
				U.BunshinCreate(B,PER,c,0.5,2)
				flick('Smoke.dmi',B)
				for(var/area/A in view(0,B)) A.Entered(B)
				U.StatUpdate_bugs()
			else {c=rand(50,99); U.CCGain(c/50); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
			..()