obj/SkillCards/Clan/Yuki/Kurosuhebun
	icon_state="card_MakyouHyoushou"
	cmdstring="Kurosuhebun"
	Range=6
	CCost=6000
	Seals=7
	DM = 2
	Cooldown = 2000

	Description = list(
		"about"="Attack your opponent with blinding speed using four Demonic Ice Mirrors"
		,"title"="Hijutsu: Kurosuhebun"
		,"type"="Ninjutsu"
		,"Element"="Ice"
		,"weak"="Fire"
		,"rank"="A"
//		,"pic"='MakyouHyoushou.png'
	)

	UpgradeChoices = list("Lower Cooldown","Increase Damage")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)||U.Gokusamaisou||U.mirroring||U.InMirrors) return
		if(U.choosingHoming)
			return

		var/dist=Range;
		var/mob/M
		if(ismob(U.Targeting) && get_dist(U.Targeting,U) <= dist)
			M = U.Targeting
		else
			M = U.TargetSelect(dist)

		if(M)
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c)
				U<<"Not enough Chakra."
				return
			if(U.CooldownCheck("Kurosuhebun",(CooldownCur*U.cooldownmultiplier)+s)) return
			if(ChakraUseCheck())
				c *= 4

			U.firing=1
			U.icon_state="seals"
			spawn(s)
				spawn(12) U.firing=0
				U.icon_state=null
				if(prob(U.ChakraControl))
					U.JutsuSeals(s); U.JutsuNin(c);
					U.ElementalUp("Ice");
					U.JutsuUseChakra(c)
					U.JutsuMessage(Description["title"])
					U.MoveUses[name]++
					if(U.PracticeMode || ControlCheck(U)) return ..()
					U.CrossHaven(M,src)
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()
mob
	var
		tmp
			InMirrorCross = 0
	proc
		CrossHaven(var/mob/M,obj/SkillCards/SK)
			M.InMirrors += 2
			var/list/ML = list()
			for(var/turf/T in oview(1,M.loc))
				if(T.density)
					continue
				if(T.y > M.y && T.x > M.x)
					var/mob/Hittable/Unresponsive/Inanimate/Break/DemonMirror/DM = new(T,src,SOUTHWEST)
					DM.InDome = 2
					ML += DM
				else if(T.y > M.y && T.x < M.x)
					var/mob/Hittable/Unresponsive/Inanimate/Break/DemonMirror/DM = new(T,src,SOUTHEAST)
					DM.InDome = 2
					ML += DM
				else if(T.y < M.y && T.x > M.x)
					var/mob/Hittable/Unresponsive/Inanimate/Break/DemonMirror/DM = new(T,src,NORTHWEST)
					DM.InDome = 2
					ML += DM
				else if(T.y < M.y && T.x < M.x)
					var/mob/Hittable/Unresponsive/Inanimate/Break/DemonMirror/DM = new(T,src,NORTHEAST)
					DM.InDome = 2
					ML += DM
				else
					continue
			InMirrorCross = 1
			if(!InAMirror)
				InAMirror=1
				invisibility += 2
				for(var/mob/TM in range())
					if(TM.Targeting == src)
						TM.DeleteTarget()

			M.overlays+='iceblastcover.dmi'
			while(ML & src)
				var/mob/Hittable/Unresponsive/Inanimate/Break/DemonMirror/TM = pick(ML)
				dir = get_dir(src,Targeting)
				if(EnteredOBJ)
					EnteredOBJ.Containing = null
				loc = TM.loc
				EnteredOBJ=TM
				EnteredOBJ.Containing=src
				var/obj/Yuki/Sensatsu/S=new()
				S.Power = 2
				NewProjectile(M,S,SK,0.9,7)
				TM.Used++
				if(TM.Used>SK.DM)
					ML-=TM
					if(!length(ML))
						ML = 0
					spawn(10)
						if(TM)
							del TM
				sleep(1)

			InAMirror = 0
			InMirrorCross = 0
			invisibility -= 2
			spawn(5)
				if(M)
					M.InMirrors -= 2
					M.overlays-='iceblastcover.dmi'

