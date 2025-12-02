mob/Hittable/Responsive/Animal
	var
		Heel=0
		hasOwner
		IsSummoned
		AType
		Size=1
	NinjaRank = "Animal"

	Stamina=200; StaminaMax=200; StaminaTrue=200
	Chakra=1; ChakraMax=1; ChakraTrue=1
	Reflex=1
	Taijutsu=1; TaijutsuMax=1; TaijutsuTrue=1
	Genjutsu=1; GenjutsuMax=1; GenjutsuTrue=1
	Ninjutsu=1; NinjutsuMax=1; NinjutsuTrue=1

	New()
		var/area/A = loc.loc
		if(A)
			if(istype(A,/area/Outdoor/Village))
				AType=text2path("/mob/Hittable/Responsive/Animal/Wild/[pick("Bird/Bird","Mouse","Rabbit","Toad","Bird/Chicken","Bird/Rooster","Dog")]")
			else if(istype(A,/area/Cave))
				AType=text2path("/mob/Hittable/Responsive/Animal/Wild/[pick("Snake","Bat","Dog")]")
			else
				AType=text2path("/mob/Hittable/Responsive/Animal/Wild/[pick("Bird/Bird","Mouse","Rabbit","Snake","Toad","Bird/Chicken","Bird/Rooster","Bat","Dog")]")
			new AType(loc)
		del src

	Wild
		New()
			if(!hasOwner)
				if(!HairColour)
					if(istype(src,/mob/Hittable/Responsive/Animal/Wild/Bird/Chicken)||istype(src,/mob/Hittable/Responsive/Animal/Wild/Bird/Rooster))
						HairColour=0
					else if(istype(src,/mob/Hittable/Responsive/Animal/Wild/Bat))
						var/A=pick(10,20,30,40,50)
						HairColour="#[A][A][A]"
					else
						HairColour="#[pick(10,20,30,40,50)][pick(10,20,30,40,50)][pick(10,20,30,40,50)]"
				AType = type
				if(prob(10)&&!istype(src,/mob/Hittable/Responsive/Animal/Wild/Bird/Chicken))
					Size=2
				if(loc.loc && !istype(loc.loc,/area/Outdoor/Village))
					if(name=="Bat"||name=="Snake"||prob(0.1)||Size>1)
						Aggressive=1
			var/icon/I=icon(icon)
			trueName = name
			if(Size>1)
				switch(name)
					if("Bat")
						I=icon('Bat.dmi')
					if("Chicken")
						I=icon('Chicken.dmi')
					if("Dog")
						I=icon('Dog.dmi')
						//I.Scale(48,48)
						//CantHenge = 1
					if("Bird")
						I=icon('Bird.dmi')
					if("Mouse")
						I=icon('Mouse.dmi')
					if("Rabbit")
						I=icon('Rabbit.dmi')
					if("Rooster")
						I=icon('Rooster.dmi')
					if("Snake")
						I=icon('Snake.dmi')
					if("Swan")
						I=icon('Swan.dmi')
					if("Toad")
						I=icon('Toad.dmi')
				name="Large [name]"
			if(HairColour)
				I.Blend(HairColour)
			icon=I
			NinStat()
			respawn=loc
			step_rand(src)
			spawn()
				AI()

		Del()
			if(SRate)
				SpawnMe(SRate,type,respawn)
				loc = null
			else
				loc = null

			spawn(100)
				if(src)
					.=..()

		Bat
			icon='BatS.dmi'
		Bird
			Bird
				icon='BirdS.dmi'
			Rooster
				icon='RoosterS.dmi'
			Swan
				icon='SwanS.dmi'
			Chicken
				icon = 'ChickenS.dmi'
				SRate = 100
		Dog
			icon='DogS.dmi'
		Mouse
			icon='MouseS.dmi'
		Rabbit
			icon='RabbitS.dmi'
		Snake
			icon='SnakeS.dmi'
		Toad
			icon='ToadS.dmi'

	AI()
		set waitfor = 0, background = 1
		while(!dead)
			CHECK_TICK
			if(RinneBlown)
				sleep(movespeed)
				continue
			var/WT = 5
			//if(waterprisoned || Kanashibari || Coffin || InKageArashi || IceBlasted || ShadowCaptured || JubakuBound)
			//	FreeMe()
			var/mob/t
			var/list/ppl=list()
			var/list/Clones=list()
			var/moveit = 0
			if(KO || InIzanami)
				sleep(10)
				continue
			if(!Aggressive)
				if(HitList.len)
					if(RESTRAINEDCHECK(src))
						sleep(10)
						continue
					for(var/mob/A in HitList)
						if(A == src)
							continue

						for(var/mob/c in A.MasterBunshinList)
							Clones+=c
						for(var/mob/c in A.EdoCloneList)
							Clones+=c
						if(A.Familiar)
							Clones+=A.Familiar
						if(A.dead)
							continue
						if(A.protect)
							continue
						if(A.invisibility > see_invisible)
							continue
						var/GD = get_dist(A,src)
						if(GD > 20 || z != A.z)
							if(GD > 50 && z == A.z)
								HitList -= A
							continue
						if(A.KO)
							t = A
							break
						if(istype(A,/mob/Hittable/Command/Clones)||istype(A,/mob/Hittable/Command/EdoClone))
							Clones+=A
						else
							if(A.client)
								moveit = 1
							ppl+=A

					if(moveit)
						if(InIllusion)
							if(InFirudo)
								step_rand(src)
								sleep(5)
								continue
							else
								if(InFakeEnemyView)
									Attack1(Projection)
								else if(InSenKaze)
									step_rand(src)
									sleep(10)
									continue
								else if(InFakeView)
									sleep(10)
									continue
								else if(InIzanami)
									sleep(10)
									continue

					if(!t)
						var/P,C
						if(ppl.len)
							P = 1
						if(Clones.len)
							C = 1
						if(P&&C)
							if(prob(80))
								t = pick(ppl)
							else
								t = pick(Clones)
						else if(P)
							t = pick(ppl)
						else if(C)
							t = pick(Clones)

					if(t)
						Attack1(t)
					else
						if(moveit)
							var/d = pick(WEST, EAST, NORTH, SOUTH, NORTHWEST, NORTHEAST, SOUTHWEST, SOUTHEAST)
							walk(src,d,3)
							spawn(6)
								walk(src,0)
						sleep(15)
						continue
				else
					for(var/mob/player/M in MasterPlayerList)
						if(get_dist(M,src) < 20)
							moveit = 1
							break

					if(moveit)
						var/d = pick(WEST, EAST, NORTH, SOUTH, NORTHWEST, NORTHEAST, SOUTHWEST, SOUTHEAST)
						walk(src,d,3)
						spawn(6)
							walk(src,0)
					sleep(15)
					continue

			else
				if(RESTRAINEDCHECK(src))
					sleep(10)
					continue

				for(var/mob/A in oview(src,10))
					if(A == src)
						continue
					if(A.dead)
						continue
					if(A.protect)
						continue
					if(A.TeamID == TeamID)
						continue
					if(istype(A,/mob/Hittable)||A.client)
						if(istype(A,/mob/Hittable/Unresponsive/NPC)||istype(A,/mob/Hittable/Unresponsive/Training)||istype(A,/mob/Hittable/Responsive/Boss)||istype(A,/mob/Hittable/Responsive/NPC))
							continue
						if(istype(A,/mob/Hittable/Command/EdoClone))
							Clones+=A
						else if(A.Familiar)
							Clones+=A.Familiar
						else if(istype(A,/mob/Hittable/Command/Clones))
							Clones += A
						else
							if(A.client)
								moveit = 1
							ppl+=A

				if(moveit)
					if(InIllusion)
						if(InFirudo)
							step_rand(src)
							sleep(5)
							continue
						else
							if(InFakeEnemyView)
								Attack1(Projection)
							else if(InSenKaze)
								step_rand(src)
								sleep(10)
								continue
							else if(InFakeView)
								sleep(10)
								continue
							else if(InIzanami)
								sleep(10)
								continue

				if(!t)
					var/P,C
					if(ppl.len)
						P = 1
					if(Clones.len)
						C = 1
					if(P&&C)
						if(prob(80))
							t = pick(ppl)
						else
							t = pick(Clones)
					else if(P)
						t = pick(ppl)
					else if(C)
						t = pick(Clones)

				if(t)
					Attack1(t)
				else
					if(moveit)
						var/d = pick(WEST, EAST, NORTH, SOUTH, NORTHWEST, NORTHEAST, SOUTHWEST, SOUTHEAST)
						walk(src,d,3)
						spawn(6)
							walk(src,0)
					sleep(10)
					continue
			sleep(WT)

	AI_Attack(mob/M, var/AttackTime)
		while(AttackTime)
			if(KO||dead)
				break
			AttackTime--
			if(!M || M.protect || M.dead)
				break
			else
				var/A = get_dist(src,M)
				if(A>=20)
					break
				if(A>1)
					while(get_dist(src,M) > 1)
						if(KO)
							break
						if(get_dist(M,src) > 12)
							break
						step_to(src,M)
						sleep(movespeed)
						if(!src || !M)
							return
				if(KO||dead)
					break
				if(get_dist(src,M)<2)
					dir = get_dir(src,M)
					AI_Punch(M)
					sleep(atkspeed)
		AttackTime = 0


	AI_Punch(mob/TARGET)
		if(TARGET)
			if(TAICHECKBOTH(src,TARGET)) return
			if(inchidori)	{ChidoriPunch(TARGET); return}
			if(inrasengan) {RasenganPunch(TARGET); return}
			var/dmg=round(Taijutsu*0.9-(TARGET.Taijutsu*0.09))
			dmg+=NPCWeapons(TARGET)
			if(dmg<round(Taijutsu*0.1)) dmg=round(Taijutsu*0.1)
			//flick("punch",src)
			if(HitCheck(TARGET))
				attacking=1; spawn(atkspeed)attacking=0
				TARGET.DamageMe(src,dmg,AttackMethod)
			else
				attacking=1
				spawn(atkspeed*4)attacking=null
				TARGET<<"You dodged [src]'s attack"

	Attack1(mob/M)
		if(M)
			if(M.KO)
				AI_KO(M)
			else if(M.dead)
				HitList -= M
			else
				if(Stamina>0&&!dead&&!DeathSee&&!Lotus&&!KO&&!MushiKabe&&!fallen&&!Underground&&!frozen&&!GMfrozen&&!resting&&!CantWalk&&!length(AcquiringList))
					if(get_dist(src,M)>=2 && !M.UsedArashi && !M.InFujinHeki)
						sleep(ATKWAit)
						if(KO || dead)
							return
						if(M)
							if(M.protect)
								return
							if(M.icon_state=="seals"&&prob(90))
								Evade1(M)
							else if(firing&&!M.kaiten&&!M.MushiKabe)
								AI_Attack(M,11)
							else
								ReCheck
								if(M.kaiten||M.MushiKabe)
									sleep(10)
									goto ReCheck
								else
									AI_Attack(M,10)
					else
						sleep(ATKWAit)
						if(KO)
							return
						if(M)
							ReCheck
							if(!M.kaiten&&!M.MushiKabe)
								AI_Attack(M,12)
							else
								sleep(10)
								goto ReCheck

	AI_KO(mob/M)
		if(KO || M.dead || KOChase)
			return
		if(M)
			KOChase = 1
			while(get_dist(src,M) > 1)
				if(KO)
					KOChase = 0
					return
				if(!step_to(src,M))
					StepFailed++
				else
					StepFailed = 0
				sleep(movespeed)
				if(!src || !M)
					KOChase = 0
					return
			sleep(5)
			if(KO)
				KOChase = 0
				return
			if(src)
				if(M)
					dir=get_dir(src,M)
					if(M.KO && !M.dead && !(TAICHECKBOTH(src,M)))
						attacking=1
						spawn(atkspeed+3)
							if(src)
								attacking=0
						flick("punch",src)
						M.Wounds+=150
						M.KillMe(src)
						HitList -= M
				KOChase = 0

	DamageMe(mob/M, var/D,METHOD,hidemessage)
		if(dead)
			return
		HitList += M

		for(var/mob/Fry in range(10, src))
			if(Fry.Creator && Fry.Creator==Creator)
				if(!(M in Fry.HitList))
					Fry.HitList += M

		if(D<1)D=1
		if(!StaminaMax)
			StaminaMax = 1
		D=round(D); var/w=(D/StaminaMax)*73
		Stamina-=D; Wounds+=w
		if(!hidemessage) DamageReport(src,M,D,METHOD)
		if(M)M.ExperienceCheck(w,src)
		M.RefreshStats()
		if(istype(M,/mob/Hittable/Command/Clones/))
			M=M.Creator
		if(Wounds>=150||Stamina < 1)
			KO=1;
			KillMe(M)

	KillMe(mob/M)
		if(istype(M,/mob/Hittable/Command/Clones/))
			M=M.Creator
		if(istype(M,/mob/Hittable/Responsive/Animal/Pet/))
			M=M.Master
		if(dead)
			return
		dead=1
		if(istype(src,/mob/Hittable/Responsive/Animal/Wild/Bird))
			var/obj/Item/Material/Feather/F=new()
			if(prob(30))
				F.amount=feathers*2
			else
				F.amount=feathers

			F.amount *= Size

			if(get_dist(M,src)<2)
				var/obj/Item/Material/Feather/C=locate(/obj/Item/Material/Feather) in M.contents
				if(!C) {F.Move(M); M.UpdateInventory()}
				else {C.amount+=F.amount; C.Checkamount(); M.UpdateInventory(); del(F)}
			else
				var/obj/Item/Material/Feather/K=locate(/obj/Item/Material/Feather) in loc
				if(K) {K.amount+=F.amount; del(F)}
				else F.loc=loc

		if(M)
			if(M.client)
				M.AnimalKills++
				M.CurAnimKills++
				var/NM = M.CurAnimKills/50
				if(NM == round(NM))
					M << "You now have [NM] C Rank missions to turn in from Animal Kills"
				if(Size>1)
					M.LargeAnimalKills++
					M.CurLAnimKills++
					var/NMM = M.CurLAnimKills/10
					if(NMM == round(NMM))
						M << "You now have [NMM] B Rank missions to turn in from Large Animal Kills"
				M.TotalKills++

			if(Creator)
				if(istype(Creator,/obj/Spawner))
					var/obj/Spawner/Spn=Creator
					if(Spn)
						for(var/mob/Fry in range())
							if(Fry.Creator && Fry.Creator==Spn)
								if(!(M in Fry.HitList))
									Fry.HitList += M
						Spn.SpLim--
						Spn.SpCur--
						Spn.SpnDthCheck()

		var/atom/DLOC = loc
		if(M && get_dist(M,src) < 2 && M.client)
			DLOC = M

		if(Size >1)
			if(prob(DropLargeAnimal+M.Luck))
				var/obj/Item/Material/Mission/Animal/LargeRemains/O = locate() in DLOC
				if(O)
					O.amount++
					O.Checkamount()
				else
					O = new(DLOC)
				if(DLOC == M)
					M << "You pick up [O.trueName]"
		else
			if(istype(src,/mob/Hittable/Responsive/Animal/Wild/Bird))
				if(prob(DropChicken+M.Luck))
					var/obj/Item/Material/Mission/Animal/DrumStick/O = locate() in DLOC
					if(O)
						O.amount++
						O.Checkamount()
					else
						O = new(DLOC)
					if(DLOC == M)
						M << "You pick up a [O.trueName]"
			else if(istype(src,/mob/Hittable/Responsive/Animal/Wild/Bat))
				if(prob(DropAnimal+M.Luck))
					var/obj/Item/Material/Mission/Animal/BatWing/O = locate() in DLOC
					if(O)
						O.amount++
						O.Checkamount()
					else
						O = new(DLOC)
					if(DLOC == M)
						M << "You pick up a [O.trueName]"
			else if(istype(src,/mob/Hittable/Responsive/Animal/Wild/Dog))
				if(prob(DropAnimal+M.Luck))
					var/obj/Item/Material/Mission/Animal/DogFur/O = locate() in DLOC
					if(O)
						O.amount++
						O.Checkamount()
					else
						O = new(DLOC)
					if(DLOC == M)
						M << "You pick up [O.trueName]"
			else if(istype(src,/mob/Hittable/Responsive/Animal/Wild/Mouse))
				if(prob(DropAnimal+M.Luck))
					var/obj/Item/Material/Mission/Animal/Whiskers/O = locate() in DLOC
					if(O)
						O.amount++
						O.Checkamount()
					else
						O = new(DLOC)
					if(DLOC == M)
						M << "You pick up [O.trueName]"
			else if(istype(src,/mob/Hittable/Responsive/Animal/Wild/Rabbit))
				if(prob(DropAnimal+M.Luck))
					var/obj/Item/Material/Mission/Animal/RabbitMeat/O = locate() in DLOC
					if(O)
						O.amount++
						O.Checkamount()
					else
						O = new(DLOC)
					if(DLOC == M)
						M << "You pick up [O.trueName]"
			else if(istype(src,/mob/Hittable/Responsive/Animal/Wild/Snake))
				if(prob(DropAnimal+M.Luck))
					var/obj/Item/Material/Mission/Animal/SnakeFang/O = locate() in DLOC
					if(O)
						O.amount++
						O.Checkamount()
					else
						O = new(DLOC)
					if(DLOC == M)
						M << "You pick up a [O.trueName]"
			else if(istype(src,/mob/Hittable/Responsive/Animal/Wild/Toad))
				if(prob(DropAnimal+M.Luck))
					var/obj/Item/Material/Mission/Animal/FrogLeg/O = locate() in DLOC
					if(O)
						O.amount++
						O.Checkamount()
					else
						O = new(DLOC)
					if(DLOC == M)
						M << "You pick up a [O.trueName]"
		for(var/mob/KM in KageBunshinList)
			del KM
		del src