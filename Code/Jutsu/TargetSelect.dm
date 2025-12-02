mob
	proc
		TargetSelect(RNG=10, BlockStump = 0, AllowCreations = 0, IgnoreTeam = 0)
			var/list/aList=list()
			choosingHoming=1
			var/mob/TGT
			for(var/mob/J in view(usr,RNG))
				if(istype(J,/mob/player)||istype(J,/mob/Hittable))
					var/mob/L = J
					if(L.BlockTarget||L.protect)
						continue
					if(BlockStump && L.TreeStump)
						continue
					if(!AllowCreations && (L.Creator == src || L == src || L == Familiar))
						continue
					if(!IgnoreTeam && IDCHECK(src,L))
						continue
					aList+=L

			if(aList.len)
				if(aList.len>1)
					TGT=input("What would you like to target?","Target") as null|anything in aList
				else
					TGT=pick(aList)
				if(TGT)
					for(var/image/x in client.images) // first, check to see if your have a target.
						if(x.icon=='target.dmi') // if so.
							del(x) // delete it.
					var/image/I = image('target.dmi',TGT) // create a new target on the source.
					src<<I // make it so only u can see the target
					Targeting=TGT // make your target variable source name.
					src<<"You target [TGT]" // tell yourself your you targeted him/her.
			choosingHoming=0
			return TGT

		Facedir(atom/movable/a)
			if(a.y>y)
				if(a.x>x)
					dir=NORTHEAST
				else if(a.x==x)
					dir=NORTH
				else if(a.x<x)
					dir=NORTHWEST
				return
			else if(a.y<y)
				if(a.x>x)
					dir=SOUTHEAST
				else if(a.x==x)
					dir=SOUTH
				else if(a.x<x)
					dir=SOUTHWEST
				return
			else //if(a.y==y)
				if(a.x>x)
					dir=EAST
				else if(a.x<x)
					dir=WEST
			/*	else
					var/A=step_y-a.step_y
					var/B=step_x-a.step_x
					if(A<-6)
						if(B<-6)
							dir=NORTHEAST
						else if(B>6)
							dir=NORTHWEST
						else //if(B==D)
							dir=NORTH
						return
					else if(A>6)
						if(B<-6)
							dir=SOUTHEAST
						else if(B>6)
							dir=SOUTHWEST
						else //if(B==D)
							dir=SOUTH
						return
					else //if(A==C)
						if(B<-6)
							dir=EAST
						else if(B>6)
							dir=WEST
						return
				return*/