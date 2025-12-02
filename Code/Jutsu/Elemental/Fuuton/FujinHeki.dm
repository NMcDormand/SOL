#if DEBUGGING
mob/verb
	SelfLearnFujinHeki()
		var/obj/SkillCards/Ninjutsu/Fuuton/FujinHeki/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Fuuton: Fujin Heki no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Fuuton/FujinHeki(src)
			new/obj/SkillCards/Ninjutsu/Fuuton/FujinHekiRelease(src)
#endif

obj/SkillCards/Ninjutsu/Fuuton/FujinHekiRelease
	icon_state="card_FujinHekiRelease"
	cmdstring="FujinHekiRelease"
	Range=0
	CCost=0
	Seals=0
	CanLevel = 0

	Description= list(
		"about"="Creates a Wind Shield capable of reducing incoming damage and Redirecting incoming jutsus"
		,"title"="Fuuton: Fujin Heki - Release"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="B"
		//,"pic"='Bunshin.png'
	)

obj/SkillCards/Ninjutsu/Fuuton/FujinHeki
	icon_state="card_FujinHeki"
	cmdstring="FujinHeki"
	CCost=1200
	Range = 1
	Seals=12
	Cooldown = 1200

	Description= list(
		"about"="Creates a Wind Shield capable of reducing incoming damage and Redirecting incoming jutsus"
		,"title"="Fuuton: Fujin Heki"
		,"type"="Ninjutsu"
		,"Element"="Wind"
		,"weak"="Fire"
		,"rank"="B"
		//,"pic"='Bunshin.png'
	)

	UpgradeChoices = list("Lower Cost","Lower Cooldown","Lower Cost","Increase Range")

	Activate(mob/U)
		if(U.InFujinHeki)
			U.InFujinHeki = 0
			return
		if(GENERICATTACKCHECK(U))
			return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("FujinHeki",(CooldownCur*U.cooldownmultiplier)+s,0)) return
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
				U.ElementalUp("Wind")
				if(U.PracticeMode) return ..()
				U.FujHeki(c * 3, Range)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

mob
	var/tmp
		list/FujinHekiList
		InFujinHeki = 0
	proc
		FujHekiDrain()
			set waitfor = 0

		FujHeki(COST = 3000,RNG = 1)
			FujinHekiList=list()
			var/F = round(0.9*(Ninjutsu + WindElemental))
			InFujinHeki = 1
			for(var/turf/T in orange(RNG))
				//var/obj/Jutsu/FujinHeki/FH = new(T,src,F)
				if(!T.density)
					new/obj/Jutsu/FujinHeki(T,src,F)
			while(InFujinHeki)
				if(Chakra < COST)
					if(Chakra < 0)
						Chakra = 0
					src<<"You do not have enough Chakra to sustain the Fujin Heki!"
					break
				Chakra-=COST
				JutsuChakra(400);
				StatUpdate_chakra()
				sleep(5)
			for(var/obj/O in FujinHekiList)
				del O
			FujinHekiList = 0
			InFujinHeki = 0


obj
	Jutsu
		FujinHeki
			icon='Tornado.dmi'
			icon_state=""
			pixel_x=-16
			layer=MOB_LAYER+1||OBJ_LAYER+1
			var
				Force = 0

			New(LOC,mob/O,F)
				loc = LOC
				Owner = O
				Force = F
				WindElemental = O.WindElemental
				O.FujinHekiList += src
				..()

			Del()
				var/mob/M = Owner
				M.FujinHekiList -= src
				if(!M.FujinHekiList.len)
					M.FujinHekiList = 0
				Owner = 0
				loc = null
				sleep(10)
				..()

			Cross(var/atom/movable/A)
				if(ismob(A))
					if(Owner == A)
						return 0
					var/mob/M = A
					if(M.Taijutsu >= Force)
						return 1
					if(M.Taijutsu <= (Force *0.8))
						var/DIR = 0
						switch(get_dir(A,src))
							if(NORTH)
								DIR = pick(NORTHWEST,NORTHEAST,EAST,WEST)
							if(NORTHWEST)
								DIR = pick(NORTH,WEST)
							if(NORTHEAST)
								DIR = pick(SOUTH,EAST)
							if(SOUTH)
								DIR = pick(SOUTHWEST,SOUTHEAST,EAST,WEST)
							if(SOUTHWEST)
								DIR = pick(SOUTH,WEST)
							if(SOUTHEAST)
								DIR = pick(SOUTH,EAST)
							if(EAST)
								DIR = pick(NORTH,NORTHEAST,SOUTH,SOUTHEAST)
							if(WEST)
								DIR = pick(NORTH,NORTHWEST,SOUTH,SOUTHWEST)
						var/TS = pick(3,5,7)
						M.DamageMe(Owner,Force,"FuujinHeki")
						spawn(0)
							for(var/i = 1 to TS)
								if(step(A,DIR))
									A.dir=get_dir(A,src)
									sleep(1)
								else
									break
						return 0
					else
						M.DamageMe(Owner,Force,"FuujinHeki")
						return 0
				else if(istype(A,/obj/Jutsu/Nara))
					return 1
				else if(istype(A,/obj/Jutsu))
					var/obj/Jutsu/o = A
					if(o.FireElemental)
						o.FireElemental+=WindElemental*5
						return 1
					else
						switch(get_dir(A,src))
							if(NORTH)
								walk(A,pick(NORTHWEST,NORTHEAST,EAST,WEST))
							if(NORTHWEST)
								walk(A,pick(NORTH,WEST))
							if(NORTHEAST)
								walk(A,pick(SOUTH,EAST))
							if(SOUTH)
								walk(A,pick(SOUTHWEST,SOUTHEAST,EAST,WEST))
							if(SOUTHWEST)
								walk(A,pick(SOUTH,WEST))
							if(SOUTHEAST)
								walk(A,pick(SOUTH,EAST))
							if(EAST)
								walk(A,pick(NORTH,NORTHEAST,SOUTH,SOUTHEAST))
							if(WEST)
								walk(A,pick(NORTH,NORTHWEST,SOUTH,SOUTHWEST))
						return 0
				else if(isobj(A))
					var/obj/o = A
					if(istype(o,/obj/Weapon/Wield))
						switch(get_dir(A,src))
							if(NORTH)
								walk(A,pick(NORTHWEST,NORTHEAST,EAST,WEST))
							if(NORTHWEST)
								walk(A,pick(NORTH,WEST))
							if(NORTHEAST)
								walk(A,pick(SOUTH,EAST))
							if(SOUTH)
								walk(A,pick(SOUTHWEST,SOUTHEAST,EAST,WEST))
							if(SOUTHWEST)
								walk(A,pick(SOUTH,WEST))
							if(SOUTHEAST)
								walk(A,pick(SOUTH,EAST))
							if(EAST)
								walk(A,pick(NORTH,NORTHEAST,SOUTH,SOUTHEAST))
							if(WEST)
								walk(A,pick(NORTH,NORTHWEST,SOUTH,SOUTHWEST))
						return 0
					else if(istype(o,/obj/Clay))
						var/obj/Clay/C = o
						C.ExplodeClay()
					else
						return 0