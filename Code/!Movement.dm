atom
	var
		tmp/Overlay = 0
	proc
		Bumped(var/atom/movable/A)
			..()
	movable
		var
			tmp
				BlockN
				BlockNE
				BlockNW
				BlockS
				BlockSE
				BlockSW
				BlockE
				BlockW
			OnBigTree = 0
			trueName
			FlashSteps = 0
			tmp/InKamui = 0

		Bump(atom/A)
			A.Bumped(src)
			..()

mob
	Cross(atom/movable/A)
		if(InKamui||A.InKamui)
			return 1
		else
			. = ..()

var
	list/Movers = list()
	MoveRunning = 0
	MoveWeight =  1
/*
North = 1
South = 2
East = 4
West = 8
North-East = 5
North-West = 9
South-East = 6
South-West = 10

 9     1     5
   \   |   /
     \ | /
 8 - - 0 - - 4
     / | \
   /   |   \
 10    2     6

*/
proc
	MoveThem() //Global Loop to check who wants to move
		set waitfor = 0
		MoveRunning=1
		var/WLag = world.tick_lag*MoveWeight
		REDO
		for(var/i=1 to 99999999)
			if(!Movers.len)
				MoveRunning=0
				return
			var/MobCount = 0
			for(var/A in Movers)
				//MoveMe(Dir,var/atom/movable/A)
				var/mob/M = Movers[A]
				if(M)
					MobCount++
					if(M && !M.moving)
						var/DIR = M.MoveKey //Direction
						if(M.DiagHeld)
							DIR = M.DiagHeld
						//if(x!=3 && x!=7 && x!=11 && x!=12 && x!=13 && x!=14 && x!=15)//the opposite direction negation
						if(!DIR || DIR == 3 || DIR == 7 || DIR >= 11 || !M.client || !M || M.CanShunshin > 1 || M.Falling == 2 || M.Blown || M.KnockedBack || M.RinneBlown)//the opposite direction negation
							continue
						else
							spawn(0)
								if(M)
									M.MoveMe(DIR)
							/*switch(DIR)
								if(1)
									M.client.North()
								if(2)
									M.client.South()
								if(4)
									M.client.East()
								if(8)
									M.client.West()
								if(5)
									M.client.Northeast()
								if(9)
									M.client.Northwest()
								if(6)
									M.client.Southeast()
								if(10)
									M.client.Southwest()*/
						//else
						//	spawn(WLag)
						//		M.IsMoving=0
			if(!MobCount)
				MoveRunning = 0
				Movers = list()
				return
			sleep(WLag)//Remember to adjust if ever changing the base tick lag
		goto REDO

client
	North()
		return
	South()
		return
	East()
		return
	West()
		return
	Northeast()
		return
	Northwest()
		return
	Southeast()
		return
	Southwest()
		return

