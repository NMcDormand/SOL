mob/var/tmp
	Charging
mob/NPC/Sound5/Jiroubou
	name="Jiroubou"
	icon='Jiroubou.dmi'
	Village="Sound"
	NinjaRank="Jounin"
	Taijutsu=12000
	Ninjutsu=9000
	Genjutsu=5000
	MTaijutsu=12000
	MNinjutsu=9000
	MGenjutsu=5000
	stamina=250000
	mstamina=250000
	FireElemental=800
	WindElemental=200
	EarthElemental=1000
	ChakraControl=100
	Reflex=10
	movespeed=2
	gender="male"
	protect=0
	CantHenge=1


	New()
		spawn(5) AI()
	Bump(mob/M)
		if(istype(M,/mob/))
			if(src.HitCheck(M)) src.AI_Punch(M)
			else M<<"You dodged [src]'s attack"

	LocateTarget(mob/T)
		if(T&&src.Darkness)
			if(prob(12)) HitList+=T
		else if(T&&!T.icon)
			if(T.InKawarimi) {if(prob(80)&&T) HitList+=T}
			else if(T.InCamo) {if(prob(90)&&T) HitList+=T}
			else if(T.InCloak) {if(prob(30)&&T) HitList+=T}
			else if(T.InMeiMei) {if(prob(50)&&T) HitList+=T}
		else if(T) HitList+=T

//------------------------------------------------------------------------------------------

	Attack1(mob/M)
		if((sleepy||JubakuBound)&&prob(85)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(40)) DispelProc()
		if(M&&M.KO)
			spawn(10) AI_KO(M)
		else if(!M)
			AI()
		else
			if(get_dist(src,M)>3)
				step_towards(src,M)
				spawn(2)
					if(M&&prob(65)&&M.icon_state=="seals") pick(135; Evade1(M),Evade2(M))
					else if(M&&src.firing)
						if(!M.kaiten&&!M.MushiKabe) AI_Attack(M,20,50)
						else AI()
					else src.AI_DotonDoryuuDango()

			else
				src.Move_Away_To_Aim1(M)
				spawn(13)
					if(M&&get_dist(src,M)>=2&&!src.firing) src.AI_DotonDoryuuDango()
					else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,20)
					else AI()

	Attack2(mob/M)
		if((sleepy||JubakuBound)&&prob(80)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(40)) DispelProc()
		if(M&&M.KO)
			spawn(10) AI_KO(M)
		else if(!M)
			AI()
		else
			if(M&&get_dist(src,M)>3)
				var/gd=get_dir(src,M)
				if(gd==NORTH||gd==SOUTH||gd==EAST||gd==WEST)
					step_towards(src,M)
					spawn(1)
						if(M&&M.icon_state=="seals"&&prob(20)) pick(Evade1(M), 150; Evade2(M))
						else if(M&&src.firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,25,10)
						else if(M) src.Jiroubou_Tokken(M)
						else AI()
				else
					if(M&&get_dist(src,M)>3)
						step_towards(src,M)
						spawn(2)
							if(M&&src.firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,10,10)
							else src.AI_DotonDoryuuDango()
					else if(M&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,15,30)
					else AI()
			else if(M)
				src.Move_Away_To_Aim2(M)
				spawn(6)
					if(M&&get_dist(src,M)>=2&&get_dir(src,M)==NORTH||get_dir(src,M)==SOUTH||get_dir(src,M)==EAST||get_dir(src,M)==WEST)
						step_towards(src,M)
						spawn(1)
							if(M&&src.firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,10,40)
							else if(M) src.Jiroubou_Tokken(M)
							else AI()
					else
						if(M&&M.icon_state=="seals")
							pick(Evade1(M),Evade2(M))
						else
							if(M&&get_dist(src,M)>=2)
								Move_In1(M)
								spawn(16)
									if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,15,15)
									else AI()
							else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,15,15)
							else AI()
			else AI()
	AI_KO(mob/M)
		spawn(40) AI()
		if(M&&get_dist(src,M)>1)
			step_to(src,M)
		else if(M&&get_dist(src,M)<=1)
			view(3,src)<<"<b>[src] says:</b> Hahaha, weakling! Now I will crush you!"
			spawn(31)
				if(M)
					src.dir=get_dir(src,M)
					if(src.TaiAttackCheck(M)) return
					if(!M.KO) view(3,src)<<"<b>[src] says:</b> Wha? No! This can't be..."
					else {src.attacking=1; flick("punch",src); M.Wounds=300; M.Kill(src); spawn(src.atkspeed+3)src.attacking=0}

mob/proc
	Jiroubou_Tokken(mob/M)
		if(AI_GenericAttackCheck())
			spawn(10) AI()
		else
			var/charge=get_dir(src,M)
			view(src)<<"<b>[src]: Tokken!</b>"
			flick("tokken",src)
			spawn(10)
				firing=1; Charging=1
				step(src,charge)
				spawn(1) step(src,charge)
				spawn(2) step(src,charge)
				spawn(3) step(src,charge)
				spawn(4) step(src,charge)
				spawn(5) step(src,charge)
				spawn(6) step(src,charge)
				spawn(8) step(src,charge)
				spawn(11) {step(src,charge); src.Charging=null}
			spawn(30) AI()
			spawn(80) firing=0

	Jiroubou_Charge(mob/M)
		if(!AI_TaijutsuAttackCheck(M))
			var/dmg = round(src.Taijutsu*5-(M.Taijutsu*0.20))
			if(dmg<=round(src.Taijutsu*0.35)) dmg=src.Taijutsu*0.35
			src.attacking=1; spawn(5)src.attacking=null
			M.Death(src,dmg,"charges")