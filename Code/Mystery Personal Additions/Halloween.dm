turf/Halloween
	GiantSpider
		layer=12
		name="Spider"
		icon='GiantSpider.dmi'
		icon_state="Meditate"
	Darkness
		icon='dark.dmi'
		icon_state="FoD"
		layer=999
		Lighting=1

obj/Halloween
	Darkness
		icon='dark.dmi'
		icon_state="FoD"
		layer=999

obj/Clothing
	Head
		PumpkinHead
			name="Pumpkin Head"
			icon='PumpkinHead.dmi'
			rare=1
		WitchHat
			name="Witch Hat"
			icon='WitchHat.dmi'
			rare=1

obj/Event
	Candy1
		name="Red Candy"
		trueName="Red Candy"
		icon='Ghost.dmi'
		icon_state="redCandy"
		price=5
		amount=1
		ItemType="Food"
		Click()
			if(src in usr.contents)
				if(OnSpeedRail) Eat()
				else usr.ItemStats(src)
		verb
			Eat()
				set name="Eat Red Candy"
				if(usr.KO||usr.dead) return
				if(usr.DamagedRecently) {usr<<"You cannot eat any Candy just yet."; return}
				usr.EatCandyRed(trueName)
				usr.UpdateInventory()
			Get()
				set src in oview(1)
				var/obj/Event/Candy1/F=locate(/obj/Event/Candy1) in usr.contents
				if(!(F in usr.contents))
					Move(usr); usr.UpdateInventory()
				else
					for(F in usr.contents)
						F.amount+=amount; F.Checkamount(); usr.UpdateInventory(); del(src)
			Drop()
				usr.DropStackedItems(src)
	Candy2
		name="Blue Candy"
		trueName="Blue Candy"
		icon='Ghost.dmi'
		icon_state="blueCandy"
		price=5
		amount=1
		ItemType="Food"
		Click()
			..()
			if(src in usr.contents)
				if(OnSpeedRail) Eat()
				else usr.ItemStats(src)
		verb
			Eat()
				set name="Eat Blue Candy"
				if(usr.KO||usr.dead) return
				if(usr.DamagedRecently) {usr<<"You cannot eat any Candy just yet."; return}
				usr.EatCandyBlue(trueName)
				usr.UpdateInventory()
			Get()
				set src in oview(1)
				var/obj/Event/Candy2/F=locate(/obj/Event/Candy2) in usr.contents
				if(!(F in usr.contents))
					Move(usr); usr.UpdateInventory()
				else
					for(F in usr.contents)
						F.amount+=amount; F.Checkamount(); usr.UpdateInventory(); del(src)
			Drop()
				usr.DropStackedItems(src)
	Candy3
		name="Green Candy"
		trueName="Green Candy"
		icon='Ghost.dmi'
		icon_state="greenCandy"
		price=5
		amount=1
		ItemType="Food"
		Click()
			..()
			if(src in usr.contents)
				if(OnSpeedRail) Eat()
				else usr.ItemStats(src)
		verb
			Eat()
				set name="Eat Green Candy"
				if(usr.KO||usr.dead) return
				if(usr.DamagedRecently) {usr<<"You cannot eat any Candy just yet."; return}
				usr.EatCandyGreen(trueName)
				usr.UpdateInventory()
			Get()
				set src in oview(1)
				var/obj/Event/Candy3/F=locate(/obj/Event/Candy3) in usr.contents
				if(!(F in usr.contents))
					Move(usr); usr.UpdateInventory()
				else
					for(F in usr.contents)
						F.amount+=amount; F.Checkamount(); usr.UpdateInventory(); del(src)
			Drop()
				usr.DropStackedItems(src)
	Candy4
		name="Large Candy"
		trueName="Large Candy"
		icon='Ghost.dmi'
		icon_state="largeLolly"
		price=500
		amount=1
		ItemType="Food"
		Click()
			..()
			if(src in usr.contents)
				if(OnSpeedRail) Eat()
				else usr.ItemStats(src)
		verb
			Eat()
				set name="Eat Large Candy"
				if(usr.KO||usr.dead) return
				if(usr.DamagedRecently) {usr<<"You cannot eat any Candy just yet."; return}
				usr.EatLargeCandy(src)
				usr.UpdateInventory()
			Get()
				set src in oview(1)
				var/obj/Event/Candy4/F=locate(/obj/Event/Candy4) in usr.contents
				if(!(F in usr.contents))
					Move(usr); usr.UpdateInventory()
				else
					for(F in usr.contents)
						F.amount+=amount; F.Checkamount(); usr.UpdateInventory(); del(src)
