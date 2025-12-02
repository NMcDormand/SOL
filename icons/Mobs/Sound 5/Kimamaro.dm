mob/NPC/Sound5/Kimamaro
	name="Kimamaro"
	icon='Kimamaro.dmi'
	Village="Sound"
	NinjaRank="Jounin"
	Taijutsu=12000
	Ninjutsu=10000
	Genjutsu=4500
	MTaijutsu=12000
	MNinjutsu=10000
	MGenjutsu=4500
	stamina=290000
	mstamina=290000
	FireElemental=800
	WindElemental=200
	ChakraControl=100
	Reflex=25
	atkspeed=3
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
			view(3,src)<<"<b>[src] says:</b> Your efforts were in vain; I have beaten you."
			spawn(31)
				if(M)
					src.dir=get_dir(src,M)
					if(src.TaiAttackCheck(M)) return
					if(!M.KO)
						view(3,src)<<"<b>[src] says:</b> Impressive, you got up."
					else
						src.attacking=1; spawn(src.atkspeed+3)src.attacking=0
						flick("punch",src); M.Wounds=300; M.Kill(src)

	LocateTarget(mob/T)
		if(src.Darkness&&T)
			if(prob(12)) HitList+=T
		else if(T&&!T.icon)
			if(T.InKawarimi) {if(prob(95)&&T) HitList+=T}
			else if(T.InCamo) {if(prob(90)&&T) HitList+=T}
			else if(T.InCloak) {if(prob(50)&&T) HitList+=T}
			else if(T.InMeiMei) {if(prob(50)&&T) HitList+=T}
		else if(T) HitList+=T

	Attack1(mob/M)
		src.EquipBoneKunai()
		if((sleepy||JubakuBound)&&prob(98)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(60)) DispelProc()
		if(M&&M.KO)
			spawn(10) AI_KO(M)
		else if(!M)
			AI()
		else
			if(get_dist(src,M)>3)
				step_towards(src,M)
				spawn(2)
					if(M&&M.icon_state=="seals"&&prob(80)) src.Evade1(M)
					else if(M&&src.firing&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,12,78)
					else if(M) {Move_Away_To_Aim1(M); spawn(15) src.Teshi()}
					else AI()

			else
				if(M&&get_dist(src,M)>=2) {step_towards(src,M); src.Yanagi()}
				else if(M&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,10,66)
				else AI()

	Attack2(mob/M)
		src.EquipBoneSword()
		if((sleepy||JubakuBound)&&prob(87)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(40)) DispelProc()
		if(M&&M.KO)
			spawn(10) AI_KO(M)
		else if(!M)
			AI()
		else
			if(M&&get_dist(src,M)>5)
				if(M&&M.icon_state=="seals"&&prob(55)) Evade1(M)
				else if(M&&(src.firing||src.InKaramatsu)&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,14,25)
				else if(M) src.Karamatsu()
				else AI()
			else if(M&&get_dist(src,M)<4&&prob(70))
				if(M.icon_state=="seals"&&prob(60)) Evade1(M)
				else
					step_towards(src,M)
					spawn(2)
						if(M&&src.firing&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,16,50)
						else if(M&&!CooldownCheck("Sawarabi",1200)) src.Sawarabi()
						else if(M&&!M.kaiten&&!M.MushiKabe ) src.AI_Attack(M,15,90)
						else AI()
			else if(M)
				src.Move_Away_To_Aim2(M)
				spawn(6)
					if(M&&get_dist(src,M)>=2)
						step_towards(src,M)
						spawn(1)
							if(M&&(src.firing)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,18,88)
							else if(M) src.Teshi()
							else AI()
					else
						if(M&&M.icon_state=="seals") Evade1(M)
						if(M&&(src.firing)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,50)
						else if(M) Tsubaki()
						else AI()
			else AI()
