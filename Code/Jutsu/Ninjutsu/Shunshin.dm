obj/SkillCards/Ninjutsu/ShunshinToggle
	icon_state="card_Shunshin"
	cmdstring="Shunshin"
	CanLevel = 0
	Range=9
	CCost=60
	Seals=1
	Description = list(
		"about"="Move so fast its like you're teleporting. Use the skillcard to toggle Shunshin Mode. When in Shunshin Mode, double click a space to inistantly move there."
		,"title"="Shunshin no Jutsu"
		,"type"="Ninjutsu"
		,"type"="B"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='Shunshin.png'
		)

	Activate(mob/U)
		if(U.CanShunshin)
			U<<"Your turn Shunshin ability off"
			U.CanShunshin=0
		else
			U<<"Your turn Shunshin ability on"
			U.CanShunshin=1

turf/Click()
	..()
	if(usr.CanShunshin && !usr.MirrorCreationMode && !usr.InCreate)
		//for(var/turf/T in orange(src,12)) if(T.density) T.opacity=1
		//if(src in oview(12,usr))
		usr.ShunshinnoJutsu(src)
		//for(var/turf/t in orange(src,12)) if(t.density) t.opacity=initial(t.opacity)

mob
	var
		CanShunshin //No longer a tmp
		ShunshinRange = 5

	proc
		ShunshinnoJutsu(turf/T)
			if(SHUNCHECK(src))
				return
			if(moving)
				sleep(1)
			var
				c=60; mx=c; s=SS*1
			if(Chakra<=c) {src<<"Not enough Chakra."; return}
			icon_state="seals"
			firing=1
			spawn(s)
				var/atom/movable/S=new(loc)
				spawn(1)icon_state=null;
				spawn(2)firing=0
				if(prob(ChakraControl))
					S.icon=icon; //icon=null
					//var/d=dir
					if(ChakraControl<100) {c+=rand(0,mx/2); CCGain(c)}
					JutsuSeals(s); ApplyEXP(c*0.4,"chakra"); JutsuNin(c)
					MoveUses["Shunshin"]++
					var/MU = MoveUses["Shunshin"]
					if(round(MU/20) >= ShunshinRange)
						ShunshinRange++
					Chakra-=c;
					//hearers(4,src)<<"<b>[src]: Shunshin no Jutsu!</b>"
					/*var/list/O = overlays.Copy()
					overlays = overlays.Remove(overlays)*/
				 	S.icon_state="Flicker"
					//S.overlays=null; flick("Flicker",S)
					spawn(3)
						if(S)
							del(S)
					spawn(-1)
					/*
						if(ismob(usr.Targeting)&&get_dist(usr.Targeting,T)<= 4)
							var/mob/m = usr.Targeting
							var/mDir = get_step(m,turn(m.dir,180))
							if(CheckDensity(mDir)) {if(get_dist(T,src)<10) {Move(T,d)}}
							else {Move(get_step(m,turn(m.dir,180))); usr.dir=get_dir(usr,m);}
							//else {usr.loc=get_step(m,turn(m.dir,180)); usr.dir=get_dir(usr,m);} <-- Don't use loc because it avoids area checks
						else if(get_dist(T,src)<10) {Move(T,d); flick("kawarimi",src); flick("Flicker",src)}*/
						var/CS = movespeed
						movespeed = 0
						CanShunshin = 2
						for(var/A = 0 to ShunshinRange)
							if(loc != T)
								step_to(src,T)
							else
								break
						spawn(3)
							CanShunshin = 1
						movespeed = CS
						if(ismob(usr.Targeting)&&get_dist(usr.Targeting,T)<= 6)
							dir = get_dir(usr,usr.Targeting)
				else {c-=rand(1,mx/2); Chakra-=c; src<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}


proc/CheckDensity(var/turf/T)
    if(T.density) return TRUE
    if(T.name=="Black Opaque") return TRUE