obj/SkillCards/Ninjutsu/EdoTensei
	cmdstring="EdoTensei"
	name="Edo Tensei"
	icon_state="card_bunshin"
	Click(x,y)
		if(src in usr)EdoTensei()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="Creates zombies of enemys killed by the user"
		Description["title"]="Edo Tensei"
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
	verb/EdoTensei()
		set category="TECHNIQUES"
		set hidden = 1
		set src in usr.contents
		var/list/Edos=list()
		for(var/x=1;x<usr.EdoTensei.len;x++)
			var/F = usr.EdoTensei[x][1]
			if(F)Edos.Add(F)
		if(Edos.len<1)
			usr<<"You don't have any Edo Tensei Saved!"
			return
		if(usr.nagashi)return
		if(usr.ingreen||usr.inyellow||usr.inred||usr.inpilluse)return
		if(usr.InMeatTank)
			usr<<"Not while using Nikudan Sensha!"
			return
		if(usr.inEdoTensei)return
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
				usr.edotensei()
				usr.firing=1
				Description["indelay"]=1
				spawn(Description["delay"])
					if(usr)
						Description["indelay"]=0
				spawn(usr.jdt)
					if(usr)
						usr.firing=0
obj
	EdoCoffin
		icon='NewEdo.dmi'
		icon_state="stay"
		density=1
		layer=TURF_LAYER+1||OBJ_LAYER+1||MOB_LAYER-1
		New()
			..()
			flick("rise",src)
			sleep(5)
			flick("open",src)
mob
	proc
		edotensei()
			if(!src)return
			var/list/Edos=list()
			for(var/x=1;x<EdoTensei.len;x++)
				var/F = EdoTensei[x][1]
				if(F)Edos.Add(F)
			var/L = input("Who's Edo Tensei would you like to Create?","Edo Tensei") in Edos
			if(!L)return
			var/obj/EdoCoffin/H = new/obj/EdoCoffin(get_step(src,dir))
			H.owner=src
			sleep(10)
			for(var/k=1;k<EdoTensei.len;k++)
				var/G = EdoTensei[k][1]
				if(!G)continue
				if(G==L)
					var/mob/Edo/Y=new/mob/Edo()
					Y.name=EdoTensei[k][1]
					Y.icon=EdoTensei[k][2]
					Y.overlays=EdoTensei[k][3]
					Y.stamina=EdoTensei[k][4]
					Y.chakra=EdoTensei[k][5]
					Y.tai=EdoTensei[k][6]
					Y.nin=EdoTensei[k][7]
					Y.gen=EdoTensei[k][8]
					Y.Reflex=EdoTensei[k][9]
					Y.movespeed=EdoTensei[k][10]
					Y.loc=H.loc
					sleep(2)
					del(H)
		EdoMark(mob/Marked)
			if(!Marked)return
			if(!src)return
			var/mob/ToMark=src
			var/obj/SkillCards/Ninjutsu/EdoTensei/J=locate(/obj/SkillCards/Ninjutsu/EdoTensei) in ToMark.contents
			if(J in ToMark.contents)
				var/L=0
				for(var/x=1;x<=ToMark.EdoTensei.len;x++)
					if(ToMark.EdoTensei[x]==Marked.name)
						L++
						break
				if(L)return
				switch(input("Would you like to Save [Marked] into your Edo Tensei List!","Edo Tensei") in list("Yes","No"))
					if("Yes")
						ToMark.EdoTensei.len=ToMark.EdoTensei.len+1
						for(var/j=1;j<=ToMark.EdoTensei.len;j++)
							if(ToMark.EdoTensei[j][1]!=null)continue
							ToMark.EdoTensei[j][1]=Marked.name
							ToMark.EdoTensei[j][2]=Marked.icon
							ToMark.EdoTensei[j][3]=Marked.overlays.Copy()
							ToMark.EdoTensei[j][4]=Marked.mstamina
							ToMark.EdoTensei[j][5]=Marked.mchakra
							ToMark.EdoTensei[j][6]=Marked.mtai
							ToMark.EdoTensei[j][7]=Marked.mnin
							ToMark.EdoTensei[j][8]=Marked.mgen
							ToMark.EdoTensei[j][9]=Marked.mReflex
							ToMark.EdoTensei[j][10]=Marked.movespeed
							break
						alert(ToMark,"[Marked.name] Added to your Edo Tensei List!")
					if("No")return
		Death(mob/M,var/I)
			if(!src)return
			if(dead)return
			if(!KO)return
			if(client)
				if(KO)
					ClearStuff()
					KO=0
					invisibility=0
					onwater=0
					swimming=0
					stamina=0
					nagashi=0
					if(InMeatTank)
						movespeed=savespeed
						InMeatTank=0
					if(InMeatTankHari)
						movespeed=savespeed
						InMeatTankHari=0
					Reflex=mReflex
					tai=mtai
					nin=mnin
					loadoverlays()
					if(ingreen||inyellow||inred)
						mstamina=Tstamina
						Tstamina=null
						var/timer=0
						if(ingreen)timer=350
						if(inyellow)timer=450
						if(inred)timer=550
						pilldelay=1
						spawn(timer)
							if(src)
								pilldelay=0
						ingreen=0
						inyellow=0
						inred=0
					inpilluse=0
					dead=1
					loc=locate(0,0,0)
					if(M.ingame&&M!=src)kills++
					if(ingame&&src!=M)deaths++
					if(I=="Water")world<<"[src] has drowned!"
					else
						if(M==src)
							if(I!="Pill")world<<"[src] has killed himself!"
							else world<<"[src] has died from the effect of the Akimichi Red Pill!"
						else world<<"[src] has been killed by [M]"
					sleep(25)
					giveBed()
			else
				if(istype(src,/mob/AI/Bunshin/))
					if(state=="Bunshin")
						del(src)
					else
						if(KO)
							del(src)
							return
				else if(istype(src,/mob/Enemy/))
					if(KO)
						view(src)<<"[M] has killed [src]!"
						M<<"You gained [giveexp] exp!"
						M.exp+=giveexp
						M.levelup()
						dead=1
						loc=locate(0,0,0)
						M.EdoMark(src)
						spawn(200)
							if(dead)
								dead=0
								loc=oldloc
				else if(istype(src,/mob/Edo/))
					if(KO)
						view(src)<<"[M] has killed [src]!"
						del(src)
		ClearStuff()
			firing=0
			inseals=0
			for(var/obj/SkillCards/Y in contents)
				if(Y.Description["indelay"])Y.Description["indelay"]=0
			for(var/mob/Y in world)
				if(Y.owner==src)
					del(Y)
			for(var/obj/Y in world)
				if(Y.owner==src)
					del(Y)