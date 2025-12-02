obj/SkillCards/Genjutsu/Starter/Bunshin
	icon_state="card_bunshin"
	cmdstring="Bunshin"
//ReverseGenjutsu Add to all new gen

	CCost=50
	Seals=2
	IsBunshin = 1
	CanLevel = 0

	Description = list(
		"about"="This technique creates a clone of the user and will drain chakra for as long as the clones are active. It is important to note that the clones are nothing more than an illusion and will dispel as soon as they are hit by any attack.  Useful for confusing or deceiving your opponent."
		,"title"="Bunshin no Jutsu"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="D"
		,"pic"='Bunshin.png'
	)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<c) {U<<"Not enough Chakra"; return}
		if(length(U.MasterBunshinList)>=U.BunshinLimit)
			for(var/mob/Hittable/Command/Clones/B in U.MasterBunshinList)
				if(B) del(B)
				break
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			U.icon_state=null
			spawn(15)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s); U.JutsuGen(c*2);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				if(U.PracticeMode) return ..()
				var/mob/Hittable/Command/Clones/Bunshin/B=new(U.loc)
				U.OldBunshinCreate(B,1,0,(U.Reflex * 0.6))
			else {c=rand(5,29); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()