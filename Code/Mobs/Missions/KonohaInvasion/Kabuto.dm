mob/Hittable/Responsive/NPC/KonohaInvasion/Kabuto
	name="Kabuto"
	icon='Kabuto1.dmi'
	Village="Sound"
	NinjaRank="Anbu"
	Taijutsu=75000; TaijutsuMax=75000
	Ninjutsu=100000; NinjutsuMax=100000
	Genjutsu=100000; GenjutsuMax=100000
	Stamina=1500000; StaminaMax=1500000
	Chakra=28000; ChakraMax=28000
	PE="Earth"; EarthElemental=18000
	SE="Wind"; WindElemental=12000
	ChakraControl=100
	Reflex=150
	movespeed=1
	SS=1
	cooldownmultiplier=0.7
	gender="male"
	KillMessage="Hehehe...you can't beat me. You have no skills."
	LiveMessage="Hmm, unXPected..."
	Locate_Darkness=100
	Locate_Kawarimi=100
	Locate_Camo=100
	Locate_Cloak=100
	Locate_MeiMei=100
	DispelOdds1=100
	DispelOdds2=100
	FirstAidSkill=90
	KillValue=70
	atkspeed = 4

	New()
		overlays+='Spectacles.dmi'
		var/obj/Item/Bandages/F=new/obj/Item/Bandages(src); F.amount=30
		NinStat()
		spawn(3)
			if(!KonohaInvasionAIList) KonohaInvasionAIList=new()
			KonohaInvasionAIList+=src
		spawn(rand(1,8))
			AI()
	Bump(mob/M)
		if(istype(M,/mob/)&&!istype(M,/mob/NPC))
			if(HitCheck(M))
				switch(pick(prob(250); 1,2))
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
				if(M.icon_state=="seals"&&prob(70))
					Evade2(M)
				else if(healingself)
					AI_Attack(M,16)
				else if(!M.sliced&&InMesu)
					if(M.client)
						for(var/i=1,i<=4,i++)
							step_to(src,M,1)
							sleep(movespeed)
							if(get_dist(src,M)<=1) {TendonSlice(src,M); break}
							sleep(movespeed)
						InMesu=0; Cooldowns["ChakraNoMesu"]=world.time+(250*cooldownmultiplier)
					else
						AI_Attack(M,16); InMesu=0; Cooldowns["ChakraNoMesu"]=world.time+(250*cooldownmultiplier)
				else if(!CooldownCheck("DoryuuDango",(90*cooldownmultiplier)+2,1))
					if(InMesu) InMesu=0
					Move_Away_To_Aim2(M)
					sleep(6)
					if(M) {step_towards(src,M); Doton_DoryuuDango()}
				else if(!CooldownCheck("ChakraNoMesu",(700*cooldownmultiplier)+10,1)&&!M.sliced&&!InMesu)
					Move_In(M); ChakraNoMesu()
				else AI_Attack(M,16)
			else if(M)
				if(M.icon_state=="seals"&&prob(85))
					Evade1(M)
				else if(!CooldownCheck("DoryuuDango",(90*cooldownmultiplier)+2,1))
					if(InMesu) InMesu=0
					step_towards(src,M); Doton_DoryuuDango()
				else if(!CooldownCheck("Nehan",(1500*cooldownmultiplier)+10))
					if(InMesu) InMesu=0
					AI_NehanShoujanoJutsu()
				else if(!CooldownCheck("Shunshin",(30*cooldownmultiplier)+1,1))
					if(get_dist(src,M)<10&&ShunshinTest(get_step(M,M.dir)))
						if(InMesu) InMesu=0
						dir=get_dir(src,M); Shunshin_no_Jutsu(get_step(M,M.dir))
						spawn(4)
							if(M) AI_Attack(M,13)
							else AI()
					else if(M) AI_Attack(M,18)
				else AI_Attack(M,10)

	Attack2(mob/M)
		if((sleepy||JubakuBound)&&prob(DispelOdds2)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(DispelOdds1/2)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		else if(M)
			if(M&&get_dist(src,M)<4)
				if(M.icon_state=="seals"&&prob(85))
					Evade1(M)
				else if(healingself)
					if(M) AI_Attack(M,18)
				else if(!M.sliced&&InMesu)
					if(M.client)
						for(var/i=1,i<=5,i++)
							step_to(src,M,1)
							sleep(movespeed)
							if(get_dist(src,M)<=1) {TendonSlice(src,M); break}
							sleep(movespeed)
						InMesu=0; Cooldowns["ChakraNoMesu"]=world.time+(250*cooldownmultiplier)
					else
						AI_Attack(M,16)
						InMesu=0
						Cooldowns["ChakraNoMesu"]=world.time+(250*cooldownmultiplier)
				else if(!CooldownCheck("DoryuuDango",(90*cooldownmultiplier)+2,1))
					Move_Away_To_Aim2(M)
					sleep(7)
					if(M) {step_towards(src,M); Doton_DoryuuDango()}
				else AI_Attack(M,20)
			else if(M)
				if(M.icon_state=="seals"&&prob(85))
					Evade2(M)
				else if(!healing&&!healingself&&Wounds>65&&!CooldownCheck("Regen",(500*cooldownmultiplier)+2,1))
					Move_Away_To_Aim2(M); InyuShometsu()
				else if(!CooldownCheck("Nehan",(1300*cooldownmultiplier)+10))
					AI_NehanShoujanoJutsu()
				else if(!CooldownCheck("DoryuuDango",(90*cooldownmultiplier)+2,1))
					step_towards(src,M); Doton_DoryuuDango()
				else if(!CooldownCheck("Shunshin",(30*cooldownmultiplier)+1,1))
					if(get_dist(src,M)<10&&ShunshinTest(get_step(M,M.dir)))
						dir=get_dir(src,M); Shunshin_no_Jutsu(get_step(M,M.dir))
						sleep(4)
						if(M&&!M.sliced&&M.client)
							for(var/i=1,i<=4,i++)
								step_to(src,M,1)
								sleep(movespeed)
								if(get_dist(src,M)<=1) {TendonSlice(src,M); break}
								sleep(movespeed)
							InMesu=0
						else if(M) AI_Attack(M,25)
					else AI_Attack(M,25)
				else AI_Attack(M,12)

//------------------------------------------------------------------------------------------
mob/proc
	ChakraNoMesu()
		var
			c=60; s=SS*4
		if(!(GENERICATTACKCHECK(src))&&Chakra>c)
			icon_state="seals"
			firing=1; spawn(30) firing=0
			spawn(s) {icon_state=null; InMesu=1; ScalpelDrain()}
			sleep(s+10)

	TendonSlice(mob/U, mob/M)
		var/mob/m = locate() in get_step(U,U.dir)
		if(m&&m==M&&M)
			if(!TAICHECKBOTH(src,M)&&!M.sliced&&U.HitCheck(M))
				flick("punch",U)
				U.attacking=1; spawn(5)U.attacking=0
				M.sliced=1; M.Wounds+=12
				spawn(250)
					if(M&&M.sliced) {M.sliced=0; M<<"Your tendons have healed."}
				M.DamageMe(U,0,"sliced")
			else
				U.attacking=1; spawn(15)U.attacking=null
				M<<"You dodged [U]'s attack."

	InyuShometsu()
		var
			c=30; s=SS*2
		if(!(GENERICATTACKCHECK(src))&&Chakra>c)
			icon_state="seals"
			firing=1
			spawn(s)
				spawn(1)icon_state=null
				healingself=1; spawn(15)SelfShousenProc()
				sleep(5)