mob/VerbHolder/Admin/Creator/verb
	CheckFines(mob/M in MasterPlayerList)
		set category="ARREST"
		if(M)
			for(var/X in M.Fines) usr<<"[X] Fines: [M.Fines[X]]"
	All_Fines()
		set category="ARREST"
		for(var/mob/M in MasterPlayerList)
			if(M.Village==usr.Village)
				usr<<"[M]'s [M.Village] Fines: [M.Fines[usr.Village]]"

mob/var
	Fines[0]
	VillageJailTime=0
	VillageJailed
	Pickpocketing
	Bribed
	tmp/JailDoor
proc
	VillageJail_Fines(mob/victim,mob/attacker,TYPE,DAMAGE)
		if(!(attacker.Provoke)) attacker.Provoke=new()
		if((victim in attacker.Provoke)) return
		if(!(attacker.Fines)) attacker.Fines=new()
		switch(TYPE)
			if("attack")
				attacker.Fines[attacker.Village]+=attacker.FineCalculator(victim,DAMAGE)
				//spawn(10) attacker.ArrestCheck()
			if("murder")
				attacker.Fines[attacker.Village]+=attacker.FineCalculator(victim,"murder")
				//attacker.ArrestCheck()

mob/proc
	VillageJailTimeCalculator()
		VillageJailTime=(Fines[Village]*0.7)

	ArrestCheck()
		spawn(1)
			if(Fines[Village]>=8000)
				for(var/i=1,i<=7,i++)
					if(InVillage!=Village) break
					sleep(10)
				if(Fines[Village]>=8000&&InVillage==Village) Arrest()

	FineCalculator(mob/victim,crime)
		if(isnum(crime))
			Fines[Village]+=round((crime/2000))
		else if(istext(crime))
			if(crime=="murder")
				Fines[Village]+=5000
				if(Rank2Num(NinjaRank) > 7)
					Fines[Village]+=10000
	Arrest()
		return
		if(VillageJailTime) return
		VillageJailTimeCalculator()
		PlaySound("poof")
		var/mob/NPC/Police/a=new/mob/NPC/Police(get_step(src,dir))
		var/mob/NPC/Police/b=new/mob/NPC/Police(get_step(src,turn(dir,90)))
		var/mob/NPC/Police/c=new/mob/NPC/Police(get_step(src,turn(dir,-90)))
		a.dir=get_dir(a,src); b.dir=get_dir(b,src); c.dir=get_dir(c,src)
		protect=1; CantWalk++
		sleep(20)
		switch(input(src,"[name], you're under arrest for crimes against [Village] and its shinobi! Pay the fines or go to jail.","You're under arrest!") in list("Pay the fine","Go to jail"))
			if("Pay the fine")
				if(gold>=Fines[Village])
					gold-=Fines[Village]
					VillageJailTime=0; Fines[Village]=0
					protect=0; CantWalk--
					if(a) del(a)
					if(b) del(b)
					if(c) del(c)
					src<<"You pay off all your fines."
				else
					alert("You don't have enough gold!")
					flick('Smoke.dmi',a)
					flick('Smoke.dmi',b)
					flick('Smoke.dmi',c)
					flick('Smoke.dmi',src)
					SendToJail(a,b,c)
			if("Go to jail")
				flick('Smoke.dmi',a)
				flick('Smoke.dmi',b)
				flick('Smoke.dmi',c)
				flick('Smoke.dmi',src)
				SendToJail(a,b,c)

	EscapeArrest()
		var/obj/Item/JailKey/K = locate() in usr
		if(K) {del(K); UpdateInventory(K)}
		VillageJailTimeCalculator()
		PlaySound("poof")
		var/mob/NPC/Police/b=new/mob/NPC/Police(get_step(src,turn(dir,90)))
		var/mob/NPC/Police/c=new/mob/NPC/Police(get_step(src,turn(dir,-90)))
		b.dir=get_dir(b,src); c.dir=get_dir(c,src)
		protect=1; CantWalk++
		sleep(12)
		flick('Smoke.dmi',b)
		flick('Smoke.dmi',c)
		flick('Smoke.dmi',src)
		SendToJail(,b,c)

	SendToJail(mob/a,mob/b,mob/c)
		ZCoord="[Village] Jail"
		var/list/JailSpawns=list()
		for(var/obj/SpawnPoints/Jail/J in JailSpawnPoints)
			if(J.name==Village) JailSpawns+=J.loc
		loc=pick(JailSpawns)
		dir=2
		if(a) a.loc=(get_step(src,dir))
		if(b) b.loc=(get_step(src,turn(dir,90)))
		if(c) c.loc=(get_step(src,turn(dir,-90)))
		spawn(20)
			if(a||b||c) PlaySound("poof")
			if(a) del(a)
			if(b) del(b)
			if(c) del(c)
		src<<"You have been placed in jail for your crimes against [Village] Village. You will remain here until you've done your time."
		VillageJailed=1; Escaping=0
		if(CantWalk)
			CantWalk--
		for(var/obj/Jail/JailDoor/j in range(src,4)) JailDoor=j
		spawn()VillageJailCountdown()

	VillageJailCountdown()
		while(VillageJailTime>0)
			VillageJailTime-=100
			sleep(100)
		var/obj/d=JailDoor
		if(d) d.icon_state="open"
		src<<"You have paid your debt to society and may now leave the jail."
		VillageJailTime=0; Fines[Village]=0; Bribed=0

