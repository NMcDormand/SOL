#if DEBUGGING
mob/verb
	learnShiTsuBakuretsuHiryu()
		var/obj/SkillCards/Profession/Clay/ShiTsuBakuretsuHiryu/J = locate(/obj/SkillCards/Profession/Clay/ShiTsuBakuretsuHiryu) in src.contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Shi Tsu Bakuretsu Hiryu no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Profession/Clay/ShiTsuBakuretsuHiryu(src)
#endif

obj/SkillCards/Profession/Clay/ShiTsuBakuretsuHiryu
	name="Shi Tsu Bakuretsu Hiryu"
	icon_state="card_bunshin"
	cmdstring="ShiTsuBakuretsuHiryu"
	Click(x,y)
		if((src in usr)&&(findtext("[y]","HotBar")))
			ShiTsuBakuretsuHiryu()
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

	verb/ShiTsuBakuretsuHiryu()
		set category="TECHNIQUES"
		set src in usr.contents
		/*if(usr.clayinfused<3)
			usr<<"You don't have enough Clay Infused - You have [usr.clayinfused] (Need: 3)!"
			return*/

		spawn(usr.SS*1)
			if(usr)
				//usr.Shitsu()
				usr.firing=0

mob
	proc
		Shitsu()
			if(!src)return
			var/mob/Clay/ClayDragon/Y = new/mob/Clay/ClayDragon(get_step(src,dir))
			Y.Creator=src
			ClayBombs += Y
	Clay
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
					while(bombs)
						if(prob(50))
							flick("tail swing",src)
						else
							flick("mouth open",src)
						var/obj/Clay/Mine/U = new(loc)
						U.Owner=Creator
						U.moving=1
						U.ClayThrow=1
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