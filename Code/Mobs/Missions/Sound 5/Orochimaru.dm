mob/var/tmp/DeathSeeCooldown
mob/var
	HasBeenBitten
	OroBittenTimes
	DropsRares
mob/Hittable/Responsive/NPC/Mission/Sound5/Orochimaru
	name="Orochimaru"
	icon='Orochimaru.dmi'
	Clan = "???"
	Village="Sound"
	NinjaRank="Unknown"
	Taijutsu=90000
	Ninjutsu=100000
	Genjutsu=100000
	TaijutsuMax=90000
	NinjutsuMax=100000
	GenjutsuMax=100000
	Stamina=1300000
	StaminaMax=1300000
	FireElemental=5000
	WindElemental=5000
	ChakraControl=100
	Reflex=200
	gender="male"
	DropsRares=1
	CantHenge=1
	FinishMSG = "Keheheh, what a puny specimin"
	NotFinishMSG = "So you've got some fight left in you after all"

	Action(mob/user)
		if(get_dist(user,src)>2) return
		if(!user.HasEdo && user.SpokeToKabuto && InIllusion)
			user.SpokeToKabuto = 1
			user.HasEdo = 1
			user << "What a fine specimen"
			var/obj/SkillCards/Ninjutsu/Special/EdoTensei/Edo/J=locate() in contents
			if(!J)
				for(var/obj/Item/Scroll/ES in user.contents)
					if(ES.trueName == "Edo Tensei No Jutsu")
						del ES
				user.UpdateInventory()
				user<<"<b><font size=2>You've just learned <i>Edo Tensei no Jutsu</i>!</b></font>"
				new/obj/SkillCards/Ninjutsu/Special/EdoTensei/Edo(user)

/*	AI_KO(mob/M)
		if(M&&get_dist(src,M)>1)
			step_to(src,M)
		else if(M&&get_dist(src,M)<=1)
			view(3,src)<<"<b>[src] says:</b> Keheheh, what a puny specimin."
			for(var/mob/Hittable/Command/Clones/B in KageBunshinList) del(B)
			spawn(31)
				if(M)
					dir=get_dir(src,M)
					if(TAICHECKBOTH(src,M)) return
					if(!M.KO)
						view(3,src)<<"<b>[src] says:</b> So you've got some fight left in you after all."
					else
						attacking=1; spawn(atkspeed+3)attacking=0
						flick("punch",src); M.Wounds=300; M.KillMe(src)*/

	Attack1(mob/M)
		if((sleepy||JubakuBound)&&prob(100)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(70)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(get_dist(src,M)>3)
				step_to(src,M)
				if(M.icon_state=="seals"&&prob(90)) Evade1(M)
				else if(M.client&&prob(1+M.Luck)&&!M.HasSeal) M.CS_Bite(src)
				else if(firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,50)
				else {Move_Away_To_Aim1(M); spawn(15) Daitoppa()}

			else
				if(M&&!KageBunshinList.len&&prob(33)) ShadowClone(M)
				else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,14,66)

	Attack2(mob/M)
		if((sleepy||JubakuBound)&&prob(30)) {sleepy=0; DispelProc()}
		if((InNarakumi)&&prob(40)) DispelProc()
		if(M&&M.KO)
			AI_KO(M)
		if(M)
			if(get_dist(src,M)<3&&prob(30))
				if(M.icon_state=="seals"&&prob(70)) Evade1(M)
				else if(M.client&&prob(5+M.Luck)&&!M.HasSeal) M.CS_Bite(src)
				else if(firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,14,25)
				else AI_Attack(M,14,22)
			else if(get_dist(src,M)<5&&prob(50))
				if(M.icon_state=="seals"&&prob(75)) Evade1(M)
				else
					step_to(src,M)
					sleep(2)
					if(M&&firing&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,16,50)
					else if(M&&!DeathSeeCooldown) DeathForseeing(M)
					else if(M&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,18,33)
			else
				Move_Away_To_Aim2(M)
				spawn(6)
					if(M&&get_dist(src,M)>=2)
						step_to(src,M)
						sleep(1)
						if(M&&(firing)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,18,60)
						else if(M) Seneitajashu()
					else
						if(M&&M.icon_state=="seals") Evade1(M)
						if(M&&(firing)&&!M.kaiten&&!M.MushiKabe) AI_Attack(M,12,50)
						else if(M) Seneitajashu()

mob/proc
	Seneitajashu()
		if(GENERICATTACKCHECK(src))
			sleep(4)
			return
		else
			firing=1; spawn(40)firing=null
			flick("punch",src); sleep(1)
			var/obj/Jutsu/SnakesHand/S = new(loc)
			S.Ninjutsu=Ninjutsu
			S.dir=dir; S.name="[src]"; S.Owner=src
			walk(S,dir)
			spawn(8)
				if(S)
					del(S)

	DeathForseeing(mob/M)
		if(GENERICATTACKCHECK(src))
			sleep(4)
			return
		else
			firing=1; spawn(80)firing=null
			DeathSeeCooldown=1; spawn(345) DeathSeeCooldown=0
			view(M)<<"<b>[M] is scared to death...</b>"
			M.DeathSee=1;
			if(M.SharinganLevel>=3 && M.InSharingan)
				M.DeathForUndo(40)
				M<<"You escape with your Sharingan."
			else
				M.DeathForUndo()
			spawn(3)
				for(var/turf/A in range(9,M))
					var/image/X = image(/obj/TWorld/DeathSee,A)
					M << X
					spawn()
						if(M)
							M.RemoveDF(X)

	DeathForUndo(A=100)
		set waitfor = 0
		sleep(A)
		if(src)
			DeathSee=0

	RemoveDF(image/I)
		while(DeathSee)
			if(Dispel) break
			sleep(10)
		del(I)

	CS_Bite(mob/M)
		if(HasSeal) return
		view(src)<<"<b>Orochimaru has bitten [src] and infected \him with the Cursed Seal!</b>"
		HasSeal=1
		OroBittenTimes++;
		spawn(25)
			if(prob(((OroBittenTimes/6)*Oro_Bite_Chance)+(Luck*0.2)))
				var/obj/SkillCards/Taijutsu/CursedSeal_Earth/J=locate(/obj/SkillCards/Taijutsu/CursedSeal_Earth) in contents
				var/obj/SkillCards/Ninjutsu/CursedSeal_Heaven/K=locate(/obj/SkillCards/Ninjutsu/CursedSeal_Heaven) in contents
				if(!J && !K)
					choosing=1
					CSLevel=1
					CS=0
					new/obj/SkillCards/CS/CS_Basic(src)
					src<<"You have obtained the Curse Seal! If you do not want it, you still have the option to remove it!";
				choosing=0
			else {src<<"You did not survive the Curse Seal's effects; you are not compatible with the Cursed Seal."; Wounds=150; HasSeal=0; KillMe(M)}

obj
	TWorld/DeathSee
		icon='DeathSee.dmi'
		layer=20