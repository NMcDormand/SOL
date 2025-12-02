mob/var
	tmp
		HasSummoned
		Poisoned
mob/Hittable/Responsive/NPC/Mission/Sound5/Kidoumaru
	name="Kidoumaru"
	icon='Kidoumaru.dmi'
	Village="Sound"
	Clan = "???"
	NinjaRank="Genin"
	Taijutsu=5500
	Ninjutsu=19000
	Genjutsu=12000
	TaijutsuMax=5500
	NinjutsuMax=19000
	GenjutsuMax=12000
	Stamina=280000
	StaminaMax=280000
	FireElemental=800
	WindElemental=200
	ChakraControl=100
	Reflex=35
	gender="male"
	CantHenge=1

/*
	AI_KO(mob/M)
		if(M&&get_dist(src,M)>1)
			step_to(src,M)
		else if(M&&get_dist(src,M)<=1)
			view(3,src)<<"<b>[src] says:</b> You just don't have what it takes to beat me."
			spawn(31)
				if(M)
					dir=get_dir(src,M)
					if(TAICHECKBOTH(src,M)) return
					if(!M.KO)
						view(3,src)<<"<b>[src] says:</b> Whaaa???"
						sleep(10)
					else
						attacking=1; spawn(atkspeed+3)attacking=0
						flick("punch",src); M.Wounds=300; M.KillMe(src)
*/
	Attack1(mob/M)
		if((sleepy||JubakuBound)&&prob(95)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(40)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(get_dist(src,M)>3)
				step_towards(src,M)
				if(M&&M.icon_state=="seals"&&prob(70)) Evade1(M)
				else if(M&&(HasSummoned||firing)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,66)
				else if(M) SummonSpider()

			else
				Move_Away_To_Aim1(M)
				if(M&&get_dist(src,M)>=2&&!firing) KidoumaruBow(M)
				else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,8,70)

	Attack2(mob/M)
		if((sleepy||JubakuBound)&&prob(87)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(40)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(get_dist(src,M)>4)
				if(M&&M.icon_state=="seals"&&prob(45)) Evade1(M)
				else if(M&&(firing||M.Webbed)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,14,44)
				else if(M) Kidoumaru_Web(M)
			else if(M&&get_dist(src,M)>2)
				if(M.icon_state=="seals"&&prob(70)) Evade1(M)
				else
					step_towards(src,M)
					spawn(2)
						if(M&&firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,16,70)
						else if(M) KidoumaruBow(M)
			else if(M)
				Move_Away_To_Aim2(M)
				spawn(6)
					if(M&&get_dist(src,M)>=2)
						step_towards(src,M)
						spawn(1)
							if(M&&(firing||M.Webbed)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,3)
							else if(M) Kidoumaru_Web(M)
					else
						if(M&&M.icon_state=="seals") Evade1(M)
						else if(M&&get_dist(src,M)>=2) {Move_In(M); spawn(16) AI_Attack(M,20,50)}
						else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,20,50)
//--------------------
mob/Hittable/Summon/Spider
	name="spider"
	NinjaRank = "NA"
	icon='spider.dmi'
	Taijutsu=4321
	Ninjutsu=1000
	Genjutsu=1000
	protect=0
	CantHenge=1
	Stamina=90000
	New()
		spawn(2)
			AI()
	Bump(mob/M)
		if(istype(M,/mob/))
			if(HitCheck(M)) S_Attack(M)
	LocateTarget(mob/T)
		if(T in HitList)
			return
		if(!T.icon)
			if(T.InKawarimi) {if(prob(98)&&T) HitList+=T}
			else if(T.InCamo) {if(prob(95)&&T) HitList+=T}
			else if(T.InCloak) {if(prob(60)&&T) HitList+=T}
			else if(T.InMeiMei) {if(prob(10)&&T) HitList+=T}
		else HitList+=T
mob/proc
	S_Attack(mob/M)
		if(!AI_TaijutsuAttackCheck(M))
			var/dmg = round(Taijutsu-(M.Taijutsu*0.1))
			if(dmg<=round(Taijutsu*0.20)) dmg=Taijutsu*0.20
			flick("attack",src)
			M.DamageMe(src,dmg,"strikes")

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
				var/mob/c=Owner
				if(target!=M) loc=M.loc
				if(M.kaiten||M.protect||M.InGatsuuga||M.InMeatTank||M.InTsuuga||M.InGarouga) del(src)
				var/holdtime
				if(M.Taijutsu>Taijutsu)
					holdtime=40
				else if(M.Taijutsu<=Taijutsu)
					holdtime=60
				M.Webbed=1; M.overlays+='Web.dmi'
				loc=locate(0,0,0); AcquiredTarget=1
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
				var/mob/O = Owner
				if(target!=M) loc=M.loc
				if(M.kaiten||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
				var/D=Ninjutsu-(M.Taijutsu*0.20)
				if(D<=Ninjutsu*0.22) D=Ninjutsu*0.22
				if(D<1) D=1
				D=round(D)
				M.DamageMe(O,D,src)
				del(src)

			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)