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

obj/SkillCards/Doton/ShiTsuBakuretsuHiryu
	name="Shi Tsu Bakuretsu Hiryu"
	icon_state="card_bunshin"
	cmdstring="ShiTsuBakuretsuHiryu"
	Click()
		if(src in usr)ShiTsuBakuretsuHiryu()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="Creates a Clay dragon that creates mines and throws them around"
		Description["title"]="Shi Tsu Bakuretsu Hiryu"
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
	verb/ShiTsuBakuretsuHiryu()
		set category="TECHNIQUES"
		set hidden = 1
		set src in usr.contents
		if(usr.inbed)return
		if(usr.AFK)return
		if(usr.KO)return
		if(usr.dead)return
		if(!usr.ingame)return
		if(Description["indelay"])return
		/*if(usr.clayinfused<3)
			usr<<"You don't have enough Clay Infused - You have [usr.clayinfused] (Need: 3)!"
			return*/
		if(!(usr.JutsuUse(src)))return
		usr.inseals=1
		usr.loadoverlays()
		spawn(usr.sealspeed*1)
			if(usr)
				usr.inseals=0
				usr.loadoverlays()
				usr.shitsu()
				usr.firing=1
				Description["indelay"]=1
				spawn(Description["delay"])
					if(usr)
						Description["indelay"]=0
				spawn(usr.jdt)
					if(usr)
						usr.firing=0

obj/SkillCards/Doton/ShiFo
	name="Shi Fo"
	icon_state="card_bunshin"
	cmdstring="ShiFo"
	Click()
		if(src in usr)ShiFo()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="Creates a Huge Doll of Clay looking like the user that explodes"
		Description["title"]="Shi Fo"
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
	verb/ShiFo()
		set category="TECHNIQUES"
		set hidden = 1
		set src in usr.contents
		if(usr.inbed)return
		if(usr.AFK)return
		if(usr.KO)return
		if(usr.dead)return
		if(!usr.ingame)return
		if(Description["indelay"])return
		/*if(usr.clayinfused<3)
			usr<<"You don't have enough Clay Infused - You have [usr.clayinfused] (Need: 3)!"
			return*/
		if(!(usr.JutsuUse(src)))return
		usr.inseals=1
		usr.loadoverlays()
		spawn(usr.sealspeed*1)
			if(usr)
				usr.inseals=0
				usr.loadoverlays()
				usr.shifo()
				usr.firing=1
				Description["indelay"]=1
				spawn(Description["delay"])
					if(usr)
						Description["indelay"]=0
				spawn(usr.jdt)
					if(usr)
						usr.firing=0


mob
	Clay
		shifo
			density=1
			New()
				..()
				spawn(5)
					grow()
			proc
				goexplode()
					var/mob/O = owner
					var/obj/Clay/explosion/U=new/obj/Clay/explosion(loc)
					U.owner=owner
					U.defaultDamage=2.8
					for(var/mob/I in range(I,2))
						if(I!=O&&I.owner!=O)
							if(!I.NPC&&!I.dead&&owner!=I&&I!=O)
								if(I.village in O.FFlist)del(src)
								if(I in O.FFlist)del(src)
								var/chance=100
								if(O.nin>I.nin)chance=95
								else if(O.nin==I.nin)chance=75
								else chance=35
								if(!I.client)I.target_mob=O
								else I.Target_Atom(O)
								if(prob(chance))
									var/damage
									damage = round(( 2 * O.nin - I.nin ) * U.defaultDamage)
									if(damage < 1)damage = 1
									I.takedamage(O,damage,name,"Ninjutsu")
								else
									if(prob(50))I.takedamage(O,"Dodge","Dodge","Ninjutsu")
									else I.takedamage(O,"Block","Block","Ninjutsu")
						sleep(3)
						continue
					return
				grow()
					if(!src)return
					if(grown==92)
						sleep(2)
						goexplode()
						return
					else
						grown+=5
						if(grown>92)grown=92
						var/icon/F = icon(ShifoICon,icon_state)
						F.Scale(grown,grown)
						icon = F
						overlays=null
						underlays=null
						for(var/obj/L in ShifoOverlays)
							var/icon/T = icon(L.icon,L.icon_state)
							T.Scale(grown,grown)
							L.icon=T
							overlays+=L
						for(var/obj/L2 in ShifoUnderlays)
							var/icon/T2 = icon(L2.icon,L2.icon_state)
							T2.Scale(grown,grown)
							L2.icon=T2
							underlays+=L2
					sleep(1)
					grow()
		ClayDragon
			icon='c2dragon.dmi'
			icon_state="Idle"
			density=1
			bombs=8
			New()
				..()
				spawn(1)
					StartBombs()
			proc
				StartBombs()
					if(!bombs)del(src)
					if(prob(50))flick("tail swing",src)
					else flick("mouth open",src)
					var/obj/Clay/ClayMine/U = new/obj/Clay/ClayMine(loc)
					U.owner=owner
					U.moving=1
					U.claythrow=1
					var/Fdir=rand(1,8)
					if(Fdir==1)walk(U,EAST,0.8)
					if(Fdir==2)walk(U,WEST,0.8)
					if(Fdir==3)walk(U,NORTH,0.8)
					if(Fdir==4)walk(U,SOUTH,0.8)
					if(Fdir==5)walk(U,NORTHEAST,0.8)
					if(Fdir==6)walk(U,NORTHWEST,0.8)
					if(Fdir==7)walk(U,SOUTHEAST,0.8)
					if(Fdir==8)walk(U,SOUTHWEST,0.8)
					bombs--
					sleep(6)
					StartBombs()
