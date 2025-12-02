#if DEBUGGING
mob/verb
	SelfLearnFusajin()
		var/obj/SkillCards/Ninjutsu/Fuuton/Fusajin/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Fuuton: Fusajin no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Fuuton/Fusajin(src)
#endif

obj/SkillCards/Ninjutsu/Fuuton/Fusajin
	icon_state="card_Fuusaijin"
	cmdstring="Fusajin"
	CCost=500
	Seals=6
	Cooldown = 800
	Duration  = 10

	Description= list(
		"about"="Creates a huge stream of wind"
		,"title"="Fusajin no Jutsu"
		,"type"="Ninjutsu"
		,"Element"="Wind"
		,"weak"="Fire"
		,"rank"="B"
		,"pic"='Bunshin.png'
	)

	UpgradeChoices = list("Increase Duration","Lower Cooldown")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U))
			return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Fusajin",(CooldownCur*U.cooldownmultiplier)+s,0)) return
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
				if(U.PracticeMode || ControlCheck(U)) return ..()
				U.FusajinProc(Duration)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

mob
	var/tmp/FuCreate = 0
	proc
		FusajinProc(DUR=20)
			if(!src)
				return
			var
				X=x
				Y=y
				Z=z
			FuCreate = 1
			switch(dir)
				if(NORTH,SOUTH)
					for(var/i = 1 to 5)
						var/turf/T
						var/obj/Jutsu/Fuuton/Fusajin/FS
						switch(i)
							if(1)
								T = loc
							if(2)
								T = locate(X-1,Y,Z)
							if(3)
								T = locate(X-2,Y,Z)
							if(4)
								T = locate(X+1,Y,Z)
							if(5)
								T = locate(X+2,Y,Z)
						if(T && !T.density)
							FS=new(T,src)
							walk(FS,dir,1)
				if(EAST, WEST)
					for(var/i = 1 to 5)
						var/turf/T
						var/obj/Jutsu/Fuuton/Fusajin/FS
						switch(i)
							if(1)
								T = loc
							if(2)
								T = locate(X,Y+1,Z)
							if(3)
								T = locate(X,Y+2,Z)
							if(4)
								T = locate(X,Y-1,Z)
							if(5)
								T = locate(X,Y-2,Z)
						if(T && !T.density)
							FS=new(T,src)
							walk(FS,dir,1)
				if(NORTHWEST)
					for(var/i = 1 to 5)
						var/turf/T
						var/obj/Jutsu/Fuuton/Fusajin/FS
						switch(i)
							if(1)
								T = loc
							if(2)
								T = locate(X+1,Y,Z)
							if(3)
								T = locate(X+2,Y,Z)
							if(4)
								T = locate(X,Y-1,Z)
							if(5)
								T = locate(X,Y-2,Z)
						if(T && !T.density)
							FS=new(T,src)
							walk(FS,dir,1)
				if(NORTHEAST)
					for(var/i = 1 to 5)
						var/turf/T
						var/obj/Jutsu/Fuuton/Fusajin/FS
						switch(i)
							if(1)
								T = loc
							if(2)
								T = locate(X-1,Y,Z)
							if(3)
								T = locate(X-2,Y,Z)
							if(4)
								T = locate(X,Y-1,Z)
							if(5)
								T = locate(X,Y-2,Z)
						if(T && !T.density)
							FS=new(T,src)
							walk(FS,dir,1)
				if(SOUTHWEST)
					for(var/i = 1 to 5)
						var/turf/T
						var/obj/Jutsu/Fuuton/Fusajin/FS
						switch(i)
							if(1)
								T = loc
							if(2)
								T = locate(X,Y+1,Z)
							if(3)
								T = locate(X,Y+2,Z)
							if(4)
								T = locate(X+1,Y,Z)
							if(5)
								T = locate(X+2,Y,Z)
						if(T && !T.density)
							FS=new(T,src)
							walk(FS,dir,1)
				if(SOUTHEAST)
					for(var/i = 1 to 5)
						var/turf/T
						var/obj/Jutsu/Fuuton/Fusajin/FS
						switch(i)
							if(1)
								T = loc
							if(2)
								T = locate(X,Y+1,Z)
							if(3)
								T = locate(X,Y+2,Z)
							if(4)
								T = locate(X-1,Y,Z)
							if(5)
								T = locate(X-2,Y,Z)
						if(T && !T.density)
							FS=new(T,src)
							walk(FS,dir,1)

			spawn(DUR)FuCreate = 0

obj
	Jutsu/Fuuton
		Fusajin
			icon='Fuutons.dmi'
			icon_state="skycutter"
			var/CreateIT = 1
			var/MaxSteps = 8
			layer=MOB_LAYER+1
			density = 1
			New(loc,mob/O)
				Owner = O
				Ninjutsu = round(O.Ninjutsu*0.4)
				WindElemental = O.WindElemental*0.5
				dir=O.dir;
				..()
				for(var/atom/movable/M in loc)
					if(M == O || M == src)
						continue
					else
						Bump(M)
			Del()
				Owner = null
				walk(src,0)
				loc = null
				..()
			Move()
				if(Owner)
					if(Owner.FuCreate && CreateIT)
						var/LOC = loc
						.=..()
						if(.)
							MaxSteps--
							if(MaxSteps<=0)
								del src
							else
								CreateIT--
								var/obj/Jutsu/Fuuton/Fusajin/FS = new(LOC,Owner)
								if(FS)
									FS.Ninjutsu = Ninjutsu
									FS.WindElemental = WindElemental
									FS.dir=dir
									walk(FS,dir,1)
					else
						.=..()
						if(.)
							MaxSteps--
							if(MaxSteps<=0)
								del src
						else
							del src
				else
					del src
			Cross(A)
				if(isobj(A))
					var/obj/M = A
					if(istype(M,/obj/Jutsu/Fuuton) && Owner == M.Owner)
						return 1
				..()
			Bump(A)
				if(!Owner)
					del src
					return
				density = 0
				spawn(2)
					if(src)
						density = 1
				if(A==Owner)
					return
				if(istype(A,/turf/))
					var/turf/T = A
					if(T.density) del(src)
				else
					if(ismob(A))
						var/damage
						var/mob/O=Owner
						var/mob/M=A
						if(M.kaiten||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
						if(O.HitCheck(M))
							damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WindElemental,M.FireElemental,Power)
							M.DamageMe(O,damage,src)
						else
							O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."
						//del(src)
					if(isobj(A))
						var/obj/M = A
						if(istype(M,/obj/Destructable))
							var/damage
							var/SE=0
							if(M.EarthElemental&&!M.FireElemental)
								SE=1
							var/mob/O=Owner
							damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WindElemental,M.FireElemental,Power,SE)
							M.Destroy(damage,O)
							//del(src)
						else if(istype(M,/obj/Jutsu))
							if(istype(M,type) && M.Owner == Owner)
								return
							else
								JutsuClash_Wind(src,M)
						else if(istype(M,/obj/Weapon/Wield))
							del M
						//else del(src)