///-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=--=-=-=
mob/proc
	EquipBoneKunai()
		if(src.wielding!="Dual Bone Kunais") {src.overlays-='BoneSword.dmi'; src.overlays+='DualBoneKunai.dmi'; src.wielding="Dual Bone Kunais"}
	EquipBoneSword()
		if(src.wielding!="Bone Sword") {src.overlays+='BoneSword.dmi'; src.overlays-='DualBoneKunai.dmi'; src.wielding="Bone Sword"}
	Yanagi()
		spawn(8) AI()
		for(var/mob/M in orange(1))
			if(get_dir(src,M)==NORTH||get_dir(src,M)==SOUTH||get_dir(src,M)==EAST||get_dir(src,M)==WEST)
				if(src.TaiAttackCheck(M)) return
				var/dmg=round(src.Taijutsu*0.7-(M.Taijutsu*0.12))
				dmg+=src.Weapons()
				if(dmg<round(src.Taijutsu*0.1)) dmg=round(src.Taijutsu*0.1)
				src.attacking=1; spawn(2)src.attacking=0
				flick("Yanagi",src)
				if(src.HitCheck(M))
					M.Death(src,dmg,"slashes")
				else
					src.attacking=1; spawn(10)src.attacking=null
					M<<"You dodged [src]'s attack"
	Tsubaki()
		spawn(8) AI()
		for(var/mob/m in orange(1))
			if(src.TaiAttackCheck(m)) return
		for(var/mob/M in orange(1))
			sleep(1)
			var/dmg=round(src.Taijutsu*0.8-(M.Taijutsu*0.11))
			dmg+=src.Weapons()
			if(dmg<round(src.Taijutsu*0.13)) dmg=round(src.Taijutsu*0.13)
			src.attacking=1; spawn(src.atkspeed)src.attacking=0
			flick("punch",src)
			//flick("SwordSpin",src)
			if(src.HitCheck(M))
				M.Death(src,dmg,"hacks at")
			else
				src.attacking=1; spawn(10)src.attacking=null
				M<<"You dodged [src]'s attack"
		spawn(8) AI()

	Karamatsu()
		spawn(8) AI()
		if(src.GenericAttackCheck()) return
		src.icon_state="seals"
		src.firing=1
		spawn(2)
			spawn(1)src.icon_state=null
			spawn(20)src.firing=0
			view(4,src)<<"<b>[src]: Karamatsu no Mai!</b>"; src.InKaramatsu=1
			//src.overlays+='karamatsu.dmi'
	Teshi()
		spawn(8) AI()
		if(src.GenericAttackCheck()) return
		src.icon_state="seals"
		src.firing=1
		spawn(1)
			spawn(1)src.icon_state=null
			spawn(40)src.firing=0
			view(4,src)<<"<b>[src]: Teshi Sendan!</b>"
			var/obj/Jutsu/Kaguya/TeshiSendan/H=new(src.loc)
			H.Ninjutsu=src.Ninjutsu; H.dir=src.dir; H.Owner=src; walk(H,src.dir)
			spawn(7)del(H)

	Sawarabi()
		if(src.GenericAttackCheck())
			spawn(8) AI()
		else
			spawn(48) AI()
			src.icon_state="seals"
			src.firing=1
			spawn(1)
				spawn(1)src.icon_state=null
				spawn(90)src.firing=0
				hearers(5,src)<<"<b>[src]: Sawarabi no Mai!</b>"
				src.InSawarabi=1; spawn(42)src.InSawarabi=0
				var/C=src.loc
				var/list/swa=list()
				var/damage=round((src.Ninjutsu+src.Taijutsu)*1.2)
				for(var/turf/T in range(3))
					var/obj/S=new/obj/Jutsu/Kaguya/Sawarabi
					S.layer=MOB_LAYER+1
					S.loc=T
					swa+=S
					spawn(40)del(S)
				src.SawarabiMovement(C,swa)
				spawn(12)
					for(var/mob/M in range(3,C))
						if(M&&M!=src) {range(6,M)<<"[M] takes damage from [src]'s Sawarabi no Mai."; M.Death(src,damage,"sawarabi")}
				spawn(22)
					for(var/mob/M in range(3,C))
						if(M&&M!=src) {range(6,M)<<"[M] takes damage from [src]'s Sawarabi no Mai."; M.Death(src,damage,"sawarabi")}
				spawn(32)
					for(var/mob/M in range(3,C))
						if(M&&M!=src) {range(6,M)<<"[M] takes damage from [src]'s Sawarabi no Mai."; M.Death(src,damage,"sawarabi")}