//			Drop()
//				usr.DropStackedItems(src)

mob/proc/
	dropRandomCandy()
		switch(pick(1,2,3))
			if(1)
				src<<"You found some candy!";
				var/counter=0
				for(var/obj/Event/Candy1/F in contents) counter++
				if(counter<=0)
					var/obj/Event/Candy1/F=new(src)
					F.Checkamount()
				else
					for(var/obj/Event/Candy1/F in contents)
						F.amount++; F.Checkamount()
				usr.UpdateInventory()
			if(2)
				src<<"You found some candy!";
				var/counter=0
				for(var/obj/Event/Candy2/F in contents) counter++
				if(counter<=0)
					var/obj/Event/Candy2/F=new(src)
					F.Checkamount()
				else
					for(var/obj/Event/Candy2/F in contents)
						F.amount++; F.Checkamount()
				usr.UpdateInventory()
			if(3)
				src<<"You found some candy!";
				var/counter=0
				for(var/obj/Event/Candy3/F in contents) counter++
				if(counter<=0)
					var/obj/Event/Candy3/F=new(src)
					F.Checkamount()
				else
					for(var/obj/Event/Candy3/F in contents)
						F.amount++; F.Checkamount()
				usr.UpdateInventory()

	giveLargeCandy()
		var/counter=0
		for(var/obj/Event/Candy4/F in contents) counter++
		if(counter<=0)
			var/obj/Event/Candy4/F=new(src)
			F.Checkamount()
		else
			for(var/obj/Event/Candy4/F in contents)
				F.amount++; F.Checkamount()
		usr.UpdateInventory()

	EatCandyRed(var/n)
		src<<"You ate a [n]"
		for(var/obj/Event/Candy1/f in contents)
			Stamina+=1000; if(Stamina>=StaminaMax) Stamina=StaminaMax; Wounds-=1; if(Wounds<0) Wounds=0
			f.amount--
			if(f.amount<1) del(f)
			else f.Checkamount()
			UpdateInventory()

	EatCandyBlue(var/n)
		src<<"You ate a [n]"
		for(var/obj/Event/Candy2/f in contents)
			Stamina+=1000; if(Stamina>=StaminaMax) Stamina=StaminaMax; Wounds-=1; if(Wounds<0) Wounds=0
			f.amount--
			if(f.amount<1) del(f)
			else f.Checkamount()
			UpdateInventory()

	EatCandyGreen(var/n)
		src<<"You ate a [n]"
		for(var/obj/Event/Candy3/f in contents)
			Stamina+=1000; if(Stamina>=StaminaMax) Stamina=StaminaMax; Wounds-=1; if(Wounds<0) Wounds=0
			f.amount--
			if(f.amount<1) del(f)
			else f.Checkamount()
			UpdateInventory()

	EatLargeCandy(obj/n)
		src<<"You ate a [n.trueName]"
		Stamina+=(StaminaMax*0.5); if(Stamina>=StaminaMax) Stamina=StaminaMax; Wounds-=80; if(Wounds<0) Wounds=0
		del(n)
		UpdateInventory()

	GiveWitchReward()
		switch(pick(prob(120); 1,prob(30);2,prob(10);3))
			if(1) new/obj/Event/Candy4(src)
			if(2) new/obj/Clothing/Head/PumpkinHead(src)
			if(3) new/obj/Clothing/Head/WitchHat(src)

	CompleteWitchQuest()
		var/
			hasFeathers; hasRocks;
			hasCandy1; hasCandy2; hasCandy3;
		for(var/obj/Item/Material/Feather/F in contents)
			if(F.amount>=100) {hasFeathers=1}
		for(var/obj/Item/Material/Ore/Stone/R in contents)
			if(R.amount>=3) {hasRocks=1}
		for(var/obj/Event/Candy1/C1 in contents)
			if(C1.amount>=5) {hasCandy1=1}
		for(var/obj/Event/Candy2/C2 in contents)
			if(C2.amount>=5) {hasCandy2=1}
		for(var/obj/Event/Candy3/C3 in contents)
			if(C3.amount>=5) {hasCandy3=1}

		if(hasFeathers&&hasRocks&&hasCandy1&&hasCandy2&&hasCandy3)
			for(var/obj/Item/Material/Ore/Stone/R in contents)
				R.amount-=3; R.Checkamount()
				if(R.amount<=0) del(R)
			for(var/obj/Item/Material/Feather/F in contents)
				F.amount-=100; F.Checkamount()
				if(F.amount<=0) del(F)
			for(var/obj/Event/Candy1/C1 in contents)
				C1.amount-=5; C1.Checkamount()
				if(C1.amount<=0) del(C1)
			for(var/obj/Event/Candy2/C2 in contents)
				C2.amount-=5; C2.Checkamount()
				if(C2.amount<=0) del(C2)
			for(var/obj/Event/Candy3/C3 in contents)
				C3.amount-=5; C3.Checkamount()
				if(C3.amount<=0) del(C3)
			src<<{"Witch: <i>"Excellent, now to finish we add eye of newt, toe of the frog and the tongue of a dog and.... There we go! Here is your reward!""};
			GiveWitchReward()
		else {src<<{"Witch: <i>"Don't lie to me or I'll put you in an oven!""};}



