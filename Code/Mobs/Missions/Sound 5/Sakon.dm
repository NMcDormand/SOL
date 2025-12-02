mob/var/tmp/Ukon
mob/Hittable/Responsive/NPC/Mission/Sound5/Sakon
	name="Sakon"
	icon='Sakon.dmi'
	Village="Sound"
	Clan = "???"
	NinjaRank="Special Jounin"
	Taijutsu=9000
	Ninjutsu=7000
	Genjutsu=4000
	TaijutsuMax=9000
	NinjutsuMax=7000
	GenjutsuMax=4000
	Stamina=110000
	StaminaMax=110000
	FireElemental=800
	WindElemental=200
	ChakraControl=100
	Reflex=45
	gender="male"
	CantHenge=1

	AI_KO(mob/M)
		if(M&&get_dist(src,M)>1)
			step_to(src,M)
		else if(M&&get_dist(src,M)<=1)
			view(3,src)<<"<b>[src] says:</b> Pathetic runt! Now I will finish you!"
			spawn(31)
				if(M)
					dir=get_dir(src,M)
					if(TAICHECKBOTH(src,M)) return
					if(!M.KO)
						view(3,src)<<"<b>[src] says:</b> Stop resisting!."
					else
						attacking=1; spawn(atkspeed+3)attacking=0
						flick("punch",src); M.Wounds=300; M.KillMe(src)

	Attack1(mob/M)
		if((sleepy||JubakuBound)&&prob(95)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(40)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(get_dist(src,M)>=3)
				step_towards(src,M)
				if(M&&M.icon_state=="seals"&&prob(70)) Evade1(M)
				else if(M&&firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,20)
				else if(M&&get_dist(src,M)<=2) MatchPunch()
				else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,19)
			else
				if(M&&get_dist(src,M)>=2) {step_towards(src,M); MatchPunch()}
				else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,10,22)

	Attack2(mob/M)
		if((sleepy||JubakuBound)&&prob(92)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(40)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(M&&get_dist(src,M)>=5&&prob(60))
				if(M&&M.icon_state=="seals"&&prob(55)) Evade1(M)
				else if(M&&(firing)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,11,5)
				else if(M&&get_dist(src,M)<2) MatchPunch()
				else if(M) AI_Attack(M,11,20)
			else if(M&&get_dist(src,M)<5&&prob(22))
				if(M.icon_state=="seals"&&prob(60)) Evade1(M)
				else
					step_towards(src,M)
					spawn(2)
						if(M&&firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,19,20)
						else if(M&&get_dist(src,M)<2) MatchPunch()
						else if(M) AI_Attack(M,18,10)
			else if(M)
				if(M&&get_dist(src,M)>=2)
					step_towards(src,M)
					spawn(1)
						if(M&&(firing)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,18,50)
						else if(M&&!Ukon) UkonRelease()
						else if(M) AI_Attack(M,10,30)
				else
					if(M&&M.icon_state=="seals") Evade1(M)
					if(M&&(firing)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,20)
					else if(M&&get_dist(src,M)<2) MatchKick()
					else if(M) AI_Attack(M,8,13)
//---------------------------
mob/Hittable/Responsive/NPC/Mission/Sound5/Ukon
	name="Ukon"
	icon='Sakon.dmi'
	Village="Sound"
	NinjaRank="Jounin"
	Taijutsu=8500
	Ninjutsu=8000
	Genjutsu=6000
	TaijutsuMax=8500
	NinjutsuMax=8000
	GenjutsuMax=6000
	Stamina=100000
	StaminaMax=100000
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
				if(HitCheck(M)) AI_Punch(M)
				else M<<"You dodged [src]'s attack"
	AI_KO(mob/M)
		if(M&&get_dist(src,M)>1)
			step_to(src,M)
		else if(M&&get_dist(src,M)<=1)
			spawn(31)
				if(M)
					dir=get_dir(src,M)
					if(TAICHECKBOTH(src,M)) return
					if(!M.KO)
						sleep(10)
					attacking=1; spawn(atkspeed+3)attacking=0
					flick("punch",src); M.Wounds=300; M.KillMe(src)

	LocateTarget(mob/T)
		if(T in HitList)
			return
		if(Darkness)
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
			AI_KO(M)
		if(M)
			if(get_dist(src,M)>3)
				step_towards(src,M)
				if(M&&M.icon_state=="seals"&&prob(70)) Evade1(M)
				else if(M&&firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,8,10)
				else if(M&&get_dist(src,M)<2) MatchPunch()
				else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,8,10)
			else
				if(M&&get_dist(src,M)>=2) {step_towards(src,M); MatchPunch()}
				else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,10,15)

	Attack2(mob/M)
		if(sleepy&&prob(95)) {sleepy=0; DispelProc()}
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(get_dist(src,M)>3)
				step_towards(src,M)
				spawn(2)
					if(M&&M.icon_state=="seals"&&prob(70)) Evade1(M)
					else if(M&&firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,8,15)
					else if(M&&get_dist(src,M)<2) MatchPunch()
					else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,8,15)

			else
				if(M&&get_dist(src,M)>=2) {step_towards(src,M); MatchPunch()}
				else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,10,31)

mob/proc
	UkonRelease()
		new/mob/Hittable/Responsive/NPC/Mission/Sound5/Ukon(loc)
		Ukon=1

	MatchPunch()
		for(var/mob/M in get_step(src,dir))
			firing=1; spawn(40) firing=null
			if(M&&M in HitList)
				var/dmg=round(Taijutsu*4-(M.Taijutsu*0.4))
				if(dmg<=round(Taijutsu*0.09)) dmg=Taijutsu*0.09
				dmg+=Weapons()
				attacking=1; spawn(10)attacking=0
				flick("punch",src)
				if(HitCheck(M))
					M.DamageMe(src,dmg,"strikes")
				else
					attacking=1; spawn(15)attacking=null
					M<<"You dodged [src]'s attack"

	MatchKick()
		for(var/mob/M in get_step(src,dir))
			firing=1; spawn(50) firing=null
			if(M&&M in HitList)
				var/dmg=round(Taijutsu*6-(M.Taijutsu))
				if(dmg<=round(Taijutsu*0.12)) dmg=Taijutsu*0.12
				dmg+=Kicks()
				attacking=1; spawn(10)attacking=0
				flick("kick",src)
				if(HitCheck(M))
					M.DamageMe(src,dmg,"kick")
				else
					attacking=1; spawn(15)attacking=null
					M<<"You dodged [src]'s attack"