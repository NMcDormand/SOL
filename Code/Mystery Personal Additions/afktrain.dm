//obj/SkillCards/Clan/Myst

mob/var/afktraining=0

obj/SkillCards/Clan/Myst/AFKTrain
	//icon_state="card_Kaiten"
	cmdstring="afktrain"
	Cooldown=5
	VerbIt=1
	CanLevel=0

	Description = list(
		"about"="AFK Train in SoM? Call an Admin!"
		,"title"="AFK Train"
		,"type"="Lazy"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="SSS"
//		,"pic"='Kaiten.png'
	)

	Activate(mob/U)
		if(U.afktraining) {U.afktraining=0; U.name=U.trueName; return;}
		U.afktraining=1; U.name="";
		U.afktraining()

mob/proc/afktraining()
	while(afktraining)
		if(Stamina<=15&&!resting) //We rest
			afk_rest()
		else if(!resting)
			afk_attack()
		var/wait=1
		if(atkspeed >=1) wait=atkspeed;
		sleep(wait)

mob/proc/afk_attack()
	//if(U.attacking) return;
	for(var/mob/M in get_step(usr,dir))
		if(Profession["Hand2Hand-Nin"]){H2HHits++}
		var/dmg=round(Taijutsu*0.9-(M.Taijutsu*0.09))
		dmg=max(dmg,round(Taijutsu*0.08)) // 8% of damage is the lowest you can go...
		dmg+=Weapons(M)
		if(dmg<round(Taijutsu*0.1)) dmg=round(Taijutsu*0.1)
		attacking=1; spawn(atkspeed){if(!meditating)attacking=0}
		flick("punch",src)
		if(M.TreeStump)
			StamUpTree()
			StamUpTree()
			if(H2HHits>3){
				H2HHits=0
				dmg*=1.8
				StamUpTree()//Proc it a second time for more training!
				if(!M.Cactus) {TreeStump(M,dmg,1); return}
				else if(M.Cactus) {Cactus(M,dmg,1); return}
			}
			else
				if(!M.Cactus) {TreeStump(M,dmg); return}
				else if(M.Cactus) {Cactus(M,dmg); return}
		else
			src<<"Please stand in front of a tree or cactus!";

mob/proc/afk_rest()
	icon_state="rest"; src<<"You sit down and rest"
	resting=1; spawn(12)rest()

proc/afkLoop()
	//Check Caps
		//Stam Cap
			//Check if weights (& how many)
		//Tai Cap
			//Check if Stump
			//Check if kage bunshin
			//Check if Reflexes
		//Gen Cap
		//Nin Cap
			//Check nin
			//Check elements