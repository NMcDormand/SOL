mob/Hittable/Responsive/NPC/KonohaInvasion/Temari
	name="Temari"
	icon='Base_Medium.dmi'
	Village="Sand"
	NinjaRank="Genin"
	Class = list("Fan-Nin" = 1)
	Taijutsu=55000; TaijutsuMax=55000
	Ninjutsu=85000; NinjutsuMax=85000
	Genjutsu=24000; GenjutsuMax=24000
	Stamina=1500000; StaminaMax=1500000
	Chakra=35000; ChakraMax=35000
	PE="Wind"; WindElemental=20000
	SE="Earth"; EarthElemental=10000
	ChakraControl=100
	Reflex=170
	cooldownmultiplier=0.9
	movespeed=1
	gender="female"
	wielding="Fan"
	KillMessage="Wasn't much of a match; kinda boring."
	LiveMessage="Still got some fight left in ya, huh?"
	Locate_Darkness=100
	Locate_Kawarimi=100
	Locate_Camo=100
	Locate_Cloak=100
	Locate_MeiMei=100
	DispelOdds1=100
	DispelOdds2=95
	FirstAidSkill=75
	KillValue=50
	atkspeed = 4


	New()
		var/icon/i='Base_Medium.dmi'
		var/icon/E = new(i)
		E.Blend('BrownEyes.dmi',ICON_OVERLAY)
		icon = E
		new/obj/Hair/Temari_Blonde(src)
		var/obj/Hair/h = locate() in src; if(h&&h.worn) overlays+=h.icon
		overlays+='Fan.dmi'
		new/obj/Clothing/Over/Temari_Suit(src)
		var/obj/Clothing/Head/Headband/Q=new/obj/Clothing/Head/Headband(src); Q.icon='TemariHB.dmi'
		for(var/obj/c in src)
			c.worn = 1
			overlays += c.icon
		var/obj/Item/Bandages/F=new/obj/Item/Bandages(src); F.amount=20
		spawn(3)
			if(!KonohaInvasionAIList) KonohaInvasionAIList=new()
			KonohaInvasionAIList+=src
		spawn(rand(1,8))
			AI()
	Bump(mob/M)
		if(istype(M,/mob/)&&!istype(M,/mob/NPC))
			if(HitCheck(M))
				switch(pick(prob(220); 1,2))
					if(1) AI_Punch(M)
					if(2) AI_Kick(M)
			else M<<"You dodged [src]'s attack"

	Attack1(mob/M)
		if((sleepy||JubakuBound)&&prob(DispelOdds1)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(DispelOdds1/2)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(M&&get_dist(src,M)<4)
				if(M.icon_state=="seals"&&prob(65))
					Evade3(M)
				else if(wielding=="Fan"&&!CooldownCheck("Kamaitachi",(60*cooldownmultiplier),1))
					Move_Away_To_Aim1(M)
					sleep(9)
					if(M) {step_towards(src,M); Fuuton_Kamaitachi()}
				else AI_Attack(M,10,40)
			else if(M)
				if(M.icon_state=="seals"&&prob(65))
					Evade1(M)
				else if(wielding=="Fan"&&!CooldownCheck("Daikamaitachi",(90*cooldownmultiplier),1))
					sleep(Move_In(M))
					if(M) Fuuton_DaiKamaitachi()
				else if(wielding=="Fan"&&!CooldownCheck("Kamaitachi",(60*cooldownmultiplier),1))
					sleep(Move_In(M)+1)
					if(M) Fuuton_Kamaitachi()
				else AI_Attack(M,18)

	Attack2(mob/M)
		if((sleepy||JubakuBound)&&prob(DispelOdds2)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(DispelOdds1/2)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		else if(M)
			if(M&&get_dist(src,M)<4)
				if(M.icon_state=="seals"&&prob(100))
					Evade1(M)
				else if(wielding=="Fan"&&!CooldownCheck("Kamaitachi",(60*cooldownmultiplier),1))
					Move_Away_To_Aim1(M)
					sleep(8)
					if(M) {step_towards(src,M); Fuuton_Kamaitachi()}
				else if(wielding=="Fan"&&!CooldownCheck("Ooshigoto",(300*cooldownmultiplier),1))
					Fuuton_TatsuNoOoshigoto(M)
				else if(wielding=="Fan"&&!CooldownCheck("Daikamaitachi",(90*cooldownmultiplier),1))
					Move_Away_To_Aim2(M)
					sleep(7)
					if(M) Fuuton_DaiKamaitachi()
				else AI_Attack(M,18,69)
			else if(M)
				if(M.icon_state=="seals"&&prob(100))
					Evade3(M)
				else if(wielding=="Fan"&&!CooldownCheck("Ookamaitachi",(110*cooldownmultiplier),1))
					sleep(Move_In(M))
					if(M) Fuuton_Ookamaitachi()
				else if(wielding=="Fan"&&!CooldownCheck("Daikamaitachi",(90*cooldownmultiplier),1))
					sleep(Move_In(M))
					if(M) Fuuton_DaiKamaitachi()
				else if(!CooldownCheck("Shunshin",(30*cooldownmultiplier)+1,1))
					if(get_dist(src,M)<10&&ShunshinTest(get_step(M,M.dir)))
						dir=get_dir(src,M); Shunshin_no_Jutsu(get_step(M,M.dir))
						sleep(4)
						if(M) AI_Attack(M,25)
					else AI_Attack(M,24)
				else AI_Attack(M,24)

//------------------------------------------------------------------------------------------

mob/proc
	Fuuton_Kamaitachi()
		var/c=120
		if(Chakra<=c||GENERICATTACKCHECK(src))
			sleep(4)
		else
			flick("fan",src)
			firing=1; spawn(20)firing=0
			Chakra-=c
			view(4,src) << "<b>[src]: Kamaitachi no Jutsu!</b>"
			var/obj/Jutsu/Class/Fan/Kamaitachi/F=new/obj/Jutsu/Class/Fan/Kamaitachi(loc)
			F.Ninjutsu=Ninjutsu; F.WindElemental=WindElemental; F.dir=dir; F.Owner=src
			walk(F,dir)
			spawn(9){if(F)del(F)}
			sleep(4)

	Fuuton_DaiKamaitachi()
		var/c=200
		if(Chakra<=c||GENERICATTACKCHECK(src))
			sleep(4)
		else
			flick("fan",src)
			firing=1; spawn(20)firing=0
			Chakra-=c
			view(4,src) << "<b>[src]: Daikamaitachi no Jutsu!</b>"
			var/obj/Jutsu/Class/Fan/Daikamaitachi/F=new/obj/Jutsu/Class/Fan/Daikamaitachi(get_step(src,dir))
			var/obj/Jutsu/Class/Fan/Daikamaitachi/F2=new/obj/Jutsu/Class/Fan/Daikamaitachi
			var/obj/Jutsu/Class/Fan/Daikamaitachi/F3=new/obj/Jutsu/Class/Fan/Daikamaitachi
			F.Ninjutsu=Ninjutsu; F.WindElemental=WindElemental
			F.dir=dir; F.Owner=src
			F2.loc = (get_step(src,turn(dir,90))); F2.loc = get_step(F2,dir)
			F2.Ninjutsu=Ninjutsu; F2.WindElemental=(WindElemental*0.85)
			F2.dir=dir; F2.Owner=src
			F3.loc = (get_step(src,turn(dir,-90))); F3.loc = get_step(F3,dir)
			F3.Ninjutsu=Ninjutsu; F3.WindElemental=(WindElemental*0.85)
			F3.dir=dir; F3.Owner=src
			walk(F,dir); walk(F2,dir); walk(F3,dir)
			spawn(12)
				if(F)del(F)
				if(F2)del(F3)
				if(F3)del(F3)
			sleep(4)

	Fuuton_Ookamaitachi()
		var/c=400
		if(Chakra<=c||GENERICATTACKCHECK(src))
			sleep(3)
		else
			flick("fan",src)
			firing=1; spawn(20)firing=0
			Chakra-=c
			view(4,src) << "<b>[src]: Ookamaitachi no Jutsu!</b>"
			var/obj/Jutsu/Class/Fan/Ookamaitachi/F=new/obj/Jutsu/Class/Fan/Ookamaitachi(get_step(src,dir))
			var/obj/Jutsu/Class/Fan/Ookamaitachi/F2=new/obj/Jutsu/Class/Fan/Ookamaitachi
			var/obj/Jutsu/Class/Fan/Ookamaitachi/F3=new/obj/Jutsu/Class/Fan/Ookamaitachi
			F.Ninjutsu=Ninjutsu; F.WindElemental=WindElemental
			F.dir=dir; F.Owner=src
			F2.loc = (get_step(src,turn(dir,90))); F2.loc = get_step(F2,dir)
			F2.Ninjutsu=Ninjutsu; F2.WindElemental=(WindElemental*0.8)
			F2.dir=dir; F2.Owner=src
			F3.loc = (get_step(src,turn(dir,-90))); F3.loc = get_step(F3,dir)
			F3.Ninjutsu=Ninjutsu; F3.WindElemental=(WindElemental*0.8)
			F3.dir=dir; F3.Owner=src
			walk(F,dir); walk(F2,dir); walk(F3,dir)
			spawn(8)
				if(F)del(F)
				if(F2)del(F3)
				if(F3)del(F3)
			sleep(4)

	Fuuton_TatsuNoOoshigoto(mob/M)
		var/c=750
		if(Chakra<=c||GENERICATTACKCHECK(src))
			sleep(3)
		else
			flick("fan",src)
			firing=1; spawn(30)firing=0
			Chakra-=c
			view(4,src) << "<b>[src]: Fuuton: Tatsu no Ooshigoto!</b>"
			var/obj/Jutsu/Class/Fan/Ooshigoto/F=new/obj/Jutsu/Class/Fan/Ooshigoto()
			F.Ninjutsu=Ninjutsu; F.WindElemental=WindElemental; F.dir=dir; F.Owner=src
			var/t=M.loc
			spawn(10)
				if(M)
					F.loc=t
					if(F.loc==M.loc) F.Bump(M)
					else walk_towards(F,M,3)
			spawn(50){if(F)del(F)}
			sleep(10)


