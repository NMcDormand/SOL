var
	CriMax=80
	AniMax=100
	DepMax=160
	DepSpn=0
	AniSpn=0
	CriSpn=0
	list/SpnOutd
	list/SpnVill
	list/SpnWall
	list/SpnCave
proc
	CreateSpawners()
		set waitfor=0
		if(!SpnOutd||!SpnVill||!SpnWall)
			SpnOutd=list()
			SpnVill=list()
			SpnWall=list()
			for(var/area/Outdoor/AA in world)
				if(istype(AA,/area/Outdoor/NoGo)||AA.NoGo||istype(AA,/area/Water)||istype(AA,/area/Waterfall)||AA.NoGo)
					continue
				for(var/turf/A in AA)
					if(A.density||A.z>2||istype(A,/turf/terrain/Water)||istype(A,/turf/terrain/Waterfall))
						continue
					else
						for(var/atom/AT in A)
							if(AT.density)
								continue
						if(istype(AA,/area/Outdoor/Village))
							SpnVill+=A
						else if(AA.VillageWall)
							SpnWall+=A
						else if(istype(AA,/area/Outdoor))
							SpnOutd+=A
		if(!SpnCave)
			SpnCave=list()
			for(var/area/Cave/AA in world)
				if(istype(AA,/area/Cave/FOD)||istype(AA,/area/Cave/NoGo)||AA.NoGo||istype(AA,/area/Water)||istype(AA,/area/Waterfall)||AA.NoGo)
					continue
				for(var/turf/A in AA)
					if(A.density||A.z>2||istype(A,/turf/terrain/Water)||istype(A,/turf/terrain/Waterfall))
						continue
					else
						for(var/atom/AT in A)
							if(AT.density)
								continue
						SpnCave+=A
		Respawn
		if(DepSpn < DepMax)

			spawn(-1)
				var/Bi=DepMax-DepSpn
				for(var/i=1 to round(Bi*0.05))
					redo
					var/turf/A=SpnCave[rand(1,SpnCave.len)]
					if(/obj/Spawner in A)
						goto redo
					new/obj/Spawner/DeposSpwn(A)

				while(DepSpn < DepMax)
					redo
					var/turf/A=SpnOutd[rand(1,SpnOutd.len)]
					if(/obj/Spawner in A)
						goto redo
					new/obj/Spawner/DeposSpwn(A)

		if(AniSpn < AniMax)
			spawn(-1)
				var/Bi=AniMax-AniSpn
				for(var/i=1 to round(Bi*0.6))
					redo
					var/turf/A=SpnOutd[rand(1,SpnOutd.len)]
					if(/obj/Spawner in A)
						goto redo
					new/obj/Spawner/AnimaSpwn(A)
				for(var/i=1 to round(Bi*0.1))
					redo
					var/turf/A=SpnCave[rand(1,SpnCave.len)]
					if(/obj/Spawner in A)
						goto redo
					new/obj/Spawner/AnimaSpwn(A)
				while(AniSpn < AniMax)
					redo
					var/turf/A=SpnVill[rand(1,SpnVill.len)]
					if(/obj/Spawner in A)
						goto redo
					new/obj/Spawner/AnimaSpwn(A)

		if(CriSpn < CriMax)
			spawn(-1)
				var/Bi=CriMax-CriSpn
				for(var/i=1 to round(Bi*0.1))
					redo
					var/turf/A=SpnCave[rand(1,SpnCave.len)]
					if(/obj/Spawner in A)
						goto redo
					new/obj/Spawner/CrimeSpwn(A)
				while(CriSpn < CriMax)
					redo
					var/turf/A=SpnOutd[rand(1,SpnOutd.len)]
					if(/obj/Spawner in A)
						goto redo
					new/obj/Spawner/CrimeSpwn(A)

		spawn(9000)
			goto Respawn
