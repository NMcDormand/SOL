obj/SkillCards/Neutral/ShikeiSeppun
	name="Shikei Seppun"
	icon_state="card_bunshin"
	cmdstring="Shikei Seppun"
	Click()
		if(src in usr)ShikeiSeppun()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="This jutsu temporarily lower one of the target's element power and if the user have that element it increases it temporary."
		Description["title"]="Shikei Seppun"
		Description["range"]=2
		Description["type"]="Ninjutsu"
		Description["cost"]=50
		Description["seals"]=5
		Description["strong"]="Neutral"
		Description["weak"]="Neutral"
		Description["rank"]="B"
		Description["pic"]='Bunshin.png'
		Description["category"]="ninjutsu"
		Description["indelay"]=0
		Description["delay"]=15
	verb/ShikeiSeppun()
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
				usr.shikeiseppun()
				usr.firing=1
				Description["indelay"]=1
				spawn(Description["delay"])
					if(usr)
						Description["indelay"]=0
				spawn(usr.jdt)
					if(usr)
						usr.firing=0

mob
	proc
		shikeiseppun()
			if(!src)return
			for(var/mob/G in get_step(src,dir))
				if(G.KO)continue
				if(G.dead)continue
				if(G.nagashi)continue
				if(G.InMeatTank)continue
				if(G.InMeatTankHari)continue
				if(G.inbed)continue
				if(G.Elements.len<1)return
				var/ele = pick(G.Elements)
				if(G.ElementsLowered[ele]>0){src<<"You can´t lower [G]'s [ele] element power any further!";return}
				G.shikeiseppun=1
				G.loadoverlays()
				spawn(3)
					G.shikeiseppun=0
					G.loadoverlays()
				var/tobuff = round(G.ElementsPower[ele]/1.8)
				G.ElementsPower[ele]=round(G.ElementsPower[ele]-tobuff)
				G.ElementsLowered[ele]=round(G.ElementsLowered[ele]+tobuff)
				view()<<"[src]'s stole some of [G]'s [ele] element power temporarily!"
				var/F=0
				if(ele in Elements)
					ElementsPower[ele]=round(ElementsPower[ele]+tobuff)
					ElementsBuffed[ele]=round(ElementsBuffed[ele]+tobuff)
					F++
					src<<"[src]'s gained some of [G]'s [ele] element power temporarily!"
				spawn(350)
					G.ElementsPower[ele]=round(G.ElementsPower[ele]+G.ElementsLowered[ele])
					G.ElementsLowered[ele]=0
					if(F)
						ElementsPower[ele]=round(ElementsPower[ele]-ElementsBuffed[ele])
						ElementsBuffed[ele]=0
					src<<"Your temporarily gained [ele] element power has vanish!"
