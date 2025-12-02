mob/var/tmp/hospital
mob/NPC/Hospital
	Medic
		icon='Medic.dmi'
		name = "Medic"
		movespeed=3
		taitraining=0
		Stamina=10000
		StaminaMax=10000
		Chakra=3000
		Taijutsu=1000
		Genjutsu=1000
		Ninjutsu=1000
		protect=1
		New()
			spawn()
				respawn=loc
				spawn(30)Wander()
		Action(mob/user)
			if(get_dist(user,src)>2) return
			switch(input("Hello there, would you like to buy some bandages? They're 100 gold each.","Medic")in list("Yes","No"))
				if("Yes")
					var/obj/Item/Bandages/B=locate(/obj/Item/Bandages) in user.contents
					var/bandages=input("How many do you require?","Medic")as num
					if(!MobDistanceCheck(user,src,3)) {user.choosing=0; return}
					bandages=round(bandages)
					//if(B&&B.amount+bandages>20) bandages=(20-B.amount)
					//else if(bandages>20) bandages=20

					var/goldneeded=bandages*100
					if(bandages<=0) return
					if(user.gold>=goldneeded)
						user.gold-=goldneeded; user.StatUpdate_gold()
						if(!B) {B=new(user); B.amount=bandages; B.Checkamount()}
						else {B.amount+=bandages; B.Checkamount()}
						user<<"Medic: <i>See you next time.</i>"; user.UpdateInventory()
					else user<<"Medic: <i>I'm sorry, but you don't seem to have enough.</i>"
obj/var/Village
var/list/HOSPITALBEDLIST=list()
obj/Hospital
	Bed
		icon='HospitalBed.dmi'
		name = "Hospital Bed"
		Foot
			icon_state="foot"
			density=0
		Head
			icon_state="head"
			layer=MOB_LAYER+3

		SecondHeads
			icon_state="secondhead"
			density=1
			layer=MOB_LAYER-1
			New()
				new/obj/Hospital/Bed/Foot(get_step(src,SOUTH))
				new/obj/Hospital/Bed/Head(loc)
				if(loc.loc)
					Village = loc.loc.name
				if(Village)
					HOSPITALBEDLIST+=src

			Bumped(mob/M)
				if(M.client)
					if(inuse) {M<<"Someone is already using that bed!"; return}
					InHospital(M)

			verb
				Sleep()
					set src in orange(1)
					if(inuse) {usr<<"Someone is already using that bed!"; return}
					InHospital(usr)

			Generic
			Admin
				Village="Admin"
			Leaf
				Village="Leaf"
			Mist
				Village="Mist"
			Rock
				Village="Rock"
			Sand
				Village="Sand"
			Rain
				Village="Rain"
			Waterfall
				Village="Waterfall"
			Sound
				Village="Sound"
			Cloud
				Village="Cloud"
			Grass
				Village="Grass"

obj/proc/InHospital(mob/m)
	set background = 1, waitfor = 0
	inuse = 1
	if(m)
		for(var/obj/Hospital/Bed/Head/h in loc)
			h.icon_state="head_used"
		for(var/obj/Hospital/Bed/b in get_step(src,SOUTH))
			b.icon_state="foot_used"

		m.hospital = 1
		m.Sleeping=1
		m.healingself = 1
		m.KO = 0
		m<<"You climb into the bed"
		m.loc=loc
		m.dir=SOUTH;

		while(m && m.hospital)
			var/Done = 0
			if(m.Stamina < m.StaminaMax)
				m.Stamina+=m.StaminaMax*0.1
			else
				Done++

			if(m.Wounds > 0)
				m.Wounds-=rand(8,11)
			else
				Done++

			if(Done>1)
				if(m.Stamina>=m.StaminaMax)
					m.Stamina=m.StaminaMax
				if(m.Wounds<=0)
					m.Wounds=0
				 m.hospital=0
			m.RefreshStats()
			sleep(10)

		if(m)
			m.BandageUses=0
			m<<"You are all healed up."
			m.healingself=0
			m.hospital=0
			m.Sleeping=0
			step(m,pick(EAST,WEST,SOUTHWEST,SOUTHEAST))
			spawn(100)
				if(m)
					m.TakenDamage=0
	inuse=0
	for(var/obj/Hospital/Bed/Head/h in loc) h.icon_state="head"
	for(var/obj/Hospital/Bed/b in get_step(src,SOUTH)) b.icon_state="foot"
