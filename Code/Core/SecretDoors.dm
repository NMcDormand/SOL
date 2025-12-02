var/EdoCreated = 0
turf
	Secret
		SecretDoor
			var
				GoX = 1
				GoY = 1
				GoZ = 1
				NewPlace
				MSG
				ProtectMe = 0
				HideMobs = 0
				EdoDoor = 0
			layer = 100
			density = 0
			//invisibility = 99
			Cross(mob/A)
				if(ismob(A))
					if(A.DamagedRecently||!A.client)
						return 0
					if(EdoDoor && A.HasEdo)
						return 0
				.=..()
			Crossed(mob/A)
				if(ismob(A))
					if(!A.client||A.DamagedRecently)
						return
					if(A.loc.loc)
						A.loc.loc.Exited(A)
					A.loc = locate(GoX,GoY,GoZ)
					A.ZCoord = NewPlace
					if(MSG)
						A << MSG
					if(HideMobs)
						A.OSight = A.sight
						A.sight &= (SEE_MOBS)
					else if(A.OSight)
						A.sight = A.OSight
					if(A.loc.loc)
						A.loc.loc.Entered(A)
					if(EdoDoor && !EdoCreated)
						EdoCreated = 1
						spawn(20000)
							EdoCreated = 0
						var/obj/Item/Scroll/ES = new(locate(873,161,2))
						ES.name = "Edo Tensei No Jutsu"
						ES.trueName = ES.name
						ES.icon_state = "Gen"
					if(!ProtectMe)
						A.protect = 0
					else
						A.protect = 1
obj
	Passage
		MovingBlock
			icon='newturfs.dmi'
			var/WillMove = 0 //0 disappear, 1 north, 2 south, 4 east, 8 west
			var/Respawn = 0
			var/list/Reqs = list()
			var/EdoBlock
			var/Moved = 0
			New()
				..()
				Respawn = loc
			Action(mob/user)
				if(Moved)
					return
				if(EdoBlock)
					if(user.HasEdo)
						return
					for(var/obj/Item/Scroll/ES in user)
						if(ES.name == "Edo Tensei No Jutsu")
							return
				for(var/A in Reqs)
					if(A == "Hair")
						if(user.CurrentHair != Reqs[A])
							return
					else if(A == "Item")
						var/found = 0
						for(var/obj/Item/W in user.contents)
							if(W.trueName == Reqs[A])
								found = 1
								break
						if(!found)
							return
					else if(A == "Worn")
						var/found = 0
						for(var/obj/Clothing/W in user.contents)
							if(W.trueName == Reqs[A] || W.name == Reqs[A])
								if(W.worn)
									found = 1
						if(!found)
							return
					else if(A == "Wield")
						var/found = 0
						for(var/obj/Weapon/Wield/W in user.contents)
							if(W.trueName == Reqs[A] || W.name == Reqs[A])
								if(W.worn)
									found = 1
						if(!found)
							return
					else if(user.vars[A] < Reqs[A])
						return
				if(WillMove)
					Moved = 1
					density = 0
					loc.invisibility = 99
					step(src,WillMove)
					sleep(50)
					density = 1
					step_to(src,Respawn)
					loc.invisibility = 0
					Moved = 0
				else
					Moved = 1
					loc.invisibility = 99
					loc=null
					Moved = 1
					sleep(50)
					loc = Respawn
					loc.invisibility = 0
					Moved = 0
			Clock
				icon_state="clock"
				density=1
			Door
				icon='Buildings.dmi'
				icon_state = "door2"
				density=1
