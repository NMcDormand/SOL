var/const/WorldVersion=4.05;
#define VERSION 4.05
world/map_format = TOPDOWN_MAP
var/DelayedReboot
var/list
	ContributorTier1=list("saucepanman","screwyparasite","icedglacier","wearysound","someguyimet","abubatata", "Psyosis023")
	ContributorTier2=list("popo7777", "yenaldooshi")
	ContributorTier3=list("neptus0","zomgbies","blazee","curiousneptune","destroior","bennywise","juweu","crimsonnyo","craney","jesuspoppin")
	SurveyList = list()

mob
	proc
		Contributorlogin()
			set waitfor = 0
			if((ckey in ContributorTier2)||(ckey in ContributorTier3))
				src<<output("<b>You have been marked as a Contributor! You will receive bonus Stat Points every time you level up; it is a small token of SoM's appreciation.</b>","Chat")
			if((ckey in ContributorTier1))
				src<<output("<b>You have been marked as a Tier One Contributor! You will receive a large bonus of Stat Points every time you level up; it is a large token of SoM's appreciation.</b>","Chat")

		SurveyLogin()
			if(SurveyList[ckey])
				src << "You have been rewarded for doing the SoM Survey, enjoy the following:<br>+200 SPS<br>+1 Elemental Weapon<br>+1 Icon Scroll"
				StatPoints += 200
				new/obj/Item/Icon_Scroll(src)
				switch(pick(1,2,3))
					if(1)
						new/obj/Weapon/Wield/Elemental/BroadSword(src)
					if(2)
						new/obj/Weapon/Wield/Elemental/Katana(src)
					if(3)
						new/obj/Weapon/Wield/Elemental/Kunai(src)
				SurveyList[ckey] = 0


var/area/Water/WaterMain = 0
var/area/Water/WaterOut = 0
var/area/Waterfall/WaterFalls = 0
var/area/Waterfall/WaterFallOut = 0
var/list/AreaList = list()
var/list/TreeList = list()

var/turf/SamehadaDoor

world
	mob = /mob/logging
	hub = "Screwyparasite.ShinobiOfMyth"
	hub_password = "THISISSOL"
	name = "Shinobi of Myth"
	status = "<font size=1><b>Version 4</b></font>"
	view = 9
	tick_lag = 1
	//loop_checks = 0

	New()
		world.log = "Debug/ErrorLog-[time2text(world.realtime,"MM DD hh",world.timezone)].txt"
		WaterMain = new()
		WaterMain.Outdoor = 0
		WaterFalls = new()
		WaterFalls.Outdoor = 0
		WaterFallOut = new()
		WaterFallOut.Outdoor = 1
		WaterOut = new()
		WaterOut.Outdoor = 1
		..()
		#if TESTING
		TESTBUILD
		#endif
		#if DEBUGGING
		DEBUGBUILD
		#endif
		OutdoorAreas -= WaterMain
		OutdoorAreas -= WaterFalls
		daycycle()
		Village_Fix()

		spawn(100)
			CreateSpawners()

			spawn(300)
				RECHECK
				if(AreaList.len)
					for(var/area/A in AreaList)
						for(var/mob/Hittable/Unresponsive/Training/Stump/Tree/T in A)
							TreeList += T
					for(var/i=1 to 3)
						Redo
						var/area/A=pick(AreaList)
						var/list/R=list()
						for(var/turf/T in A)
							if(!T.density)
								R+=T
						if(!R.len)
							goto Redo
						var/turf/Z=pick(R)
						new/obj/Item/Cat(Z)
				else
					sleep(300)
					goto RECHECK

		fps=WORLD_FPS

		//spawn(1)
		LoadGameSettings();
		LoadKages();
		LoadGuilds();
		LoadSwords();
		LoadNames();
		LoadGMLog();
		InitiateDMGMSG();LoadGMs()

		if(!MasterPlayerList)
			MasterPlayerList=new()

		ChuuninExamTime=world.timeofday+36000
		ChuuninVillage=pick("Leaf","Mist","Sand","Cloud","Rock","Sound","Waterfall","Grass","Rain")
		#if DEBUGGING
		KonohaInvasionTime=world.timeofday+1200
		#else
		KonohaInvasionTime=world.timeofday+18000
		#endif
		RebootTime=world.timeofday+360000

		EventLoop()

		//spawn(rand(12000,40000)) AFK_Check()
		spawn(600)
			ClockRefresher()
		//spawn(900) GeninAlert()
		spawn(30000)
			ChuuninCheck=1
			ChuuninAlert()
		spawn(12000)
			KonohaInvasionMission()
		//spawn(360000) world << "<font color=red size=3><b>There will be an Automatic Reboot in 5 minutes.</b></font>"
		spawn(world.timeofday+360000)
			WorldRebootProc()
		.= ..()

	Del()
		//world.log = file("ErrorLog.txt")
		if(!TotalSavePrevention)
			SaveGameSettings()
			SaveKages()
			SaveGuilds()
			SaveSwords()
			SaveGMS()
			SaveBank()
			SaveSkills()
		return ..()
