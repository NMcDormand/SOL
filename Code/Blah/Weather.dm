mob/proc/
	//ChangeScene("inside")
	//ChangeScene("outside")

/*	ChangeScene(var/weather, var/hasShadow, var/Inside, var/Protect)
		if(weather) //If null or 0, skip this and leave weather alone
			var/obj/Time/T=GrabHolder("Time")
			if(weather==1)

			//If 1, "outside" display weather

			//If 2, "inside" remove weather
		if(hasShadow) //If null or 0, skip this and leave shadows as is
			//If 1, hasShadow - check if already has shadow - if not give it to them.
			//if 2, noShadow - remove shadows
		if(Inside) //If null or 0, leave Protection alone
			//If 1, Set to inside
			if(Inside==1) src.isInside=1;
			//If 2, Set to outside
			else src.isInside=0;
		if(Protect) //If null or 0, leave Protection alone
			//If 1, Protect
			//If 2, Remove Protection

*/


	ChangeScene(var/type)
		if(!(type=="inside" || type == "redo" || type=="noShadow"|| type == "outside")) {usr<<"Hey! Notify an Admin about this and where you got it! TY"; return;}

		var/obj/Time/T=GrabHolder("Time")

		if(type=="inside")
			src.isInside=1
			//Remove Shadow
			if(src.shadows.len>=1) // Check to see if they have a shadow in their shadow list we created.
				for(var/shadow/S in src.shadows) //If a shadow is found.
					src.underlays -= S // Remove it from the underlays.
					src.shadows.Cut() // Remove it from the shadow list
			//Remove weather/Daytime Stuff
			if(!isnull(T))
				src.client.screen-=T
				src.client.screen-=T.Weather
		else if (type=="outside")
			if(!src.isInside) return // Avoid doing this twice
			src.isInside=0
			//Add weather/Daytime Stuff
			if(!isnull(T))
				T.Apply(src)
			//Add Shadow Stuff
			//GenerateShadow(src, EAST)
		else if (type=="redo") //Reapply the shadow
			if(src.isInside) return //Use outside instead
			src.ChangeScene("inside")
			src.ChangeScene("outside")
		else if (type=="noShadow")
			if(src.isInside) return //Use outside instead
			src.ChangeScene("inside")
			//Add weather/Daytime Stuff
			if(!isnull(T))
				T.Apply(src)



var/global
	list/holder=list("Time"=new/obj/Time)

proc
	GrabHolder(wh as text)//grabs something out of the holder associated list by name.
		if(holder.Find(wh))
			return holder[wh]
		else
			return null


obj/Time//this is the time object
	New()//upon creation initialize the weather object and set it's properties.
		if(isnull(Weather))//should be null at start
			Weather=new
			Weather.screen_loc="SOUTHWEST to NORTHEAST"
			Weather.icon='Weather.dmi'
			Weather.icon_state="calm"
			Weather.layer=MOB_LAYER+6//configures the weather properly.
		spawn(25)DayCycle()
		..()
	layer=MOB_LAYER+5
	icon_state="still"
	mouse_opacity=0
	alpha=50
	icon='DayNNite.dmi'
	screen_loc="SOUTHWEST to NORTHEAST"
	var
		rev=0
		cTOD="morning"//time of the day
		cWEA="calm"//the current weather
		season="Spring"//the current season
		weather_counter=1//weather counter, responsible for changing weather.
		list/TOD=list("morning","midmorning","noon",
		"afternoon","dusk","sunset","nightfall","night")//time of day goes here, should match the name of your icon states.
		chg_wait=4000//5 mins per change.
		obj/Weather//this is the object that holds the visual elements for weather.
	proc
		Apply(mob/m)//this applies the weather and day to the client's screen. call this once
			if(!isnull(m.client))
				m.client.screen+=src
				m.client.screen+=src.Weather
		Remove(mob/m)
			if(!isnull(m.client))
				m.client.screen-=src
				m.client.screen-=src.Weather

		ChangeDay()
			var/r
			if(r==TOD.len)r=1
			else
				r=min(TOD.len,r+1) //Grabs next time of day from list
			animate(src,color=DayColor(TOD[r]),5)
			cTOD=TOD[r]//Changes time of day to next in list

		DayColor(wh)//simply changes the color of the day based on the time of the day.
			switch(wh)
				if("midmorning")
					return rgb(255,255,204,46)
				if("morning")
					return rgb(255,255,204,46)
				if("noon")
					return rgb(255,255,204,0)
				if("afternoon")
					return rgb(255,255,204,0)
				if("sunset")
					return rgb(255,153,0,40)
				if("nightfall")
					return rgb(0,0,102,90)
				if("night")
					return rgb(0,0,200,100)
				if("dusk")
					return rgb(0,153,153,30)//you can play with these for various effects.

		DayCycle()//this is the day cycle proc. It runs and controls daytime changes and
			if(!rev)//weather changes.
				rev=1//recursive looped so that this runs smoothly in the background at all times
				var/r=TOD.Find(cTOD)//with little to no CPU cost on the host server.
				if(r==TOD.len)r=1
				else
					r=min(TOD.len,r+1) //Grabs next time of day from list
				animate(src,color=DayColor(TOD[r]),time=round(chg_wait/3))
				cTOD=TOD[r]//Changes time of day to next in list
				//InWea()//call weather changes.
				spawn(chg_wait)
					rev=0
					.()


mob/Myst/verb
	changeWeather()
		set name="Change Weather"
		set category="Server"
		var/obj/Time/T=GrabHolder("Time")
		var/input = input("Choose a type of weather!","Time of Day")
		T.Weather.icon_state=input
	cycleTimeofDay()
		set name="Change Day Time"
		set category="Server"
		var/obj/Time/T=GrabHolder("Time")
		if(!isnull(T))
			T.ChangeDay()
	changeTimeofDay()
		set name="Change Server Time"
		set category="Server"
		var/obj/Time/T=GrabHolder("Time")
		var/inputr = input("Red","Time of Day") as num
		var/inputg = input("Green","Time of Day") as num
		var/inputb = input("Blue","Time of Day") as num
		var/inputt = input("Trans","Time of Day") as num
		animate(T,color=rgb(inputr,inputg,inputb,inputt), 2);
