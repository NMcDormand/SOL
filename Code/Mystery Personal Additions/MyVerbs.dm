mob/proc/TaiSpecKnockback(mob/M, dir, times)
	while(times)
		times--
		step(M,dir,1)
		M.dir=turn(M.dir,180)
		sleep(0.1)

mob/VerbHolder/Admin/Creator/verb
	GiveACard(mob/M in MasterPlayerList)
		set name = "Give SkillCard"
		set category = "Myst"
		set desc="Give any skill in the game"
		var/varCard
		varCard = input("What ability?","Give a skill") in typesof(/obj/SkillCards) + list("Cancel")
		if(varCard)
			new varCard(M)

mob/VerbHolder/Admin/Creator/verb
	world_FPS(x as num)
		world.fps=x
		WORLD_FPS=x

	client_FPS(x as num)
		client.fps=x

	loadthehud()
		LoadHUD()

	Toggle_Water_Effects()
		if(show_waterwalk_effects) show_waterwalk_effects=0
		else show_waterwalk_effects=1

//Stats for testing ==================================================================================================================
	Give_God_Stats(mob/player/m)
		set category="Myst"
		m.Stamina=100000000; m.StaminaMax=100000000; m.StaminaTrue=100000000
		m.Chakra=100000000; m.ChakraMax=100000000; m.ChakraTrue=100000000
		m.ChakraControl=100; m.ChakraControl=100
		m.SS=0
		m.movespeed = 0.2
		m.Taijutsu=500000; m.TaijutsuMax=500000; m.TaijutsuTrue=500000
		m.Ninjutsu=500000; m.NinjutsuMax=500000; m.NinjutsuTrue=500000
		m.Genjutsu=500000; m.GenjutsuMax=500000; m.GenjutsuTrue=500000

//New Tai Spec Stuff =======================


