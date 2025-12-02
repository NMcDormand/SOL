obj/SkillCards/Suiton/SuitonTeppodama
	name="Suiton Teppodama"
	icon_state="card_bunshin"
	cmdstring="SuitonTeppodama"
	Click()
		if(src in usr)SuitonTeppodama()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="Water spherical projectile"
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
	verb/SuitonTeppodama()
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
				usr.createTeppo()
				usr.firing=1
				Description["indelay"]=1
				spawn(Description["delay"])
					if(usr)
						Description["indelay"]=0
				spawn(usr.jdt)
					if(usr)
						usr.firing=0

obj
	teppo
		icon='teppo.dmi'
		icon_state="waterball"
		name="Suiton Teppodama"
		New()
			..()
			spawn(25)
				del(src)
mob
	proc
		createTeppo(var/range)
			if(!src)return
			var/obj/teppo/Y=new/obj/teppo(get_step(src,dir))
			Y.owner=src
			walk(Y,dir,1)