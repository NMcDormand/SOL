mob/var/tmp/InDoumu
obj/SkillCards/Ninjutsu/Doton/DorouDoumu
	icon_state="card_doroudoumu"
	cmdstring="DorouDoumu"
	Range=2
	CCost=3000
	Seals=10
	Cooldown = 1600

	Description = list(
		"about"="Encase your opponent in earth and sap their chakra."
		,"title"="Doton: Dorou Doumu"
		,"type"="Ninjutsu"
		,"Element"="Earth"
		,"weak"="Lightning"
		,"rank"="C"
//		,"pic"='DorouDoumu.png'
		)

	UpgradeChoices = list("Lower Cooldown","Lower Cost","Lower Cost","Increase Range")

	Activate(mob/U)
		if(U.DorouDoumu) {U.DorouDoumu=0; return}
		if(GENERICATTACKCHECK(U)) return
		if(U.onwater) {U<<"Cannot do this on water."; return}
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("DorouDoumu",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(70)U.firing=0
			if(prob(U.ChakraControl))
				U.CantWalk++; spawn(8)U.CantWalk--
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.ElementalUp("Earth")
				if(U.PracticeMode || ControlCheck(U)) return ..()

				U.DorouDoumu=1
				var/turf/t=get_step(U,U.dir);
				if(t.density)
					U<<"There was not enough space to complete the Jutsu"
					U.Cooldowns -= "DorouDoumu"
					return
				var/obj/AIM=new(t)
				for(var/i = 1 to Range)
					t=get_step(t,U.dir);
					if(!t || t.density)
						break
					AIM.loc=get_step(t,U.dir)

				var/list/DorouList=list()
				var/list/DorouListAll=list(AIM)
				var/list/BackWall=list()
				var/list/CapturedPeople=list()

				for(var/turf/T in range(Range,AIM))
					var/area/AR = T.loc
					if(AR && AR.NoGo || T.density)
						continue
					if(get_dist(AIM,T) == Range)
						var/DIR = get_dir(T,AIM)
						var/obj/Destructable/Doton/DorouWall/DO
						switch(DIR)
							if(NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST)
								DO=new/obj/Destructable/Doton/DorouWall/Corner
							if(NORTH, SOUTH, EAST, WEST)
								DO=new/obj/Destructable/Doton/DorouWall/Wall

						DO.dir = DIR
						DO.Owner=U
						DO.loc=T
						if(get_dist(AIM.loc,U)>Range*2)
							var/healthvar=((U.Ninjutsu*0.03) * (U.EarthElemental*0.5))
							if(healthvar>U.StaminaMax) healthvar=U.StaminaMax
							DO.HEALTH=healthvar*0.5
							DO.EarthElemental=U.EarthElemental
							BackWall+=DO
						else
							DO.CantDamage=1
						IDCOPY(DO,U)
						DorouList+=DO
						DorouListAll+=DorouList
					else
						var/obj/Destructable/Doton/DorouWall/Middle/m=new/obj/Destructable/Doton/DorouWall/Middle(T)
						if(m.loc!=AIM.loc) {m.dir=get_dir(m,AIM); m.icon_state="inner"}
						m.Owner=U; DorouListAll+=m

				for(var/mob/p in range(Range-1,AIM))
					if(!(IDCHECK(p,U)) && !istype(p,/mob/Hittable/Unresponsive/Training) && !istype(p,/mob/Hittable/Command/Genjutsu))
						if(p.NinjaRank != "Academy Student")
							CapturedPeople+=p
							spawn(5)
								DorouDoumu_Captured(p,U,AIM)
				DorouDoumu_BreakCheck(U,DorouListAll,BackWall,CapturedPeople,AIM)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

proc
	DorouDoumu_Captured(mob/v,mob/u,obj/J)
		set waitfor = 0
		var/D=u.ChakraMax*0.05
		var/damage=JutsuDamage(u.Ninjutsu,v.Ninjutsu,u.EarthElemental,v.WindElemental)
		v.InDoumu=1
		while(u.DorouDoumu)
			if(!v||!u||get_dist(v,J)>1) break
			v.Chakra-=D
			if(v.Chakra<=0)
				v.Stamina-=D
			else if(u.Chakra<u.ChakraMax)
				u.Chakra+=D
				if(u.Chakra>u.SetMaxChakra()) u.Chakra=u.SetMaxChakra()
			v.DamageMe(u,damage,"Dorou Doumu")
			sleep(30)
			if(!u||!v)
				break
		if(v)
			v.InDoumu=0

	DorouDoumu_BreakCheck(mob/u,list/objects,list/BackWall,list/CP,obj/J)
		while(u.DorouDoumu)
			if(!u||!J) break
			var/l=0
			for(var/mob/c in CP)
				l++
				if(c.KO||c.dead||get_dist(c,J)>1)
					CP-=c; c.InDoumu=0
			if(!length(CP)||!l) break
			l=0
			for(var/obj/w in BackWall) l++
			if(l!=3)break
			sleep(20)
			if(!u||!J)
				break
		for(var/obj/o in objects)
			del(o)
		if(u)
			u.DorouDoumu=0