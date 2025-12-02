obj/SkillCards/Fuuton/FujinHeki
	name="FujinHeki"
	icon_state="card_bunshin"
	cmdstring="FujinHeki"
	Click(x,y)
		if(src in usr)FujinHeki()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="Creates a Wind Shield capable of reducing incoming damage and Redirecting incoming jutsus"
		Description["title"]="FujinHeki"
		Description["range"]="0"
		Description["type"]="Ninjutsu"
		Description["cost"]=100
		Description["seals"]=2
		Description["strong"]="N/A"
		Description["weak"]="N/A"
		Description["rank"]="B"
		Description["pic"]='Bunshin.png'
		Description["category"]="ninjutsu"
		Description["indelay"]=0
		Description["delay"]=15
	verb/FujinHeki()
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
				usr.fujinheki()
				usr.firing=1
				Description["indelay"]=1
				spawn(Description["delay"])
					if(usr)
						Description["indelay"]=0
				spawn(usr.jdt)
					if(usr)
						usr.firing=0

obj/SkillCards/Fuuton/Fusajin
	name="Fusajin no Jutsu"
	icon_state="card_bunshin"
	cmdstring="Fusajin"
	Click(x,y)
		if(src in usr)Fusajin()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="Creates a huge stream of wind"
		Description["title"]="Fusajin no Jutsu"
		Description["range"]="0"
		Description["type"]="Ninjutsu"
		Description["cost"]=100
		Description["seals"]=2
		Description["strong"]="N/A"
		Description["weak"]="N/A"
		Description["rank"]="B"
		Description["pic"]='Bunshin.png'
		Description["category"]="ninjutsu"
		Description["indelay"]=0
		Description["delay"]=15
	verb/Fusajin()
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
		if(usr.dir!=NORTH&&usr.dir!=SOUTH&&usr.dir!=WEST&&usr.dir!=EAST)
			usr<<"You can't use this jutsu in diagonals!"
			return
		if(Description["indelay"])return
		if(!(usr.JutsuUse(src)))return
		usr.inseals=1
		usr.loadoverlays()
		spawn(usr.sealspeed*1)
			if(usr)
				usr.inseals=0
				usr.loadoverlays()
				usr.fusajin()
				usr.firing=1
				Description["indelay"]=1
				spawn(Description["delay"])
					if(usr)
						Description["indelay"]=0
				spawn(usr.jdt)
					if(usr)
						usr.firing=0

obj
	fujinheki
		icon='Tornado.dmi'
		icon_state=""
		pixel_x=-8
		layer=MOB_LAYER+1||OBJ_LAYER+1
	fusajin
		icon='Fuutons.dmi'
		icon_state="skycutter"
		moving=1
		New()
			..()
			spawn(10)
				del(src)
		Move()
			var/obj/fusajin/I = new/obj/fusajin(loc)
			I.owner=owner
			I.dir=dir
			..()
		Bump(M)
			if(ismob(M))
				var/mob/I = M
				if(I.nagashi)del(src)
				if(I.fujinHeki)del(src)
				if(I.dead)del(src)
				view(src)<<"[I] was hit by [owner]'s Fusajin no Jutsu!"
				I<<"You were hit by [owner]'s Fusajin no Jutsu!"
				step_away(I,src)
				del(src)
			if(istype(M,/obj/))
				var/obj/I = M
				if(I.moving)
					walk_away(I,src)
				del(src)
mob
	proc
		fujinhekiDrain()
			if(!RaitonYoroi)return
			chakra-=20
			if(chakra<=0)
				chakra=0
				fujinHeki=0
				movespeed=savespeed
				savespeed=null
				Reflex=mReflex
				loadoverlays()
				tai=mtai
				src<<"You stop using FujinHeki!"
			spawn(15)
				RYoroiDrain()
		fujinheki()
			fujinHeki=1
			loadoverlays()
			fujinhekiDrain()
			spawn(300)
				if(fujinHeki)
					fujinHeki=0
					loadoverlays()
					src<<"You stop using FujinHeki!"
		fusajin()
			if(!src)return
			var/obj/fusajin/Y=new/obj/fusajin(get_step(src,dir))
			var/obj/fusajin/Y2=new/obj/fusajin(get_step(src,dir))
			var/obj/fusajin/Y3=new/obj/fusajin(get_step(src,dir))
			var/obj/fusajin/Y4=new/obj/fusajin(get_step(src,dir))
			var/obj/fusajin/Y5=new/obj/fusajin(get_step(src,dir))
			Y.owner=src
			Y2.owner=src
			Y3.owner=src
			Y4.owner=src
			Y5.owner=src
			if(dir==NORTH||dir==SOUTH)
				Y2.x-=1
				Y3.x+=1
				Y4.x-=2
				Y5.x+=2
			else
				Y2.y-=1
				Y3.y+=1
				Y4.y-=2
				Y5.y+=2
			walk(Y,dir,0.8)
			walk(Y2,dir,0.8)
			walk(Y3,dir,0.8)
			walk(Y4,dir,0.8)
			walk(Y5,dir,0.8)


/*                  Fujinheki is supposed to lower damage received or redirect incoming jutsus             */
mob
	var
		fujinHeki
obj
	var
		moving