mob/NPC/Police
	name="Village Police Officer"
	NinjaRank="Jounin"
	protect=1
	layer=4
	New()
		var/icon/i=pick(AI_IconList)
		var/icon/E = new(i)
		E.Blend('BrownEyes.dmi',ICON_OVERLAY)
		flick('Smoke.dmi',src)
		icon = E
		new/obj/Clothing/Pants/Pants(src)
		new/obj/Clothing/Shirt/LongSleeveShirt(src)
		new/obj/Clothing/Over/ChuuninVest(src)
		new/obj/Clothing/Head/Headband(src)
		for(var/obj/C in src)
			C.worn = 1
			overlays += C.icon
		AssignRandomHair(pick(0,80),pick(0,80),pick(0,80))
		var/obj/Hair/h = locate() in src; if(h&&h.worn) overlays+=h.icon
		..()
	Del()
		flick('Smoke.dmi',src)
		return ..()
mob/var/tmp
	EastPatrol
	WestPatrol
	MidPatrol
	Patroling
	Escaping

mob/NPC/Jailer
	name="Jailer"
	NinjaRank="Chuunin"
	icon='Base_Tan.dmi'
	protect=0
	Stamina=600000; StaminaMax=600000
	Taijutsu=25000; Genjutsu=40000; Ninjutsu=20000
	Reflex=60
	layer=4
	New()
		var/icon/i=pick(AI_IconList)
		var/icon/E = new(i)
		E.Blend('BrownEyes.dmi',ICON_OVERLAY)
		flick('Smoke.dmi',src)
		icon = E
		new/obj/Clothing/Pants/Pants(src)
		new/obj/Clothing/Shirt/LongSleeveShirt(src)
		new/obj/Clothing/Over/ChuuninVest(src)
		new/obj/Clothing/Head/Headband(src)
		for(var/obj/C in src)
			C.worn = 1
			overlays += C.icon
		AssignRandomHair(pick(0,80),pick(0,80),pick(0,80))
		var/obj/Hair/h = locate() in src; if(h&&h.worn) overlays+=h.icon
		spawn(3)
			for(var/obj/Jail/Patrol/East/ED in range(src,30)) if(ED.y==y) EastPatrol=ED
			for(var/obj/Jail/Patrol/Mid/MD in range(src,20)) if(MD.y==y) MidPatrol=MD
			for(var/obj/Jail/Patrol/West/WD in range(src,1)) if(WD.y==y) WestPatrol=WD
			Patrol()
		respawn=loc
		..()
	Action(mob/user)
		set src in oview(4)
		if(get_dist(user,src)<=2 && user.dir==get_dir(user,src))
			if(firing) return
			firing=1; spawn(100) firing=0
			if(prob(20))
				usr<<"You pick pocketed the jailer's key!"
				new/obj/Item/JailKey(usr)
				usr.UpdateInventory(); usr.Pickpocketing=1
			else usr<<"You failed to grab the key"
		else
			if(user.VillageJailTime)
				switch(pick(1,2,3,4,5,6,7,8,prob(10); 9))
					if(1) user<<"Heheh, [user.Village]'s finest, locked up!"
					if(2) user<<"What is it, maggot?"
					if(3) user<<"If I had my way, you wouldn't even get a bed..."
					if(4) user<<"*grumble*"
					if(5) user<<"I don't get paid enough for this crap"
					if(6) user<<"Urgh! I have to babysit <i>you</i>?!"
					if(7) user<<"What are you in here for? Steal from the pick 'n' mix?"
					if(8) user<<"I don't socialise with the likes of you."
					if(9) user<<"What I wouldn't do for 2000 gold..."
			else if(user.Fines[user.Village])
				switch(pick(1,2,3,4,5))
					if(1) user<<"Hmm, you look troublesome..."
					if(2) user<<"Go away pest!"
					if(3) user<<"You're not welcome here."
					if(4) user<<"Hah, won't be long before I see you on the other side of these bars."
					if(5) user<<"Urgh, leave me..."
			else
				switch(pick(1,2,3,4,5))
					if(1) user<<"Hello there, [user], You look like a fine shinobi!"
					if(2) user<<"What can I do for you?"
					if(3) user<<"Do you want something?"
					if(4) user<<"Can't you see I'm busy?"
					if(5) user<<"You wouldn't believe the kind of scum that gets put behind these bars!"