/*
var
	WORLDADDRESS=world.address
	WORLDPORT=world.port
proc/Crash_Check()
	var/server = world.Export("byond://[WORLDADDRESS]:[WORLDPORT]?ping")

	if(!server)
		shutdown(server)
		sleep(100)
		startup('SoM.dmb',WORLDPORT,"-logself","-trusted")
		world << "World restarted at [time2text(world.realtime, "Day, Month DD, YYYY")]"
		Crash_Check()
		..()
	else spawn(600) Crash_Check()
	*/

proc/WorldRebootProc()
	//world << "<font color=red size=3><b>There will be an Automatic Reboot in 5 minutes.</b></font>"
	set waitfor = 0
	if(DelayedReboot)
		DelayedReboot = 0
		RebootTime = world.timeofday + 60000
		spawn(60000)
			WorldRebootProc()
	else
		//Proc the countdown AFTER we do the spawn calls due to "sleep".
		for(var/i=5; i>0; i--) {
			if(DelayedReboot)
				world << "The Auto reboot has been delayed"
				WorldRebootProc()
				return
			NotifyAll("reboot2", i)
			sleep(600)
		}
		NotifyAll("reboot") //not a defined proc because it's not a mob proc
		world<<"<font color=red size=3><b>Automatic Reboot in 10 seconds.</font>"; //SavePrevention=1
		sleep(100)
		world << "<font color=red>Rebooting now...</font>"
		sleep(10)
		WorldSave(1)
		world.Reboot()


//--------------------------------------------------------------------------- Host Check

proc
	daycycle()
		set waitfor=0
		Z
		for(var/I=0 to 999999999999)
			var/sleeps=0
			var/Yarkut=""
			for(var/which=1 to 12)
				sleep(sleeps)
				if(which==1)
					Yarkut="Sun1"
					sleeps=2495
				else if(which==2)
					Yarkut="Sun2Sun"
					sleeps=5
				else if(which==3)
					Yarkut="Sun2"
					sleeps=2491
				else if(which==4)
					Yarkut="Sun2Day"
					sleeps=9
				else if(which==5)
					Yarkut=""
					sleeps=67000
					WorldSave()
				else if(which==6)
					Yarkut="Day2Sun"
					sleeps=9
				else if(which==7)
					Yarkut="Sun2"
					sleeps=2491
				else if(which==8)
					Yarkut="Sun2Sun2"
					sleeps=5
				else if(which==9)
					Yarkut="Sun1"
					sleeps=2495
				else if(which==10)
					Yarkut="Sun2N"
					sleeps=25
				else if(which==11)
					Yarkut="Night"
					sleeps=66950
					WorldSave()
				else if(which==12)
					Yarkut="N2Sun"
					sleeps=25
				var/icon/A=new('Buildings.dmi',"roofmain")
				var/icon/A2=new('Buildings.dmi',"Mistroof")
				var/icon/B=new('Floods.dmi',Yarkut)
				var/icon/B2=new('FloodsOver.dmi',Yarkut)
				var/icon/B3=new('FloodsOver.dmi',Yarkut)
				var/icon/B4=new('FloodsOver.dmi',Yarkut)
				var/icon/B5=new('FloodsOver.dmi',Yarkut)
				var/icon/B5a=new('FloodsOver.dmi',"Nighty")
				var/icon/B6=new('FloodsOver.dmi',Yarkut)
				var/icon/B6a=new('FloodsOver.dmi',"Nighty")
				B3.Turn(-90)
				B4.Turn(90)
				A.Blend(B,ICON_OVERLAY)
				A2.Blend(B,ICON_OVERLAY)
				B5.Blend(B5a,ICON_SUBTRACT)
				B6.Blend(B6a,ICON_SUBTRACT)
				B6.Flip(WEST)
				for(var/area/Roof/N in world)
					var/image/G=N.image
					if(istype(N,/area/Roof/Mist1))
						N.image=image(A2,N,,254)
					else
						N.image=image(A,N,,254)
					for(var/mob/M in MasterPlayerList)
						if(M.InBuilding==0 && M.client)
							M.client.images+=N.image
							M.client.images-=G
					spawn()for(var/turf/terrain/BuildingExt/Roof/BB in N)
						if(BB.Special=="")
							continue
						else if(BB.Special=="BOTTOM")
							BB.overlays-=BB.overlays
							BB.overlays+=B2
						else if(BB.Special=="LEFT")
							BB.overlays-=BB.overlays
							BB.overlays+=B4
						else if(BB.Special=="RIGHT")
							BB.overlays-=BB.overlays
							BB.overlays+=B3
						else if(BB.Special=="CORNERLEFT")
							BB.overlays-=BB.overlays
							BB.overlays+=B5
							BB.overlays+=B4
						else if(BB.Special=="CORNERRIGHT")
							BB.overlays-=BB.overlays
							BB.overlays+=B3
							BB.overlays+=B6
				for(var/area/AA in OutdoorAreas)
					if(AA.Outdoor)
						if(which<13)
							AA.icon_state=Yarkut
		goto Z
