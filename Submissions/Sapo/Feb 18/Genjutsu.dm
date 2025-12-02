obj/SkillCards/Genjutsu/Starter/Bunshin
	name="Bunshin no Jutsu"
	icon_state="card_bunshin"
	cmdstring="BunshinnoJutsu"
	Click()
		if(src in usr)BunshinnoJutsu()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="This technique creates a clone of the user and will drain chakra for as long as the clones are active.  It is important to note that the clones are nothing more than an illusion and will dispel as soon as they are hit by any attack.  Useful for confusing or deceiving your opponent."
		Description["title"]="Bunshin no Jutsu"
		Description["range"]="N/A"
		Description["type"]="Genjutsu"
		Description["cost"]=10
		Description["seals"]=2
		Description["strong"]="N/A"
		Description["weak"]="N/A"
		Description["rank"]="D"
		Description["pic"]='Bunshin.png'
		Description["category"]="genjutsu"
		Description["indelay"]=0
		Description["delay"]=5
	verb/BunshinnoJutsu()
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
		if(!(usr.CheckClones()))
			usr<<"You can´t create more Clones! - Your max: [usr.useclones]"
			return
		if(!(usr.JutsuUse(src)))return
		usr.inseals=1
		usr.loadoverlays()
		spawn(usr.sealspeed*1)
			if(usr)
				usr.inseals=0
				usr.loadoverlays()
				usr.createClones("Bunshin")
				usr.firing=1
				Description["indelay"]=1
				spawn(Description["delay"])
					if(usr)
						Description["indelay"]=0
				spawn(usr.jdt)
					if(usr)
						usr.firing=0

obj/SkillCards/Genjutsu/Rockslide
	name="Rockslide Genjutsu"
	icon_state="card_bunshin"
	cmdstring="Rockslide"
	Click()
		if(src in usr)Rockslide()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="N/A"
		Description["title"]="Rockslide Genjutsu"
		Description["range"]="N/A"
		Description["type"]="Genjutsu"
		Description["cost"]=10
		Description["seals"]=2
		Description["strong"]="N/A"
		Description["weak"]="N/A"
		Description["rank"]="D"
		Description["pic"]='Bunshin.png'
		Description["category"]="genjutsu"
		Description["indelay"]=0
		Description["delay"]=5
	verb/Rockslide()
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
				usr.rockslide()
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
		createClones(var/state)
			if(!src)return
			var/mob/AI/Bunshin/I = new/mob/AI/Bunshin()
			I.owner=src
			I.icon=icon
			I.icon_state=state
			I.overlays=overlays
			I.underlays=underlays
			I.name=name
			if(state=="Bunshin")
				I.density=0
				I.stamina=1
				I.chakra=1
				I.tai=1
				I.nin=1
				I.gen=1
				I.movespeed=movespeed
			else
				I.density=1
				I.stamina=round(mstamina/1.5)
				I.chakra=round(mchakra/1.5)
				I.tai=round(mtai/1.5)
				I.nin=round(mnin/1.5)
				I.gen=round(mgen/1.5)
				I.movespeed=movespeed
				var/obj/Smoke/Y=new/obj/Smoke()
				Y.loc=I.loc
			I.loc=loc
			spawn(150)
				if(I)
					del(I)
		CheckClones()
			var/x=0
			for(var/mob/AI/Bunshin/O in world)
				if(O.owner==src)
					x++
			if(x>=useclones)return 0
			else return 1
		rockslide()
			if(!src)return
			if(target_mob)
				var/mob/I = target_mob
				var/dif=round(I.gen/gen*100)
				if(dif<20)
					src<<"You try to use Rockslide Genjutsu on [I] but he resisted!"
					I<<"[src] try to use Rockslide Genjutsu on you but you resisted!"
				else
					var/chance=100
					if(gen>I.gen)chance=95
					else if(gen==I.gen)chance=75
					else chance=35
					if(prob(chance))
						I<<"You are paralyzed in fear after hearing large explosions around you!"
						src<<"[I] is now paralyzed in fear from your Rockslide Genjutsu!"
						var/l = 0
						I.rockslide=1
						I.genpower=gen
						while(l<10)
							var/image/K=image('Epic Explosion.dmi',I)
							K.layer=FLY_LAYER+300
							K.icon_state=""
							K.pixel_x=rand(-150,150)
							K.pixel_y=rand(-150,150)
							I<<K
							I.genimages+=K
							spawn(10)
								if(K)
									I.genimages-=K
									del(K)
							l++
							sleep(5)
							continue
					else
						src<<"You failed to use Rockslide Genjutsu on [I]!"
						I<<"[src] try to use Genjutsu on you but failed!"
			else
				var/list/players=list()
				for(var/mob/K in view(src))
					if(!K.NPC&&!K.dead&&!K.KO/*&&K!=src*/)
						players.Add(K)
				var/mob/I = input("Who do you wish to use Kori Shinchu no Jutsu on?","Kori Shinchu no Jutsu") in players
				if(!I)
					src<<"No target close by!"
					return
				var/chance=100
				if(gen>I.gen)chance=95
				else if(gen==I.gen)chance=75
				else chance=35
				if(prob(chance))
					I<<"You are paralyzed in fear after hearing large explosions around you!"
					src<<"[I] is now paralyzed in fear from your Rockslide Genjutsu!"
					var/l = 0
					I.rockslide=1
					I.genpower=gen
					while(l<10)
						var/image/K=image('Epic Explosion.dmi',I)
						K.layer=FLY_LAYER+300
						K.icon_state=""
						K.pixel_x=rand(-150,150)
						K.pixel_y=rand(-150,150)
						I<<K
						I.genimages+=K
						spawn(10)
							if(K)
								I.genimages-=K
								del(K)
						l++
						sleep(5)
						continue
				else
					src<<"You failed to use Rockslide Genjutsu on [I]!"
					I<<"[src] try to use Genjutsu on you but failed!"