/*
mob
	verb
		SPStart()
			CreateSpawners()
		SPCheck()
			world << "<h2>Spawn Check</h2>"
			world << "[CriSpn] / [CriMax] Criminals Spawned"
			world << "[AniSpn] / [AniMax] Animals Spawned"
			world << "[DepSpn] / [DepMax] Deposits Spawned"
			world << "Caves: [length(SpnCave)]"
			world << "OutDo: [length(SpnOutd)]"
			world << "Vills: [length(SpnVill)]"
			world << "Walls: [length(SpnWall)]"
		SpawnerPort()
			var/list/Choice= list()
			for(var/obj/Spawner/SP in world)
				Choice += SP
			var/obj/C = input("Which one?","Which") as null|anything in Choice
			if(C)
				loc = C.loc
*/
obj
	Spawner
		var
			SpTyp
			SpCur=0
			SpRte=0
			SpMax=0
			SpLim=0
			RangY=0
			RangX=0
		//icon='Diag.dmi'
		//icon_state="Village"
		New()
			..()
			if(!SpRte)
				SpRte=pick(200,400,800)
			if(!SpMax)
				SpMax=pick(3,4,5)
			if(!SpLim)
				SpLim=pick(2,3,4)
			if(!RangX)
				RangX=pick(2,4,6)
			if(!RangY)
				RangY=RangX
			trueName = name

		proc
			SpnDthCheck()
				if(SpCur<1)
					del src

			InitSpn(Cus)
				set waitfor = 0
				//icon=null
				//name=null
				if(Cus)
					SpTyp=text2path(Cus)
				//SetRange
				var/list/BlA=block(locate(x-RangX,y-RangY,z),locate(x+RangX,y+RangY,z))
				var/list/SpnArea=list()
				for(var/turf/A in BlA)
					var/area/AR = A.loc
					if(A.density||istype(AR,/area/Outdoor/NoGo)||istype(AR,/area/Water)||istype(AR,/area/Waterfall)||istype(AR,/area/Cave/NoGo)||istype(AR,/area/Indoor)||AR.NoGo)
						continue
					if(A.loc == loc.loc)
						SpnArea+=A
				if(!SpnArea.len)
					del src
				Repeat
				var/SpFail
				if(SpLim > SpCur)
					var/Bi=SpLim-SpCur
					for(var/i=1 to Bi)
						redo
						var/turf/B=SpnArea[rand(1,SpnArea.len)]
						for(var/atom/AT in B)
							if(AT.density)
								SpFail++
								if(SpFail>=SpnArea.len)
									break
								goto redo
						var/atom/Ab = new SpTyp(B)
						if(istype(Ab,/obj))
							var/obj/Abc=Ab
							Abc.Owner=src
						else if(istype(Ab,/mob/Hittable/Responsive))
							var/mob/Hittable/Responsive/Abc=Ab
							Abc.TeamID = "Spawned"
							Abc.SRate = 0
							Abc.Creator = src

						SpCur++
						sleep(SpRte)
					/*if(SpCur==SpLim&&SpLim<SpMax)
						SpLim++
						if(prob(10))
							RangX++
							RangY++
							SpMax++
							goto SetRange*/
				sleep(SpRte*3)
				goto Repeat

		CrimeSpwn
			SpnDthCheck()
				if(SpCur<1)
					range(4,src)<<"The threat dissipated"
					del src
			New()
				..()
				trueName="CriSpawn[CriSpn]"
				name = trueName
				CriSpn++
				if(!SpTyp)
					switch(pick(1,2,3,4))
						if(1)
							SpTyp = "/mob/Hittable/Responsive/NPC/Criminal/Murderer"
						if(2)
							SpTyp = "/mob/Hittable/Responsive/NPC/Criminal/Prisoner"
						if(3)
							SpTyp = "/mob/Hittable/Responsive/NPC/Criminal/Ravager"
						if(4)
							SpTyp = "/mob/Hittable/Responsive/NPC/Criminal/Thief"
				InitSpn(SpTyp)
			Del()
				CriSpn--
				..()

		DeposSpwn
			SpnDthCheck()
				if(SpCur<1)
					range(4,src)<<"The area doesnt seem as rich as it once was"
					del src
			New()
				..()
				DepSpn++
				trueName="DepSpawn[DepSpn]"
				name = trueName
				if(!SpTyp)
					switch(pick("Rand","Spec"))
						if("Rand")
							switch(pick(prob(1000);1,prob(500);2,prob(250);3,prob(125);4,prob(50);5))
								if(1)
									InitSpn("/mob/Hittable/Unresponsive/Training/Mining/Deposit/Common")
								if(2)
									InitSpn("/mob/Hittable/Unresponsive/Training/Mining/Deposit/Uncommon")
								if(3)
									InitSpn("/mob/Hittable/Unresponsive/Training/Mining/Deposit/Rare")
								if(4)
									InitSpn("/mob/Hittable/Unresponsive/Training/Mining/Deposit/SuperRare")
								if(5)
									InitSpn("/mob/Hittable/Unresponsive/Training/Mining/Deposit/Legendary")
						if("Spec")
							switch(pick(prob(1000);1,prob(700);2,prob(550);3,prob(450);4,prob(250);5,prob(150);6,prob(50);6))
								if(1)
									InitSpn("/mob/Hittable/Unresponsive/Training/Mining/Deposit/Stone")
								if(2)
									InitSpn("/mob/Hittable/Unresponsive/Training/Mining/Deposit/Copper")
								if(3)
									InitSpn("/mob/Hittable/Unresponsive/Training/Mining/Deposit/Tin")
								if(4)
									InitSpn("/mob/Hittable/Unresponsive/Training/Mining/Deposit/Iron")
								if(5)
									InitSpn("/mob/Hittable/Unresponsive/Training/Mining/Deposit/Platinum")
								if(6)
									InitSpn("/mob/Hittable/Unresponsive/Training/Mining/Deposit/Mithril")
								if(7)
									InitSpn("/mob/Hittable/Unresponsive/Training/Mining/Deposit/Obsidian")
			Del()
				DepSpn--
				..()

		AnimaSpwn
			SpnDthCheck()
				if(SpCur<1)
					range(4,src)<<"The animals nearby seem to have left"
					del src
			New()
				..()
				AniSpn++
				trueName="AniSpawn[AniSpn]"
				name = trueName
				if(!SpTyp)
					var/area/A = loc.loc
					if(A)
						if(istype(A,/area/Outdoor/Village))
							InitSpn("/mob/Hittable/Responsive/Animal/Wild/[pick("Bird/Bird","Mouse","Rabbit","Toad","Bird/Chicken","Bird/Rooster","Dog")]")
						else if(istype(A,/area/Cave))
							InitSpn("/mob/Hittable/Responsive/Animal/Wild/[pick("Snake","Bat","Dog")]")
						else
							InitSpn("/mob/Hittable/Responsive/Animal/Wild/[pick("Bird/Bird","Mouse","Rabbit","Snake","Toad","Bird/Chicken","Bird/Rooster","Bat","Dog")]")
			Del()
				AniSpn--
				..()