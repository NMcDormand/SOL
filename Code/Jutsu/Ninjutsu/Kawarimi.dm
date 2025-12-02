mob/var/tmp/CantKawarimi
obj/SkillCards/Ninjutsu/Starter/Kawarimi
	icon_state="card_kawarimi"
	cmdstring="Kawarimi"
	CCost=10
	Seals=0
	XPLGain = 200
	Duration = 15

	Description = list(
		"about"="Create a substitute of your body while you sneak away or flank the enemy.  As soon as the substitute takes a hit, it will reveal itself to be a fake."
		,"title"="Kawarimi no Jutsu"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="D"
		,"pic"='Kawarimi.png'
		)

	UpgradeChoices = list("Increase Duration")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)||U.InKawarimi||U.InHenge||U.CantKawarimi) return
		var
			c=CCost; mx=c; s=Seals; k

		if(U.onwater) k="water"
		else if(U.onmountain) k="mountain"
		else if(U.onsand) k="sand"
		else k="land"

		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(60)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c)
				U.JutsuMessage(Description["title"])
				if(U.PracticeMode || ControlCheck(U)) return ..()

				U.InKawarimi=1
				U.CantKawarimi=1
				var/mob/Kawarimi/S=new(U.loc)
				S.appearance=U.appearance; S.name=U.name; S.dir=U.dir; U.Kawarimi=S
				U.RemoveAllTargetMe()
				U.invisibility++
				U.alpha = 153
				U.underlays=null
				spawn(Duration)
					if(S)
						S.overlays=null; flick('Smoke.dmi',S)
						spawn(5)
							if(S)
								if(k=="water") {S.icon='kawarimi.dmi'; S.icon_state="fish"}
								else if(k=="mountain") {S.icon='kawarimi.dmi'; S.icon_state="rock"}
								else if(k=="sand") {S.icon='kawarimi.dmi'; S.icon_state="tumbleweed"}
								else {S.icon='kawarimi.dmi'; S.icon_state="log"}
								spawn(20) if(S)del(S)
					flick('Smoke.dmi',U)
					spawn(5)
						spawn(20)U.InKawarimi=null
						spawn(60) U.CantKawarimi=0
						U.invisibility--
						U.alpha = 255
						if(!U.onwater) U.overlays-='WaterWalk.dmi'
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
			..()