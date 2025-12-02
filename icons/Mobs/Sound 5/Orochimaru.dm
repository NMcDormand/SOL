mob/var/tmp/DeathSeeCooldown
mob/var
	HasBeenBitten
	OroBittenTimes
	DropsRares
mob/NPC/Sound5/Orochimaru
	name="Orochimaru"
	icon='Orochimaru.dmi'
	Village="Sound"
	NinjaRank="Jounin"
	Taijutsu=40000
	Ninjutsu=50000
	Genjutsu=50000
	MTaijutsu=40000
	MNinjutsu=50000
	MGenjutsu=50000
	stamina=700000
	mstamina=700000
	FireElemental=5000
	WindElemental=5000
	ChakraControl=100
	Reflex=110
	gender="male"
	DropsRares=1
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
		spawn(20) AI()
		if(M&&get_dist(src,M)>1)
			step_to(src,M)
		else if(M&&get_dist(src,M)<=1)
			view(3,src)<<"<b>[src] says:</b> Keheheh, what a puny specimin."
			for(var/mob/NPC/Clones/B in src.KageBunshinList) del(B)
			spawn(31)
				if(M)
					src.dir=get_dir(src,M)
					if(src.TaiAttackCheck(M)) return
					if(!M.KO)
						view(3,src)<<"<b>[src] says:</b> So you've got some fight left in you after all."
					else
						src.attacking=1; spawn(src.atkspeed+3)src.attacking=0
						flick("punch",src); M.Wounds=300; M.Kill(src)

	LocateTarget(mob/T)
		if(src.Darkness&&T)
			if(prob(70)) HitList+=T
		else if(T&&!T.icon)
			if(T.InKawarimi) {if(prob(100)&&T) HitList+=T}
			else if(T.InCamo) {if(prob(100)&&T) HitList+=T}
			else if(T.InCloak) {if(prob(80)&&T) HitList+=T}
			else if(T.InMeiMei) {if(prob(90)&&T) HitList+=T}
		else if(T) HitList+=T


	Attack1(mob/M)
		if((sleepy||JubakuBound)&&prob(100)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(70)) DispelProc()
		if(M&&M.KO)
			spawn(5) AI_KO(M)
		else if(!M)
			AI()
		else
			if(get_dist(src,M)>3)
				step_to(src,M)
				spawn(2)
					if(M&&M.icon_state=="seals"&&prob(90)) src.Evade1(M)
					else if(M&&prob(1)&&!M.HasSeal) M.CS_Bite(src)
					else if(M&&src.firing&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,12,50)
					else if(M) {Move_Away_To_Aim1(M); spawn(15) src.Daitoppa()}
					else AI()

			else
				if(M&&!length(src.KageBunshinList)&&prob(33)) src.ShadowClone(M)
				else if(M&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,14,66)
				else AI()

	Attack2(mob/M)
		if((sleepy||JubakuBound)&&prob(30)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(40)) DispelProc()
		if(M&&M.KO)
			spawn(5) AI_KO(M)
		else if(!M)
			AI()
		else
			if(M&&get_dist(src,M)<3&&prob(30))
				if(M&&M.icon_state=="seals"&&prob(70)) Evade1(M)
				else if(M&&prob(5)&&!M.HasSeal) M.CS_Bite(src)
				else if(M&&src.firing&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,14,25)
				else if(M) src.AI_Attack(M,14,22)
				else AI()
			else if(M&&get_dist(src,M)<5&&prob(50))
				if(M.icon_state=="seals"&&prob(75)) Evade1(M)
				else
					step_to(src,M)
					spawn(2)
						if(M&&src.firing&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,16,50)
						else if(M&&!src.DeathSeeCooldown) src.DeathForseeing(M)
						else if(M&&!M.kaiten&&!M.MushiKabe) src.AI_Attack(M,18,33)
						else AI()
			else if(M)
				src.Move_Away_To_Aim2(M)
				spawn(6)
					if(M&&get_dist(src,M)>=2)
						step_to(src,M)
						spawn(1)
							if(M&&(src.firing)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,18,60)
							else if(M) src.Seneitajashu()
							else AI()
					else
						if(M&&M.icon_state=="seals") Evade1(M)
						if(M&&(src.firing)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,50)
						else if(M) Seneitajashu()
						else AI()
			else AI()

