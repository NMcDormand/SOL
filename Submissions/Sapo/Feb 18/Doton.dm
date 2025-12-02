obj/SkillCards/Doton/DotonYomiNuma
	name="Doton Yomi Numa"
	icon_state="card_bunshin"
	cmdstring="DotonYomiNuma"
	Click()
		if(src in usr)DotonYomiNuma()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="This jutsu creates a red swamp where anyone that enters gets paralyzed except the user"
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
		if(usr.Giant)return
		if(usr.InMeatTank)return
		if(usr.InMeatTankHari)return
		if(usr.nagashi)return
		if(usr.inbed)return
		if(usr.AFK)return
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

obj/SkillCards/Doton/RetsudoTensho
	name="Doton Retsudo Tensho"
	icon_state="card_bunshin"
	cmdstring="DotonRetsudoTensho"
	Click()
		if(src in usr)DotonRetsudoTensho()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="This is among the more basic techniques taught in Iwagakure. By placing the palm of their hand on the ground, the user breaks up and shifts the local earth."
		Description["title"]="Doton Retsudo Tensho"
		Description["range"]=2
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
	verb/DotonRetsudoTensho()
		set category="TECHNIQUES"
		set hidden = 1
		set src in usr.contents
		if(usr.Giant)return
		if(usr.InMeatTank)return
		if(usr.InMeatTankHari)return
		if(usr.nagashi)return
		if(usr.inbed)return
		if(usr.AFK)return
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
				usr.retsudo(Description["range"])
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
	ClayMine
		icon='c2novo.dmi'
		icon_state=""
	shake
		icon='shake.dmi'
		name="Doton Retsudo Tensho"
		pixel_y=-32
		pixel_x=-32
		layer=TURF_LAYER+1||OBJ_LAYER+1||MOB_LAYER-1
		New()
			..()
			Spin()
			spawn(25)
				del(src)
		proc
			Spin()
				if(!src)return
				var/mob/O = owner
				for(var/mob/I in loc)
					if(!I.NPC&&!I.dead&&owner!=I&&I!=O)
						if(I in hit)continue
						if(I.village in O.FFlist)continue
						if(I in O.FFlist)continue
						if(!I.client)I.target_mob=O
						else I.Target_Atom(O)
						view(I)<<"[I] was hit by [src] Doton Retsudo Tensho!"
						I.stamina=0
						I.KO(O,name)
						hit.Add(I)
						spawn(15)
							if(src)
								hit.Remove(I)
				spawn(5)
					Spin()
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
		retsudo(var/range)
			if(!src)return
			if(!range)return
			for(var/turf/G in range(src,3))
				var/obj/shake/F = new/obj/shake()
				F.owner=src
				F.loc=G
				sleep(0.5)
				continue
