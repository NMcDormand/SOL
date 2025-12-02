obj/SkillCards/Doton/ShiWanSet
	name="Kibaku Jirai Set"
	icon_state="card_bunshin"
	cmdstring="KibakuJiraiSet"
	Click()
		if(src in usr)KibakuJiraiSet()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="Creates a Clay mine that explodes when someone gets close to it or when user chooses"
		Description["title"]="Kibaku Jirai Set"
		Description["range"]="0"
		Description["type"]="Ninjutsu"
		Description["cost"]=100
		Description["seals"]=2
		Description["strong"]="N/A"
		Description["weak"]="Lightning"
		Description["rank"]="B"
		Description["pic"]='Bunshin.png'
		Description["category"]="ninjutsu"
		Description["indelay"]=0
		Description["delay"]=15
	verb/KibakuJiraiSet()
		set category="TECHNIQUES"
		set hidden = 1
		set src in usr.contents
		if(usr.inbed)return
		if(usr.AFK)return
		if(usr.KO)return
		if(usr.dead)return
		if(!usr.ingame)return
		if(Description["indelay"])return
		if(usr.clayinfused<3)
			usr<<"You don't have enough Clay Infused - You have [usr.clayinfused] (Need: 3)!"
			return
		if(!(usr.JutsuUse(src)))return
		usr.inseals=1
		usr.loadoverlays()
		spawn(usr.sealspeed*1)
			if(usr)
				usr.inseals=0
				usr.loadoverlays()
				usr.kibakujiraiset()
				usr.firing=1
				Description["indelay"]=1
				spawn(Description["delay"])
					if(usr)
						Description["indelay"]=0
				spawn(usr.jdt)
					if(usr)
						usr.firing=0

obj/SkillCards/Doton/ShiWanThrow
	name="Kibaku Jirai Throw"
	icon_state="card_bunshin"
	cmdstring="KibakuJiraiThrow"
	Click()
		if(src in usr)KibakuJiraiThrow()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="Creates a Clay mine and throws it and it explodes on touch"
		Description["title"]="Kibaku Jirai Throw"
		Description["range"]="0"
		Description["type"]="Ninjutsu"
		Description["cost"]=100
		Description["seals"]=2
		Description["strong"]="N/A"
		Description["weak"]="Lightning"
		Description["rank"]="B"
		Description["pic"]='Bunshin.png'
		Description["category"]="ninjutsu"
		Description["indelay"]=0
		Description["delay"]=15
	verb/KibakuJiraiThrow()
		set category="TECHNIQUES"
		set hidden = 1
		set src in usr.contents
		if(usr.inbed)return
		if(usr.AFK)return
		if(usr.KO)return
		if(usr.dead)return
		if(!usr.ingame)return
		if(Description["indelay"])return
		if(usr.clayinfused<3)
			usr<<"You don't have enough Clay Infused - You have [usr.clayinfused] (Need: 3)!"
			return
		if(!(usr.JutsuUse(src)))return
		usr.inseals=1
		usr.loadoverlays()
		spawn(usr.sealspeed*1)
			if(usr)
				usr.inseals=0
				usr.loadoverlays()
				usr.kibakujirainthrow()
				usr.firing=1
				Description["indelay"]=1
				spawn(Description["delay"])
					if(usr)
						Description["indelay"]=0
				spawn(usr.jdt)
					if(usr)
						usr.firing=0

obj/SkillCards/Doton/Katsu
	name="Katsu"
	icon_state="card_bunshin"
	cmdstring="Katsu"
	Click()
		if(src in usr)Katsu()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="Used to Explode any clays set by the user"
		Description["title"]="Katsu"
		Description["range"]="0"
		Description["type"]="Ninjutsu"
		Description["cost"]=20
		Description["seals"]=2
		Description["strong"]="N/A"
		Description["weak"]="Lightning"
		Description["rank"]="B"
		Description["pic"]='Bunshin.png'
		Description["category"]="ninjutsu"
		Description["indelay"]=0
		Description["delay"]=15
	verb/Katsu()
		set category="TECHNIQUES"
		set hidden = 1
		set src in usr.contents
		if(usr.inbed)return
		if(usr.AFK)return
		if(usr.KO)return
		if(usr.dead)return
		if(!usr.ingame)return
		for(var/obj/Clay/O in world)
			if(O.owner==usr)
				usr.ExplodeClay(O)

obj
	Clay
		ClayMine
			icon='c2novo.dmi'
			icon_state=""
			Move()
				..()
				for(var/mob/U in range(src,1))
					if(U!=owner)
						U.ExplodeClay(src)
			New()
				..()
				spawn(25)
					if(claythrow)
						var/mob/U=owner
						if(!U)
							del(src)
						else
							U.ExplodeClay(src)
turf
	Enter(M)
		if(istype(M,/mob/))
			var/mob/I=M
			for(var/obj/U in range(I,1))
				if(istype(U,/obj/ClayMine/))
					if(I!=U.owner)
						I.ExplodeClay(U)
	Enter(M)
		if(istype(M,/mob/))
			var/mob/I=M
			if(I.ingame&&clay)
				if(prob(10))
					if(I.clay<I.canclay)
						I.clay+=rand(1,5)
						if(I.clay>I.canclay)I.clay=I.canclay
						I<<"You collected some Clay from the Ground."
		return 1

mob
	proc
		kibakunendo()
			if(!src)return
			if(prob(80))
				clay-=5
				clayinfused+=3
				if(clayinfused>maxclayinfused)clayinfused=maxclayinfused
				src<<"You infused some Clay. You now have [clayinfused] to use on C4 Explosive Jutsus!"
			else
				src<<"You failed to infuse Clay!"
				clay-=2
		kibakujiraiset()
			if(!src)return
			clayinfused-=3
			var/obj/Clay/ClayMine/I=new/obj/Clay/ClayMine()
			I.owner=src
			I.loc=loc
		kibakujirainthrow()
			if(!src)return
			clayinfused-=3
			var/obj/Clay/ClayMine/I=new/obj/Clay/ClayMine(loc)
			I.owner=src
			I.claythrow=1
			walk(I,dir)
		ExplodeClay(obj/U)
			if(!U)return
			U.overlays+='Explode.dmi'
			for(var/mob/Y in range(U,1))
				if(Y!=U.owner)
					Y<<"You took damage from a Clay Mine Explosion!"
			spawn(5)
				if(U)
					del(U)
