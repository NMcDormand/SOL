proc
	CreateProjectile(mob/o,obj/j,element,location,direction,speed,distance,nin_multiplier,ele_multiplier)
		j.Ninjutsu=(o.Ninjutsu*nin_multiplier)
		if(element)
			switch(element)
				if("Earth") j.EarthElemental = (o.EarthElemental*ele_multiplier)
				if("Water") j.WaterElemental = (o.WaterElemental*ele_multiplier)
				if("Ice") j.IceElemental = ((0.5*(o.WaterElemental+o.WindElemental))*ele_multiplier)
				if("Fire") j.FireElemental = (o.FireElemental*ele_multiplier)
				if("Wind") j.WindElemental = (o.WindElemental*ele_multiplier)
				if("Lightning") j.LightningElemental = (o.LightningElemental*ele_multiplier)
		j.loc=location; j.dir=direction; j.Owner=o; walk(j,direction,speed)
		spawn(distance) if(j) del(j)

	NewProjectile(mob/M,obj/j,obj/SkillCards/S,NM=1,EM=1,turf/NewLock = 0)
		set waitfor = 0
		j.Ninjutsu = M.Ninjutsu * NM
		j.Taijutsu = M.Taijutsu * NM
		j.Power = NM

		if(S.Description["Element"])
			j.vars["[S.Description["Element"]]Elemental"] = M.vars["[S.Description["Element"]]Elemental"]*EM

		if(NewLock)
			j.loc = NewLock
		else
			j.loc = M.loc

		IDCOPY(j,M)
		j.dir = M.dir
		j.Owner = M
		j.movespeed = S.Speed

		if(S.Tracker && M.Targeting)
			if(S.Tracker == 1)
				j.Homing(M.Targeting)
			else
				j.BetterHoming(M.Targeting)
		else
			walk(j,j.dir,j.movespeed)

		spawn(S.Range*2)
			if(j)
				walk(j,0)
				j.loc = null
				/*spawn(20)
					if(j)
						del j*/

	CreateTaijutsuProjectile(mob/o,obj/j,element,location,direction,speed,distance,tai_multiplier,ele_multiplier)
		j.Taijutsu=(o.Taijutsu*tai_multiplier)
		if(element)
			switch(element)
				if("Earth") j.EarthElemental = (o.EarthElemental*ele_multiplier)
				if("Water") j.WaterElemental = (o.WaterElemental*ele_multiplier)
				if("Ice") j.IceElemental = ((0.5*(o.WaterElemental+o.WindElemental))*ele_multiplier)
				if("Fire") j.FireElemental = (o.FireElemental*ele_multiplier)
				if("Wind") j.WindElemental = (o.WindElemental*ele_multiplier)
				if("Lightning") j.LightningElemental = (o.LightningElemental*ele_multiplier)
		j.loc=location; j.dir=direction; j.Owner=o; walk(j,direction,speed)
		spawn(distance) if(j) del(j)

	JutsuDamage(J_NIN,OPPOSITE_NIN,J_ELEMENT,OPPOSITE_ELEMENT,POWER,SUPER_EFFECTIVE)
		var
			DAMAGE; N_DAMAGE; E_DAMAGE
			NIN_DEFENSE=0.2; ELE_DEFENSE=0.6
		if(!J_ELEMENT)
			J_ELEMENT=1
		if(!OPPOSITE_ELEMENT)
			OPPOSITE_ELEMENT=1
		switch(POWER)
			if(1) {POWER=2.3; NIN_DEFENSE+=0.12}
			if(2) {POWER=2.5; NIN_DEFENSE+=0.15; J_ELEMENT*=1.01}
			if(3) {POWER=2.6; NIN_DEFENSE+=0.17; J_ELEMENT*=1.03}
			if(4) {POWER=2.65; NIN_DEFENSE+=0.18; J_ELEMENT*=1.05}
			if(5) {POWER=2.69; NIN_DEFENSE+=0.19; J_ELEMENT*=1.1}
			if(6) {POWER=2.71; NIN_DEFENSE+=0.2; J_ELEMENT*=1.12}
			else POWER=1.8
		if(SUPER_EFFECTIVE)
			POWER*=1.3
		N_DAMAGE = (J_NIN - (OPPOSITE_NIN * NIN_DEFENSE))
		if(!J_ELEMENT&&!OPPOSITE_ELEMENT)
			E_DAMAGE=(N_DAMAGE*0.1)
		else
			E_DAMAGE = (J_ELEMENT - (OPPOSITE_ELEMENT * ELE_DEFENSE))
		DAMAGE = round(E_DAMAGE+N_DAMAGE) * POWER
		if(DAMAGE <= 1)
			DAMAGE=1
		return DAMAGE

obj/proc
	Homing(mob/target)
		set waitfor = 0
		Targeting = target
		for(var/i = 1 to 2)
			if(!src)
				break
			if(!target||target.dead||get_dist(target,src)>10||target.z != z)
				del(src)
				break

			if(target)
				spawn()
					step_towards(src,target)
			else
				del src
				break
			sleep(movespeed)
		if(src)
			walk(src,dir,movespeed)

	BetterHoming(mob/target)
		set waitfor = 0
		var/MS = movespeed*2
		Targeting = target
		while(src && target)
			if(target.dead||target.z != z)
				del(src)
			else if(get_dist(src,target) > 1)
				step_to(src,target)
			else
				step_towards(src,target)
			sleep(MS)
