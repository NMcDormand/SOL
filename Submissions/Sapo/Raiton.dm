obj/SkillCards/Raiton/RaitonYoroi
	cmdstring="RaitonYoroi"
	name="Raiton no Yoroi"
	icon_state="card_bunshin"
	Click(x,y)
		if(src in usr)RaitonYoroi()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="The user wraps their body in a layer of lightning chakra to increase their physical stats"
		Description["title"]="Raiton no Yoroi"
		Description["range"]="N/A"
		Description["type"]="Ninjutsu"
		Description["cost"]=50
		Description["seals"]=2
		Description["strong"]="N/A"
		Description["weak"]="N/A"
		Description["rank"]="A"
		Description["pic"]='Bunshin.png'
		Description["category"]="ninjutsu"
		Description["indelay"]=0
		Description["delay"]=15
	verb/RaitonYoroi()
		set category="TECHNIQUES"
		set hidden = 1
		set src in usr.contents
		if(usr.RaitonYoroi)
			usr.RaitonYoroi=0
			usr.loadoverlays()
			usr.tai=usr.mtai
			usr.movespeed=usr.savespeed
			usr.savespeed=null
			usr.Reflex=usr.mReflex
			usr<<"You stop using Raiton no Yoroi!"
		else
			if(usr.Giant)return
			if(usr.InMeatTank)return
			if(usr.InMeatTankHari)return
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
					usr.raitonyoroi()
					usr.firing=1
					Description["indelay"]=1
					spawn(Description["delay"])
						if(usr)
							Description["indelay"]=0
					spawn(usr.jdt)
						if(usr)
							usr.firing=0
obj/SkillCards/Raiton/ChidoriNagashi
	cmdstring="ChidoriNagashi"
	name="Chidori Nagashi"
	icon_state="card_bunshin"
	Click(x,y)
		if(src in usr)ChidoriNagashi()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="By releasing the Chidori in every direction, an electrical discharge flows from the user's entire body allowing him to affect multiple enemies."
		Description["title"]="Chidori Nagashi"
		Description["range"]="N/A"
		Description["type"]="Ninjutsu"
		Description["cost"]=50
		Description["seals"]=2
		Description["strong"]="N/A"
		Description["weak"]="N/A"
		Description["rank"]="A"
		Description["pic"]='Bunshin.png'
		Description["category"]="ninjutsu"
		Description["indelay"]=0
		Description["delay"]=15
	verb/ChidoriNagashi()
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
				usr.nagashi()
				usr.firing=1
				Description["indelay"]=1
				spawn(Description["delay"])
					if(usr)
						Description["indelay"]=0
				spawn(usr.jdt)
					if(usr)
						usr.firing=0




obj
	pillarLeft
		icon='LightningPillar.dmi'
		icon_state="idlel"
		layer=MOB_LAYER+1
		density=1
		New()
			..()
			flick("left",src)
	pillarRight
		icon='LightningPillar.dmi'
		icon_state="idler"
		layer=MOB_LAYER+1
		density=1
		New()
			..()
			flick("right",src)
	ShibariElec
		icon='electricity.dmi'
		icon_state=""
		layer=MOB_LAYER+1
		New()
			..()
			spawn()
				spin()
			spawn(100)
				if(src)
					del(src)
		proc
			spin()
				var/mob/O = owner
				for(var/mob/I in loc)
					if(I!=src&&I.owner!=src)
						if(I.nagashi)continue
						if(I.dead)continue
						I.canmove=0
						I<<"Suffered damage from [owner]'s Raiton Shichu Shibari!"
						O<<"You hit [I] with Raiton Shichu Shibari! - he will now be paralyze temporarily while taking damage!"
						if(!(I in shibarihit))shibarihit.Add(I)
					sleep(3)
					continue
		Del()
			var/mob/O = owner
			for(var/obj/pillarLeft/U in world)
				if(U.owner==O)
					del(U)
			for(var/obj/pillarRight/U in world)
				if(U.owner==O)
					del(U)
			for(var/mob/Y in shibarihit)
				Y.canmove=1
			..()
mob
	proc
		RYoroiDrain()
			if(!RaitonYoroi)return
			chakra-=20
			if(chakra<=0)
				chakra=0
				RaitonYoroi=0
				movespeed=savespeed
				savespeed=null
				Reflex=mReflex
				loadoverlays()
				tai=mtai
				src<<"You stop using Raiton no Yoroi!"
			spawn(15)
				RYoroiDrain()
		nagashi()
			nagashi=1
			loadoverlays()
			spawn(100)
				if(nagashi)
					nagashi=0
					loadoverlays()
			while(nagashi)
				chakra-=100
				if(chakra<=0)
					nagashi=0
					loadoverlays()
					break
					return
				for(var/mob/I in range(src,1))
					if(I!=src&&I.owner!=src)
						if(I.nagashi)continue
						if(I.dead)continue
						view(src)<<"[I] was hit by [src] Chidori Nagashi!"
				sleep(5)
				continue
		raitonyoroi()
			RaitonYoroi=1
			loadoverlays()
			tai=round(mtai*1.3)
			savespeed=movespeed
			movespeed=1
			Reflex+=40
			RYoroiDrain()
			spawn(300)
				if(RaitonYoroi)
					RaitonYoroi=0
					Reflex=mReflex
					movespeed=savespeed
					savespeed=null
					tai=mtai
					loadoverlays()
					src<<"You stop using Raiton no Yoroi!"