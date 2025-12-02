#if DEBUGGING
mob/verb
	SelfLearnHiraishin()
		var/obj/SkillCards/Ninjutsu/Special/Hiraishin/J=locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned the <i>Flying Thunder God Technique</i>, <font size=3>Hiraishin</font>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Special/Hiraishin(src)
			HasHiraishin = 1
			verbs += new/mob/VerbHolder/Jutsu/Hiraishin/verb/Hiraishin_Mark()

#endif

mob/VerbHolder/Jutsu/Hiraishin
	verb
		Hiraishin_Mark(B as turf|mob in oview(usr,1))
			if(B)
				var/atom/A = B
				var/mob/U = usr
				if(isturf(A))
					if(protect||dead||Arena||KI_InMission)
						return
					if("[A.type]" == "/turf")
						return
					switch(ZCoord)
						if("Sound 5 Quest", "Revolution", "Hospital", "Inside", "Guild House", "Logging In", "Chuunin Fight", "Ninja Academy", "Jail", "Forest of Death")
							usr << "You cant mark the land in this location"
							return
						if("Leaf Jail", "Mist Jail", "Sand Jail", "Cloud Jail", "Grass Jail", "Rock Jail", "Rain Jail", "Sound Jail")
							usr << "You cant mark the land in this location"
							return
					if(z>2)
						return
					if(!A.density)
						var/NA = input("What would you like to name this location?","Loc Name") as text
						if(NA)
							if(NA != "")
								if(U.MarkedLocations[NA])
									if(alert("You already have a location saved under this name, would you like over write it?","Overwrite","Yes","No") == "Yes")
										U.MarkedLocations[NA] = new/SavedLoc(A)
										usr << "You marked [A] with your seal"
								else
									U.MarkedLocations[NA] = new/SavedLoc(A)
									usr << "You marked [A] with your seal"
							else
								usr << "You need to enter a name to save a location"
				else if(ismob(A))
					var/mob/M = A
					if(M.protect)
						usr << "You failed to mark [M]"
						return
					if(A == U.Targeting || istype(A,/mob/player)||istype(A,/mob/Hittable/Responsive/Boss))
						if(!M.trueName||M.trueName=="")
							M.trueName = M.name
						if(!U.MarkedTargets[M.trueName])
							U.MarkedTargets[M.trueName] = A
							M.MarkedMe += U
							M.Marked = 1
							usr << "You marked [M] with your seal"
						else
							usr << "[M] was already marked"
					else if(!(A in U.MarkedThings))
						U.MarkedThings += A
						usr << "You marked [M] with your seal"
				/*else if(isobj(A))
					if(isturf(A.loc))
						if(!(A in U.MarkedThings))
							U.MarkedThings += A
							usr << "You marked [A] with your seal"*/

