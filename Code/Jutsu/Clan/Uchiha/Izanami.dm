#if DEBUGGING
mob/verb
	SelfLearnIzanami()
		var/obj/SkillCards/Clan/Uchiha/MS/Izanami/J=locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Izanami no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Uchiha/MS/Izanami(src)
#endif


obj/SkillCards/Clan/Uchiha/MS/Izanami
	icon_state="card_Izanami"
	cmdstring="Izanami"
	CCost=20000
	Seals=0
	Duration = 50
	Range = 2
	Cooldown = 8000
	var/WatchIzanami = 0

	Description = list(
		"about"="Locks the victim in a loop causing them to be stunned and take real damage from the illusion. This will block your Sharingan from being used fpr a large amount of time"
		,"title"="Izanami"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
//		,"pic"='Dispel.png'
	)

	UpgradeChoices = list("Increase Range","Increase Duration")

	verb/Watch_Izanami()
		if(WatchIzanami)
			WatchIzanami = 0
			usr << "You will no longer see the victims view while in the genjutsu"
		else
			WatchIzanami = 1
			usr << "You will now see the victims view while in the Genjutsu"

	Activate(mob/U)
		if(U.choosingHoming)
			return
		var/mob/M
		if(ismob(U.Targeting)&&get_dist(U.Targeting,U)<= Range)
			M = U.Targeting
		else
			M = U.TargetSelect(Range,1)
		if(M && !istype(M,/mob/Hittable/Responsive/Boss/Madara))
			if(GENERICATTACKCHECK(U))
				return
			if(M.InIllusion)
				U << "[M] is already under the influence of a mind altering jutsu"
				return
			var
				c=CCost; mx=c;
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("Izanami",(CooldownCur*U.cooldownmultiplier))) return
			U.Cooldowns["Sharingan"] = world.time+4000
			if(ChakraUseCheck()) c *= 3
			U.firing=1
			if(M)
				spawn(2)U.firing=0
				if(prob(U.ChakraControl))
					U.JutsuGen(c*0.2);
					U.MoveUses[name]++
					U.JutsuUseChakra(c,0.1);
					if(U.PracticeMode || ControlCheck(U))
						U.JutsuMessage(Description["title"])
						return ..()
					if(U.GenjutsuTrue < 50000)
						U.JutsuMessage(Description["title"])
					else
						U << "You used [Description["title"]]"

					if(istype(M,/mob/Hittable/Responsive)&&!(U in M.HitList))
						M.HitList+=U

					U.IzanamiActivate(M,Duration,WatchIzanami)
					U.InSharingan = 0
					U.InMangekyou=0
					U.Reflex=U.ReflexTrue
					U.overlays -= U.DouEyes
					U.DouEyes = null
					if(!U.EternalSharingan && prob(135-Level))
						U.BlindMe("Izanami")
				else
					c-=rand(1,mx/2); U.Chakra-=c
					U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"
					return
				..()
	verb
		Izanami_Release()
			if(usr.IzanamiTgt)
				usr.IzanamiTgt.ReleaseIzanami()
			else
				usr << "You do not have any targets under it's affects"

mob
	var/mob/IzanamiTgt
	var/tmp/InIzanami = 0
	Hittable/Command/Genjutsu/Izanami
		density = 1
		CantHenge = 1
		var/mob/Victim
		var/Steps
		var/turf/OLoc
		var/ODir
		var/Duration
		var/Moved = 0
		New(mob/Vic,DUR,G)
			..()
			Victim = Vic
			loc = Vic.loc
			OLoc = loc
			ODir = Vic.dir
			Duration = DUR
			Genjutsu = G

		Move()
			.=..()
			if(get_dist(src,OLoc)>5)
				loc = OLoc
				dir = ODir
				Steps = 0
			else
				if(!Moved)
					Moved = 1
					spawn(Duration)
						if(Victim)
							Victim.ReleaseIzanami()
			if(.)
				Victim.DamageMe(Creator,Genjutsu,"Izanami",1)

		Cross(A)
			return 1
			if(ismob(A))
				if(istype(A,/mob/player)||istype(A,/mob/Hittable))
					return 1
			else
				.=..()

	proc
		IzanamiActivate(mob/M, DUR, WI)
			if(M.client)
				//sleep(10)
				src << "<b>[M] is now under the affect of the Izanami</b>"
				M.InIllusion = 1
				M.Targeting = null
				if(M.client)
					for(var/image/x in M.client.images) // first, check to see if your have a target.
						if(x.icon=='target.dmi') // if so.
							del(x) // delete it.
				IzanamiTgt = M

				var/mob/Hittable/Command/Genjutsu/Izanami/I = new(M,DUR,Genjutsu)
				I.movespeed = M.movespeed
				I.setspeed = M.setspeed
				I.equippedweight = M.equippedweight
				I.name = "[M.name]"
				I.Creator = src
				var/icon/IC = icon(M.icon)
				for(var/A in M.overlays)
					IC.Blend(icon(A:icon),ICON_OVERLAY)
				I.invisibility = 100
				var/image/IM = image(IC,I)
				M << IM
				if(WI)
					src << IM

				M.Projection = I
				M.ControlProjection = 1
				M.OSight = M.sight
				M.sight = 0
				M.see_invisible = 4
				M.InIzanami = 1
				//M.client.perspective = EYE_PERSPECTIVE;
				M.client.eye = I;
				spawn()
					if(M)
						while(M.InIzanami)
							M.DamageMe(src,Genjutsu,"Izanami",1)
							sleep(10)
			else
				M.Projection = src
				M.InIzanami = Genjutsu
				M.InIllusion = 1
				spawn(DUR)
					if(M)
						M.InIzanami = 0
						M.Projection = 0
						M.InIllusion = 0

		ReleaseIzanami()
			sight = OSight
			OSight = null
			see_invisible = 7+InSharingan+InByakugan
			InIzanami = 0
			InIllusion = 0
			if(client)
				client.perspective = MOB_PERSPECTIVE|EDGE_PERSPECTIVE;
				client.eye = src;
			if(Targeting)
				DeleteTarget()
			if(Projection)
				var/mob/A
				if(client)
					A = Projection.Creator
					Projection.Creator = null
					Projection.loc = null
					ControlProjection = 0
				else
					A = Projection
				if(A)
					A.InIzanami = 0
				Projection = 0