obj/SkillCards/Genjutsu/sexyjutsu
	icon_state="card_sexy"
	cmdstring="SexyJutsu"
	CCost=10
	Seals=1
	CanLevel = 0

	Description = list(
		"about"="Transform yourself into that of beauty for a short period of time! I hear the strongest people tend to be easily influenced by this..."
		,"title"="Sexy Jutsu!"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="D"
		//,"pic"='Kawarimi.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)||U.InKawarimi||U.InHenge||U.CantKawarimi) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(60)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuUseChakra(c)
				U.JutsuMessage(Description["title"])
				U.InSexy=1
				U.CantKawarimi=1
				U.icon='sexy.dmi'
				U.underlays=null
				spawn(30)
					flick('Smoke.dmi',U)
					spawn(5)
						spawn(20)U.InSexy=null
						spawn(60) U.CantKawarimi=0
						U.CreationSkin(1)
						if(!U.onwater) U.overlays-='WaterWalk.dmi'
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()