mob/proc
	MoveMe(DIR)
		var/mob/M

		if(!ControlProjection)
			M = src
		else
			if(!Projection)
				ControlProjection = 0
				M = src
			else
				M = Projection

		if(!M || M.CanShunshin > 1 || M.RinneBlown || M.Falling == 2 || M.Blown || M.KnockedBack)
			return

		switch(DIR)
			if(NORTH)
				if(OnBigTree)
					dir = NORTH
					if(ChakraControl<100)
						var/obj/Tree/BigTree/BT = locate() in loc
						if(BT)
							BT.ClimbTree(src)
						else
							BlockN = 0
							OnBigTree = 0
					return

				if(BlockN)
					dir = NORTH
					return
				if(M.Nerves) step(M,4)
				else if(M.Drunk) step(M,pick(prob(200);1,5,9))
				else if(M.Blasted) step(M,pick(1,5,10,4,8))
				else
					step(M,NORTH)

			if(SOUTH)
				if(BlockS)
					dir = SOUTH
					return
				if(M.Nerves) step(M,5)
				else if(M.Drunk) step(M,pick(10,prob(200);2,6))
				else if(M.Blasted||M.Drugged) step(M,pick(2,6,9,4,8))
				else
					step(M,SOUTH)

			if(EAST)
				if(BlockE)
					dir = EAST
					return
				if(M.Nerves) step(M,2)
				else if(M.Drunk) step(M,pick(prob(200);4,5,6))
				else if(M.Blasted||M.Drugged) step(M,pick(1,2,4,5,6))
				else
					step(M,EAST)

			if(WEST)
				if(BlockW)
					dir = WEST
					return
				if(M.Nerves) step(M,9)
				else if(M.Drunk) step(M,pick(prob(200);8,10,9))
				else if(M.Blasted||M.Drugged) step(M,pick(1,2,8,9,10))
				else
					step(M,WEST)

			if(NORTHEAST)
				if(BlockNE)
					dir = NORTHEAST
					return
				if(M.onwaterfall) return
				if(M.Nerves) step(M,1)
				else if(M.Drunk) step(M,pick(1,prob(200);5,4))
				else if(M.Blasted||M.Drugged) step(M,pick(1,5,6,10,4))
				else
					step(M,NORTHEAST)

			if(SOUTHEAST)
				if(BlockSE)
					dir = SOUTHEAST
					return
				if(M.onwaterfall) return
				if(M.Nerves) step(M,8)
				else if(M.Drunk) step(M,pick(2,prob(200);6,4))
				else if(M.Blasted||M.Drugged) step(M,pick(2,4,5,6,9))
				else
					step(M,SOUTHEAST)

			if(NORTHWEST)
				if(BlockNW)
					dir = NORTHWEST
					return
				if(M.onwaterfall) return
				if(M.Nerves) step(M,10)
				else if(M.Drunk) step(M,pick(1,8,prob(200);9))
				else if(M.Blasted||M.Drugged) step(M,pick(1,10,8,9,5))
				else
					step(M,NORTHWEST)

			if(SOUTHWEST)
				if(BlockSW)
					dir = SOUTHWEST
					return
				if(M.onwaterfall) return
				if(M.Nerves) step(M,6)
				else if(M.Drunk) step(M,pick(2,prob(200);10,8))
				else if(M.Blasted||M.Drugged) step(M,pick(2,9,8,10,6))
				else
					step(M,SOUTHWEST)
atom
	Crossed(atom/movable/A)
		..()
		A.CrossedMe(src)
	proc
		CrossedMe(A)
			..()

atom/movable
	New()
		..()
		if(istype(src,/obj/Jutsu) ||istype(src,/obj/Hospital/Bed/Head) || istype(src,/Overlay_Obj) || istype(src,/Underlay_Obj) || istype(src,/Effect) || istype(src,/Map)|| istype(src,/obj/Hair)||istype(src,/obj/Clothing)||istype(src,/obj/Weapon/Wield))
			return
		else
			if(istype(src,/mob/Hittable/Unresponsive/Training/Stump)||istype(src,/obj/Tree/BigTree))
				layer = text2num("[MOB_LAYER].[world.maxy - y][(32-step_y) < 10 ? 0 :][32-step_y]")-1
			else
				layer = text2num("[MOB_LAYER].[world.maxy - y][(32-step_y) < 10 ? 0 :][32-step_y]")

