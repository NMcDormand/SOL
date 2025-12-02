
mob/Hittable/Responsive/NPC/Mission/Sound5/Jiroubou
	name="Jiroubou"
	icon='Jiroubou.dmi'
	Clan = "???"
	Village="Sound"
	NinjaRank="Chuunin"
	Taijutsu=13000
	Ninjutsu=12000
	Genjutsu=7000
	TaijutsuMax=13000
	NinjutsuMax=9000
	GenjutsuMax=5000
	Stamina=350000
	StaminaMax=350000
	FireElemental=800
	WindElemental=200
	EarthElemental=1000
	ChakraControl=100
	Reflex=30
	SS = 5
	movespeed=2
	gender="male"
	protect=0
	CantHenge=1

//------------------------------------------------------------------------------------------

	Attack1(mob/M)
		if((sleepy||JubakuBound)&&prob(85)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(40)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(get_dist(src,M)>2)
				step_towards(src,M)
				if(M&&prob(65)&&M.icon_state=="seals") pick(135; Evade1(M),Evade2(M))
				else if(M&&firing)
					if(!M.kaiten&&!M.MushiKabe) AI_Attack(M,20,50)
				else DoryuuDango()
			else
				if(prob(20))
					Move_Away_To_Aim1(M)
					if(M&&get_dist(src,M)>=2&&!firing) DoryuuDango()
				else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,20)

	Attack2(mob/M)
		if((sleepy||JubakuBound)&&prob(80)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(40)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(M&&get_dist(src,M)>2)
				var/gd=get_dir(src,M)
				if(gd==NORTH||gd==SOUTH||gd==EAST||gd==WEST)
					if(M&&M.icon_state=="seals"&&prob(20)) pick(Evade1(M), 150; Evade2(M))
					else if(M&&firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,25)
					else if(M) Jiroubou_Tokken(M)
				else
					if(M&&get_dist(src,M)>3)
						if(M&&firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,10)
						else DoryuuDango()
					else if(M&&!M.kaiten&&!M.MushiKabe)
						AI_Attack(M,15)
			else if(M)
				if(M&&get_dist(src,M)>=2&&get_dir(src,M)==NORTH||get_dir(src,M)==SOUTH||get_dir(src,M)==EAST||get_dir(src,M)==WEST)
					step_towards(src,M)
					if(M&&firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,10)
					else if(M) Jiroubou_Tokken(M)
				else
					if(M&&M.icon_state=="seals")
						pick(Evade1(M),Evade2(M))
					else
						if(M&&get_dist(src,M)>=2)
							Move_In(M)
							if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,15)
						else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,15)
			/*
	AI_KO(mob/M)
		if(M&&get_dist(src,M)>1)
			step_to(src,M)
		else if(M&&get_dist(src,M)<=1)
			hearers(3,src)<<"<b>[src] says:</b> Hahaha, weakling! Now I will crush you!"
			spawn(31)
				if(M)
					dir=get_dir(src,M)
					if(TAICHECKBOTH(src,M)) return
					if(!M.KO) hearers(3,src)<<"<b>[src] says:</b> Wha? No! This can't be..."
					else {attacking=1; flick("punch",src); M.Wounds=300; M.KillMe(src); spawn(atkspeed+3)attacking=0}
*/
mob/proc
	Jiroubou_Tokken(mob/M)
		if(AIGENERICCHECK(src))
			sleep(10)
		else
			var/charge=get_dir(src,M)
			view(src)<<"<b>[src]: Tokken!</b>"
			flick("tokken",src)
			spawn(10)
				firing=1; Charging=1
			movespeed = 1
			for(var/i = 1 to 8)
				step(src,charge)
				sleep(1)
			Charging=null
			spawn(80) firing=0
			movespeed = 2

	Jiroubou_Charge(mob/M)
		if(!AI_TaijutsuAttackCheck(M))
			var/dmg = round(Taijutsu*5-(M.Taijutsu*0.20))
			if(dmg<=round(Taijutsu*0.35)) dmg=Taijutsu*0.35
			attacking=1; spawn(5)attacking=null
			M.DamageMe(src,dmg,"charges")