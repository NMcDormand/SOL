mob/Hittable/Responsive/NPC/KonohaInvasion/Kankuro
	name="Kankuro"
	icon='base_medium.dmi'
	Village="Sand"
	NinjaRank="Genin"
	Taijutsu=53000; TaijutsuMax=53000
	Ninjutsu=55000; NinjutsuMax=55000
	Genjutsu=27000; GenjutsuMax=27000
	Stamina=900000; StaminaMax=900000
	WindElemental=10000
	EarthElemental=10000
	ChakraControl=100
	Reflex=150
	movespeed=1
	gender="male"
	KillMessage="This is the real power of the battle puppet!"
	LiveMessage="Why do you persist??"
	Locate_Darkness=100
	Locate_Kawarimi=100
	Locate_Camo=100
	Locate_Cloak=100
	Locate_MeiMei=100
	DispelOdds1=70
	DispelOdds2=80


	New()
		if(!KI_Commenced) del(src)
		var/obj/Item/Bandages/F=new/obj/Item/Bandages(src); F.amount=20
		spawn(3) KonohaInvasionAIList+=src
		spawn(rand(1,8))
			AI()
	Bump(mob/M)
		if(istype(M,/mob/))
			if(HitCheck(M)) AI_Punch(M)
			else M<<"You dodged [src]'s attack"

//------------------------------------------------------------------------------------------

	Attack1(mob/M)
		if((sleepy||JubakuBound)&&prob(DispelOdds1)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(DispelOdds1/2)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		else if(M)
			if(get_dist(src,M)<4)
				return
			else
				return

	Attack2(mob/M)
		if((sleepy||JubakuBound)&&prob(DispelOdds2)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(DispelOdds1/2)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		else if(M)
			if(get_dist(src,M)<4)
				return
			else if(M)
				return