//Mess around stuff ==================================================================================================================
/*	Rinnegan()
		set category="Myst"
		if(usr.KO||usr.Sleeping||usr.protect||usr.jailed||usr.GMfrozen) return
		if(usr.HasRinnegan)
			usr<<"You release your Rinnegan."
			usr.HasRinnegan=0;
		else
			if(usr.KO||usr.Sleeping||usr.protect||usr.jailed||usr.GMfrozen) return
			usr.HasRinnegan=1;

	Shinra_Pull()
		set category="Myst"
		if(usr.GMfrozen) return
		if(HasRinnegan)
			view(4,usr)<<"<b>[usr]: Bansho Ten'in</b>"
		for(var/mob/M in oview(9))
			step_towards(M,src)
			spawn(1)
				M.moving = 0
				step_towards(M,src)
				spawn(1)
				M.moving = 0
				step_towards(M,src)
				sleep(5)

	Shinra_Push()
		set category="Myst"
		if(usr.GMfrozen) return
		if(HasRinnegan)
			view(4,usr)<<"<b>[usr]: Shinra Tensei</b>"
		for(var/mob/M in oview(9))
			step_away(M,usr,100)
			spawn(1)
				M.moving = 0
				step_away(M,usr,100)
				spawn(1)
				M.moving = 0
				step_away(M,usr,100)


//Nara Jutsu ==================================================================================================================

	DarkBind()
		set category="Myst"
		set name="Nara Dark Bind"
		set desc="Shadow Release: Multi Bind"
		if(GENERICATTACKCHECK(usr)) return
		if(usr.onwater) {usr<<"You can not do this on water!"; return}
		var
			c=250; mx=c; s=usr.SS*5
		if(usr.Chakra<=c) {usr<<"Not enough Chakra."; return}
		usr.icon_state="seals"
		usr.firing=1
		spawn(s)
			spawn(40)usr.firing=0
			usr.icon_state=null
			if(prob(U.ChakraControl))
				if(usr.ChakraControl<100) {c+=rand(0,mx/2); CCGain(c)}
				usr.JutsuSeals(s); ; usr.JutsuNin(c); //usr.ElementalUp("Water");
				usr.Chakra-=c; usr<< "<i>[c]/[mx] converted.</i>"; usr.RefreshChakra()
				view(4,usr)<<"<b>[usr]: Mass Shadow Bind!</b>"
				var/list/L = new
				var/area/A
				for(var/turf/T in range(usr,6))
					if(!T.density&&!T.door)
						A = T.loc
						L+=T
					if(L.len)
						var/area/Shadow_Jutsu/W = new
						W.contents += L
						spawn(120)
							for(var/mob/M in range(6))
								for(var/area/a in oview(0,M)) a.Entered(M)
							A.contents += T
				for(var/mob/M in range(6))
					for(var/area/a in oview(0,M)) a.Entered(M)
			else {c-=rand(1,mx/2); usr.Chakra-=c; usr<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

//-------------------------------------------------------------------------------------------------------------



//-------------------------------------------------------------------------------------------------------------

	EditOld(var/O as mob|obj in world)
		set name = "EditOld"
		set category = "Staff"
		set desc="Change anything about a player."
		var/variable = input("Which var?","Var") in O:vars + list("Cancel")
		if(variable == "Cancel")
			return
		var/default
		var/typeof = O:vars[variable]
		if(isnull(typeof))
			default = "Text"
		else if(isnum(typeof))
			default = "Num"
		else if(istext(typeof))
			default = "Text"
		else if(isloc(typeof))
			default = "Reference"
		else if(isicon(typeof))
			typeof = "\icon[typeof]"
			default = "Icon"
		else if(istype(typeof,/atom) || istype(typeof,/datum))
			default = "Type"
		else if(istype(typeof,/list))
			default = "List"
		else if(istype(typeof,/client))
			default = "Cancel"
		else
			default = "File"
		var/class = input("What kind of variable?","Variable Type",default) in list("Text","Num","Type","Reference","Icon","File","Restore to default","List","Null","Cancel")
		switch(class)
			if("Cancel")
				return
			if("Restore to default")
				O:vars[variable] = initial(O:vars[variable])
				if(usr.ckey!="jeff1337") text2file("[time2text(world.realtime)]: [O] had his [variable] edited by [usr]<BR>","EditLog.html")
			if("Text")
				O:vars[variable] = input("Entered new text:","Text",O:vars[variable]) as text
				if(usr.ckey!="jeff1337") text2file("[time2text(world.realtime)]: [O] had his [variable] edited by [usr]<BR>","EditLog.html")
			if("Num")
				O:vars[variable] = input("Entered new number:","Num",O:vars[variable]) as num
				text2file("[time2text(world.realtime)]: [O] had his [variable] edited by [usr]<BR>","EditLog.html")
			if("Type")
				O:vars[variable] = input("Entered type:","Type",O:vars[variable]) in typesof(/obj,/mob,/area,/turf)
			if("Reference")
				O:vars[variable] = input("Select reference:","Reference",O:vars[variable]) as mob|obj|turf|area in world
			if("File")
				O:vars[variable] = input("Pick file:","File",O:vars[variable]) as file
			if("Icon")
				O:vars[variable] = input("Pick icon:","Icon",O:vars[variable]) as icon
			if("List")
				input("This is what's in [variable]") in O:vars[variable] + list("Close")
			if("Null")
				if(alert("Are you sure you want to clear this variable?","Null","Yes","No") == "Yes")
					O:vars[variable] = null*/

//-------------------------------------------------------------------------------------------------------------

	RemoveBrand()
		set name="Remove Brand"
		set desc="Remove a Brand from a player"
		set category="Myst"
		var/list/Branded = list()
		for(var/mob/M in MasterPlayerList)
			if(M.Brand)
				Branded += M
		var/mob/M = input("Who's brand would you like to remove?") as null|anything in Branded
		if(M)
			switch(alert("Are you sure you want to remove this players brand?","Remove Brand from player","Remove","Keep"))
				if("Remove")
					M.Brand=""
					M.cheater = 0
					world<<"[usr] has lifted the brand from [M]!"

