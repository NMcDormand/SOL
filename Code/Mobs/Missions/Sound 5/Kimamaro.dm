mob/Hittable/Responsive/NPC/Mission/Sound5/Kimamaro
	name="Kimamaro"
	icon='Kimamaro.dmi'
	Village="Sound"
	Clan = "Kaguya"
	NinjaRank="Special Jounin"
	Taijutsu=22000
	Ninjutsu=18000
	Genjutsu=7500
	TaijutsuMax=22000
	NinjutsuMax=13000
	GenjutsuMax=7500
	Stamina=490000
	StaminaMax=490000
	FireElemental=800
	WindElemental=200
	ChakraControl=100
	Reflex=60
	atkspeed=3
	gender="male"
	CantHenge=1

	AI_KO(mob/M)
		if(M&&get_dist(src,M)>1)
			step_to(src,M)
		else if(M&&get_dist(src,M)<=1)
			view(3,src)<<"<b>[src] says:</b> Your efforts were in vain; I have beaten you."
			spawn(31)
				if(M)
					dir=get_dir(src,M)
					if(TAICHECKBOTH(src,M)) return
					if(!M.KO)
						view(3,src)<<"<b>[src] says:</b> Impressive, you got up."
					else
						attacking=1; spawn(atkspeed+3)attacking=0
						flick("punch",src); M.Wounds=300; M.KillMe(src)

	Attack1(mob/M)
		EquipBoneKunai()
		if((sleepy||JubakuBound)&&prob(98)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(60)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(get_dist(src,M)>3)
				step_towards(src,M)
				if(M&&M.icon_state=="seals"&&prob(80)) Evade1(M)
				else if(M&&firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,78)
				else if(M) {Move_Away_To_Aim1(M); spawn(15) Teshi()}

			else
				if(M&&get_dist(src,M)>=2) {step_towards(src,M); Yanagi()}
				else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,10,66)

	Attack2(mob/M)
		EquipBoneSword()
		if((sleepy||JubakuBound)&&prob(87)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(40)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(M&&get_dist(src,M)>5)
				if(M&&M.icon_state=="seals"&&prob(55)) Evade1(M)
				else if(M&&(firing||InKaramatsu)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,14,25)
				else if(M) Karamatsu()
			else if(M&&get_dist(src,M)<4&&prob(70))
				if(M.icon_state=="seals"&&prob(60)) Evade1(M)
				else
					step_towards(src,M)
					spawn(2)
						if(M&&firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,16,50)
						else if(M&&!CooldownCheck("Sawarabi",1200))
							//if(InSawa)
							Sawarabi()
						else if(M&&!M.kaiten&&!M.MushiKabe ) AI_Attack(M,15,90)
			else if(M)
				Move_Away_To_Aim2(M)
				spawn(6)
					if(M&&get_dist(src,M)>=2)
						step_towards(src,M)
						spawn(1)
							if(M&&(firing)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,18,88)
							else if(M) Teshi()
					else
						if(M&&M.icon_state=="seals") Evade1(M)
						if(M&&(firing)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,50)
						else if(M) Tsubaki()
///-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=--=-=-=
mob/proc
	EquipBoneKunai()
		if(wielding!="Dual Bone Kunais") {overlays-='BoneSword.dmi'; overlays+='DualBoneKunai.dmi'; wielding="Dual Bone Kunais"}

	EquipBoneSword()
		if(wielding!="Bone Sword") {overlays+='BoneSword.dmi'; overlays-='DualBoneKunai.dmi'; wielding="Bone Sword"}

	Yanagi()
		for(var/mob/M in orange(1))
			if(get_dir(src,M)==NORTH||get_dir(src,M)==SOUTH||get_dir(src,M)==EAST||get_dir(src,M)==WEST)
				if(TAICHECKBOTH(src,M)) return
				var/dmg=round(Taijutsu*0.7-(M.Taijutsu*0.12))
				dmg+=Weapons()
				if(dmg<round(Taijutsu*0.1)) dmg=round(Taijutsu*0.1)
				attacking=1; spawn(2)attacking=0
				flick("Yanagi",src)
				if(HitCheck(M))
					M.DamageMe(src,dmg,"slashes")
				else
					attacking=1; spawn(10)attacking=null
					M<<"You dodged [src]'s attack"

	Tsubaki()
		for(var/mob/M in orange(1))
			if(TAICHECKBOTH(src,M)) continue
			sleep(1)
			var/dmg=round(Taijutsu*0.8-(M.Taijutsu*0.11))
			dmg+=Weapons()
			if(dmg<round(Taijutsu*0.13)) dmg=round(Taijutsu*0.13)
			attacking=1; spawn(atkspeed)attacking=0
			flick("punch",src)
			//flick("SwordSpin",src)
			if(HitCheck(M))
				M.DamageMe(src,dmg,"hacks at")
			else
				attacking=1; spawn(10)attacking=null
				M<<"You dodged [src]'s attack"

	Karamatsu()
		if(GENERICATTACKCHECK(src)) return
		icon_state="seals"
		firing=1
		spawn(2)
			spawn(1)icon_state=null
			spawn(20)firing=0
			view(4,src)<<"<b>[src]: Karamatsu no Mai!</b>"; InKaramatsu=1
			//overlays+='karamatsu.dmi'

	Teshi()
		if(GENERICATTACKCHECK(src)) return
		icon_state="seals"
		firing=1
		spawn(1)
			spawn(1)icon_state=null
			spawn(40)firing=0
			view(4,src)<<"<b>[src]: Teshi Sendan!</b>"
			var/obj/Jutsu/Kaguya/TeshiSendan/H = new(loc)
			H.Ninjutsu=Ninjutsu; H.dir=dir; H.Owner=src; walk(H,dir)
			spawn(7)del(H)

	Sawarabi()
		if(GENERICATTACKCHECK(src))
			sleep(7)
			return
		else
			icon_state="seals"
			firing=1
			spawn(1)
				spawn(1)icon_state=null
				spawn(90)firing=0
				hearers(5,src)<<"<b>[src]: Sawarabi no Mai!</b>"
				InSawarabi=1; spawn(42)InSawarabi=0
				var/C=loc
				var/list/swa=list()
				var/damage=round((Ninjutsu+Taijutsu)*1.2)
				for(var/turf/T in range(3))
					var/obj/S=new/obj/Jutsu/Kaguya/Sawarabi
					S.layer=MOB_LAYER+1
					S.loc=T
					swa+=T
					spawn(40)del(S)
				spawn()
					var/turf/Start = loc
					while(InSawarabi && swa.len && !KO)
						loc = pick(swa)
						sleep(5)
					if(!KO)
						loc = Start
				for(var/i=1 to 4)
					sleep(10)
					spawn()
						for(var/mob/M in range(3,C))
							if(M&&M!=src) {range(6,M)<<"[M] takes damage from [src]'s Sawarabi no Mai."; M.DamageMe(src,damage,"sawarabi")}