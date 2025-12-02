//Senshoku firudo //Area Illusion escape
#if DEBUGGING
mob/verb
	SelfLearnSenshokuFirudo()
		var/obj/SkillCards/Genjutsu/SenshokuFirudo/J=locate(/obj/SkillCards/Genjutsu/SenshokuFirudo) in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Senshoku Firudo no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Genjutsu/SenshokuFirudo(src)
#endif

obj/SkillCards/Genjutsu/SenshokuFirudo
	icon_state="card_Firudo"
	cmdstring="SenshokuFirudo"
	CCost=30000
	Seals=12
	Cooldown = 3000
	Range = 6
	Shots = 8
	Duration = 1

	Description = list(
		"about"="Creates a field of illusionary clones that disorient all within range, it cannot be avoided. Any attacks to the clones will cause damage to the attacker"
		,"title"="Senshoku Firudo"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="A"
//		,"pic"='Dispel.png'
		)

	UpgradeChoices = list("More Clones","Increase Duration","Increase Range")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U))
			return
		var
			c=CCost; mx=c; s=U.SS * Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("SenshokuFirudo",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 2
		if(U.GenjutsuTrue > 100000)
			s = 1
		else
			U.icon_state="seals"
			spawn(s+10)
				U.icon_state=null
		U.firing=1
		spawn(s)
			spawn(2)U.firing=0
			U.JutsuSeals(s)
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
				U.Firudo(Range,Duration,Shots)
			else
				c-=rand(1,mx/2); U.Chakra-=c
				U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"
				return
			..()

mob
	proc
		Firudo(Range=6,DUR=1,Shots=8)
			var/list/Turfs = list()
			var/list/Mobs = list()
			var/list/Players = list()
			var/list/ALLMobs = list()
			for(var/atom/T in view(Range, src))
				if(isturf(T))
					if(T.density)
						continue
					else
						Turfs += T
				if(ismob(T))
					if(istype(T,/mob/Hittable/Command/Genjutsu/FakeEnemy)||istype(T,/mob/Hittable/Command/Genjutsu/FakeView)||T==src)
						continue
					else
						var/mob/M = T
						if(IDCHECK(src,M))
							continue
						if(M.InIllusion)
							continue
						if(M.Blind||M.IsBlinded||M.TreeStump)
							continue
						if(M.Genjutsu > Genjutsu*1.4)
							if(M.client)
								M << "You skillfully avoided the effects of [src]'s illusion"
							continue
						else
							if(M.client)
								Players += T
							else
								Mobs += T
							ALLMobs += T

			if(!ALLMobs.len||!Turfs.len)
				return

			var/icon/IC = icon(icon)
			for(var/A in overlays)
				IC.Blend(icon(A:icon),ICON_OVERLAY)
			var/FEList = list()
			var/list/IMGList = list()
			for(var/i=1 to Shots)
				if(!ALLMobs.len||!Turfs.len)
					break

				var/turf/CT = pick(Turfs)
				Turfs -= CT

				var/mob/Hittable/Command/Genjutsu/FakeEnemy/I = new(CT)
				FEList += I
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
				I.Genjutsu = Genjutsu * 1.2
				I.WW = 1
				I.invisibility = 50
				I.icon = IC
				I.AttackTarget = ALLMobs.Copy()

				var/image/IM = image(IC,I)
				IMGList += IM
				spawn(0)
					var/A = 1
					var/mob/B = pick(I.AttackTarget)
					if(B && I)
						for(var/c=1 to 4)
							if(!ALLMobs.len || !B || !I)
								break
							if(B.Genjutsu > I.Genjutsu)
								if(B.Dispel)
									if(B.InFirudo)
										B.see_invisible += 2
										B.InFirudo = 0
										B.InIllusion = 0
									for(var/mob/M in FEList)
										I.AttackTarget -= B
									if(I.AttackTarget.len)
										B = pick(I.AttackTarget)
									else
										del I
								if(B.ReverseGenjutsu)
									if(B.InFirudo)
										B.see_invisible += 2
										B.InFirudo = 0
										B.InIllusion = 0
									for(var/mob/M in FEList)
										del I
									B.SenshokuKaze(src,Shots,DUR)
									return
							if(A == 1)
								walk_away(I,B)
								A = 2
								sleep(5*DUR)
							else if(A == 2)
								walk_rand(I,1)
								A = 3
								sleep(30*DUR)
							else
								B = pick(I.AttackTarget)
								walk_to(I,B)
								A = 1
								sleep(50*DUR)
					if(I)
						del I

			for(var/mob/player/M in Players)
				if(M.Genjutsu > Genjutsu*1.2)
					M << "The world has suddenly become distorted"
				else if(Class["Sensory-Nin"])
					M << "The Chakra incoming shinobi has no chakra signature"

				for(var/image/IM in IMGList)
					M << IM
				M.Targeting = null
				for(var/image/x in M.client.images) // first, check to see if your have a target.
					if(x.icon=='target.dmi') // if so.
						del(x) // delete it.
				M.see_invisible -= 2
				M.InFirudo = 1
				spawn(DUR)
					if(M.InFirudo)
						M.see_invisible += 2
						M.InFirudo = 0
						M.InIllusion = 0
			for(var/mob/M in Mobs)
				if(istype(M,/mob/NPC)&&!(src in M.HitList))
					M.HitList+=src
				M.InFirudo = pick(FEList)
				spawn(80)
					if(M)
						M.InFirudo = 0
						M.InIllusion = 0
