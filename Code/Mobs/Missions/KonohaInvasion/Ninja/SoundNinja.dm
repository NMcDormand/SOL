mob/Hittable/Responsive/NPC/KonohaInvasion/SoundNinja
	name="Sound Ninja"
	Village="Sound Invader"
	NinjaRank="Anbu"
	/*Taijutsu=25000; TaijutsuMax=25000
	Ninjutsu=25000; NinjutsuMax=25000
	Genjutsu=25000; GenjutsuMax=25000
	Stamina=900000; StaminaMax=900000
	Chakra=10000; ChakraMax=10000*/
	ChakraControl=100
	SS=2
	cooldownmultiplier=1
	Reflex=60
	movespeed=2
	gender="male"
	Locate_Darkness=50
	Locate_Kawarimi=50
	Locate_Camo=80
	Locate_Cloak=65
	Locate_MeiMei=100
	DispelOdds1=65
	FirstAidSkill=10
	SwordSkill=500
	KnifeSkill=500
	H2HSkill=500
	ThrowingSkill=750
	KillValue=8

	New()
		NinStat()
		spawn(rand(0,1))
			var/icon/i=pick(AI_IconList)
			var/icon/E = new(i)
			AssignRandomHair(pick(0,50,100,150),pick(0,50,100,150),pick(0,50,100,150))
			var/obj/Hair/h = locate() in src; if(h&&h.worn) overlays+=h.icon
			E.Blend('BrownEyes.dmi',ICON_OVERLAY)
			icon = E
			new/obj/Clothing/Pants/Pants(src)
			new/obj/Clothing/Shirt/LongSleeveShirt(src)
			new/obj/Clothing/Over/ChuuninVest(src)
			new/obj/Clothing/Head/Headband(src)
			for(var/obj/c in src)
				c.worn = 1
				overlays += c.icon
		spawn(2)
			switch(pick(1,2,3,4,5))
				if(1) {SE="Earth"; EarthElemental=8000}
				if(2) {SE="Lightning"; LightningElemental=8000}
				if(3) {SE="Water"; WaterElemental=8000}
				if(4) {SE="Fire"; FireElemental=8000}
				if(5) {SE="Wind"; FireElemental=8000}
			switch(pick(1,2,3,4,5))
				if(1) {PE="Earth"; EarthElemental=12000}
				if(2) {PE="Lightning"; LightningElemental=12000}
				if(3) {PE="Water"; WaterElemental=12000}
				if(4) {PE="Fire"; FireElemental=12000}
				if(5) {PE="Wind"; FireElemental=12000}
			switch(pick(1,2,3,4))
				if(1) {Speciality="Taijutsu"; Taijutsu+=rand(10000,12000)}
				if(2) {Speciality="Ninjutsu"; Ninjutsu+=rand(10000,12000)}
				if(3) {Speciality="Genjutsu"; Genjutsu+=rand(10000,12000)}
				if(4) {Speciality="All Round"; Genjutsu+=rand(3000,4000); Ninjutsu+=rand(3000,4000); Taijutsu+=rand(3000,4000)}
			switch(pick(1,prob(33); 2,3,4,prob(250); 5))
				if(1) {Class["Sword-Nin"] = 1; SwordSkill+=rand(50,200)}
				if(2) {Class["Medical-Nin"] = 1; FirstAidSkill+=rand(25,50)}
				if(3) {Class["Hand2Hand-Nin"] = 1; H2HSkill+=rand(50,200)}
				if(4) {Class["Sensory-Nin"] = 1; Locate_Darkness=100}
				if(5) Class["None"] = 1
			if(Class["Sword-Nin"])
				switch(pick(1,2))
					if(1) {overlays+='Katana.dmi'; wielding="Katana"}
					if(2) {overlays+='BroadSword.dmi'; wielding="Broad Sword"}
			else if(prob(25)&&!Class["Hand2Hand-Nin"])
				switch(pick(1,2,3))
					if(1) {overlays+='Kunai.dmi'; wielding="Kunai"}
					if(2) {overlays+='Katana.dmi'; wielding="Katana"}
					if(3) {overlays+='BroadSword.dmi'; wielding="Broad Sword"}
		spawn(3)
			var/obj/Weapon/Thrown/WindmillShuriken/X=new/obj/Weapon/Thrown/WindmillShuriken(src); X.amount=15
			var/obj/Item/Bandages/F=new/obj/Item/Bandages(src)
			if(Class["Medical-Nin"]) F.amount=20
			else F.amount=10
			if(!KonohaInvasionAIList) KonohaInvasionAIList=new()
			KonohaInvasionAIList+=src
		spawn(rand(1,8))
			AI()

	Bump(mob/M)
		if(istype(M,/mob/)&&!istype(M,/mob/NPC))
			if(HitCheck(M))
				if(Class["Sword-Nin"])
					AI_Punch(M)
				else switch(pick(prob(200); 1,2))
					if(1) AI_Punch(M)
					if(2) AI_Kick(M)
			else M<<"You dodged [src]'s attack"

	Attack1(mob/M)
		if((sleepy||JubakuBound)&&prob(DispelOdds1)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(DispelOdds1/2)) DispelProc()
		if(M)
			if(M.KO)
				AI_KO(M)
			else if(get_dist(src,M)<4)
				if(M.icon_state=="seals"&&prob(40))
					Evade1(M)
				else if(Class["Hand2Hand-Nin"]&&!CooldownCheck("TsutenKyaku",(250*cooldownmultiplier),1))
					attacking=1
					sleep(Move_In(M))
					attacking=0
					if(M)
						step_to(src,M,1)
						if(M in get_step(src,dir)) AITsuutenKyaku(M)
						else AI_Attack(M,12)
				else if(Class["Medical-Nin"]&&!CooldownCheck("RanshinShou",(600*cooldownmultiplier),1)&&!M.Nerves&&prob(30))
					attacking=1
					sleep(Move_In(M))
					attacking=0
					if(M)
						step_to(src,M,1)
						if(M in get_step(src,dir)) AI_Ranshin_Shou(src,M)
						else AI_Attack(M,12)
				else if(!CooldownCheck("Kyoumeisen",(1000*cooldownmultiplier),1)&&!M.Blasted&&prob(10))
					attacking=1
					sleep(Move_In(M))
					attacking=0
					if(M)
						step_to(src,M,1)
						if(M in get_step(src,dir)) AI_Kyoumeisen(src,M)
						else AI_Attack(M,12)
				else if(!CooldownCheck("specialty",(500*cooldownmultiplier),1))
					switch(Speciality)
						if("Taijutsu")
							spawn(Move_In(M))
								if(M) AI_Attack(M,20)
						if("Ninjutsu")
							spawn(Move_Away_To_Aim1(M))
								if(M)
									if(!CooldownCheck("ElementalJutsu",(110*cooldownmultiplier),1))
										AI_JutsuSelection()
									else if(!CooldownCheck("WindmillShuriken",(60*cooldownmultiplier),1))
										var/obj/Weapon/Thrown/WindmillShuriken/x = locate() in contents
										if(x&&x.amount>0) WindmillShuriken(src,M,x)
										else AI_Attack(M,14)
									else AI_Attack(M,14)
						else
							if(!CooldownCheck("WindmillShuriken",(60*cooldownmultiplier),1))
								var/obj/Weapon/Thrown/WindmillShuriken/x = locate() in contents
								if(x&&x.amount>0) WindmillShuriken(src,M,x)
								else AI_Attack(M,14)
							else AI_Attack(M,14)
				else if(!CooldownCheck("ElementalJutsu",(110*cooldownmultiplier),1))
					spawn(Move_Away_To_Aim1(M)) AI_JutsuSelection()
				else if(!CooldownCheck("WindmillShuriken",(60*cooldownmultiplier),1))
					var/obj/Weapon/Thrown/WindmillShuriken/x = locate() in contents
					if(x&&x.amount>0)
						spawn(Move_Away_To_Aim1(M))
							if(M) WindmillShuriken(src,M,x)
					else AI_Attack(M,14)
				else AI_Attack(M,12)

			else
				if(M.icon_state=="seals"&&prob(50))
					Evade3(M)
				else if(Class["Hand2Hand-Nin"]&&!CooldownCheck("Oukashou",(100*cooldownmultiplier),1))
					spawn(Move_In(M))
						if(M)
							step_to(src,M,1)
							if(M in get_step(src,dir)) AIOukashou(M)
							else AI_Attack(M,12)
				else if(!CooldownCheck("specialty",(500*cooldownmultiplier),1))
					switch(Speciality)
						if("Taijutsu")
							spawn(Move_In(M))
								if(M) AI_Attack(M,20)
						if("Ninjutsu")
							spawn(Move_Away_To_Aim1(M))
								if(M)
									if(!CooldownCheck("ElementalJutsu",(110*cooldownmultiplier),1))
										AI_JutsuSelection()
									else if(!CooldownCheck("WindmillShuriken",(60*cooldownmultiplier),1))
										var/obj/Weapon/Thrown/WindmillShuriken/x = locate() in contents
										if(x&&x.amount>0) WindmillShuriken(src,M,x)
										else AI_Attack(M,14)
									else AI_Attack(M,14)
						if("Genjutsu")
							if(!M.IsBlinded&&!InvisibilityCheck(src,M)&&!CooldownCheck("Kokuangyou",(1800*cooldownmultiplier)+(SS*17),1))
								if(get_dist(src,M)>6)
									spawn(Move_In(M))
										if(M) AI_Kokuangyou(M)
								else AI_Kokuangyou(M)
							else if(!CooldownCheck("Nehan",(1500*cooldownmultiplier)+(SS*10),1))
								AI_NehanShoujanoJutsu()
							else
								AI_Attack(M,14)
						else
							if(!CooldownCheck("WindmillShuriken",(60*cooldownmultiplier),1))
								var/obj/Weapon/Thrown/WindmillShuriken/x = locate() in contents
								if(x&&x.amount>0) WindmillShuriken(src,M,x)
								else AI_Attack(M,14)
							else AI_Attack(M,14)


				else if(!CooldownCheck("ElementalJutsu",(110*cooldownmultiplier),1))
					AI_JutsuSelection()
				else if(!CooldownCheck("WindmillShuriken",(60*cooldownmultiplier),1))
					var/obj/Weapon/Thrown/WindmillShuriken/x = locate() in contents
					if(x&&x.amount>0) WindmillShuriken(src,M,x)
					else AI_Attack(M,14)
				else AI_Attack(M,12)