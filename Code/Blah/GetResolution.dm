var
	Resolutions[0]
	SubmittedResolutions=list()
	Over1200=0
	Under1152=0
	Over1152=0
	TotalResolutions=0
mob
	var
		resolution
		scrwidth
		scrheight
client
	Topic(t)
		sleep(100)
		if(!(src.ckey in SubmittedResolutions)&&!(src.mob.resolution in Resolutions))
			var/nlist[] = params2list(t)
			if(nlist["action"] && (nlist["action"] == "resol"))//If action exists & is set to assign resolution
				src.mob.scrwidth=text2num(nlist["width"])//assigns width to mob
				src.mob.scrheight=text2num(nlist["height"])//same here (with height)
				src.mob.resolution="[src.mob.scrwidth]x[src.mob.scrheight]"
				Resolutions[src.mob.resolution]+=1
				SubmittedResolutions+=src.ckey
				if(src.mob.scrwidth>=1200) Over1200++
				else if(src.mob.scrwidth>=1152) {Over1200++; Over1152++}
				else Under1152++
				TotalResolutions++
				SaveResolutions()


proc
	LoadResolutions()
		if(fexists("ResolutionLog.sav"))
			var/savefile/F = new ("Data/ResolutionLog.sav")
			F["Resolutions"]>>Resolutions
			F["CIDs"]>>SubmittedResolutions
			F["Over1200"]>>Over1200
			F["Over1152"]>>Over1152
			F["Under1152"]>>Under1152
			F["TotalResolutions"]>>TotalResolutions

	SaveResolutions()
		var/savefile/F = new("Data/ResolutionLog.sav")
		F["Resolutions"]<<Resolutions
		F["CIDs"]<<SubmittedResolutions
		F["Over1200"]<<Over1200
		F["Over1152"]<<Over1152
		F["Under1152"]<<Under1152
		F["TotalResolutions"]<<TotalResolutions


mob/AJ/verb/CheckResolutions()
	set category="Special"
	BubbleSort(Resolutions)
	for(var/v in Resolutions)
		usr<<"[v] --> [Resolutions[v]]"
	var/wp=round((Over1200/TotalResolutions)*100)
	var/m=round((Over1152/TotalResolutions)*100)
	var/up=round((Under1152/TotalResolutions)*100)
	usr<<"[wp]% of players have a screen as wide or wider than <i>1200 pixels</i>."
	usr<<"[m]% of players screen between 1152 and 1200 <i>1152 pixels</i> wide"
	usr<<"[up]% of players have a narrower than <i>1200 pixels</i>."

proc
    BubbleSort(list/L)
        .=L
        var/swapped = FALSE
        do
            swapped = FALSE
            for(var/i = 1 to (L.len-1))
                if(L[i] > L[i+1])
                    L.Swap(i,i+1)
                    swapped = TRUE
        while(swapped)