mob/proc
	Daitoppa()
		if(src.GenericAttackCheck())
			spawn(4) AI()
		else
			src.icon_state="seals"
			src.firing=1
			spawn(2)
				spawn(1)src.icon_state=null
				spawn(35)src.firing=0
				view(4,src) << "<b>[src]: Fuuton: Daitoppa!</b>"
				var/obj/Jutsu/FuutonDaitoppa/F=new/obj/Jutsu/FuutonDaitoppa(src.loc)
				F.Ninjutsu=src.Ninjutsu; F.WindElemental=src.WindElemental
				F.dir=src.dir; F.movespeed=2; F.name="[src]"; F.Owner=src
				walk(F,src.dir)
				spawn(10){if(F)del(F)}
			spawn(8) AI()

	ShadowClone(mob/M)
		if(src.GenericAttackCheck())
			spawn(4) AI()
		else
			src.icon_state="seals"
			src.firing=1
			spawn(3)
				src.icon_state=null
				spawn(12)src.firing=0
				view(4,src)<<"<b>[src]: Kage Bunshin!</b>"
				var/mob/NPC/Clones/KageBunshin/B=new(src.loc)
				B.name="[src]"; B.Village="[src.Village]"; B.dir=src.dir; B.movespeed=src.movespeed
				B.Creator=src; src.KageBunshinList+=B; B.icon=src.icon; B.overlays+=src.overlays
				B.stamina=round(src.mstamina*0.20); B.mstamina=B.stamina; B.Taijutsu=round(src.Taijutsu*0.15)
				B.KnifeSkill=src.KnifeSkill; B.SwordSkill=src.SwordSkill; B.wielding=src.wielding
				flick('Smoke.dmi',B)
				for(var/area/A in view(0,B)) A.Entered(B)
				if(M)
					B.target=M
					if(B.bunshinstatus!=status_attack) {B.bunshinstatus=status_attack; spawn()B.bunatck()}
				else
					del(B)
			spawn(8) AI()

	Seneitajashu()
		if(src.GenericAttackCheck())
			spawn(4) AI()
		else
			src.firing=1; spawn(40)src.firing=null
			flick("punch",src); sleep(1)
			var/obj/SnakesHand/S = new(src.loc)
			S.Ninjutsu=src.Ninjutsu
			S.dir=src.dir; S.name="[src]"; S.Owner=src
			walk(S,src.dir)
			spawn(8)del(S)
			spawn(7) AI()

	DeathForseeing(mob/M)
		if(src.GenericAttackCheck())
			spawn(4) AI()
		else
			src.firing=1; spawn(80)src.firing=null
			src.DeathSeeCooldown=1; spawn(345) src.DeathSeeCooldown=0
			view(M)<<"<b>[M] is scared to death...</b>"
			M.DeathSee=1;
			if(M.SharinganLevel==3&&M.InSharingan)
				spawn(40)if(M) M.DeathSee=0
				M<<"You escape with your Sharingan."
			else
				spawn(100)if(M) M.DeathSee=0
			spawn(3)
				for(var/turf/A in range(9,M))
					var/image/X = image(/obj/TWorld/DeathSee,A)
					M << X
					spawn()M.RemoveDF(X)
			spawn(11) AI()

	RemoveDF(image/I)
		while(src.DeathSee)
			if(src.Dispel) break
			sleep(10)
		del(I)


	CS_Bite(mob/M)
		if(src.HasSeal) return
		view(src)<<"<b>Orochimaru has bitten [src] and infected \him with the Cursed Seal!</b>"
		src.HasSeal=1
		src.OroBittenTimes++;
		spawn(15)
			if(M) M.AI()
		spawn(25)
			if(prob((OroBittenTimes/6)*Oro_Bite_Chance))
				var/obj/SkillCards/Taijutsu/CursedSeal_Earth/J=locate(/obj/SkillCards/Taijutsu/CursedSeal_Earth) in src.contents
				var/obj/SkillCards/Ninjutsu/CursedSeal_Heaven/K=locate(/obj/SkillCards/Ninjutsu/CursedSeal_Heaven) in src.contents
				if(!(J in src.contents) && !(K in src.contents))
					src.choosing=1
					src.CSLevel=1
					src.CS=0
					new/obj/SkillCards/CS/CS_Basic(src)
					src<<"You have obtained the Curse Seal! If you do not want it, you still have the option to remove it!";
				src.choosing=0
			else {src<<"You did not survive the Curse Seal's effects; you are not compatible with the Cursed Seal."; src.Wounds=150; src.HasSeal=0; src.Kill(M)}

obj
	SnakesHand
		name="snakes"
		icon='SnakeHands.dmi'
		density=1
		movespeed=0
		Del()
			if(AcquiredTarget)sleep(18)
			..()
		Bump(A)
			if(ismob(A))
				var/mob/M = A
				var/mob/O=src.Owner
				if(istype(M,/mob/NPC)) del(src)
				if(M.kaiten||M.protect||M.InGatsuuga||M.InMeatTank||M.InTsuuga||M.InGarouga) del(src)
				var/D=src.Ninjutsu*1.5-(M.Ninjutsu*0.20)
				if(D<=src.Ninjutsu*0.22) D=src.Ninjutsu*0.22
				src.AcquiredTarget=1
//				if(prob(20))
//					if(!M.Poisoned) {M.Poisoned=1; M.Poison(); M<<"<b>You have been poisoned by the snakes</b>"}
				if(prob(15))
					M<<"<b>You are bound by the snakes</b>"
					M.cantwalk=1; spawn(15)M.cantwalk=null
				M.Death(O,D,src); src.loc=locate(0,0,0)

			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)
	TWorld/DeathSee
		icon='DeathSee.dmi'
		layer=20