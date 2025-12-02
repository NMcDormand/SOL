var
	Sound5KillCount=0
mob/var
	tmp
		Sound5Kills

mob/NPC/Sound5
	AI()
		spawn(rand(1,10))
			while(!src.dead)
				var/mob
					M; m; t
				src.HitList=new/list
				var/list/ppl=SoundMissionaries
				for(m in SoundMissionaries)
					for(var/mob/c in m.KageBunshinList) if(c) ppl+=c
					if(m.Familiar) ppl+=m.Familiar
				for(M in ppl)
					if(get_dist(M,src)<11&&!(M in src.HitList)) src.LocateTarget(M)
				if(length(src.HitList))
					t=pick(HitList)
					if(src.Wounds<30)
						if(!isnull(t)) {src.Attack1(t); break}
						else sleep(1)
					else
						switch(pick(1,2))
							if(1)
								if(!isnull(t)) {src.Attack1(t); break}
								else sleep(1)
							if(2)
								if(!isnull(t)) {src.Attack2(t); break}
								else sleep(1)
				else sleep(22)


/*mob/NPC/Sound5/AI_Attack(mob/M, var/AttackTime, var/d)
	if(AttackTime>0&&M)
		AttackTime--
		if(prob(d))
			step_to(src,M)
			spawn(2) step_towards(src,M)
		else
			step_towards(src,M)
		if(get_dist(src,M)>1)
			spawn(2)
				if(!M.kaiten&&!M.MushiKabe&&prob(50)) AI_Attack(M,AttackTime,d)
				else AI()
		else
			AttackTime--
			spawn(5)
				if(!M.kaiten&&!M.MushiKabe&&prob(50)) src.AI_Attack(M,AttackTime,d)
				else AI()
	else AI()
*/

mob/NPC/Summon/AI()
	if(src.dead) return
	var
		c=0
	var/mob
		M; m; t; h
	for(h in src.HitList) HitList-=h
	for(M in range(6,src))
		if(istype(M,/mob/player)||istype(M,/mob/Clones)||istype(M,/mob/Pet))
			if(!(M in src.HitList)) src.LocateTarget(M)
	for(m in src.HitList) c++
	if(c)
		t=pick(src.HitList)
		if(!isnull(t)) src.AI_Attack(t,7,65)
		else AI()
	else
		spawn(22) src.AI()