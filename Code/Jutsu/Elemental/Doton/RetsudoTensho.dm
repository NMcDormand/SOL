#if DEBUGGING
mob/verb
	SelfLearnRetsudoTensho()
		var/obj/SkillCards/Ninjutsu/Doton/RetsudoTensho/J = locate(/obj/SkillCards/Ninjutsu/Doton/RetsudoTensho) in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Doton: Retsudo Tensho no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Doton/RetsudoTensho(src)
#endif

obj/SkillCards/Ninjutsu/Doton/RetsudoTensho
	icon_state="card_Retsudo"
	cmdstring="RetsudoTensho"
	Range=1
	CCost=400
	Seals=5
	Cooldown = 240

	Description= list(
		"about"="This is among the more basic techniques taught in Iwagakure. By placing the palm of their hand on the ground, the user breaks up and shifts the local earth."
		,"title"="Doton Retsudo Tensho"
		,"type"="Ninjutsu"
		,"Element"="Earth"
		,"weak"="Lightning"
		,"rank"="B"
		,"pic"='Bunshin.png'
	)

	UpgradeChoices = list("Increase Range","Lower Cooldown","Lower Cost")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("RetsudoTensho",(CooldownCur*U.cooldownmultiplier)+s,1)) return
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
				U.ElementalUp("Earth")
				if(U.PracticeMode || ControlCheck(U)) return ..()
				U.Retsudo(Range)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
			..()

turf
	var
		CleanMe=0
	proc
		Cleaning()
			set waitfor = 0
			var/Current = CleanMe
			spawn(60)
				if(CleanMe == Current)
					overlays=null
					CleanMe = 0

mob
	proc
		Retsudo(Range = 1)
			if(!src)
				return
			var/list/Turfs = list()
			var/icon/IC = icon('shake.dmi')
			IC.Scale(32,16)
			for(var/turf/G in orange(Range))
				Turfs += G
				G.overlays+=IC
				G.CleanMe++
				G.Cleaning()

			for(var/i = 1 to 5)
				if(src)
					var/D = EarthElemental + (Ninjutsu*0.4)
					for(var/turf/G in Turfs)
						if(i==5)
							G.overlays -= IC
							G.CleanMe--
						for(var/mob/I in G)
							if(I.protect || I.KO || I == src || I.Intangible || !I.density || IDCHECK(src,I))
								continue
							var/CD =round(D - (I.EarthElemental+(I.Ninjutsu*0.1)))
							I.DamageMe(src,CD,"RetsudoTensho")
					sleep(5)
				else
					for(var/turf/G in Turfs)
						G.overlays -= IC
						if(G.CleanMe)
							G.CleanMe--
					break