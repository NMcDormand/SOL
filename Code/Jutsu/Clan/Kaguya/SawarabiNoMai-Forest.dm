obj/SkillCards/Clan/Kaguya/SawarabiNoMaiRelease
	icon_state="card_SawarabiNoMaiRelease"
	cmdstring="SawarabiNoMaiRelease"
	CCost=0
	SCost = 0
	Seals=0
	CanLevel = 0

	Description = list(
		"about"="Release your bone forest"
		,"title"="Release: Sawarabi no Mai"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
//		,"pic"='SawarabiNoMai.png'
		)

	Activate(mob/U)
		if(U.InSawa)
			U.InSawa = 0
			return

obj/SkillCards/Clan/Kaguya/SawarabiNoMai
	icon_state="card_SawarabiNoMai"
	cmdstring="SawarabiNoMai"
	CCost=18000
	SCost = 4000
	Seals=20
	Range=5
	XPLGain = 10
	Shots = 15

	Cooldown = 6000
	CooldownCur = 6000

	New()
		..()
		if(ismob(loc))
			new/obj/SkillCards/Clan/Kaguya/SawarabiNoMaiRelease(loc)

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[CCost*usr.KGCModifier]';DamageAmount.text='[35+Shots] Bones'")

	Description = list(
		"about"="Push your body beyond its limit and create a forest of sharp bones to trap your opponents."
		,"title"="Sawarabi no Mai"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
//		,"pic"='SawarabiNoMai.png'
		)

	UpgradeChoices = list("Increase Range","More Bones")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=(CCost*U.KGCModifier); s=U.SS*Seals; mx=c
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}

		if(U.CooldownCheck("SawarabiForest",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			U.icon_state=null
			spawn(6)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuUseChakra(c)
				U.MoveUses[name]++
				U.JutsuSeals(s); U.JutsuTai(U.Taijutsu*0.06)
				if(U.PracticeMode || ControlCheck(U)) return ..()
				U.SawaCentre = U.loc
				var/SRange = Range
				U.InSawa = list()
				U.SawaBoost = round(U.TaijutsuMax*(0.4))
				U.Taijutsu += U.SawaBoost
				U.RefreshStats()

				var/OH = round(U.Stamina * 0.3)
				var/IH = round(OH * 0.5)
				for(var/turf/T in view(U,SRange+1))
					if(T.density)
						continue
					/*for(var/atom/A in T)
						if(A.density)
							continue*/
					if(get_dist(U,T) > SRange)
						//var/mob/Hittable/Unresponsive/Inanimate/Break/AA=
						new/mob/Hittable/Unresponsive/Inanimate/Break/Bone(T,U,U.SawaBoost,OH)
					else
						U.InSawa+=T

				var/Z=35+Shots
				var/list/Picked = list()
				for(var/N=0 to Z)
					//var/Skub=rand(1,10)
					//if(Skub<=6)
					Ga
					if(U && U.InSawa.len && Picked.len < U.InSawa.len)
						var/turf/added = pick(U.InSawa)
						if(added in Picked)
							goto Ga
						else
							//var/mob/Hittable/Unresponsive/Inanimate/Break/AA =
							var/mob/Hittable/Unresponsive/Inanimate/Break/Bone/B = new(added,U,U.SawaBoost,IH)
							Picked += B
				U.SawaDrain(SCost)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()


mob/proc/SawaDrain(S)
	while(InSawa)
		Stamina-=S;
		if(Stamina<S)
			src<<"You can no longer sustain your Forest."
			if(Stamina<1)
				Stamina=0
			InSawa = 0
			break
		RefreshStamina()
		sleep(30)
	RefreshStamina()

	for(var/mob/Hittable/Unresponsive/Inanimate/Break/Bone/A in Bones)
		del A
	Taijutsu -= SawaBoost
	SawaBoost = 0
	SawaCentre = 0
	RefreshStats()
	src<<"Your bones from the forest retract."