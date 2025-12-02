mob/Hittable/Responsive/NPC/KonohaInvasion/Gaara
	name="Gaara"
	icon='Base_Medium.dmi'
	Village="Sand"
	NinjaRank="Jounin"
	Taijutsu=58000; TaijutsuMax=58000
	Ninjutsu=155000; NinjutsuMax=155000
	Genjutsu=80000; GenjutsuMax=80000
	Stamina=4450000; StaminaMax=4450000
	Chakra=80000; ChakraMax=80000
	PE="Wind"; WindElemental=80000
	SE="Lightning"; LightningElemental=50000
	ChakraControl=100
	SS=2
	cooldownmultiplier=0.6
	Reflex=190
	movespeed=1
	gender="male"
	KillMessage="I shall kill you. I will not cease to exist."
	LiveMessage="You're only extending your suffering..."
	Locate_Darkness=100
	Locate_Kawarimi=100
	Locate_Camo=100
	Locate_Cloak=100
	Locate_MeiMei=100
	DispelOdds1=100
	DispelOdds2=100
	FirstAidSkill=20
	ThrowingSkill=880
	BunshinLimit=2
	SandArmour=1
	KillValue=80
	atkspeed = 4

	New()
		overlays+='BrownEyes.dmi'
		overlays+='gara_hair.dmi'
		overlays+='Gourd.dmi'
		NinStat()
		var/obj/Item/Bandages/F=new/obj/Item/Bandages(src); F.amount=20
		spawn(3)
			if(!KonohaInvasionAIList) KonohaInvasionAIList=new()
			KonohaInvasionAIList+=src
		spawn(rand(1,8))
			AI()
	Bump(mob/M)
		if(istype(M,/mob/)&&!istype(M,/mob/NPC))
			if(HitCheck(M))
				switch(pick(prob(230); 1,2))
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
				if((M.icon_state=="seals"&&prob(60))||InMirrors)
					Evade4(M)
				else if(M.Coffin&&!CooldownCheck("Funeral",(5000*cooldownmultiplier)+2)&&M in CoffinList)
					SubakuSouSou(M)
				else if(!CooldownCheck("SunaShuriken",(30*cooldownmultiplier),1))
					step_to(src,M,1); AI_SunaShuriken()
				else if(!CooldownCheck("SunaBunshin",(300*cooldownmultiplier),1))
					AI_SunaBunshin(M)
				else if(!CooldownCheck("Mugen",(70*cooldownmultiplier)+3,1))
					Move_Away_To_Aim1(M)
					Fuuton_MugenSajinDaitoppa()
				else AI_Attack(M,15)
			else if(M)
				if((M.icon_state=="seals"&&prob(65))||InMirrors)
					Evade4(M)
				else if(!CooldownCheck("Mugen",(70*cooldownmultiplier)+3,1))
					step_to(src,M,1); Fuuton_MugenSajinDaitoppa()
				else if(!CooldownCheck("SunaBunshin",(300*cooldownmultiplier),1))
					AI_SunaBunshin(); Move_In(M)
				else if(!CooldownCheck("SunaShuriken",(30*cooldownmultiplier),1))
					Move_Away_To_Aim2(M)
					spawn(8) {step_to(src,M,1); AI_SunaShuriken()}
				else if(!CooldownCheck("Shunshin",(35*cooldownmultiplier)+1,1))
					if(get_dist(src,M)<10&&ShunshinTest(get_step(M,M.dir)))
						dir=get_dir(src,M); Shunshin_no_Jutsu(get_step(M,M.dir))
						sleep(4)
						if(M) AI_Attack(M,15)
					else if(M) AI_Attack(M,18)
				else AI_Attack(M,10)

	Attack2(mob/M)
		if((sleepy||JubakuBound)&&prob(DispelOdds2)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(DispelOdds1/2)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(M&&get_dist(src,M)<4)
				if((M.icon_state=="seals"&&prob(60))||InMirrors)
					Evade4(M)
				else if(M.Coffin&&!CooldownCheck("Funeral",(5000*cooldownmultiplier)+2)&&M in CoffinList)
					spawn(6) SubakuSouSou(M)
				else if(!CooldownCheck("Gokusamaisou",(250*cooldownmultiplier)+3,1)&&!onwater&&!M.Coffin)
					step_to(src,M,1); Gokusamaisou(src)
				else if(!CooldownCheck("Mugen",(80*cooldownmultiplier)+6,1))
					Move_Away_To_Aim2(M); spawn(7) Fuuton_MugenSajinDaitoppa()
				else if(!CooldownCheck("Coffin",(1000*cooldownmultiplier)+2,1)&&!M.Coffin&&!M.Gokusamaisou)
					for(var/i=1,i<=5,i++)
						step_to(src,M,1)
						sleep(movespeed)
						if(get_dist(src,M)<=1) {SubakuKyou(src,M); break}
						sleep(movespeed)
					sleep(4)
				else AI_Attack(M,10)
			else if(M)
				if((M.icon_state=="seals"&&prob(60))||InMirrors)
					Evade4(M)
				else if(!CooldownCheck("Renkoudan",(80*cooldownmultiplier)+6,1))
					step_towards(src,M)
					if(dir==NORTH||dir==SOUTH||dir==EAST||dir==WEST) Fuuton_Renkoudan()
					else AI_Attack(M,10)
				else if(!CooldownCheck("Mugen",(70*cooldownmultiplier)+3,1))
					step_to(src,M,1); Fuuton_MugenSajinDaitoppa()
				else if(!CooldownCheck("Shunshin",(50*cooldownmultiplier)+1,1))
					if(get_dist(src,M)<10&&ShunshinTest(get_step(M,M.dir)))
						dir=get_dir(src,M); Shunshin_no_Jutsu(get_step(M,M.dir))
						sleep(4)
						if(!CooldownCheck("Coffin",(1000*cooldownmultiplier)+2,1)&&!M.Coffin&&!M.Gokusamaisou)
							for(var/i=1,i<=4,i++)
								step_to(src,M,1)
								sleep(movespeed)
								if(get_dist(src,M)<=1) {SubakuKyou(src,M); break}
								sleep(movespeed)
							sleep(4)
						else if(M) AI_Attack(M,25,86)
					else AI_Attack(M,25)
				else AI_Attack(M,13)

//------------------------------------------------------------------------------------------
mob/Hittable/Responsive/NPC/KonohaInvasion/Clones
	SunaBunshin
		drain=110
		drain2=0.0014
		Bump(mob/M)
			if(istype(M,/mob/)&&M==target)
				if(HitCheck(M))BunshinAttack(M)
				else M<<"You dodged [src]'s attack"
		Del()
			if(dead&&Explosive) {Explosive=0; ExplosiveBunshin()}
			else dead=1
			frozen=1
			var/mob/P=Creator
			if(src in P.KageBunshinList) P.KageBunshinList-=src
			flick("Suna Death",src)
			sleep(4)
			..()
proc
	Gokusamaisou(mob/U)
		var
			c=200; s=U.SS*1
		if(!(GENERICATTACKCHECK(U)) &&U.Chakra>c)
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				spawn(5) if(U)U.firing=0
				if(U)
					U.icon_state=null
					var/trapped=list()
					var/turf/T=get_step(U,U.dir); T=get_step(T,U.dir)
					hearers(4,U) << "<b>[U]: Gokusamaisou!</b>"
					var/obj/Jutsu/Gokusamaisou/Centre/C=new/obj/Jutsu/Gokusamaisou/Centre(T)
					for(var/mob/m in range(1,T))
						if(!m.Gokusamaisou&&m!=U&&!(m in trapped))
							if(m in U.KageBunshinList) del(m)
							if(m) {trapped+=m; m.Gokusamaisou=1; m<<"[U] has trapped you in sand!"}
					spawn(100) {del(C); for(var/mob/t in trapped) t.Gokusamaisou=0}
		sleep(20)

	SubakuKyou(mob/U, mob/M)
		var
			c=300; s=U.SS*2
		if(!(GENERICATTACKCHECK(U)) &&!InvisibilityCheck(U,M)&&U.Chakra>c)
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				if(U&&M&&get_dist(U,M)<2)
					U.icon_state=null
					spawn(15) U.firing=0
					U.CoffinList=new/list; U.Chakra-=c
					hearers(4,U)<<"<b>[U]: Sabaku Kyou!</b>"
					U.CoffinList+=M; M.overlays+='Coffin.dmi'; M.Coffin=1; M<<"<i>You are trapped in sand.</i>"
					spawn(140)
						if(U && M)
							if(M in U.CoffinList) {U.CoffinList-=M; M.overlays-='Coffin.dmi';}
						else
							if(M)
								if(M.Coffin)
									M.overlays-='Coffin.dmi';
									M.Coffin = 0
mob/proc
	SunaNoMayuDrain()
		while(SunaNoMayu)
			Chakra-=300
			if(Chakra<=300) {overlays+='UnSunaNoMayu.dmi'; overlays-='SunaNoMayu.dmi'; SunaNoMayu=0; spawn(5) overlays-='UnSunaNoMayu.dmi'}
			sleep(18)
		overlays+='UnSunaNoMayu.dmi'; overlays-='SunaNoMayu.dmi'; spawn(5) overlays-='UnSunaNoMayu.dmi'

	SubakuSouSou(mob/M)
		var
			c=480; s=SS*2
		if(Chakra>c)
			icon_state="seals"
			firing=1
			spawn(s)
				icon_state=null
				spawn(15)firing=0
				Chakra-=c
				hearers(4,src)<<"<b>[src]: Sabaku Sousou!</b>"
				spawn(5)
					if(M) {M.overlays-='Coffin.dmi'; flick("Funeral",M)}
				sleep(4)
				if(M) {CoffinList-=M; M.Coffin=0; M.DamageMe(src,((Ninjutsu*20)-M.Taijutsu))}

	AI_SunaShuriken()
		var/c=10
		if(!(GENERICATTACKCHECK(src))&&Chakra>c)
			throwing=1; spawn(9) throwing=0
			Chakra-=c
			var/obj/SandNin/SunaShuriken/S=new(loc)
			S.Taijutsu=Taijutsu*0.25; S.ThrowingSkill=ThrowingSkill; S.dir=dir; S.Owner=src
			walk(S,dir,1)
			spawn(10)del(S)

	AI_SunaBunshin(mob/M)
		var
			c=100; s=SS*1
		if(!(GENERICATTACKCHECK(src))&&Chakra>c)
			if(KageBunshinList.len>=BunshinLimit)
				for(var/mob/Hittable/Command/Clones/B in KageBunshinList)
					if(B) del(B)
					break
			icon_state="seals"
			firing=1
			spawn(s)
				icon_state=null
				spawn(9)firing=0
				Chakra-=c
				hearers(4,src)<<"<b>[src]: Suna Bunshin!</b>"
				var/mob/Hittable/Responsive/NPC/KonohaInvasion/Clones/SunaBunshin/B=new(loc)
				BunshinCreate(B,0.07)
				flick('Smoke.dmi',B)
				for(var/area/A in view(0,B)) A.Entered(B)
				sleep(2)
				if(M)
					B.target=M
					if(B.Status!=STATUS_ATTACK) {B.Status=STATUS_ATTACK; spawn()B.bunatck()}
				else del(B)
		sleep(4)

	Fuuton_MugenSajinDaitoppa()
		var
			c=175; s=SS*3
		if(!(GENERICATTACKCHECK(src))&&Chakra>c)
			icon_state="seals"
			firing=1
			spawn(s)
				spawn(1)icon_state=null
				spawn(2)firing=0
				Chakra-=c
				hearers(4,src) << "<b>[src]: Fuuton: Mugen Sajin Daitoppa!</b>"
				var/obj/Jutsu/Fuuton/MugenSajin/F1=new/obj/Jutsu/Fuuton/MugenSajin(get_step(src,dir))
				var/obj/Jutsu/Fuuton/MugenSajin/F2=new/obj/Jutsu/Fuuton/MugenSajin
				var/obj/Jutsu/Fuuton/MugenSajin/F3=new/obj/Jutsu/Fuuton/MugenSajin

				CreateProjectile(src,F1,"Wind",loc,dir,0,20,1,1.4)
				spawn(1)
					CreateProjectile(src,F2,"Wind",(get_step(src,turn(dir,90))),dir,0,20,1,0.7)
					CreateProjectile(src,F3,"Wind",(get_step(src,turn(dir,-90))),dir,0,20,1,0.7)
					F2.loc = get_step(F2,dir); F3.loc = get_step(F3,dir)
		sleep(4)