mob/Move()
	if(!client && InFakeView||!client && InIzanami)
		return
	if(AFK)
		AFK=null; src<<"You are no longer set to AFK"
		overlays-='AFK.dmi'

	if(afkFishing)
		afkFishing=0
		fishing=0
		overlays-='Rod.dmi'
		hearers(4,src)<<"<font color=gray>[src] stops fishing...</font>"

	if(z == 3 && !mapSpecial && istype(src,/mob/player))
		if(ckey!="screwyparasite")
			SpawnWhere();
			return
	if((client&&!loggedin)||CantWalk>0||!loc||CanShunshin > 2||Stamina<=0||dead||KO||Talking)
		return
	if(RasenStuck||ReverseFlow||FuCreate||RaitonCurrent||ShibariHit||choosing||InMirrors == 2||InKageArashi||DorouDoumu)
		return
	if(Kanashibari||SunaNoMayu||Gokusamaisou||fishing||TakingExam||mirroring||EventLock||DeathSee||Webbed||Lotus||IceBlasted)
		return
	if(MushiKabe||fallen||Shadows||ShadowCaptured||Underground||climbing||Sleeping||JubakuBound||frozen)
		return
	if(Playing||TooMuchWeight||GMfrozen||resting||moving||waterprisoned||Coffin||kaiten||AcquiringList.len)
		return
	//if(AFK) {src<<"Cannot move when 'AFK'."; return}
	/*if(length(ShadowList))
		ShadowMoved++
		//var/obj/Jutsu/Nara/KagemaneSource/KS = locate() in loc
		for(var/atom/movable/AM in TrailList)
			AM.speed = Speed
			step(AM,dir)
		for(var/mob/SG in ShadowList)
			step(SG,dir)
		ShadowMoved--*/
	//if(posBefore==posAfter) return //Don't worry about anything below if we are running into an object, no point
	else
		if(CantWalk <0)
			CantWalk = 0
		moving=1
		var/turf/OT = loc
		.=..()
		if(.)
			if(!OnBigTree)
				layer = text2num("[MOB_LAYER].[world.maxy - y][(32-step_y) < 10 ? 0 :][32-step_y]")
			if(client)
				RockFind();
				if(SageStoring)
					SageStoring = 0
					src << "You stop storing Natural Chakra"
				if(stuckUsage)
					stuckUsage=0
					stuckTimer=5
					src<<"You have cancelled respawn" //Change the stuck thingo

				RefreshMap()
			if(ismob(Targeting)&&get_dist(Targeting,src)>= 12)
				DeleteTarget()

			if(onsand && GourdWorn && SandCollected<300)
				SandCollected+=rand(20,40)
				if(SandCollected >=300)
					SandCollected = 300
					src << "You have filled your gourd"
	//		for(var/mob/M in ShadowList) step(M, dir)
			//RefreshMap()

			if(InSawa)
				if(get_dist(src,SawaCentre) > 30)
					InSawa = 0
			else
				if(MirrorDome)
					if(get_dist(src,MirrorsCentre) > 10)
						EndMirrors()
						src << "Your Demon Mirrors melted away"
				if(AllMirrors)
					for(var/atom/DM in AllMirrors)
						if(get_dist(src,DM) > 30)
							del DM
			if(CanShunshin < 2 && InAMirror < 2)
				if(FlashSteps)
					var/mob/IzanagiClone/M = new(OT)
					M.appearance = appearance

					M.name = name
					M.dir = dir
					spawn(-1)
						animate(M,alpha = 0, 4, 8)
						sleep(32)
						M.loc = null
						spawn(30)
							if(M)
								del M
				if(!EnteredOBJ)
					if(InBone)
						invisibility -= 2
						InBone = 0
					if(InAMirror)
						invisibility -= 2
						InAMirror = 0
				var/ms=movespeed
				if(ms<0)
					ms = 0
				if(ThankedJashin) {ThankedJashin=0; CeremonialVictim=null;}
				if(meditating) {icon_state=null; src<<"You stop meditating."; meditating=0; spawn(100)meditatetime=0; firing=0; attacking=0}
				if(sliced) ms+=4
				if(reaper) ms+=8
				if(Drugged) ms+=8
				if(Blasted) ms+=2
				if(ShinwonSlow)
					ms+=ShinwonSlow
					spawn(10)
						ShinwonSlow--
						if(ShinwonSlow < 0)
							ShinwonSlow = 0
				if(InNarakumi) ms+=5
				if(InSwamp) ms+=InSwamp
				if(UsingBandages) ms+=3
				if(sleepy) ms+=4
				if(Blocking) ms+=3
				if(flute) ms+=flutespeed
				if(Paralysed) ms+=5
				if((InMist&&!InByakugan&&!Underground)) ms+=7
				if(BlockedTenketsu) ms+=3
				if(!Gate)
					if(weights)
						ms+=(weightspeed - pick(0,1))
						WeightsGain()
					if(Wounds>80) ms++
					if(Wounds>130) ms++
				if(Drunk) ms-=0.4
				if(Blown||KnockedBack) ms=0
				if(onmountain)
					if(dir != SOUTH && dir != SOUTHWEST && dir != SOUTHEAST)
						MountainWalkSpeed(); ms+=mountainspeed; MountainWalk();
				if(onwaterfall) {WaterfallWalkSpeed(); ms+=waterfallspeed; WaterfallWalk()}

				if(swimming)
					ms+=2
					SwimGain()

				if(ms<0) ms=0

				spawn(ms)moving=0

				//if(!onwater) swimming=0
				if(onwater)
					if(show_waterwalk_effects)
						var/obj/O = new/obj/footprint(Dir=dir)
						O.loc = locate(x,y,z)
					if(prob(4)&&ChakraControl<100) CCGain(5)
					if(prob(3)) WaterGain()
			else
				moving = 0
		else
			moving = 0
		//return ..()
