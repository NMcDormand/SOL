obj/SkillCards/Clan/Uchiha/KyoutenChiten
	icon_state="card_KyoutenChiten"
	cmdstring="KyoutenChiten"
	CanLevel = 0
	Duration = 50
	Cooldown = 500
	CCost = 200

	Description = list(
		"about"="Reverse Genjutsu used on you, back onto the user."
		,"title"="Kyouten Chiten"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='KyoutenChiten.png'
		)

	UpgradeChoices = list("Lower Cooldown","Increase Duration")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		if(DISPELCHECK(U))return
		if(!U.InSharingan&&!U.InMangekyou) {U<<"You need the Sharingan Eye for this technique."; return}
		var
			c=CCost; mx=c; s=U.SS
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("KyoutenChiten",(Cooldown*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 4
		U.firing=1
		spawn(s)
			spawn(Duration)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuUseChakra(CCost)
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s)
				U.JutsuNin(c)
				if(U.PracticeMode) return ..()
				spawn(1)
					U.ReverseGenjutsu=1
				spawn(Duration)
					U.ReverseGenjutsu=0
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()