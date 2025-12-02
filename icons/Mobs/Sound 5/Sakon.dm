mob/var/tmp/Ukon
mob/NPC/Sound5/Sakon
	name="Sakon"
	icon='Sakon.dmi'
	Village="Sound"
	NinjaRank="Jounin"
	Taijutsu=9000
	Ninjutsu=7000
	Genjutsu=4000
	MTaijutsu=9000
	MNinjutsu=7000
	MGenjutsu=4000
	stamina=110000
	mstamina=110000
	FireElemental=800
	WindElemental=200
	ChakraControl=100
	Reflex=25
	gender="male"
	CantHenge=1

	New()
		spawn(50) AI()
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
			view(3,src)<<"<b>[src] says:</b> Pathetic runt! Now I will finish you!"
			spawn(31)
				if(M)
					src.dir=get_dir(src,M)
					if(src.TaiAttackCheck(M)) return
					if(!M.KO)
						view(3,src)<<"<b>[src] says:</b> Stop resisting!."
					else
						src.attacking=1; spawn(src.atkspeed+3)src.attacking=0
						flick("punch",src); M.Wounds=300; M.Kill(src)

	LocateTarget(mob/T)
		if(src.Darkness&&T)
			if(prob(8)) HitList+=T
		else if(T&&!T.icon)
			if(T.InKawarimi) {if(prob(90)&&T) HitList+=T}
			else if(T.InCamo) {if(prob(85)&&T) HitList+=T}
			else if(T.InCloak) {if(prob(38)&&T) HitList+=T}
			else if(T.InMeiMei) {if(prob(50)&&T) HitList+=T}
		else if(T) HitList+=T


	Attack1(mob/M)
		if((sleepy||JubakuBound)&&prob(95)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(40)) DispelProc()
		if(M&&M.KO)
			spawn(10) AI_KO(M)
		else if(!M)
			AI()
		else
			if(get_dist(src,M)>=3)
				step_towards(src,M)
				spawn(2)
					if(M&&M.icon_state=="seals"&&prob(70)) src.Evade1(M)
					else if(M&&src.firing&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,12,20)
					else if(M&&get_dist(src,M)<=2) src.MatchPunch()
					else if(M&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,12,19)
					else AI()

			else
				if(M&&get_dist(src,M)>=2) {step_towards(src,M); src.MatchPunch()}
				else if(M&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,10,22)
				else AI()

	Attack2(mob/M)
		if((sleepy||JubakuBound)&&prob(92)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(40)) DispelProc()
		if(M&&M.KO)
			spawn(10) AI_KO(M)
		else if(!M)
			AI()
		else
			if(M&&get_dist(src,M)>=5&&prob(60))
				if(M&&M.icon_state=="seals"&&prob(55)) Evade1(M)
				else if(M&&(src.firing)&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,11,5)
				else if(M&&get_dist(src,M)<2) src.MatchPunch()
				else if(M) src.AI_Attack(M,11,20)
				else AI()
			else if(M&&get_dist(src,M)<5&&prob(22))
				if(M.icon_state=="seals"&&prob(60)) Evade1(M)
				else
					step_towards(src,M)
					spawn(2)
						if(M&&src.firing&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,19,20)
						else if(M&&get_dist(src,M)<2) src.MatchPunch()
						else if(M) src.AI_Attack(M,18,10)
						else AI()
			else if(M)
				if(M&&get_dist(src,M)>=2)
					step_towards(src,M)
					spawn(1)
						if(M&&(src.firing)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,18,50)
						else if(M&&!src.Ukon) src.UkonRelease()
						else if(M) AI_Attack(M,10,30)
						else AI()
				else
					if(M&&M.icon_state=="seals") Evade1(M)
					if(M&&(src.firing)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,20)
					else if(M&&get_dist(src,M)<2) MatchKick()
					else if(M) AI_Attack(M,8,13)
					else AI()
			else AI()