mob/var/tmp
	witchQuest=0;
mob/Hittable/Responsive/Event/
	Witch
		name="Witch"
		NinjaRank="Evil"
		icon='witch.dmi'
		protect=1
		CantHenge=1
		Action(mob/user)
			if(get_dist(user,src)>2) return
			if(user.GMfrozen|Talking)
				return
			else
				user.Talking=1
				var/eventQuest;
				if(user.witchQuest) eventQuest=list("I have gathered the materials!","What do I have to do?","This is my candy!")
				else eventQuest=list("What do I have to do?","I don't deal with witchcraft!")

				switch(input("Would you like to help me?","Witch")as null|anything in eventQuest)
					if("What do I have to do?") {user<<{"Witch: <i>"I require <b>100</b> feathers, <b>3</b> rocks and <b>5</b> of each candy, three types to be exact!</i>""}; user.witchQuest=1; user.Talking=0}
					if("I don't deal with witchcraft!") {user<<{"Witch: That's a shame... you do look Delicious...<i>"</i>""}; user.Talking=0}
					if("This is my candy!") {user<<{"Witch: I guess you chose Trick...<i>"</i>""};user<<"The Witch zaps [user.name] for [user.Stamina-(user.Stamina*0.1)] damage!";user.Stamina-=(user.Stamina*0.1); user.Talking=0}
					if("I have gathered the materials!") {user.CompleteWitchQuest(); user.Talking=0}

mob/Hittable/Responsive/Event/Halloween/Ghost
	Ghost
		name = "Ghost"
		icon = 'Ghost.dmi'
		Stamina=500; StaminaMax=500; StaminaTrue=500
		Chakra=1; ChakraMax=1; ChakraTrue=1
		Reflex=1
		Taijutsu=1; TaijutsuMax=1; TaijutsuTrue=1
		Genjutsu=1; GenjutsuMax=1; GenjutsuTrue=1
		Ninjutsu=1; NinjutsuMax=1; NinjutsuTrue=1
		New()
			respawn=loc

var/Candy = 1
mob/Hittable/Responsive/Event/Halloween/Ghost/DamageMe(mob/M,var/d,METHOD,hidemessage)
	if(dead) return
	Stamina-=d
	DamageReport(src,M,d,METHOD)
	if(Stamina>0)
		step_away(src,M)
		sleep(1)
		step_away(src,M)
	if(Stamina<=0)
		var/obj/Item/Material/Feather/F=new/obj/Item/Material/Feather
		if(prob(30)) F.amount=feathers
		else F.amount=feathers

		if(get_dist(M,src)<2)
			if(prob(10)) M.dropRandomCandy()
			var/obj/Item/Material/Feather/C=locate(/obj/Item/Material/Feather) in M.contents
			if(!(C in M.contents)) {F.Move(M); M.UpdateInventory()}
			else {C.amount+=F.amount; C.Checkamount(); M.UpdateInventory(); del(F)}
		else
			var/obj/Item/Material/Feather/K=locate(/obj/Item/Material/Feather) in loc
			if(K) {K.amount+=F.amount; del(F)}
			else F.loc=loc
		loc=null; dead=1
		if(istype(M,/mob/Hittable/Command/Clones/)) M=M.Creator
		//M.ChickenKills++
		spawn(80)
			var/mob/Hittable/Responsive/Event/Halloween/Ghost/Ghost/C = new(respawn)
			C.loc=ghostRespawn(C.loc)
			del(src)

proc/ghostRespawn(L)
	var/r=list()
	for(var/turf/R in range(1,L)) r+=R
	var/turf/respawn=pick(r)
	if(respawn.density) return L
	else return respawn