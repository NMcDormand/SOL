obj/SkillCards/Doton/DotonYomiNuma
	name="Doton Yomi Numa"
	icon_state="card_bunshin"
	cmdstring="DotonYomiNuma"
	Click()
		if(src in usr)DotonYomiNuma()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="This jutsu creates a red swamp that paralyzes anyone within its reach"
		Description["title"]="Doton Yomi Numa"
		Description["range"]=4
		Description["type"]="Ninjutsu"
		Description["cost"]=400
		Description["seals"]=5
		Description["strong"]="Lightning"
		Description["weak"]="Water"
		Description["rank"]="B"
		Description["pic"]='Bunshin.png'
		Description["category"]="ninjutsu"
		Description["indelay"]=0
		Description["delay"]=15
	verb/DotonYomiNuma()
		set category="TECHNIQUES"
		set hidden = 1
		set src in usr.contents
		if(usr.inbed||usr.AFK||usr.KO||usr.dead)return
		if()return
		if(usr.KO)return
		if(usr.dead)return
		if(!usr.ingame)return
		if(Description["indelay"])return
		if(!(usr.JutsuUse(src)))return
		usr.inseals=1
		usr.loadoverlays()
		spawn(usr.sealspeed*1)
			if(usr)
				usr.inseals=0
				usr.loadoverlays()
				usr.createSwamp(Description["range"])
				usr.firing=1
				Description["indelay"]=1
				spawn(Description["delay"])
					if(usr)
						Description["indelay"]=0
				spawn(usr.jdt)
					if(usr)
						usr.firing=0

obj
	Swamp
		icon='earth style dark swamp.dmi'
		icon_state="center"
mob
	proc
		createSwamp(var/range)
			if(!src)return
			for(var/turf/I in range(src,range))
				if(I.density)continue
				if(I.iswamp)continue
				I.overlays+=/obj/Swamp
				I.iswamp=1
				I.swampuser=src
				for(var/mob/O in I)
					if(O.canmove&&O!=I.swampuser)
						O.canmove=0
				spawn(100)
					if(I.iswamp)
						I.iswamp=0
						I.overlays=null
						for(var/mob/O in I)
							if(!O.canmove)
								O.canmove=1

turf
	Entered(M)
		if(iswamp)
			if(istype(M,/mob/))
				var/mob/I=M
				if(I!=swampuser)
					I.canmove=0
					//You need to put the variable you use to stop movement in my case (canmove)
				else
					return 1
		else
			return 1

turf
	var
		iswamp
		swampuser