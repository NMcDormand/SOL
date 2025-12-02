obj/SkillCards/Ninjutsu/RaitonKageBunshin
	icon_state="card_RaitonKageBunshinnoJutsu"
	cmdstring="RaitonBunshin"
	CCost=4000
	Seals=2
	DM=22
	IsBunshin = 1

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[min(CCost,usr.ChakraMax*0.25)]'; DamageAmount.text='[DM]% Bunshin Strength'")

	Description = list(
		"about"="Creates an exact copy of the user.  These types of clones will shock opponents when dispatched, stunning them momentarily."
		,"title"="Raiton: Kage Bunshin no Jutsu"
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
			c=min(CCost,U.ChakraMax*0.25); mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			U.icon_state=null
			spawn(20)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuSeals(s); U.JutsuNin(c*0.02); U.ElementalUp("Lightning");
				U.MoveUses[name]++
				U.JutsuUseChakra(c,0.05)
				U.JutsuMessage(Description["title"])
				if(U.PracticeMode || ControlCheck(U)) return ..()
				var/mob/Hittable/Command/Clones/RaiBunshin/B=new(U.loc)
				U.BunshinCreate(B,DM*0.01,c,1,0.5,2)
				B.LightningElemental=U.LightningElemental
			else {c=rand(10,49); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

