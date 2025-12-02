mob/Hittable/Responsive/NPC/KonohaInvasion/Baki
	name="Baki"
	icon='Base_Tan.dmi'
	Village="Sand"
	NinjaRank="Jounin"
	Taijutsu=58000; TaijutsuMax=58000
	Ninjutsu=60000; NinjutsuMax=60000
	Genjutsu=50000; GenjutsuMax=50000
	Stamina=1300000; StaminaMax=1300000
	Chakra=38000; ChakraMax=38000
	PE="Wind"; WindElemental=24000
	SE="Earth"; EarthElemental=15000
	ChakraControl=100
	SS=1
	cooldownmultiplier=0.8
	Reflex=170
	movespeed=1
	gender="male"
	KillMessage="A blade of the wind cannot be stopped by anyone."
	LiveMessage="So... the mouse continues to scurry around."
	Locate_Darkness=100
	Locate_Kawarimi=100
	Locate_Camo=100
	Locate_Cloak=100
	Locate_MeiMei=100
	DispelOdds1=100
	DispelOdds2=95
	FirstAidSkill=30
	KillValue=60

	New()
		var/icon/i=icon
		var/icon/E = new(i)
		NinStat()
		E.Blend('BrownEyes.dmi',ICON_OVERLAY)
		icon = E
		new/obj/Clothing/Over/Baki_Suit(src)
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
				switch(pick(prob(200); 1,2))
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
				if(M.icon_state=="seals"&&prob(85))
					Evade3(M)
				else if(!CooldownCheck("KazenoYaiba",(350*cooldownmultiplier),1))
					var/turf/T = loc; var/mob/m
					step_to(src,M,1)
					for(var/i=1;i<=2;i++)
						T=get_step(T,dir)
						if(T)
							m = locate() in T
							if(m&&m==M) break
							else m=null
					if(m) Kaze_no_Yaiba(m)
					else if(M) AI_Attack(M,6)
				else if(!CooldownCheck("Daitoppa",(70*cooldownmultiplier)+2,1))
					Move_Away_To_Aim2(M)
					sleep(4)
					if(M) {step_towards(src,M); Fuuton_Daitoppa()}
				else AI_Attack(M,20)
			else if(M)
				if(M.icon_state=="seals"&&prob(90))
					Evade1(M)
				else if(!CooldownCheck("Renkoudan",(90*cooldownmultiplier)+6,1))
					step_towards(src,M)
					if(dir==NORTH||dir==SOUTH||dir==EAST||dir==WEST) Fuuton_Renkoudan()
					else if(M) AI_Attack(M,10)
				else if(!CooldownCheck("Shunshin",(30*cooldownmultiplier)+1,1))
					if(get_dist(src,M)<10&&ShunshinTest(get_step(M,M.dir)))
						dir=get_dir(src,M); Shunshin_no_Jutsu(get_step(M,M.dir))
						sleep(4)
						if(M) AI_Attack(M,13)
					else AI_Attack(M,18)
				else AI_Attack(M,12)

	Attack2(mob/M)
		if((sleepy||JubakuBound)&&prob(DispelOdds2)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(DispelOdds1/2)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(M&&get_dist(src,M)<4)
				if(M.icon_state=="seals"&&prob(88))
					Evade3(M)
				else if(!CooldownCheck("KazenoYaiba",(280*cooldownmultiplier),1))
					var/turf/T = loc; var/mob/m
					step_to(src,M,1)
					for(var/i=1;i<=2;i++)
						T=get_step(T,dir)
						if(T)
							m = locate() in T
							if(m&&m==M) break
							else m=null
					if(m) Kaze_no_Yaiba(m)
					else if(M) AI_Attack(M,6)
				else if(!CooldownCheck("Daitoppa",(60*cooldownmultiplier)+2,1))
					Move_Away_To_Aim2(M)
					sleep(4)
					if(M) {step_towards(src,M); Fuuton_Daitoppa()}
				else if(M) AI_Attack(M,28)
			else if(M)
				if(M.icon_state=="seals"&&prob(85))
					Evade1(M)
				else if(!CooldownCheck("Renkoudan",(80*cooldownmultiplier)+6,1))
					step_towards(src,M)
					if(dir==NORTH||dir==SOUTH||dir==EAST||dir==WEST) Fuuton_Renkoudan()
					else if(M) AI_Attack(M,17)
				else if(!CooldownCheck("Shunshin",(30*cooldownmultiplier)+1,1))
					if(get_dist(src,M)<10&&ShunshinTest(get_step(M,M.dir)))
						dir=get_dir(src,M); Shunshin_no_Jutsu(get_step(M,M.dir))
						sleep(4)
						if(M) AI_Attack(M,25)
					else AI_Attack(M,25)
				else AI_Attack(M,25)

//------------------------------------------------------------------------------------------
mob/proc
	Fuuton_Renkoudan()
		var
			c=300; s=SS*6
		if(!(GENERICATTACKCHECK(src))&&Chakra>c)
			icon_state="seals"
			firing=1
			spawn(s)
				spawn(1)icon_state=null
				spawn(2)firing=0
				Chakra-=c
				view(4,src)<<"<b>[src]: Fuuton: Renkoudan!</b>"
				var/turf/LOC
				switch(usr.dir)
					if(NORTH)
						LOC = locate(usr.x-1,usr.y-2,usr.z)
					if(SOUTH)
						LOC = locate(usr.x-1,usr.y,usr.z)
					if(WEST)
						LOC = locate(usr.x,usr.y-1,usr.z)
					if(EAST)
						LOC = locate(usr.x-2,usr.y-1,usr.z)
					if(NORTHWEST)
						LOC = locate(usr.x,usr.y-2,usr.z)
					if(NORTHEAST)
						LOC = locate(usr.x-2,usr.y-2,usr.z)
					if(SOUTHWEST)
						LOC = locate(usr.x,usr.y,usr.z)
					if(SOUTHEAST)
						LOC = locate(usr.x-2,usr.y,usr.z)
				var/obj/Jutsu/Fuuton/Renkoudan/F=new(LOC)
				CreateProjectile(src,F,"Wind",LOC,dir,2,20,1,2.6)
				CentralJutsu=F
				sleep(4)

	Kaze_no_Yaiba(mob/M)
		var/c=1000
		if(Chakra>c&&!(GENERICATTACKCHECK(src)))
			firing=1; spawn(10)firing=0
			Chakra-=c
			view(4,src) << "<b>[src]: Kaze no Yaiba!</b>"
			M.overlays+='KazenoYaiba.dmi'; M.CantWalk++
			var/E=WindElemental-(M.FireElemental*0.4)
			var/N=Ninjutsu-(M.Ninjutsu*0.4)
			var/dmg=(N+(E*1.6))*4
			if(dmg<1)dmg=1
			dmg=round(dmg)
			hearers(6,M)<<"<i>[M] was hit by [src]'s Kaze no Yaiba!</i>"
			for(var/i=1;i<=3;i++)
				if(M) {M.Wounds+=3; hearers(6,M)<<"<i>[dmg] damage!</i>"; M.DamageMe(src,dmg)}
				sleep(3)
			if(M) {M.overlays-='KazenoYaiba.dmi'; M.CantWalk--}
			sleep(20)

	Shunshin_no_Jutsu(turf/T)
		return
		var
			c=60; s=SS*1
		if(Chakra>c&&!(GENERICATTACKCHECK(src)))
			icon_state="seals"
			firing=1
			spawn(s)
				spawn(1)icon_state=null
				spawn(30)firing=0
				var/d=dir
				Chakra-=c
				hearers(4,src)<<"<b>[src]: Shunshin no Jutsu!</b>"
				flick("kawarimi",src); flick('Flicker.dmi',src)
				spawn(3)
					flick("kawarimi",src); flick('Flicker.dmi',src)
					moving=1
					spawn(movespeed)
						moving=0
						if(get_dist(T,src)<10) {Move(T); dir=d}
	ShunshinTest(turf/t)
		return
		for(var/turf/T in orange(t,12)) if(T.density) T.opacity=1
		if(t in oview(12,src)) ShunshinnoJutsu(t)
		for(var/turf/tt in orange(t,12)) if(tt.density) tt.opacity=initial(tt.opacity)