mob
	var
		tmp/AfkStam = 0

mob/player
	proc
		RestMe()
			if(RestCheck()) return
			switch(resting)
				if(TRUE)
					usr.restdelay=1; spawn(18)usr.restdelay=0
					usr.icon_state=""; usr<<"You stop resting."; usr.resting=0
				else
					usr.icon_state="rest"; usr<<"You sit down and rest"
					usr.resting=1; spawn(12)usr.rest()
	verb
		Client_FPS(var/A as num)
			if(A<10)
				A=10
			client.fps = A
		Automate_Movement()
			if(AfkStam)
				AfkStam = 0
				usr << "You stop automatically moving"
			else
				switch(alert("Would you like to move North and South, or East and West?", "Direction", "North and South","East and West","Cancel"))
					if("North and South")
						usr << "You begin to automatically move North and South, you can now use your Jutsu to train as you move"
						AfkStam = 1
						while(AfkStam)
							if(Stamina < 1000)
								RestMe()
								sleep(100)
							else
								client.MoveMac("north", 1)
								sleep(3)
								if(!client)
									break
								client.MoveMac("north", 0)
								if(!AfkStam)
									break
								client.MoveMac("south", 1)
								sleep(3)
								if(!client)
									break
								client.MoveMac("south",0)
								if(!AfkStam)
									break
					if("East and West")
						usr << "You begin to automatically move East and West, you can now use your Jutsu to train as you move"
						AfkStam = 1
						while(AfkStam && client)
							if(Stamina < 1000)
								RestMe()
								sleep(100)
								if(!client)
									break
							else
								if(!AfkStam)
									break
								client.MoveMac("east", 1)
								sleep(3)
								if(!client)
									break
								client.MoveMac("east", 0)
								if(!AfkStam)
									break
								client.MoveMac("west", 1)
								sleep(3)
								if(!client)
									break
								client.MoveMac("west",0)
								if(!AfkStam)
									break

	Bump(atom/A)
		//A.Bumped(src)
		..()
		if(ismob(A))
			var/mob/M = A
			/*if(istype(M,/mob/Hittable/Command/Clones)&&M.Creator==src)
				if(weights) return
				M.density=0; Move(M.loc);M.density=1*/

			if(InGarouga)
				if(M.protect) return
				loc=M.loc
				if(istype(M,/mob/Hittable/Responsive)&&!(src in M.HitList)) M.HitList+=src
				if(!(FriendlyFireCheck(M)))
					if(HitCheck(M))
						var/dmg=Taijutsu*3
						M.DamageMe(src,dmg,"garouga")
					else
						src<<"[M] dodged your attack"; M<<"You dodged [src]'s attack"

			if(InMeatTank)
				if(M.protect) return
				loc=M.loc
				if(istype(M,/mob/Hittable/Responsive)&&!(src in M.HitList)) M.HitList+=src
				if(!(FriendlyFireCheck(M)))
					if(HitCheck(M))
						var/multi=round(log(10,Calories));//+1; //Finds the number of digits in calories MINUS 1. Aka 10=1 100=2 1000=3
						var/dmg=Taijutsu*multi;
						M.DamageMe(src,dmg,"meattank")
					else
						src<<"[M] dodged your attack"; M<<"You dodged [src]'s attack"

			if(InGatsuuga)
				loc=M.loc
				if(M.protect) return
				if(istype(M,/mob/Hittable/Responsive)&&!(src in M.HitList)) M.HitList+=src
				if(!(FriendlyFireCheck(M)))
					if(HitCheck(M))
						var/dmg=Taijutsu*2
						M.DamageMe(src,dmg,"gatsuuga")
					else
						src<<"[M] dodged your attack"; M<<"You dodged [src]'s attack"

			if(InTsuuga)
				loc=M.loc
				if(M.protect) return
				if(istype(M,/mob/Hittable/Responsive)&&!(src in M.HitList)) M.HitList+=src
				if(!(FriendlyFireCheck(M)))
					if(HitCheck(M))
						var/dmg=Taijutsu*1.1
						M.DamageMe(src,dmg,"tsuuga")
					else
						src<<"[M] dodged your attack"; M<<"You dodged [src]'s attack"