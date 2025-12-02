mob
	proc
		Inazuma()
			new/Effect/Visual/Inazuma(loc)
			for(var/mob/A in range(src,3))
				if(A==src)
					continue
				for(var/B = 0 to 3)
					A.DamageMe(src,round(LightningElemental*0.3),"Inazuma")
		KuchuNejire()
			new/Effect/Visual/KuchuNejire(loc)
			for(var/mob/a in range(src,3))
				if(a==src)
					continue
				if(a.y>y)
					if(a.x>x)
						dir=NORTHEAST
					else if(a.x==x)
						dir=NORTH
					else if(a.x<x)
						dir=NORTHWEST
				else if(a.y<y)
					if(a.x>x)
						dir=SOUTHEAST
					else if(a.x==x)
						dir=SOUTH
					else if(a.x<x)
						dir=SOUTHWEST
				var/DIR = dir
				step(a,turn(a.dir,-180))
				dir = DIR
				a.DamageMe(src,round(WindElemental*3),"KuchuNejire")
		KazanFunka()
			new/Effect/Visual/KazanFunka(loc)
			for(var/mob/A in range(src,2))
				if(A==src)
					continue
				A.DamageMe(src,round(FireElemental*3),"KazanFunka")
		KawaEvade()
			var/mob/Kawarimi/S=new(loc)
			var/k
			if(onwater) k="water"
			else if(onmountain) k="mountain"
			else if(onsand) k="sand"
			else k="land"
			S.icon=icon; S.name=name; S.dir=dir; S.overlays=overlays; S.underlays=underlays; Kawarimi=S
			S.overlays=null; flick('Smoke.dmi',S)
			spawn(5)
				if(S)
					if(k=="water") {S.icon='kawarimi.dmi'; S.icon_state="fish"}
					else if(k=="mountain") {S.icon='kawarimi.dmi'; S.icon_state="rock"}
					else if(k=="sand") {S.icon='kawarimi.dmi'; S.icon_state="tumbleweed"}
					else {S.icon='kawarimi.dmi'; S.icon_state="log"}
					spawn(20) if(S)del(S)
			RemoveAllTargetMe()
			var/X = pick(-4,-3,3,4)
			var/Y = pick(-4,-3,3,4)
			loc = locate(x+X,y+Y,z)
		HiraishinEvade()
			var/list/DIRS = list(NORTH,SOUTH,EAST,WEST,NORTHWEST,NORTHEAST,SOUTHWEST,SOUTHEAST)
			Knives = list()
			HEvade = 1
			for(var/a in DIRS)
				spawn()
					var/obj/Weapon/Thrown/HKunai/K=new(loc,src)
					Knives += K
					K.Taijutsu=Taijutsu; K.ThrowingSkill=1000
					K.dir=a
					spawn(20)
						del K
					walk(K,K.dir)
			sleep(5)
			if(HEvade && !KO)
				if(length(Knives))
					var/obj/K = pick(Knives)
					var/turf/HL = loc
					HL.overlays += 'Hiraishin.dmi'
					spawn(4)
						HL.overlays -= 'Hiraishin.dmi'
					loc = K.loc
					del K
					HEvade = 0
			Knives = 0