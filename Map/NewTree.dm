mob/var/Cactus
mob/Hittable/Unresponsive/Training/Stump
	invisibility = 4
	CantHenge=1

	Stamina=3000000
	StaminaMax=3000000
	StaminaTrue=3000000

	Chakra=10
	ChakraMax=10
	ChakraTrue=10

	Taijutsu=10
	TaijutsuMax=10
	TaijutsuTrue=10

	Genjutsu=10
	GenjutsuMax=10
	GenjutsuTrue=10

	Ninjutsu=10
	NinjutsuMax=10
	NinjutsuTrue=10

	taitraining=9
	var/HasDoor = 0
	var
		GoX = 0
		GoY = 0
		GoZ = 0
		GoSZ = 0
		GoOut = 0
		Message

	Tree
		TreeStump = 0
		BlockTarget = 1
		icon='Tree3.dmi'
		name = "Tree"
		icon_state=""
		density=1
		layer=5
		pixel_x = -16

		Cross(A)
			if(ismob(A) && HasDoor && dead)
				var/mob/M = A
				if(M.DamagedRecently||!M.client)
					return 0
				return 1
			.=..()

		Crossed(var/mob/A)
			if(ismob(A) && HasDoor)
				if(GoX<1||GoY<1||GoZ<1)
					A<<"Broken Door, please report, [x], [y], [z]"
					return
				if(A.loc.loc)
					A.loc.loc.Exited(A)
				A.loc = locate(GoX,GoY,GoZ)
				if(A.loc.loc)
					A.loc.loc.Entered(A)
				A.canfindrocks=GoOut
				A.protect=GoSZ
				if(Message)
					A << Message

		New()
			Overlay = new/Overlay_Obj(icon('Tree3Top.dmi'),layer+2,-32)
			overlays += Overlay
			..()

		DamageMe(mob/M,DAMAGE,METHOD,hidemessage)
			if(METHOD == "swings at")
			 DAMAGE *= 1.6
			if(TreeStump||dead)
				return
			if(istype(METHOD,/obj/Jutsu))
				var/obj/Jutsu/J = METHOD
				if(J.FireElemental)
					DAMAGE *= 1.5

			Stamina -= DAMAGE * 0.3

			if(Stamina<=0)
				if(!TreeStump||!dead)
					dead = 1
					for(var/Overlay_Obj/OL in overlays)
						OL.icon_state = "BlankT"
					overlays -= Overlay
					if(HasDoor)
						icon_state = "2"
						name = "Entrance"
					else
						icon_state = "1"
						name = "Stump"
						TreeStump = 1

					var/obj/Item/Material/Wood/WO = new(loc)
					WO.amount = pick(1,2,3,4)
					WO.Checkamount()
					spawn(3000)
						dead = 0
						TreeStump = 0
						Stamina = StaminaMax
						overlays += Overlay
						name = "Tree"
						icon_state = ""
						for(var/Overlay_Obj/OL in overlays)
							OL.icon_state = ""

	TreeStump
		icon='Stump.dmi'
		icon_state="stump"
		name = "Stump"
		CantWalk = 0
		TreeStump=1
		BlockTarget = 0
		DamageMe(mob/M,DAMAGE,METHOD,hidemessage)
			TextOverlay(src, DAMAGE, "stump");
			DamageReport(src,M,DAMAGE,METHOD)

		Action(mob/user)
			if(!(user in range(1, src))) return
			if(!storedShuriken) user<<"There are no shurikens on this tree..."
			else user<<"You found [storedShuriken] shurikens!"
			var/counter=0
			for(var/obj/Weapon/Thrown/Shuriken/S in user.contents) counter++
			if(counter<=0)
				var/obj/Weapon/Thrown/Shuriken/S=new(user); S.amount=storedShuriken; S.Checkamount()
			else
				for(var/obj/Weapon/Thrown/Shuriken/S in user.contents)
					S.amount+=storedShuriken; S.Checkamount()
			storedShuriken=0

mob/Hittable/Unresponsive/Training/Cactus
	invisibility = 4
	Cactus
		DamageMe(mob/M,DAMAGE,METHOD,hidemessage)
			TextOverlay(src, DAMAGE, "stump");
			DamageReport(src,M,DAMAGE,METHOD)
		icon='Cactus.dmi'
		icon_state="cactus"

		TreeStump=1
		Cactus=1
		BlockTarget = 0

		Stamina=1000000
		StaminaMax=1000000
		StaminaTrue=1000000

		Chakra=10
		ChakraMax=10
		ChakraTrue=10

		Taijutsu=10
		TaijutsuMax=10
		TaijutsuTrue=10

		Genjutsu=10
		GenjutsuMax=10
		GenjutsuTrue=10

		Ninjutsu=10
		NinjutsuMax=10
		NinjutsuTrue=10

		taitraining=12
		CantWalk = 0

obj/Tree
	//var/health
	layer=MOB_LAYER+1
	pixel_x = -16
	BigTree
		icon='Tree2.dmi'
		layer=5
		density=1
		pixel_x=-32
		Cross(mob/A)
			if(ismob(A) && A.client)
				if(A.dir != SOUTH)
					return 1
			else
				return 0
		Uncross(atom/movable/M)
			if(M.dir == NORTH)
				return 0
			. = ..()
		Crossed(mob/A)
			//A.BlockN = 1
			A.OnBigTree = 1
			A.layer = layer+0.01
			..()
		Uncrossed(mob/A)
			//A.BlockN = 0
			A.OnBigTree = 0
			A.layer = text2num("[MOB_LAYER].[world.maxy - y][(32-step_y) < 10 ? 0 :][32-step_y]")
			..()

		New()
			//new/obj/Tree/BigTreeTop(locate(x,y,z))
			Overlay = new/Overlay_Obj(icon('Tree2Top.dmi'),layer+2,-32,0)
			overlays += Overlay
			..()

		ClimbTree(mob/user)
			if(!user || user.ChakraControl>=100)
				return
			if(user.dir==NORTH||user.dir==NORTHWEST||user.dir==NORTHEAST)
				if(user.climbing||user.KO||user.resting||user.meditating||user.IceBlasted) return
//					else if(user.PreventAllList) return
				else if(user.Chakra<10)
					user<<"You are out of chakra!";
					user.climbing=1;
					spawn(60)
						if(user)
							user.climbing=0
							return
				else {user.overlays+='WaterWalk(Old).dmi'; user.stillclimbing=1; user.climbing=1; user.icon_state="TreeClimb"; user.TreeClimb()}
			else
				user<<"You must stand to the tree's South."
