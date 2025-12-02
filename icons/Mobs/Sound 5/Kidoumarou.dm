mob/var
	tmp
		HasSummoned
		Poisoned
mob/NPC/Sound5/Kidoumaru
	name="Kidoumaru"
	icon='Kidoumaru.dmi'
	Village="Sound"
	NinjaRank="Jounin"
	Taijutsu=4500
	Ninjutsu=15000
	Genjutsu=8000
	MTaijutsu=4500
	MNinjutsu=15000
	MGenjutsu=8000
	stamina=180000
	mstamina=180000
	FireElemental=800
	WindElemental=200
	ChakraControl=100
	Reflex=20
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
			view(3,src)<<"<b>[src] says:</b> You just don't have what it takes to beat me."
			spawn(31)
				if(M)
					src.dir=get_dir(src,M)
					if(src.TaiAttackCheck(M)) return
					if(!M.KO)
						view(3,src)<<"<b>[src] says:</b> Whaaa???"
						sleep(10)
					else
						src.attacking=1; spawn(src.atkspeed+3)src.attacking=0
						flick("punch",src); M.Wounds=300; M.Kill(src)

	LocateTarget(mob/T)
		if(T&&src.Darkness)
			if(prob(15)&&T) HitList+=T
		else if(T&&!T.icon)
			if(T.InKawarimi) {if(prob(85)&&T) HitList+=T}
			else if(T.InCamo) {if(prob(95)&&T) HitList+=T}
			else if(T.InCloak) {if(prob(20)&&T) HitList+=T}
			else if(T.InMeiMei) {if(prob(65)&&T) HitList+=T}
		else if(T) HitList+=T

	Attack1(mob/M)
		if((sleepy||JubakuBound)&&prob(95)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(40)) DispelProc()
		if(M&&M.KO)
			spawn(10) AI_KO(M)
		else if(!M)
			AI()
		else
			if(get_dist(src,M)>3)
				step_towards(src,M)
				spawn(2)
					if(M&&M.icon_state=="seals"&&prob(70)) Evade1(M)
					else if(M&&(HasSummoned||firing)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,66)
					else if(M) AI_SummonSpider()
					else AI()

			else
				Move_Away_To_Aim1(M)
				spawn(13)
					if(M&&get_dist(src,M)>=2&&!src.firing) KidoumaruBow(M)
					else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,8,70)
					else AI()

	Attack2(mob/M)
		if((sleepy||JubakuBound)&&prob(87)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(40)) DispelProc()
		if(M&&M.KO)
			spawn(10) AI_KO(M)
		else if(!M)
			AI()
		else
			if(get_dist(src,M)>4)
				if(M&&M.icon_state=="seals"&&prob(45)) Evade1(M)
				else if(M&&(src.firing||M.Webbed)&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,14,44)
				else if(M) src.Kidoumaru_Web(M)
				else AI()
			else if(M&&get_dist(src,M)>2)
				if(M.icon_state=="seals"&&prob(70)) Evade1(M)
				else
					step_towards(src,M)
					spawn(2)
						if(M&&src.firing&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,16,70)
						else if(M) src.KidoumaruBow(M)
						else AI()
			else if(M)
				src.Move_Away_To_Aim2(M)
				spawn(6)
					if(M&&get_dist(src,M)>=2)
						step_towards(src,M)
						spawn(1)
							if(M&&(src.firing||M.Webbed)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,3)
							else if(M) src.Kidoumaru_Web(M)
							else AI()
					else
						if(M&&M.icon_state=="seals") Evade1(M)
						else if(M&&get_dist(src,M)>=2) {Move_In1(M); spawn(16) AI_Attack(M,20,50)}
						else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,20,50)
						else AI()
			else AI()
//--------------------
mob/NPC/Summon/Spider
	name="spider"
	icon='spider.dmi'
	Taijutsu=4321
	Ninjutsu=1000
	Genjutsu=1000
	protect=0
	CantHenge=1
	stamina=90000
	New()
		spawn(2) AI()
	Bump(mob/M)
		if(istype(M,/mob/))
			if(src.HitCheck(M)) src.S_Attack(M)
	LocateTarget(mob/T)
		if(!T.icon)
			if(T.InKawarimi) {if(prob(98)&&T) HitList+=T}
			else if(T.InCamo) {if(prob(95)&&T) HitList+=T}
			else if(T.InCloak) {if(prob(60)&&T) HitList+=T}
			else if(T.InMeiMei) {if(prob(10)&&T) HitList+=T}
		else HitList+=T
mob/proc
	S_Attack(mob/M)
		if(!AI_TaijutsuAttackCheck(M))
			var/dmg = round(src.Taijutsu-(M.Taijutsu*0.1))
			if(dmg<=round(src.Taijutsu*0.20)) dmg=src.Taijutsu*0.20
			flick("attack",src)
			M.Death(src,dmg,"strikes")

obj/Sound5
	Web
		Taijutsu=5000
		name="Spider Bind"
		icon='Web.dmi'
		icon_state="projectile"
		movespeed=2
		density=1

		Del()
			if(AcquiredTarget)sleep(60)
			..()


		Bump(A)
			if(ismob(A))
				var/mob/M = A
				var/mob/c=src.Owner
				if(src.target!=M) src.loc=M.loc
				if(M.kaiten||M.protect||M.InGatsuuga||M.InMeatTank||M.InTsuuga||M.InGarouga) del(src)
				var/holdtime
				if(M.Taijutsu>src.Taijutsu)
					holdtime=40
				else if(M.Taijutsu<=src.Taijutsu)
					holdtime=60
				M.Webbed=1; M.overlays+='Web.dmi'
				src.loc=locate(0,0,0); src.AcquiredTarget=1
				spawn(holdtime) if(M) M.Webbed=null; M.overlays-='Web.dmi'
				range(6,M)<<"<i>[M] is held by [c]'s web!</i>"

			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)

	Arrow
		name="Arrow"
		icon='Arrow.dmi'
		density=1
		movespeed=1

		Bump(A)
			if(ismob(A))
				var/mob/M = A
				var/mob/O = src.Owner
				if(src.target!=M) src.loc=M.loc
				if(M.kaiten||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
				var/D=src.Ninjutsu-(M.Taijutsu*0.20)
				if(D<=src.Ninjutsu*0.22) D=src.Ninjutsu*0.22
				if(D<1) D=1
				D=round(D)
				M.Death(O,D,src)
				del(src)

			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)