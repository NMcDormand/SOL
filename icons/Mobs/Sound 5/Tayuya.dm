mob/var/tmp
	flute=0
	flutelist=list()
	Playing
	flutespeed
	flutecooldown
mob/NPC/Sound5
	Tayuya
		name="Tayuya"
		icon='Tayuya.dmi'
		Village="Sound"
		NinjaRank="Jounin"
		Taijutsu=7000
		Ninjutsu=5000
		Genjutsu=10000
		MTaijutsu=10000
		MNinjutsu=5000
		MGenjutsu=10000
		stamina=100000
		mstamina=100000
		FireElemental=900
		WindElemental=1200
		ChakraControl=100
		Reflex=15
		CantHenge=1
		gender="female"
	New()
		spawn(80) AI()
	Bump(A)
		if(ismob(A))
			var/mob/M=A
			if(!(istype(M,/mob/NPC)))
				if(src.HitCheck(M)) AI_Punch(M)
				else M<<"You dodged [src]'s attack"
	AI_KO(mob/M)
		spawn(40) AI()
		if(M&&get_dist(src,M)>1)
			step_to(src,M)
		else if(M&&get_dist(src,M)<=1)
			view(3,src)<<"<b>[src] says:</b> You're nothing compared to me!"
			spawn(31)
				if(M)
					src.dir=get_dir(src,M)
					if(src.TaiAttackCheck(M)) return
					if(M.KO)
						src.attacking=1; spawn(src.atkspeed+3)src.attacking=0
						flick("punch",src); M.Wounds=300; M.Kill(src)

	LocateTarget(mob/T)
		if(T&&src.Darkness)
			if(prob(60)) HitList+=T
		else if(T&&!T.icon)
			if(T.InKawarimi) {if(prob(100)&&T) HitList+=T}
			else if(T.InCamo) {if(prob(90)&&T) HitList+=T}
			else if(T.InCloak) {if(prob(66)&&T) HitList+=T}
			else if(T.InMeiMei) {if(prob(70)&&T) HitList+=T}
		else if(T) HitList+=T


	Attack1(mob/M)
		if((sleepy||JubakuBound)&&prob(100)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(77)) DispelProc()
		if(M&&M.KO)
			spawn(10) AI_KO(M)
		else if(!M)
			AI()
		else
			if(get_dist(src,M)<=5)
				step_towards(src,M)
				spawn(2)
					if(M&&M.icon_state=="seals"&&prob(90)) src.Evade1(M)
					else if(M&&src.firing&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,16,15)
					else if(M&&!src.flutecooldown)
						src.icon_state="flute"; src.flutelist=new/list; step_towards(src,M); src.Playing=1; spawn(134) src.Playing=0
						src.Mugenonsa(); spawn(33) Mugenonsa_Damage(src)
						flutecooldown=1; spawn(300) flutecooldown=0
					else if(M&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,16,22)
					else AI()

			else
				if(M&&get_dist(src,M)>=3&&!src.flutecooldown)
					src.icon_state="flute"; src.flutelist=new/list; step_towards(src,M); src.Playing=1; spawn(134) src.Playing=0
					src.Mugenonsa(); spawn(33) Mugenonsa_Damage(src)
					flutecooldown=1; spawn(300) flutecooldown=0
				else if(M&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,8,22)
				else AI()
	Attack2(mob/M)
		if((sleepy||JubakuBound)&&prob(100)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(90)) DispelProc()
		if(M&&M.KO)
			spawn(10) AI_KO(M)
		else if(!M)
			AI()
		else
			if(get_dist(src,M)<=5)
				step_towards(src,M)
				spawn(2)
					if(M&&M.icon_state=="seals"&&prob(90)) src.Evade1(M)
					else if(M&&src.firing&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,22,15)
					else if(M&&!src.flutecooldown)
						src.icon_state="flute"; src.flutelist=new/list; step_towards(src,M); src.Playing=1; spawn(134) src.Playing=0
						src.Mugenonsa(); spawn(33) Mugenonsa_Damage(src)
						flutecooldown=1; spawn(300) flutecooldown=0
					else if(M&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,33,22)
					else AI()

			else
				if(M&&get_dist(src,M)>=3&&!src.flutecooldown)
					src.icon_state="flute"; src.flutelist=new/list; step_towards(src,M); src.Playing=1; spawn(134) src.Playing=0
					src.Mugenonsa(); spawn(33) Mugenonsa_Damage(src)
					flutecooldown=1; spawn(300) flutecooldown=0
				else if(M&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,8,22)
				else AI()


mob/proc
	Mugenonsa()
		if(src.GenericAttackCheck())
			spawn(4) AI()
		else
			for(var/mob/M in range(4,src))
				if(src!=M)
					if(!(M in src.flutelist)&&!M.flute)
						if(M&&M.Genjutsu<=src.Genjutsu) {M<<"<i>You're captivated by the sound of a melodic flute...</i>"; M.flutespeed=20}
						else if(M&&M.Genjutsu<=round(src.Genjutsu*1.8)) {M<<"<i>You're captivated by the sound of a melodic flute...</i>"; M.flutespeed=14}
						else {M<<"<i>You hear strange music; your strong Genjutsu enables you to resist its captivating effect.</i>"; M.flutespeed=8}
						src.flutelist+=M; M.flute=1; M.firing=1
					else {M.firing=1; if(M.flutespeed>8) M.flute++}
			for(var/mob/f in src.flutelist)
				if(get_dist(f,src)>7||(f.Dispel&&f.flutespeed<20)||!src.Playing)
					f<<"You are no longer under the sinister influence of the melody."
					f.flute=0; src.flutelist-=f; f.firing=0
			spawn(8)
				if(src.Playing) src.Mugenonsa()
				else
					for(var/mob/f in src.flutelist)
						if(f) {f<<"You are no longer under the sinister influence of the melody."; f.flute=0; src.flutelist-=f; f.firing=0}
					src.flutelist=new/list; src.icon_state=""; spawn(8) AI()

	Mugenonsa_Damage(mob/F)
		for(var/mob/M in F.flutelist)
			if(!F) {M.flute=0; return}
			if(M&&F&&M.flute>=4&&F.Playing)
				M<<"<b><i>Your flesh starts to peel from your bones!!</b></i>"
				M.Death(F,M.mstamina/5,,1)
			else M.flute=0
		spawn(25)
			for(var/mob/M in F.flutelist)
				if(!F) {M.flute=0; return}
				if(M&&F&&M.flute>=4&&F.Playing)
					M<<"<b><i>Your flesh is peeling from your bones!!</b></i>"
					M.Death(F,M.mstamina/5,,1)
				else M.flute=0
		spawn(50)
			for(var/mob/M in F.flutelist)
				if(!F) {M.flute=0; return}
				if(M&&F&&M.flute>=4&&F.Playing)
					M<<"<b><i>You try to scream but the agony takes your breath!</b></i>"
					M.Death(F,M.mstamina/5,,1)
				else M.flute=0
		spawn(75)
			for(var/mob/M in F.flutelist)
				if(!F) {M.flute=0; return}
				if(M&&F&&M.flute>=4&&F.Playing)
					M<<"<b><i>Your arms and legs are ripped from their sockets!!</b></i>"
					M.Death(F,M.mstamina/5,,1)
				else M.flute=0
		spawn(100)
			for(var/mob/M in F.flutelist)
				if(!F) {M.flute=0; return}
				if(M&&F&&M.flute>=4&&F.Playing)
					M<<"<b><i>The illusion fades but the mental damage is done...</b></i>"
					M.Death(F,M.mstamina/5,,1)
				else M.flute=0


