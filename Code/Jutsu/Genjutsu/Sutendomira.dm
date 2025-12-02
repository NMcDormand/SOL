#if DEBUGGING
mob/verb
	SelfLearnSutendomira()
		var/obj/SkillCards/Genjutsu/Sutendomira/J=locate(/obj/SkillCards/Genjutsu/Sutendomira) in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Sutendomira no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Genjutsu/Sutendomira(src)
#endif

obj/SkillCards/Genjutsu/Sutendomira
	icon_state="card_Sutendomira"
	cmdstring="Sutendomira"
	CCost=8000
	Seals=1
	Duration = 70
	Range = 5
	Cooldown = 1200

	Description = list(
		"about"="Stuns the user with an illusion without alerti them they under the influence of a genjutsu"
		,"title"="Sutendomira"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="A"
//		,"pic"='Dispel.png'
	)

	UpgradeChoices = list("Increase Range","Increase Duration")

	Activate(mob/U)
		if(U.choosingHoming)
			return
		var/mob/M
		if(ismob(U.Targeting)&&!U.Targeting.TreeStump&&get_dist(U.Targeting,U)<= Range)
			M = U.Targeting
		else
			M = U.TargetSelect(Range,1)
		if(M)
			if(GENERICATTACKCHECK(U))
				return
			if(M.InIllusion)
				U << "[M] is already under the influence of a mind altering jutsu"
				return
			if(M.Blind||M.IsBlinded)
				U << "[M] was unable to see the genjutsu and remains unaffected"
				return
			var
				c=CCost; mx=c; s=U.SS
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("Sutendomira",(CooldownCur*U.cooldownmultiplier)+s,1)) return
			if(ChakraUseCheck()) c *= 3
			if(U.GenjutsuTrue > 100000)
				s = 0
			else
				U.icon_state="seals"
				spawn(s+1)
					U.icon_state=null
					U.JutsuSeals(s)
			U.firing=1
			spawn(s)
				if(M)
					spawn(2)U.firing=0
					if(prob(U.ChakraControl))
						U.JutsuSeals(s); U.JutsuGen(c);
						U.MoveUses[name]++
						U.JutsuUseChakra(c);
						if(U.PracticeMode || ControlCheck(U))
							U.JutsuMessage(Description["title"])
							return ..()
						if(U.GenjutsuTrue < 50000)
							U.JutsuMessage(Description["title"])
						else
							U << "You used [Description["title"]]"
						if(istype(M,/mob/Hittable/Responsive)&&!(U in M.HitList))
							M.HitList+=U
						U.FakeEye(M,Duration)
					else
						c-=rand(1,mx/2); U.Chakra-=c
						U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"
						return
					..()
	verb
		Sutendomira_Release()
			if(usr.FakeEyeTgt)
				usr.FakeEyeTgt.ReleaseFakeEye()
			else
				usr << "You do not have any targets under it's affects"

mob
	Hittable/Command/Genjutsu/FakeView
		density = 1
		CantHenge = 1
		Cross(A)
			if(ismob(A))
				if(istype(A,/mob/player)||istype(A,/mob/Hittable))
					return 1
			else
				.=..()

	proc

		FakeEye(mob/M, DUR)
			if(M.client)
				if(M.Genjutsu > Genjutsu*2)
					M << "You skillfully avoided the effects of the Sutendomira from [src]"
					return
				else if(M.Genjutsu > Genjutsu*0.9)
					M << "The world has suddenly become distorted"
					sleep(20)
				else if(Class["Sensory-Nin"])
					M << "The Chakra signatures of all shinobi within range have disappeared"
					sleep(10)

				sleep(10)
				src << "<b>[M] is now under the affect of the Sutendomira</b>"
				if(M.Genjutsu > Genjutsu*0.8)
					if(M.Dispel)
						M << "You dispeled the threat of [src]'s Sutendomira"
						return
					if(M.ReverseGenjutsu)
						M.FakeEye(src, DUR)
						return
				M.InIllusion = 1
				M.Targeting = null
				if(M.client)
					for(var/image/x in M.client.images) // first, check to see if your have a target.
						if(x.icon=='target.dmi') // if so.
							del(x) // delete it.
				FakeEyeTgt = M
				var/mob/Hittable/Command/Genjutsu/FakeView/I = new(M.loc)
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

				M.Projection = I
				M.ControlProjection = 1
				M.OSight = M.sight
				M.sight = 0
				M.see_invisible = 5
				M.InFakeView = Genjutsu
				//M.client.perspective = EYE_PERSPECTIVE;
				M.client.eye = I;

				spawn(DUR)
					M.ReleaseFakeEye()
			else
				M.Projection = src
				M.InFakeView = Genjutsu
				M.InIllusion = 1
				spawn(DUR)
					if(M)
						M.InFakeView = 0
						M.Projection = 0
						M.InIllusion = 0

		ReleaseFakeEye()
			if(client)
				sight = OSight
				OSight = null
				see_invisible = 7+InSharingan+InByakugan
				InFakeView = 0
				InIllusion = 0
					//client.perspective = MOB_PERSPECTIVE|EDGE_PERSPECTIVE;
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
					A.FakeEyeTgt = 0
					Projection = 0
			else
				InFakeView = 0
				Projection = 0
				InIllusion = 0