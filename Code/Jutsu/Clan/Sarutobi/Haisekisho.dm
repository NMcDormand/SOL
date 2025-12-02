#if DEBUGGING
mob/verb
	SelfLearnHaisekisho()
		var/obj/SkillCards/Clan/Sarutobi/Haisekisho/J=locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Katon: Haisekisho no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Sarutobi/Haisekisho(src)
#endif

obj/SkillCards/Clan/Sarutobi/Haisekisho
	icon_state="card_Haisekisho"
	cmdstring="Haisekisho"
	Range=4
	CCost=1500
	Seals=20
	DM = 1
	Shots = 1
	Cooldown = 3000
	var/tmp/Triggered=0

	Description = list(
		"about"="Create a smoke screen that can be triggered to explode by the user"
		,"title"="Katon: Haisekisho"
		,"type"="Ninjutsu"
		,"Element"="Fire"
		,"weak"="Water"
		,"rank"="B"
//		,"pic"='Housenka.png'
		)

	UpgradeChoices = list("Increase Damage","Increase Range")

	Activate(mob/U)
		if(U.HaiseList.len)
			if(!Triggered)
				U.HaiseMovers = 0
				Triggered = 1
				spawn(100)
					Triggered = 0
				U.HaiseTrigger()
				U.HaiseList = list()
		else
			if(GENERICATTACKCHECK(U)) return
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("Haisekisho",(CooldownCur*U.cooldownmultiplier)+s,1)) return
			if(ChakraUseCheck()) c *= 4
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				spawn(1)U.icon_state=null
				spawn(4)U.firing=0
				if(prob(U.ChakraControl))
					U.JutsuMessage(Description["title"])
					U.JutsuSeals(s);
					U.JutsuNin(c);
					U.MoveUses[name]++
					U.JutsuUseChakra(c);
					U.ElementalUp("Fire")
					if(U.PracticeMode || ControlCheck(U))
						return ..()

					var/list/Tiles = list()
					for(var/turf/T in view(Range,U))
						if(T.density)
							continue
						Tiles += T

					new/obj/Jutsu/Katon/Haisekisho(U.loc,U,src)
					sleep(2)
					for(var/i = 1 to Range)
						for(var/turf/I in Tiles)
							if(get_dist(I,U) == i)
								spawn(-1)
									new/obj/Jutsu/Katon/Haisekisho(I,U,src)
						sleep(5)

				else {c-=rand(1,mx/2); usr.Chakra-=c; usr<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

mob
	var
		tmp
			list/HaiseList = list()
			HaiseMovers = 0
	proc
		HaiseTrigger()
			var/obj/Jutsu/Katon/Haisekisho/H = pick(HaiseList)
			H.Trigger()

obj/Jutsu/Katon/Haisekisho
	var
		StepsTaken = 0
		Range = 3
		ODIR
		SC
		Triggered=0

	layer = MOB_LAYER+1
	icon = 'Haisekisho.dmi'
	New(LOC,mob/M,obj/SkillCards/S)
		..()
		loc = LOC
		alpha = rand(153,255)
		icon_state = "Ash"
		Ninjutsu = M.Ninjutsu*0.2
		Taijutsu = M.Taijutsu
		FireElemental = (M.FireElemental*0.2) * S.DM
		SC = S
		ODIR = M.dir
		if(isobj(M))
			var/obj/Jutsu/M2 = M
			Owner = M2.Owner
		else
			Owner = M
		Owner.HaiseList += src

		IDCOPY(src,M)
		dir = ODIR
		movespeed = S.Speed
		spawn(5)
			icon_state = "Smoke"

	Move()
		var/turf/OT = loc
		.=..()
		new/obj/Jutsu/Katon/Haisekisho(OT,Owner,SC)

	CrossedMe(M)
		if(ismob(M))
			//do stuff
		else if(istype(M,/obj/Jutsu/Katon/Haisekisho))
			var/obj/Jutsu/Katon/Haisekisho/K = M
			if(IDCHECK(K,src))
				var/icon/I = icon(icon)
				I.Blend(icon(K.icon),ICON_OVERLAY)
				icon = I
				FireElemental += K.FireElemental
				spawn(5)
					del K

	Del()
		if(Owner)
			Owner.HaiseList -= src
		..()

	proc
		Trigger()
			set waitfor = 0
			icon = null
			icon = icon('Haisekisho.dmi')
			icon_state = "Flames"
			layer = MOB_LAYER-1
			alpha = 255
			Triggered=1
			spawn(pick(1,2,3))
				for(var/obj/Jutsu/Katon/Haisekisho/K in range(1,src))
					if(K==src||K.Triggered||!(IDCHECK(K,src)))
						continue
					else
						if(K)
							K.Triggered = 1
							K.Trigger()
			if(!Owner)
				del src
			for(var/mob/M in loc)
				if(M.kaiten||M.MushiKabe||M.InMeatTank||M.protect||M.InGatsuuga||M.InTsuuga||M.InGarouga)//||M == Owner||IDCHECK(M,src))
					continue
				if(NINIGNORELIST(M))
					continue
				if(Owner.HitCheck(M))
					var/D = JutsuDamage(Ninjutsu,M.Ninjutsu,FireElemental,M.WaterElemental,3)
					M.DamageMe(Owner,D,"HaiseBlow")
			for(var/i=1 to 20)
				for(var/mob/M in loc)
					if(NINIGNORELIST(M))
						continue
					if(M.kaiten||M.MushiKabe||M.InMeatTank||M.protect||M.InGatsuuga||M.InTsuuga||M.InGarouga)//||M == Owner||IDCHECK(M,src))
						continue
					var/D = JutsuDamage(Ninjutsu,M.Ninjutsu,FireElemental,M.WaterElemental,2)
					M.DamageMe(Owner,D,"HaiseFlames")
				sleep(10)
			del src