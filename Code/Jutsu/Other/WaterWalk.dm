mob/var
	WW
	CantWaterWalk=1
mob/proc
	LearnWaterWalk()
		if(ChakraControl>=38 && !JutsuList["Waterwalk"])
			src<<"<b><font size=2>You now have the ability to walk on water!</b></font>"
			CantWaterWalk=0; WW=1; JutsuList["Waterwalk"]=1
			verbs+=new/mob/VerbHolder/WaterWalk/verb/ToggleWW()

mob/VerbHolder/WaterWalk/verb/ToggleWW()
	set name="Toggle Water Walk"
	set desc="On: you walk on water.  Off: You only swim"
	set category="Commands"
	if(usr.WW) {WW=0; usr<<"Water Walk set to <i>off</i>."}
	else {WW=1; usr<<"Water Walk set to <i>on</i>."}

obj/var/visible_time = 7 //Time before it fades
obj/footprint
   icon = 'waterwalk2.Dmi'
   icon_state = "Trail2"
   New(Dir)
      if(Dir) dir=Dir
      flick(src,"appear") //I may have these arguments backwards.
      spawn(visible_time)
         flick(src,"fade")
         del src