obj/SkillCards/Ninjutsu/Special/Hiraishin
	icon_state="card_Hiraishin"
	JutsuType = "S-Rank"
	cmdstring="Hiraishin"
	Range=999
	CCost=6000
	CanLevel = 0

	Description = list(
		"about"="Used to instantly travel to a marked locations or people, remember this only works on anything you have already marked"
		,"title"="Hiraishin"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
		//,"pic"='Chidori.png'
		)

	Activate(mob/U)
		if(!U.HiraishinToggled)
			if(U.CooldownCheck("Hiraishin",(4000 * U.cooldownmultiplier),0)) return
			U<<"You turn the Hiraishin ability on"
			U.HiraishinToggled=U.HiraishinMax
		else
			var/mob/T = U.Targeting
			if(T && get_dist(T, U) < 10 && !T.HiraishinBlockCheck() && U.MarkedTargets[T.trueName])
				var/LOC = Get_Rand_DirStep(T)
				if(LOC)
					if(U.HiraishinPort(LOC,T))
						return
			else
				switch(alert(U,"What would you like to do with Hiraishin","Hiraishin","Use","Deactivate"))
					if("Deactivate")
						U<<"You turn the Hiraishin ability off"
						U.HiraishinToggled=0
						if(U.HiraishinToggled == U.HiraishinMax)
							U.Cooldowns -= "Hiraishin"
					if("Use")
						T = U.Targeting
						if(T && get_dist(T, U) < 10 && !T.HiraishinBlockCheck() && U.MarkedTargets[T.trueName])
							var/LOC = Get_Rand_DirStep(T)
							if(LOC)
								if(U.HiraishinPort(LOC,T))
									return
						var/list/Choices = list()
						if(length(U.MarkedTargets))
							Choices += "Target"
						if(length(U.MarkedThings))
							Choices += "Thing"
						if(length(U.MarkedLocations))
							Choices += "Location"
						if(length(Choices))
							if(length(Choices) > 1)
								Choices += "Cancel"
							var/Choice = input("What are you are you hoping to instantly travel to?","Hiraishin") in Choices
							if(Choice != "Cancel")
								var/turf/LOC
								switch(Choice)
									if("Target")
										Choices = list()
										for(var/TA in usr.MarkedTargets)
											var/mob/M = usr.MarkedTargets[TA]
											if(M)
												if(!M.HiraishinBlockCheck())
													Choices += M
										if(length(Choices))
											var/mob/M = input("Which Target?","Hiraishin") as null|anything in Choices
											if(M)
												LOC = Get_Rand_DirStep(M)
										else
											usr << "You have no Targets marked"
									if("Thing")
										Choices = list()
										for(var/atom/movable/A in usr.MarkedThings)
											if(ismob(A))
												var/mob/M = A
												if(!M.HiraishinBlockCheck())
													Choices += M
											else
												if(!ismob(A.loc) && A.loc)
													Choices += A
										if(length(Choices))
											if(length(Choices)>1)
												Choices += "Cancel"
											var/atom/movable/A = input("Which Thing?","Hiraishin") in Choices
											if(A && A != "Cancel")
												if(ismob(A))
													LOC = Get_Rand_DirStep(A)
												else
													LOC = A.loc
										else
											U << "You have nothing marked that can be travelled too"
									if("Location")
										var/SavedLoc/SL = U.MarkedLocations[input("Which Location?","Hiraishin") as null|anything in U.MarkedLocations]
										if(SL)
											LOC = SL.FindMe()
											if("[LOC.type]" == "/turf")
												del SL
												return
											if(LOC.z > 2)
												usr << "Nice Try"
												del SL
												return
								if(LOC)
									var/D = get_dist(LOC,src) - 10
									var/Cost = D * 250
									if(Cost < 3000)
										Cost = 3000
									if(U.Chakra >= Cost)
										if(alert("This will cost you [Cost] Chakra, is this ok?","Chakra Cost","Yes","No") == "Yes")
											U.HiraishinPort(LOC)
									else
										U << "You do not have enough to Chakra to travel this far (Need:[Cost] Chakra)"

	verb
		Hiraishin_Remove_Location()
			set category="TECHNIQUES"
			set src in usr.contents
			var/mob/U = usr
			var/A = input("Which Location would you like to remove?","Hiraishin") as null|anything in U.MarkedLocations
			if(A)
				U.MarkedLocations -= A

		Hiraishin_Settings()
			set category="TECHNIQUES"
			set src in usr.contents
			var/Choice = input("Which setting would you like to change?","Hiraishin") as null|anything in list("Auto Attack","Auto Distance","Auto Dodge")
			if(Choice)
				switch(Choice)
					if("Auto Attack")
						switch(alert("You will automatically use Hiraishin when you have a target and try to Attack from a distance if it is possible, Auto Attack will cost 2 times as much","Auto Punch","Enable","Disable"))
							if("Enable")
								if(!usr.HiraishinAuto)
									usr << "The Auto Attack is now enabled"
									usr.HiraishinAuto = 1
								else
									usr << "The Auto Attack will remain enabled"
							if("Disable")
								if(usr.HiraishinAuto)
									usr << "The Auto Attack is now disabled"
									usr.HiraishinAuto = 0
								else
									usr << "The Auto Attack will remain disabled"
					if("Auto Distance")
						var/D = input("If Enabled the Auto Attack will only activate if you are further than this range","Auto Distance") as num
						if(D<=0)
							if(alert("Are you sure you would like to set this to 0? this means you will use hiraishin even if you are 1 tile away","Are you sure?","Yes","No") == "Yes")
								usr.HiraishinAutoDist = 0
						else
							if(alert("Are you sure you would like to set this to [D]? this means you will use hiraishin if they are [D+1] tiles away","Are you sure?","Yes","No") == "Yes")
								usr.HiraishinAutoDist = D
					if("Auto Dodge")
						switch(alert("If Enabled the Auto dodge anything that will damage you, Auto Dodge will cost 3 times as much","Auto Distance","Enable","Disable"))
							if("Enable")
								if(!usr.HiraishinAutoDodge)
									usr << "The Auto Dodge is now enabled"
									usr.HiraishinAutoDodge = 1
								else
									usr << "The Auto Dodge will remain enabled"
							if("Disable")
								if(usr.HiraishinAutoDodge)
									usr << "The Auto Dodge is now disabled"
									usr.HiraishinAutoDodge = 0
								else
									usr << "The Auto Dodge will remain disabled"

