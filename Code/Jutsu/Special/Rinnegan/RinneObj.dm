Effect/Visual
	ChibakuTensei
		name = "Chibaku Shinsei"
		icon = 'ChibakuTensei.dmi'
		pixel_x = -16
		pixel_y = -16
		density = 1
		var/Damage = 0
		var/Active = 1
		New(turf/LOC, mob/M, DUR, RNG)
			loc = LOC
			Owner = M
			IDSET(src,M)
			Damage = round(0.1 * (M.Taijutsu + M.Ninjutsu))
			..()
			icon_state = "Summon"
			sleep(14)
			Activate(DUR,RNG)

		proc/Activate(DUR=30, RNG=5)
			set waitfor = 0
			icon_state = "Active"
			Active = 1
			spawn(DUR)
				Active = 0
			while(Active)
				if(!Owner)
					break
				for(var/mob/M in view(RNG,src))
					if(IDCHECK(Owner,M)||M==Owner)
						continue
					if(M.dead)
						continue
					if(M.protect)
						continue
					if(M == Owner.Familiar)
						continue
					if(istype(M,/mob/Hittable)||istype(M,/mob/player))
						if(NINIGNORELIST(M))
							continue
						spawn(-1)
							M.RinneBlown = 1
							var/SP = M.movespeed
							M.movespeed = 0
							//while(get_dist(M,src)<12)
							M.DamageMe(Owner,Damage,"ChibakuTensei")
							if(M)
								step_towards(M,src)
								M.movespeed = SP
								M.RinneBlown = 0
				sleep(1)
			//animate(src,alpha=0,4,4)
			//sleep(16)
			loc = null

	TengaiShinsei
		name = "Tenga Shinsei"
		icon = 'TengaiShinsei.dmi'
		pixel_x = -112
		pixel_y = -112
		layer = 50
		var/list/DustTiles = list()
		var/Damage = 0
		New(turf/LOC,mob/D,SummonMadara)
			loc=LOC
			IDSET(src,D)
			Owner = D
			Damage = round(0.3 * (D.Taijutsu + D.Ninjutsu))
			..()
			spawn(10)
				new/Effect/Visual/KuchuNejire(loc)

				Activate(SummonMadara)
				if(SummonMadara)
					spawn(20)
						var/mob/Hittable/Responsive/Boss/Madara/TM = SpecialMobs["Madara"]
						TM.loc=loc
						var/LE = new/Underlay_Obj('UchihaCards.dmi',7,-16,0,"EMS1")
						var/RE = new/Underlay_Obj('UchihaCards.dmi',7,16,0,"EMS1")
						spawn(10)
							TM.overlays += LE
							TM.overlays += RE
						//TextRandoOverlay(TM, "HA", 200, 20)
						spawn(60)
							spawn(5)
								TM.overlays -= LE
								TM.overlays -= RE
							TextExactOverlay(TM,"I am Destiny",0,32)
							hearers(8,src)<<output("<b><font face=verdana color=\"[TM.VillageColour]\">[TM]</font> says:</b> and your destiny has now arrived", "Chat")
							loc = null
							spawn(10)
								TM.AI()
				else
					spawn(4)
						loc = null

		proc/Activate(SummonMadara)
			var/list/D = list()
			for(var/turf/A in view(12,src))
				var/GD = get_dist(A,src)
				if(!D["[GD]"])
					D["[GD]"] = list()
				D["[GD]"] += A
			if(SummonMadara)
				var/Effect/Visual/Dust/DU1 = new(loc,0)
				DU1.density = 1
				DustTiles += DU1
				for(var/i=0 to D.len)
					for(var/turf/A in D["[i]"])
						spawn()
							new/Effect/Visual/KuchuNejire(A)
							sleep(1)
							var/Effect/Visual/Dust/DU = new(A,0)
							spawn(1)
								DU.density = 1
							DustTiles += DU
							if(pick(1,2,3,4) == 3)
								spawn(pick(10, 15, 20, 25, 30))
									DU.overlays += 'SharinganEyes.dmi'
						for(var/mob/M in A)
							if(IDCHECK(src,M))
								continue
							if(M == Owner)
								continue
							if(M.dead)
								continue
							if(M.protect)
								continue
							if(M == Owner.Familiar)
								continue
							if(istype(M,/mob/Hittable)||M.client)
								if(istype(M,/mob/Hittable/Command/Genjutsu)||istype(M,/mob/Hittable/Unresponsive/NPC)||istype(M,/mob/Hittable/Unresponsive/Training))
									continue
								else
									spawn(-1)
										M.RinneBlown = 1
										var/SP = M.movespeed
										M.movespeed = 0
										//while(get_dist(M,src)<12)
										M.DamageMe(Owner,Damage,"TengaShinsei")
										if(M)
											M.RinneBlown = 1
											if(A == loc)
												step(M, pick(NORTH,SOUTH,EAST,WEST))
											else
												step(M,get_dir(src,M))
											M.dir = pick(NORTH,SOUTH,EAST,WEST)
											M.RinneBlown = 0
											//sleep(1)
											M.movespeed = SP
					sleep(1)
			else
				var/Effect/Visual/Dust/DU1 = new(loc,0)
				DustTiles += DU1
				for(var/i=0 to D.len)
					for(var/turf/A in D["[i]"])
						spawn()
							new/Effect/Visual/KuchuNejire(A)
							sleep(1)
							var/Effect/Visual/Dust/DU = new(A,0)
							DustTiles += DU
						for(var/mob/M in A)
							if(IDCHECK(src,M))
								continue
							if(M == Owner)
								continue
							if(M == Owner.Familiar)
								continue
							if(M.dead)
								continue
							if(M.protect)
								continue
							if(istype(M,/mob/Hittable)||M.client)
								if(NINIGNORELIST(M))
									continue
								else
									spawn(-1)
										M.RinneBlown = 1
										var/SP = M.movespeed
										M.movespeed = 0
										//while(get_dist(M,src)<12)
										M.DamageMe(Owner,Damage,"TengaShinsei")
										if(M)
											step(M,get_dir(src,M))
											M.dir = pick(NORTH,SOUTH,EAST,WEST)
											//sleep(1)
											M.movespeed = SP
											M.RinneBlown = 0
					sleep(1)
			spawn(90)
				for(var/Effect/Visual/Dust/DU in DustTiles)
					spawn()
						del DU