//---------------------------
mob/NPC/Sound5/Ukon
	name="Ukon"
	icon='Sakon.dmi'
	Village="Sound"
	NinjaRank="Jounin"
	Taijutsu=8500
	Ninjutsu=8000
	Genjutsu=6000
	MTaijutsu=8500
	MNinjutsu=8000
	MGenjutsu=6000
	stamina=100000
	mstamina=100000
	FireElemental=700
	WindElemental=100
	ChakraControl=100
	Reflex=25
	gender="male"
	CantHenge=1
	New()
		spawn(25) AI()
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
			spawn(31)
				if(M)
					src.dir=get_dir(src,M)
					if(src.TaiAttackCheck(M)) return
					if(!M.KO)
						sleep(10)
					src.attacking=1; spawn(src.atkspeed+3)src.attacking=0
					flick("punch",src); M.Wounds=300; M.Kill(src)

	LocateTarget(mob/T)
		if(src.Darkness)
			if(prob(5)&&T) HitList+=T
		else if(!T.icon)
			if(T.InKawarimi) {if(prob(70)&&T) HitList+=T}
			else if(T.InCamo) {if(prob(75)&&T) HitList+=T}
			else if(T.InCloak) {if(prob(28)&&T) HitList+=T}
			else if(T.InMeiMei) {if(prob(40)&&T) HitList+=T}
		else HitList+=T

	Attack1(mob/M)
		if(sleepy&&prob(95)) {sleepy=0; DispelProc()}
		if(M&&M.KO)
			spawn(10) AI_KO(M)
		else if(!M)
			AI()
		else
			if(get_dist(src,M)>3)
				step_towards(src,M)
				spawn(2)
					if(M&&M.icon_state=="seals"&&prob(70)) src.Evade1(M)
					else if(M&&src.firing&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,8,10)
					else if(M&&get_dist(src,M)<2) src.MatchPunch()
					else if(M&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,8,10)
					else AI()

			else
				if(M&&get_dist(src,M)>=2) {step_towards(src,M); src.MatchPunch()}
				else if(M&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,10,15)
				else AI()
	Attack2(mob/M)
		if(sleepy&&prob(95)) {sleepy=0; DispelProc()}
		if(M&&M.KO)
			spawn(10) AI_KO(M)
		else if(!M)
			AI()
		else
			if(get_dist(src,M)>3)
				step_towards(src,M)
				spawn(2)
					if(M&&M.icon_state=="seals"&&prob(70)) src.Evade1(M)
					else if(M&&src.firing&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,8,15)
					else if(M&&get_dist(src,M)<2) src.MatchPunch()
					else if(M&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,8,15)
					else AI()

			else
				if(M&&get_dist(src,M)>=2) {step_towards(src,M); src.MatchPunch()}
				else if(M&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,10,31)
				else AI()

mob/proc
	UkonRelease()
		spawn(10) src.AI()
		new/mob/NPC/Sound5/Ukon(src.loc)
		src.Ukon=1
	MatchPunch()
		spawn(10) AI()
		for(var/mob/M in get_step(src,src.dir))
			src.firing=1; spawn(40) src.firing=null
			if(M&&M in src.HitList)
				var/dmg=round(src.Taijutsu*4-(M.Taijutsu*0.4))
				if(dmg<=round(src.Taijutsu*0.09)) dmg=src.Taijutsu*0.09
				dmg+=src.Weapons()
				src.attacking=1; spawn(10)src.attacking=0
				flick("punch",src)
				if(src.HitCheck(M))
					M.Death(src,dmg,"strikes")
				else
					src.attacking=1; spawn(15)src.attacking=null
					M<<"You dodged [src]'s attack"

	MatchKick()
		spawn(10) AI()
		for(var/mob/M in get_step(src,src.dir))
			src.firing=1; spawn(50) src.firing=null
			if(M&&M in src.HitList)
				var/dmg=round(src.Taijutsu*6-(M.Taijutsu))
				if(dmg<=round(src.Taijutsu*0.12)) dmg=src.Taijutsu*0.12
				src.Kicks(); dmg+=src.Kicks()
				src.attacking=1; spawn(10)src.attacking=0
				flick("kick",src)
				if(src.HitCheck(M))
					M.Death(src,dmg,"kick")
				else
					src.attacking=1; spawn(15)src.attacking=null
					M<<"You dodged [src]'s attack"