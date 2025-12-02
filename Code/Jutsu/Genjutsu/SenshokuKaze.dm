#if DEBUGGING
mob/verb
	SelfLearnSenshokuKaze()
		var/obj/SkillCards/Genjutsu/SenshokuKaze/J=locate(/obj/SkillCards/Genjutsu/SenshokuKaze) in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Senshoku Firudo no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Genjutsu/SenshokuKaze(src)
#endif

obj/SkillCards/Genjutsu/SenshokuKaze
	icon_state="card_Kaze"
	cmdstring="SenshokuKaze"
	CCost=22000
	Seals=8
	Cooldown = 2500

	Description = list(
		"about"="Creates illusionary clones that disorient the targetted shinobi, it can be dispeled. Any attacks to the clones will cause damage to the attacker"
		,"title"="Senshoku Kaze"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="A"
//		,"pic"='Dispel.png'
		)

	UpgradeChoices = list("More Clones","Increase Duration")

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
				U << "[M] is already under the influence of a mind altering genjutsu"
				return
			if(M.Blind||M.IsBlinded)
				U << "[M] was unable to see the genjutsu and remains unaffected"
				return
			var
				c=CCost; mx=c; s=U.SS * Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("SenshokuKaze",(CooldownCur*U.cooldownmultiplier)+s,0)) return
			if(ChakraUseCheck()) c *= 3
			if(U.GenjutsuTrue > 100000)
				s = 1
			else
				U.icon_state="seals"
				spawn(s+10)
					U.icon_state=null
					U.JutsuSeals(s)
			U.firing=1
			spawn(s)
				if(M)
					spawn(2)U.firing=0
					if(prob(U.ChakraControl))
						U.JutsuGen(c*0.2);
						U.MoveUses[name]++
						U.JutsuUseChakra(c,0.05);

						if(U.PracticeMode || ControlCheck(U))
							U.JutsuMessage(Description["title"])
							return ..()
						if(U.GenjutsuTrue < 50000)
							U.JutsuMessage(Description["title"])
						else
							U << "You used [Description["title"]]"

						if(istype(M,/mob/Hittable/Responsive)&&!(U in M.HitList))
							M.HitList+=U
						U.SenshokuKaze(M,Shots,Duration)
					else
						c-=rand(1,mx/2); U.Chakra-=c
						U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"
						return
					..()

mob
	proc
		SenshokuKaze(mob/M,Shots,DUR)
			set waitfor = 0
			var/list/FEList = list()
			if(M.client)
				if(M.Genjutsu > Genjutsu*1.2)
					M << "The world has suddenly become distorted"
					if(M.ReverseGenjutsu)
						M.SenshokuKaze(src,Shots,DUR)
						return
				else if(Class["Sensory-Nin"])
					M << "The incoming shinobi have no chakra signature"

				M.InIllusion = 1
				M.Targeting = null
				/*for(var/image/x in M.client.images) // first, check to see if your have a target.
					if(x.icon=='target.dmi') // if so.
						del(x) // delete it.
						*/

				var/icon/IC = icon(icon)
				for(var/A in overlays)
					IC.Blend(icon(A:icon),ICON_OVERLAY)

				var/list/Turfs = list()
				for(var/turf/T in view(5))
					if(T.density)
						continue
					else
						Turfs += T
				for(var/i=1 to Shots)
					if(!Turfs.len)
						break
					var/turf/CT = pick(Turfs)
					Turfs -= CT

					var/mob/Hittable/Command/Genjutsu/FakeEnemy/I = new(CT)
					FEList += I
					I.Creator = src
					I.Rank = trueName
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
					I.invisibility = 50
					I.icon = IC

					var/image/IM = image(IC,I)
					M << IM

					I.AttackTarget += M
					spawn(0)
						var/A = 1
						for(var/b=1 to 10)
							if(M)
								if(A)
									walk_away(I,M)
									A = 0
									sleep(10*DUR)
								else
									walk_to(I,M)
									A = 1
									sleep(30*DUR)
							else
								del I
								break

				M.see_invisible -= 2
				M.InSenKaze = FEList
				M.SenKazeBreak = Genjutsu

				spawn(200)
					if(M)
						M.InSenKaze = 0
					if(!src)
						for(var/mob/Hittable/Command/Genjutsu/FakeEnemy/A in FEList)
							walk_to(A,0)
							A.Creator = null
							A.loc = null
							A.AttackTarget = 0
						return
				while(M.InSenKaze && src)
					if(M)
						sleep(10)
					else
						break
				if(M)
					M.ReleaseSenKaze()

				for(var/mob/Hittable/Command/Genjutsu/FakeEnemy/A in FEList)
					walk_to(A,0)
					A.Creator = null
					A.loc = null
					A.AttackTarget = 0
			else
				M.InSenKaze = 1
				M.SenKazeBreak = Genjutsu
				M.InIllusion = 1

				for(var/i=1 to 20)
					if(M)
						if(M.SenshokuDispel)
							M.InSenKaze = 0
							M.InIllusion = 0
							return
						else
							sleep(10)
					else
						break

		ReleaseSenKaze()
			see_invisible += 2
			InSenKaze = 0
			SenKazeBreak = 0
			InIllusion = 0
			SenshokuDispel = 0
			if(Targeting)
				DeleteTarget()