mob/NPC/proc
	BribeCheck()
		while(Patroling)
			var/obj/gold/g = locate() in oview(src,2)
			if(g&&g.Bribe&&g.gold>=500)
				var/mob/B=g.Bribe
				if(B.Bribed) break
				Patroling=0
				sleep(10)
				hearers(2,src)<<"Hmm, what's this??"
				while(g&&get_dist(src,g)>=2)
					step_to(src,g,1)
					sleep(3)
				sleep(60)
				if(g&&g.gold>=2000&&B) {B.Bribed=1; B<<"This'll buy me lots of lovely things!  Here, I'll halve your jail time, but don't tell anyone; it'll be <i>our little secret</i>."; B.VillageJailTime/=2; del(g)}
				else if(g&&B) {B<<"I'll take that, but it won't get you anywhere."; del(g)}
				else if(B) B<<"Quit fooling around!"
				else if(g) del(g)
			sleep(10)
		spawn(25) Patrol()
	Patrol()
		if(Patroling) return

		if(!(length(MasterPlayerList)))
			spawn(30) Patrol()
			return

		var/x=0
		for(var/mob/player/p in MasterPlayerList)
			if(get_dist(src,p)<40)	 {x=1; break}
		if(!x)
			spawn(30) Patrol()
			return

		Patroling=1
		spawn()BribeCheck()
		while(get_dist(src,MidPatrol)>1&&Patroling)
			step_to(src,MidPatrol)
			sleep(8)
		if(!Patroling) return
		sleep(30)
		while(get_dist(src,EastPatrol)>1&&Patroling)
			step_to(src,EastPatrol)
			sleep(8)
		if(!Patroling) return
		sleep(10)
		while(get_dist(src,MidPatrol)>1&&Patroling)
			step_to(src,MidPatrol)
			sleep(8)
		if(!Patroling) return
		sleep(30)
		while(get_dist(src,WestPatrol)>1&&Patroling)
			step_to(src,WestPatrol)
			sleep(8)
		if(!Patroling) return
		Patroling=0

	LineOfSight(mob/m)
		while(m.Pickpocketing)
			var/turf/T=loc; var/mob/M
			for(var/i=1;i<=3;i++)
				T = get_step(T,dir)
				if(T)
					M = locate() in T
					if(M&&M==m) break
					else M=null
			if(M)
				hearers(6,src)<<"<b>Guards! [M] is trying to escape!</b>"
				M.EscapeArrest()
			sleep(3)

obj/var
	Bribe
	Open
obj/Jail
	JailDoor
	icon='Jail.dmi'
	icon_state="door"
	layer=MOB_LAYER+1
	Entered()
		if(Open) usr.Escaping=1
	verb
		Open()
			set name="Open Jail Door"
			set src in oview(1)
			var/obj/Item/JailKey/K = locate() in usr
			if(K)
				hearers(4,src)<<"The door creaks open..."
				sleep(10)
				icon_state="open"
				usr.Escaping=1; Open=1
				spawn(30)
					Open=0; icon_state="door"; hearers(4,src)<<"The door shut."
					for(var/mob/m in loc) m.Escaping=0

			else usr<<"You don't have the key!"

	Patrol
		icon=null
		East
		West
		Mid

obj/Item/JailKey
	name="Key"
	icon='Key.dmi'