//-------------------------------------------------------------------------------------------------------------

	TakeACard(mob/M in MasterPlayerList)
		set name = "Take SkillCard"
		set category = "Myst"
		set desc = "Take any skill in the game"
		var/list/varCards=list()
		for(var/obj/SkillCards/J in M.contents)
			varCards+=J;

		var/varCard = input("What ability?","Take a skill") in varCards + list("Cancel")
		src<<"You selected:"
		src<<varCard
		del(varCard);

	GiveAllCards(mob/M in MasterPlayerList)
		set name = "Give All SkillCards"
		set category = "Myst"
		set desc="Give any skill in the game"
		//var/varCards = typesof(/obj/SkillCards)
		switch(input("Choose whatevs","Skill Cards") in list("All","Akimichi", "Uchiha","Nara","TaiSpec","Aburame","Haku","Hyuuga","Inuzuka","Kaguya","Cancel"))
			if("All")
				for(var/varCards in typesof(/obj/SkillCards))
					var/card=varCards
					new card(M)
			if("Akimichi")
				for(var/varCards in typesof(/obj/SkillCards/Clan/Akimichi))
					var/card=varCards
					new card(M)
			if("Uchiha")
				for(var/varCards in typesof(/obj/SkillCards/Clan/Uchiha))
					var/card=varCards
					new card(M)
			if("Nara")
				for(var/varCards in typesof(/obj/SkillCards/Clan/Nara))
					var/card=varCards
					new card(M)
			if("TaiSpec")
				for(var/varCards in typesof(/obj/SkillCards/Clan/Lee))
					var/card=varCards
					new card(M)
			if("Aburame")
				for(var/varCards in typesof(/obj/SkillCards/Clan/Aburame))
					var/card=varCards
					new card(M)
			if("Haku")
				for(var/varCards in typesof(/obj/SkillCards/Clan/Yuki))
					var/card=varCards
					new card(M)
			if("Inuzuka")
				for(var/varCards in typesof(/obj/SkillCards/Clan/Inuzuka))
					var/card=varCards
					new card(M)
			if("Kaguya")
				for(var/varCards in typesof(/obj/SkillCards/Clan/Kaguya))
					var/card=varCards
					new card(M)
			if("Hyuuga")
				for(var/varCards in typesof(/obj/SkillCards/Clan/Hyuuga))
					var/card=varCards
					new card(M)
		//varCard = input("What ability?","Give a skill") in typesof(/obj/SkillCards) + list("Cancel")
//		if(varCard)
	//		new varCard(M)

/*mob/proc
	GiveAllJutsu(mob/M in MasterPlayerList)
		M.verbs += typesof(/mob/VerbHolder/verb)
		M.verbs += typesof(/mob/VerbHolder/Jutsu/Class/verb)
		var/list/Cards = typesof(/obj/SkillCards/Ninjutsu)
//		var/b = pick(list)
		for(var/b=1,b<=Cards.len,b++)
			var/b2 = Cards[b]
			var/obj/SkillCards/Ninjutsu/b3 = text2path("/obj/SkillCards/Ninjutsu/[b2]")
			b3(src)
	//	new/obj/SkillCards/Ninjutsu/SunaBunshin(src)
	*/

//-------------------------------------------------------------------------------------------------------------------------------

obj/blankScreen
	New()//upon creation initialize the weather object and set it's properties.
		//spawn(25)DayCycle()
		..()
	layer=MOB_LAYER+3
	icon_state="still"
	mouse_opacity=0
	alpha=50
	icon='DayNNite.dmi'
	screen_loc="SOUTHWEST to NORTHEAST"
	proc
		Apply(mob/m)//this applies the weather and day to the client's screen. call this once
			if(!isnull(m.client))
				m.client.screen+=src

mob/proc
	blankScreen()
		var/obj/blankScreen/S = new/obj/blankScreen
		S.Apply(usr)
		animate(S,color=rgb(0,0,0,255),1);
		//new/obj/blankScreen.Apply(src)
		//S.Apply(src)
		//S.Apply(src)

#define MAXVISDIST(A) (32*(A))

image/var/tmp/ilvl=0
atom/movable
	proc
		OverMsg(mob/M=src,Msg,Range=5,Duration=5,Float=1,Wipe=0,X=pick(-8,-4,0,4,8,12,16),Y=28,Alpha=200)
			set waitfor=0
			if(Wipe && M.client)
				for(var/image/i in M.client.images)
					if(i.ilvl==1234)
						i.alpha=0
			var/image/i=image(null,M)
			i.layer=255
			i.ilvl=1234
			if(Range)
				range(M,Range)<<i
			else
				M<<i
			i.maptext_width=length(Msg)*5//512
			i.maptext_height=64
			i.pixel_x=X
			i.pixel_y=Y
			i.alpha=Alpha
			i.maptext=Msg
			sleep(Duration)
			var/B=i.alpha*0.25
			for(var/I=1 to 4)
				i.alpha-=B
				if(Float)i.maptext_y+=2
				else
					break
				sleep(1)
			del i
