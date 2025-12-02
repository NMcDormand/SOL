mob/var/tmp
	flute=0
	flutelist=list()
	Playing
	flutespeed
	flutecooldown

mob/Hittable/Responsive/NPC/Mission/Sound5
	Tayuya
		name="Tayuya"
		icon='Tayuya.dmi'
		Clan = "???"
		Village="Sound"
		NinjaRank="Special Jounin"
		Taijutsu=7000
		Ninjutsu=5000
		Genjutsu=10000
		TaijutsuMax=10000
		NinjutsuMax=5000
		GenjutsuMax=10000
		Stamina=100000
		StaminaMax=100000
		FireElemental=900
		WindElemental=1200
		ChakraControl=100
		Reflex=15
		CantHenge=1
		gender="female"

	AI_KO(mob/M)
		if(M&&get_dist(src,M)>1)
			step_to(src,M)
		else if(M&&get_dist(src,M)<=1)
			view(3,src)<<"<b>[src] says:</b> You're nothing compared to me!"
			spawn(31)
				if(M)
					dir=get_dir(src,M)
					if(TAICHECKBOTH(src,M)) return
					if(M.KO)
						attacking=1; spawn(atkspeed+3)attacking=0
						flick("punch",src); M.Wounds=300; M.KillMe(src)

	Attack1(mob/M)
		if((sleepy||JubakuBound)&&prob(100)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(77)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(get_dist(src,M)<=5)
				step_towards(src,M)
				if(M&&M.icon_state=="seals"&&prob(90)) Evade1(M)
				else if(M&&firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,16,15)
				else if(M&&!flutecooldown)
					icon_state="flute"; flutelist=new/list; step_towards(src,M); Playing=1; spawn(134) Playing=0
					Mugenonsa(); spawn(33) Mugenonsa_Damage(src)
					flutecooldown=1; spawn(300) flutecooldown=0
				else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,16,22)
			else
				if(M&&get_dist(src,M)>=3&&!flutecooldown)
					icon_state="flute"; flutelist=new/list; step_towards(src,M); Playing=1; spawn(134) Playing=0
					Mugenonsa(); spawn(33) Mugenonsa_Damage(src)
					flutecooldown=1; spawn(300) flutecooldown=0
				else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,8,22)

	Attack2(mob/M)
		if((sleepy||JubakuBound)&&prob(100)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(90)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(get_dist(src,M)<=5)
				step_towards(src,M)
				spawn(2)
					if(M&&M.icon_state=="seals"&&prob(90)) Evade1(M)
					else if(M&&firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,22,15)
					else if(M&&!flutecooldown)
						icon_state="flute"; flutelist=new/list; step_towards(src,M); Playing=1; spawn(134) Playing=0
						Mugenonsa(); spawn(33) Mugenonsa_Damage(src)
						flutecooldown=1; spawn(300) flutecooldown=0
					else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,33,22)

			else
				if(M&&get_dist(src,M)>=3&&!flutecooldown)
					icon_state="flute"; flutelist=new/list; step_towards(src,M); Playing=1; spawn(134) Playing=0
					Mugenonsa(); spawn(33) Mugenonsa_Damage(src)
					flutecooldown=1; spawn(300) flutecooldown=0
				else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,8,22)

mob/proc
	Mugenonsa()
		if(GENERICATTACKCHECK(src))
			sleep(4)
			return
		else
			for(var/mob/M in range(4,src))
				if(src!=M)
					if(!(M in flutelist)&&!M.flute)
						if(M&&M.Genjutsu<=Genjutsu) {M<<"<i>You're captivated by the sound of a melodic flute...</i>"; M.flutespeed=20}
						else if(M&&M.Genjutsu<=round(Genjutsu*1.8)) {M<<"<i>You're captivated by the sound of a melodic flute...</i>"; M.flutespeed=14}
						else {M<<"<i>You hear strange music; your strong Genjutsu enables you to resist its captivating effect.</i>"; M.flutespeed=8}
						flutelist+=M; M.flute=1; M.firing=1
					else {M.firing=1; if(M.flutespeed>8) M.flute++}
			for(var/mob/f in flutelist)
				if(get_dist(f,src)>7||(f.Dispel&&f.flutespeed<20)||!Playing)
					f<<"You are no longer under the sinister influence of the melody."
					f.flute=0; flutelist-=f; f.firing=0
			spawn(8)
				if(Playing) Mugenonsa()
				else
					for(var/mob/f in flutelist)
						if(f) {f<<"You are no longer under the sinister influence of the melody."; f.flute=0; flutelist-=f; f.firing=0}
					flutelist=new/list; icon_state=""

	Mugenonsa_Damage(mob/F)
		for(var/mob/M in F.flutelist)
			if(!F) {M.flute=0; return}
			if(M&&F&&M.flute>=4&&F.Playing)
				M<<"<b><i>Your flesh starts to peel from your bones!!</b></i>"
				M.DamageMe(F,M.StaminaMax/5,,1)
			else M.flute=0
		spawn(25)
			for(var/mob/M in F.flutelist)
				if(!F) {M.flute=0; return}
				if(M&&F&&M.flute>=4&&F.Playing)
					M<<"<b><i>Your flesh is peeling from your bones!!</b></i>"
					M.DamageMe(F,M.StaminaMax/5,,1)
				else M.flute=0
		spawn(50)
			for(var/mob/M in F.flutelist)
				if(!F) {M.flute=0; return}
				if(M&&F&&M.flute>=4&&F.Playing)
					M<<"<b><i>You try to scream but the agony takes your breath!</b></i>"
					M.DamageMe(F,M.StaminaMax/5,,1)
				else M.flute=0
		spawn(75)
			for(var/mob/M in F.flutelist)
				if(!F) {M.flute=0; return}
				if(M&&F&&M.flute>=4&&F.Playing)
					M<<"<b><i>Your arms and legs are ripped from their sockets!!</b></i>"
					M.DamageMe(F,M.StaminaMax/5,,1)
				else M.flute=0
		spawn(100)
			for(var/mob/M in F.flutelist)
				if(!F) {M.flute=0; return}
				if(M&&F&&M.flute>=4&&F.Playing)
					M<<"<b><i>The illusion fades but the mental damage is done...</b></i>"
					M.DamageMe(F,M.StaminaMax/5,,1)
				else M.flute=0