obj
	Clay
		c0
			icon='c0.dmi'
			icon_state=""
			layer=MOB_LAYER+1||OBJ_LAYER+1
		explosion
			icon='explosion.dmi'
			icon_state=""
			pixel_y=-16
			pixel_x=-16
			layer=MOB_LAYER+1||OBJ_LAYER+1
		explosion2
			icon='Epic Explosion.dmi'
			icon_state=""
			pixel_y=-80
			pixel_x=-80
			layer=MOB_LAYER+1||OBJ_LAYER+1
			New()
				..()
				spawn()
					spin()
				spawn(15)
					if(src)
						del(src)
			proc
				spin()
					var/mob/O = owner
					for(var/mob/I in range(I,4))
						if(I!=O&&I.owner!=O)
							if(!I.NPC&&!I.dead&&owner!=I&&I!=O)
								var/chance=100
								if(O.nin>I.nin)chance=95
								else if(O.nin==I.nin)chance=75
								else chance=35
								if(!I.client)I.target_mob=O
								else I.Target_Atom(O)
								if(prob(chance))
									var/damage
									damage = round(( 2 * O.nin - I.nin ) * defaultDamage)
									if(damage < 1)damage = 1
									I.takedamage(O,damage,name,"Ninjutsu")
								else
									if(prob(50))I.takedamage(O,"Dodge","Dodge","Ninjutsu")
									else I.takedamage(O,"Block","Block","Ninjutsu")
						sleep(5)
						continue
					sleep(5)
					spin()
		ClayMine
			icon='c2novo.dmi'
			icon_state=""
			Move()
				..()
				for(var/mob/U in range(src,1))
					if(U!=owner&&U.owner!=owner)
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
					if(I!=U.owner&&I.owner!=U.owner)
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
		shitsu()
			if(!src)return
			var/mob/Clay/ClayDragon/Y = new/mob/Clay/ClayDragon(get_step(src,dir))
			Y.owner=src
		shifo()
			if(!src)return
			var/mob/Clay/shifo/Y = new/mob/Clay/shifo(get_step(src,dir))
			Y.owner=src
			Y.icon=icon
			Y.icon_state=""
			Y.dir=dir
			Y.overlays=overlays
			Y.underlays=underlays
			Y.ShifoICon=icon
			Y.ShifoOverlays=overlays
			Y.ShifoUnderlays=underlays
			Y.grown=32
		kyukyokugeijutsu()
			if(!src)return
			if(inc)return
			inc=13
			grown=32
			while(inc>1)
				if(inc==12)icon='Base_Pale.dmi'
				if(inc==11)icon='Base_Tan.dmi'
				if(inc==10)icon='Base_Medium.dmi'
				if(inc==9)icon='Base_Dark.dmi'
				if(inc==8)icon='Base_Black.dmi'
				if(inc==7)
					grown=30
					var/icon/T = icon(icon,icon_state)
					T.Scale(grown,grown)
					icon=T
					icon+=rgb(0,0,0)
					pixel_y=2
					pixel_x=2
				if(inc==6)
					grown=25
					var/icon/T = icon(icon,icon_state)
					T.Scale(grown,grown)
					icon=T
					icon+=rgb(0,0,0)
					pixel_y=7
					pixel_x=7
				if(inc==5)
					grown=20
					var/icon/T = icon(icon,icon_state)
					T.Scale(grown,grown)
					icon=T
					icon+=rgb(0,0,0)
					pixel_y=12
					pixel_x=12
				if(inc==4)
					grown=15
					var/icon/T = icon(icon,icon_state)
					T.Scale(grown,grown)
					icon=T
					icon+=rgb(0,0,0)
					pixel_y=17
					pixel_x=17
				if(inc==3)
					grown=10
					var/icon/T = icon(icon,icon_state)
					T.Scale(grown,grown)
					icon=T
					icon+=rgb(0,0,0)
					pixel_y=22
					pixel_x=22
				if(inc==2)
					grown=5
					var/icon/T = icon(icon,icon_state)
					T.Scale(grown,grown)
					icon=T
					icon+=rgb(0,0,0)
					pixel_y=27
					pixel_x=27
				if(inc==1)
					grown=0
					var/icon/T = icon(icon,icon_state)
					T.Scale(grown,grown)
					icon=T
					icon+=rgb(0,0,0)
					pixel_y=32
					pixel_x=32
				inc--
				sleep(1)
				continue
			var/obj/Clay/explosion2/U=new/obj/Clay/explosion2(loc)
			U.owner=src
			U.defaultDamage=3.2
			spawn(15)
				if(src)
					var/mob/O=src
					O.inc=0
					O.tai=O.mtai
					O.mstamina=O.Tstamina
					O.nin=O.mnin
					O.Reflex=O.mReflex
					O.wounds=150
					O.stamina=0
					O.KO=1
					O.pixel_y=0
					O.pixel_x=0
					O.Tstamina=null
					O.Death(O,"C0")