mob/Hittable/Responsive/Animal/Pet
	Dog
		icon='smallDog.dmi'
		OriginalIcon='smallDog.dmi'
		name = "dog"

		movespeed=1
		taitraining=0

		Stamina=40
		StaminaMax=40
		StaminaTrue=40
		StaminaXP=0
		StaminaMXP=100

		Chakra =1
		ChakraMax=1
		ChakraTrue=1

		Taijutsu=5
		TaijutsuMax=5
		TaijutsuTrue=5
		TaijutsuXP=0
		TaijutsuMXP=50

		Genjutsu =1
		GenjutsuMax=1
		GenjutsuTrue=1

		Ninjutsu =1
		NinjutsuMax=1
		NinjutsuTrue=1

		Bump(mob/M)
			if(istype(M,/mob/Hittable/Command/Genjutsu/FakeView))
				density = 0
				spawn(1)
					density = 1
			else if(istype(M,/mob/))
				DogAttack(M)

mob/Hittable/Responsive/Animal/Pet
	VetPet
		icon='Dog.dmi'
		name = "Dog"

		Stamina=999999999
		StaminaMax=1

		Taijutsu=9999999999
		TaijutsuMax=1
		TaijutsuTrue=1

		Genjutsu =99999999999
		GenjutsuMax=1
		GenjutsuTrue=1

		Ninjutsu =999999999999
		NinjutsuMax=1
		NinjutsuTrue=1

mob/Hittable/Responsive/Animal/Wild
	Dog
		icon='smallDog.dmi'
		name = "dog"
		CantHenge=1

		movespeed=1
		taitraining=0

		Stamina=250
		StaminaMax=250

		Chakra =1

		Taijutsu=80
		TaijutsuMax=80
		Genjutsu=1
		GenjutsuMax=1
		Ninjutsu=1
		NinjutsuMax=1
		var/FurColour ="#000000"
		/*New()
			respawn=loc
			spawn(120) Wander()
			var/colours= list("white", "red", "blue", "grey", "black");
			switch(pick(colours))
				if("white")
					icon='smallDog.dmi'; DogColour="white"
				if("red")
					icon='smallDogRed.dmi'; DogColour="red"
				if("black")
					icon='smallDogBlack.dmi'; DogColour="black"
				if("grey")
					icon='smallDogGrey.dmi'; DogColour="grey"
				if("blue")
					icon='smallDogBlue.dmi'; DogColour="blue"*/

mob/Hittable/Responsive/Animal/Pet
	New(LOC)
		loc = LOC
		trueName = name

	proc/DogAttack(mob/M)
		var/mob/O=Master
		if(M&&M!=O)
			if(TAICHECKBOTH(src,M)) return
			var/dmg=round(Taijutsu*0.9-(M.Taijutsu*0.09))
			if(dmg<round(Taijutsu*0.1)) dmg=round(Taijutsu*0.1)
			attacking=1; spawn(atkspeed)attacking=0
			if(M.TreeStump)
				if(Stamina<=15&&reset) return
				if(Stamina<=15&&!reset)
					O<<"[src] is too tired to attack the stump"
					reset=1; spawn(20)reset=0
					return
				flick("attack",src)
				O.StatUpdate_dogStuff()
				if(!M.Cactus) {TreeStump(M,dmg); return}
				else if(M.Cactus) {Cactus(M,dmg); return}
			flick("attack",src)
			if(HitCheck(M))
				M.DamageMe(src,dmg,"attacks")
				O.StatUpdate_dogStuff()
				var/taiup=rand(3,5)
				if(M)
					TaijutsuXP+=(taiup+M.taitraining)
				//Taiup()
				var/stamup=rand(2,4); StamUpTree()
				ApplyDogEXP(stamup,"stam")
				ApplyDogEXP(taiup,"tai")
			else
				attacking=1
				spawn(15)attacking=null
				src<<"[M] dodged the attack!"; M<<"You dodged [src]'s attack"
//-------------------------------------
mob/proc
	Wander()
		set background=1
		spawn(rand(1,50))
			while(!dead)
				for(var/mob/player/M in MasterPlayerList) if(get_dist(src,M)<11) steprand()
				sleep(55)

	Wander_Sentry()
		set background=1
		loc=respawn
		while(!dead)
			var
				w=0; t=0
			var/list/tmplist=VillageChecker()
			if(length((HitList|tmplist)))
				for(var/mob/h in (HitList|tmplist))
					if(h&&get_dist(src,h)<13)
						if((h in HitList))t=1
						else if((h in tmplist)&&(BountyCheck(h))) t=1
						else w=1
					else for(var/mob/H in MasterPlayerList)
						if(h&&get_dist(src,H)<11)
							if(!istype(H,/mob/NPC)) VillageHitListCheck(H)
							if(istype(H,/mob/player)) w=1
			else for(var/mob/h in MasterPlayerList)
				if(h&&get_dist(src,h)<11)
					if(!istype(h,/mob/NPC)) VillageHitListCheck(h)
					if(istype(h,/mob/player)) w=1
			for(var/mob/CR in view(10,src))
				if(CR.Aggressive||istype(CR,/mob/Hittable/Responsive/NPC/Criminal))
					t++
					break
			if(t)
				break
			else if(w)
				if(get_dist(src,respawn)<5) steprand()
				else step(src,get_dir(src,respawn))
				sleep(40)
			else
				if(get_dist(src,respawn)>5) step(src,get_dir(src,respawn))
				sleep(66)
		Wandering = 0