#if DEBUGGING
mob/verb
	SelfLearnYomiNuma()
		var/obj/SkillCards/Ninjutsu/Doton/YomiNuma/J=locate(/obj/SkillCards/Ninjutsu/Doton/YomiNuma) in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Doton Yomi Numa no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Doton/YomiNuma(src)
			new/obj/SkillCards/Ninjutsu/Doton/YomiNumaRelease(src)

#endif

obj/SkillCards/Ninjutsu/Doton/YomiNumaRelease
	icon_state="card_YomiNumaRelease"
	cmdstring="YomiNumaRelease"
	Range=0
	CCost=0
	Seals=0
	CanLevel = 0

	Description= list(
		"about"="This will release your Yomi Numa Technique"
		,"title"="Doton: Yomi Numa - Release"
		,"type"="Ninjutsu"
		,"Element"="Lightning"
		,"weak"="Water"
		,"rank"="B"
		,"pic"='Bunshin.png'
	)

	Activate(mob/U)
		if(U.MySwamp)
			var/area/Swamp/ThisSwamp = U.MySwamp
			ThisSwamp.SwampEnd()

obj/SkillCards/Ninjutsu/Doton/YomiNuma
	icon_state="card_YomiNuma"
	cmdstring="YomiNuma"
	Range=2
	CCost=10000
	Seals=20
	Cooldown = 3000

	Description= list(
		"about"="This jutsu creates a swamp that paralyzes anyone within its reach"
		,"title"="Doton: Yomi Numa"
		,"type"="Ninjutsu"
		,"Element"="Earth"
		,"weak"="Lightning"
		,"rank"="A"
		//,"pic"='Bunshin.png'
	)

	UpgradeChoices = list("Increase Range","Lower Cooldown")

	Activate(mob/U)
		if(U.onwater) {U<<"Cannot do this on water."; return}
		if(U.MySwamp)
			U << "you cant create another swamp"
			return
		if(U.SwampTrapped||GENERICATTACKCHECK(U))
			return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("YomiNuma",(CooldownCur*U.cooldownmultiplier)+s)) return
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			if(U)
				if(prob(U.ChakraControl))
					U.CantWalk++
					U.JutsuMessage(Description["title"])
					U.JutsuSeals(s); U.JutsuNin(c*0.01);
					U.MoveUses[name]++
					U.JutsuUseChakra(c);
					U.ElementalUp("Earth")
					if(U.PracticeMode)
						U.icon_state=null
						U.firing=0
						U.CantWalk--
						return ..()
					U.createSwamp(Range)
					spawn(1)
						U.icon_state=null
						U.firing=0
						U.CantWalk--
				else
					c-=rand(1,mx/2); U.Chakra-=c
					U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"
				..()

mob
	var/tmp
		InSwamp = 0
		SwampTrapped = 0
		MySwamp = 0

	proc
		createSwamp(var/range)
			var/area/Swamp/NewSwamp = new/area/Swamp()
			NewSwamp.name = "[name]'s Swamp"
			NewSwamp.Owner = src
			MySwamp = NewSwamp
			var/list/TurfList = list()
			for(var/turf/I in range(src,range))
				if(I.density||I.iswamp||istype(I.loc,/area/Water)||istype(I.loc,/area/Waterfall))
					continue
				TurfList += I

			for(var/i = 0 to range)
				for(var/turf/I in TurfList)
					if(get_dist(I,src) != i)
						continue
					var/area/CAREA = I.loc
					I.OAREA = CAREA
					I.iswamp = 1

					NewSwamp.contents += I
					TurfList -= I

					for(var/mob/M in I)
						if(!M.TreeStump)
							CAREA.Exited(M)
							NewSwamp.Entered(M)
				sleep(10)

		SwampTrapped()
			set waitfor = 0
			InSwamp++
			while(InSwamp)
				if(SwampTrapped)
					InSwamp++
					if(NinjaRank != "Academy Student")
						if(prob(20))
							Wounds+=pick(1,2,3)
							StatUpdate_wounds()
					sleep(10)
				else
					InSwamp--
					sleep(3)
			if(InSwamp<0)
				InSwamp = 0
			src << "You have been freed from the effects of the swamp"

turf
	var
		tmp
			iswamp = 0
			area/OAREA = 0

area
	Swamp
		icon='Swamp.dmi'
		icon_state="1,3"
		layer = 2
		var
			EndTimer = 10
			OwnerIn = 0
			Draining = 0
			mob/Owner = 0
			Ending = 0

		proc
			SwampDrain()
				set waitfor = 0
				var/mob/M = Owner
				if(Draining)
					return
				var/ET = 10 - EndTimer
				if(ET)
					var/ETT = ET*2000
					if(M.Chakra >= ETT)
						M.Chakra -= ETT
						M << "You poured [ETT] of your chakra to repair the swamp"
						M.JutsuChakra(10*ET)
						M.StatUpdate_chakra()
					else
						M << "You didnt have enough chakra to repair the swamp"
				Draining = 1

				while(OwnerIn)
					if(M)
						if(M.KO||M.dead||Ending)
							break
						else if(M.Chakra >= 2000)
							M.Chakra -= 2000
							M.JutsuChakra(10)
							M.StatUpdate_chakra()
							if(Draining == 5)
								M << "Your swamp continues to drain your chakra"
							else if(Draining <=10)
								Draining++
							else
								Draining = 1
							sleep(30)
						else
							break
					else
						M << "You've exhausted your chakra and lose grip of the swamp"
						OwnerIn = 0
						SwampEnd()
						return
				Draining = 0
				while(EndTimer)
					if(Draining)
						return
					else
						EndTimer--
						sleep(10)
				SwampEnd()

			SwampEnd()
				set waitfor = 0
				for(var/turf/I in contents)
					I.iswamp = 0
					contents.Remove(I)
					var/area/CAREA
					if(I.OAREA)
						CAREA = I.OAREA
						CAREA.contents.Add(I)
					for(var/mob/M in I)
						Exited(M)
						M.SwampTrapped = 0
						if(CAREA)
							CAREA.Entered(I)
				if(Owner)
					Owner.MySwamp = 0
					Owner.InSwamp = 0

		Entered(M)
			if(Owner)
				if(!Ending)
					if(ismob(M))
						var/mob/PL = M
						if(Owner == PL)
							if(!OwnerIn)
								OwnerIn = 1
									PL.InSwamp = 0.5
								if(!Draining)
									SwampDrain()
						else
							if(!PL.SwampTrapped)
								PL.SwampTrapped = 1
								if(!PL.InSwamp)
									PL.SwampTrapped()
			else
				SwampEnd()

		Exited(M)
			if(ismob(M))
				var/mob/PL = M
				if(Owner == PL)
					if(OwnerIn)
						OwnerIn = 0
						PL.InSwamp = 0
						PL << "Your swamp begins to recede"
				else
					PL.SwampTrapped = 0
