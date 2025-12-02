#if DEBUGGING
mob/verb
	SelfLearnTobenaiBoko()
		var/obj/SkillCards/Genjutsu/TobenaiBoko/J=locate(/obj/SkillCards/Genjutsu/TobenaiBoko) in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Tobenai Boko no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Genjutsu/TobenaiBoko(src)
#endif

obj/SkillCards/Genjutsu/TobenaiBoko
	icon_state="card_Tobenai"
	cmdstring="TobenaiBoko"
	CCost = 9000
	Seals = 5
	Range = 5
	Cooldown = 2000
	Duration = 100

	Description = list(
		"about"="Creates the illusion of an enemy attacking the target who resembles the users appearance, attacking while under the illusion causes damage to the target"
		,"title"="Tobenai Boko"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="A"
//		,"pic"='Dispel.png'
	)

	UpgradeChoices = list("Lower Cost","Increase Duration")

	Activate(mob/U)
		if(U.choosingHoming)
			return
		var/mob/M
		if(ismob(U.Targeting)&&!U.Targeting.TreeStump&&get_dist(U.Targeting,U)<= Range)
			M = U.Targeting
		else
			M = U.TargetSelect(Range,1)
		if(M)
			/*U.FakeEnemy(M)
			if(istype(M,/mob/NPC)&&!(U in M.HitList))
				M.HitList+=U
			return*/
			if(GENERICATTACKCHECK(U)||U.ShadowList.len||U.Gokusamaisou||U.mirroring||M.mirroring||U.InMirrors||InvisibilityCheck(U,M))
				return
			if(M.InIllusion)
				U << "[M] is already under the influence of a mind altering genjutsu"
				return
			if(M.Blind||M.IsBlinded)
				U << "[M] was unable to see the genjutsu and remains unaffected"
				return
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("TobenaiBoko",(CooldownCur*U.cooldownmultiplier)+s,1)) return
			if(ChakraUseCheck()) c *= 2

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
						U.FakeEnemy(M,Duration)
					else
						c-=rand(1,mx/2); U.Chakra-=c
						U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"
						return
					..()
	verb
		TobenaiBoko_Release()
			if(usr.FakeEnemyTgt)
				usr.FakeEnemyTgt.ReleaseFakeEnemy()
			else
				usr << "You do not have any targets under it's affects"

mob
	proc
		FakeEnemy(mob/M, DUR)
			if(M.Genjutsu > Genjutsu*2)
				M << "You skillfully avoided the effects of the Tobenai Boko from [src]"
				return
			else if(M.Genjutsu > Genjutsu*0.9)
				M << "The world has suddenly become distorted"
				sleep(20)
			else if(Class["Sensory-Nin"])
				M << "The Chakra of the incoming shinobi has no chakra signature"
				sleep(10)

			sleep(10)
			if(M.Genjutsu > Genjutsu*0.8)
				if(M.Dispel)
					M << "You dispeled the threat of [src]'s Tobenai Boko"
					return
				if(M.ReverseGenjutsu)
					M.FakeEnemy(src,DUR)
					return
			src << "<b>[M] is now under the affect of the Tobenai Boko</b>"
			M.Targeting = null
			if(M.client)
				for(var/image/x in M.client.images) // first, check to see if your have a target.
					if(x.icon=='target.dmi') // if so.
						del(x) // delete it.
			FakeEnemyTgt = M
			var/mob/Hittable/Command/Genjutsu/FakeEnemy/I = new(loc)
			I.Creator = src
			I.movespeed = movespeed
			I.setspeed = setspeed
			I.equippedweight = equippedweight
			I.name = "[name]"
			I.Taijutsu = Taijutsu
			I.Village = Village
			I.NinjaRank = NinjaRank
			I.ChakraControl = 100
			I.Chakra = 10000000000000
			I.Stamina = 10000000000000
			I.WW = 1
			I.invisibility = 100
			M.Projection = I
			M.InFakeEnemyView = Genjutsu
			M.InIllusion = 1

			var/icon/IC = icon(icon)
			for(var/A in overlays)
				if(A:icon)
					IC.Blend(icon(A:icon),ICON_OVERLAY)
			I.icon = IC
			var/image/IM = image(IC,I)
			M << IM

			I.AttackTarget += M
			I.AI()
			if(M)
				if(M.client)
					if(M.Targeting == src)
						M.SetTarget(I)
					else
						M.DeleteTarget()
					M.see_invisible = 6
					spawn(DUR)
						if(M)
							src << "The effects of Tobenai Boko on [M] have ended"
							M << "[src]'s Tobenai Boko has ended"
							M.ReleaseFakeEnemy()
				else
					spawn(DUR)
						if(M)
							src << "The effects of Tobenai Boko on [M] have ended"
							M.ReleaseFakeEnemy()

		ReleaseFakeEnemy()
			see_invisible = 7+InSharingan+InByakugan
			InFakeEnemyView = 0
			InIllusion = 0
			if(Targeting)
				DeleteTarget()
			if(Projection)
				var/mob/A = Projection.Creator
				if(A)
					A.FakeEnemyTgt = null
				Projection.loc = null
				Projection.Creator = null
				walk(Projection,0)
				del Projection
				Projection = null