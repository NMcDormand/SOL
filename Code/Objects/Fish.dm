mob
	var
		FishingBox
		tmp/fishing=0
		tmp/afkFishing = 0;
	proc
		SelectRod()
			var/list/UL = list()
			for(var/obj/Item/rod/FR in src)
				if(FR.Durability > 0)
					if(istype(FR,/obj/Item/rod/Rod3))
						if(!UL["3"])
							UL["3"] = list(FR)
						else
							UL["3"] += FR
					else if(istype(FR,/obj/Item/rod/Rod2))
						if(!UL["2"])
							UL["2"] = list(FR)
						else
							UL["2"] += FR
					else if(istype(FR,/obj/Item/rod/Rod1))
						if(!UL["1"])
							UL["1"] = list(FR)
						else
							UL["1"] += FR
					else if(istype(FR,/obj/Item/rod/Rod0))
						if(!UL["0"])
							UL["0"] = list(FR)
						else
							UL["0"] += FR
			if(!UL.len)
				return 0

			var/list/CL = list()
			if(FishingSkill>=80 && UL["3"])
				CL = UL["3"]
			else if(FishingSkill>=45 && UL["2"])
				CL = UL["2"]
			else if(UL["1"])
				CL = UL["1"]
			else if(UL["0"])
				CL = UL["0"]

			//world << "[CL.len]"

			if(CL.len)
				var/obj/Item/rod/R
				for(var/obj/Item/rod/TR in CL)
					if(!R)
						R = TR
					else
						if(TR.Durability < R.Durability)
							R = TR

				return R

obj/Item/rod
	verb
		DurabilityCheck()
			set background = 1
			var/D=round((Durability/MaxDurability)*100)
			usr<<"[name]'s Durability: <i>[D]%</font></i>"
	Drop()
		..()
		usr.afkFishing=0
		OnSpeedRail=null; usr.SpeedRailSlotsUsed[ItemSlot]=0
		usr.UpdateInventory()
	proc
		Fish(mob/U)
			set background = 1
			..()
	Rod1
		name="Fishing Rod"
		trueName="Fishing Rod"
		icon='Rod.dmi'
		icon_state="inventory"
		repairCost=1000
		price=1300
		Durability=500
		MaxDurability=500

		Click()
			..()
			if(src in usr.contents)
				usr.ItemStats(src)
			else
				if(usr.clicked_item) return
				usr.clicked_item = 1
				spawn(10) usr.clicked_item = 0
				Get()

		Fish(mob/U)
			if(Durability<=0) return
			var/turf/M=get_step(U,U.dir)
			if(M)
				if(!istype(M.loc,/area/Water))
					U<<"You must be near water to fish"
					return

				if((U.FishingAttackCheck()||U.fishing))
					return

				U.overlays+='Rod.dmi'
				U.fishing=1;
				range(4,U)<<"<font color=gray>[U] casts \his line into the water...</font>"; U.fishing=1
				sleep(15)
				if(U.FishingSkill<10)
					switch(pick(1,prob(6+U.Luck); 2))
						if(1) U.CatchNothing()
						if(2) U.CatchSmall()
				else
					switch(pick(1,prob(round(U.FishingSkill/1.5)); 2,prob(round(U.FishingSkill/20)+U.Luck); 3))
						if(1) U.CatchNothing()
						if(2) U.CatchSmall()
				DamagetoWeapon(rand(4,10),U)

			else
				return


//-------------------------------------------------------------------------------------------------------------
	Rod2
		name="Quality Fishing Rod"
		trueName="Quality Fishing Rod"
		icon='Rod.dmi'
		icon_state="inventory"
		price=3800
		repairCost=3200
		Durability=2500
		MaxDurability=2500
		Click()
			..()
			if(src in usr.contents)
				usr.ItemStats(src)
			else
				if(usr.clicked_item) return
				usr.clicked_item = 1
				spawn(10) usr.clicked_item = 0
				Get()

		Fish(mob/U)
			if(Durability<=0) return
			var/turf/M=get_step(U,U.dir)
			if(M)
				if(!istype(M.loc,/area/Water))
					U<<"You must be near water to fish"
					return
				if(U.FishingAttackCheck()||U.fishing) return
				if(U.FishingSkill<45)
					U<<"Your fishing skill is not high enough to use this"
					return

				U.overlays+='Rod.dmi'
				U.fishing=1;
				range(4,U)<<"<font color=gray>[U] casts \his quality line into the water...</font>"
				sleep(15)
				switch(pick(1,prob(round(U.FishingSkill/2)); 2,prob(round(U.FishingSkill/2)+U.Luck); 3,prob(round(U.FishingSkill/10)+U.Luck); 4,prob(round(U.FishingSkill/25)+U.Luck); 5))
					if(1) U.CatchNothing()
					if(2) U.CatchSmall()
					if(3) U.CatchMedium()
					if(4) U.CatchLarge()
					if(5) U.CatchLava()
				DamagetoWeapon(rand(8,12),U)
			else
				return

//-------------------------------------------------------------------------------------------------------------
	Rod3
		name="Premium Fishing Rod"
		trueName="Premium Fishing Rod"
		icon='Rod.dmi'
		icon_state="inventory"
		price=16000
		repairCost=10000
		Durability=5000
		MaxDurability=5000
		Click()
			..()
			if(src in usr.contents)
				usr.ItemStats(src)
			else
				if(usr.clicked_item) return
				usr.clicked_item = 1
				spawn(10) usr.clicked_item = 0
				Get()
		Fish(mob/U)
			set background = 1
			if(Durability<=0) return
			if(U.FishingSkill<80) {U<<"Your fishing skill is not high enough to use this"; return}
			var/turf/M=get_step(U,U.dir)
			if(M)
				if(!istype(M.loc,/area/Water))
					U<<"You must be near water to fish"
					return
			if(U.FishingAttackCheck()||U.fishing) return
			U.overlays+='Rod.dmi'
			U.fishing=1;
			range(3,U)<<"<font color=gray>[U] casts \his premium line into the water...</font>"
			sleep(15)
			switch(pick(1,prob(U.FishingSkill/10); 2,prob(round(U.FishingSkill/15)+U.Luck); 3,prob(round(U.FishingSkill/20)+U.Luck); 4,prob(round(U.FishingSkill/80)+U.Luck); 5,prob(round(U.FishingSkill/120)+U.Luck); 6))
				if(1) U.CatchNothing()
				if(2) U.CatchLarge()
				if(3) U.CatchLava()
				if(4) U.CatchShadow()
				if(5) U.CatchAngel()
				if(6) U.CatchRainbow()
			DamagetoWeapon(rand(1,4),U)

//-------------------------------------------------------------------------------------------------------------
	Rod0
		name="Useless Fishing Rod"
		trueName="Useless Fishing Rod"
		icon='Rod.dmi'
		icon_state="inventory"
		price=1
		repairCost=1
		Durability=50000
		MaxDurability=50000
		Click()
			if(src in usr.contents)
				usr.ItemStats(src)
			else
				if(usr.clicked_item) return
				usr.clicked_item = 1
				spawn(10) usr.clicked_item = 0
				Get()
		Fish(mob/U)
			set background = 1
			if(Durability<=0) return
			var/turf/M=get_step(U,U.dir)
			if(M)
				if(!istype(M.loc,/area/Water))
					U<<"You must be near water to fish"
					return
			if(U.FishingAttackCheck()||U.fishing) return
			U.overlays+='Rod.dmi'
			U.fishing=1;
			range(3,U)<<"<font color=gray>[U] casts \his useless line into the water...</font>"
			sleep(15)
			switch(pick(1,prob(U.FishingSkill/10); 2,prob(U.FishingSkill/15); 3,prob(U.FishingSkill/20); 4,prob(U.FishingSkill/40); 5,prob(U.FishingSkill/60); 6))
				if(1) U.CatchNothing()
				if(2) U.CatchLarge()
				if(3) U.CatchLava()
				if(4) U.CatchShadow()
				if(5) U.CatchAngel()
				if(6) U.CatchRainbow()
			DamagetoWeapon(rand(5,10),U)

//-------------------------------------------------------------------------------------------------------------
	FishingBox
		name="Fishing Box"
		trueName="Fishing Box"
		icon='Rod.dmi'
		icon_state="box"
		price=75
		Click()
			if(!(src in usr.contents))
				Get()
			else
				if(OnSpeedRail)
					if(usr.clicked_item) return
					usr.clicked_item = 1
					spawn(10) usr.clicked_item = 0
				else usr.ItemStats(src)
		verb
			Place()
				if(usr.recentLogin) {usr<<"Please wait a while longer"; return}
				if(Placed=="Recently")  {usr<<"You only placed this recently"; return}
				else if(Placed) return
				if(!usr.onwater)  {usr<<"You must be on water to place this"; return}
				Placed=usr.trueName; loc=usr.loc
				usr.overlays-='WaterWalk.dmi'; usr.onwater=0
				for(var/area/A in oview(0,usr)) A.Entered(usr)
				name="[usr.trueName]'s Fishing Box"
				usr<<"You place the fishing box in the water."; usr.UpdateInventory()
				if(!FishyList) {FishyList=new(); FishyList["Medium"]=0;FishyList["Large"]=0;FishyList["Lava"]=0;FishyList["Shadow"]=0}
				FishingBoxProcedure(usr)

			CollectFish()
				set src in oview(1)
				usr.CollectFishProcedure(src)

		Get()
			set src in oview(1)
			if(Placed!=usr.name) {usr<<"That's not your fishing Box"; return}
			loc=usr; name="Fishing Box"
			usr.CollectFishProcedure(src); Placed="Recently"
			spawn(220)
				if(Placed=="Recently") Placed=null
			usr<<"You pick up the [name]"
			usr.UpdateInventory()

mob/proc
	FishEat(var/obj/Fish/Fi)
		src << "You eat \a [Fi.trueName]"
		switch(Fi.FishEffect)
			if(1)//Small
				usr.Stamina+=1000
				if(usr.Stamina>=usr.StaminaMax)
					usr.Stamina=usr.StaminaMax
			if(2)//Medium
				usr.Stamina+=3000
				if(usr.Stamina>=usr.StaminaMax)
					usr.Stamina=usr.StaminaMax
			if(3)//Large
				usr.Stamina+=5000
				if(usr.Stamina>=usr.StaminaMax)
					usr.Stamina=usr.StaminaMax
			if(4)//Lava
				usr.Stamina = usr.StaminaMax
			if(5)//Shadow
				usr.Chakra = usr.SetMaxChakra()
			if(6)//Angel
				usr.Wounds-=50
				TextOverlay(usr, 50, "health")
				if(usr.Wounds<0)
					usr.Wounds=0
			if(7)//Rainbow
				usr.Wounds-=50
				if(usr.Wounds<0)
					usr.Wounds=0
				TextOverlay(usr, 50, "health");
				usr.Chakra = usr.SetMaxChakra()
				usr.Stamina = usr.StaminaMax
		Calories(Fi.CalorieIntake)
		RefreshStats()
//-------------------------------------------------------------------------------------------------------------
obj/Fish
	invisibility = 5
	var
		tmp/Eating = 0
		CalorieIntake = 0
		Cooldown = 1
		FishEffect = 0
	Stackable = 1
	amount=1
	ItemType="Fish"
	icon='Fish.dmi'
	Click()
		..()
		if(src in usr.contents)
			if(OnSpeedRail)
				Eat()
			else
				usr.ItemStats(src)
	verb
		Eat()
			if(Eating)
				return
			if(usr.KO||usr.dead)
				return
			if(usr.CooldownCheck(trueName,Cooldown,1))
				usr<<"You cannot eat another [trueName] just yet."
				return
			Eating = 1
			usr.FishEat(src)
			amount--
			Checkamount()
			usr.UpdateInventory()
			if(amount <1)
				del src
			else
				sleep(Cooldown)
				Eating = 0
		Get()
			set src in oview(1)
			Active++
			if(Active == 1)
				var/obj/Fish/Small/F=locate(type) in usr.contents
				if(!F)
					loc = usr
					usr.UpdateInventory()
					usr << "You pick up 1 [trueName]"
					Active = 0
				else
					F.amount+=amount
					F.Checkamount()
					usr.UpdateInventory()
					usr << "You pick up 1 [trueName]"
					del src
		Drop()
			Active++
			if(Active == 1)
				usr.DropStackedItems(src)
				Active = 0

	Small
		name="Small Fish"
		trueName="Small Fish"
		icon_state="SmallFish"
		price=20
		CalorieIntake = 2
		Cooldown = 3
		FishEffect = 1
		verb
			EatMe()
				set name="Eat Small Fish"
				if(usr.KO)
					return
				if(Eating||usr.CooldownCheck(trueName,Cooldown,1))
					usr<<"You cannot eat another [trueName] just yet."
					return
				Eating = 1
				usr.FishEat(src)
				amount--
				Checkamount()
				usr.UpdateInventory()
				if(amount <1)
					del src
				else
					sleep(Cooldown)
					Eating = 0

	Medium
		name="Medium Fish"
		trueName="Medium Fish"
		icon_state="MediumFish"
		price=30
		CalorieIntake = 2
		Cooldown = 3
		FishEffect = 2
		verb
			EatMe()
				set name="Eat Medium Fish"
				if(usr.KO)
					return
				if(Eating||usr.CooldownCheck(trueName,Cooldown,1))
					usr<<"You cannot eat another [trueName] just yet."
					return
				Eating = 1
				usr.FishEat(src)
				amount--
				Checkamount()
				usr.UpdateInventory()
				if(amount <1)
					del src
				else
					sleep(Cooldown)
					Eating = 0

	Large
		name="Large Fish"
		trueName="Large Fish"
		icon_state="LargeFish"
		price=80
		CalorieIntake = 2
		Cooldown = 3
		FishEffect = 3
		verb
			EatMe()
				set name="Eat Large Fish"
				if(usr.KO)
					return
				if(Eating||usr.CooldownCheck(trueName,Cooldown,1))
					usr<<"You cannot eat another [trueName] just yet."
					return
				Eating = 1
				usr.FishEat(src)
				amount--
				Checkamount()
				usr.UpdateInventory()
				if(amount <1)
					del src
				else
					sleep(Cooldown)
					Eating = 0

	Lava
		name="Lava Fish"
		trueName="Lava Fish"
		icon_state="LavaFish"
		price=150
		CalorieIntake = 12
		Cooldown = 200
		FishEffect = 4
		verb
			EatMe()
				set name="Eat Lava Fish"
				if(usr.KO)
					return
				if(Eating||usr.CooldownCheck(trueName,Cooldown,1))
					usr<<"You cannot eat another [trueName] just yet."
					return
				Eating = 1
				usr.FishEat(src)
				amount--
				Checkamount()
				usr.UpdateInventory()
				if(amount <1)
					del src
				else
					sleep(Cooldown)
					Eating = 0

	Shadow
		name="Shadow Fish"
		trueName="Shadow Fish"
		icon_state="ShadowFish"
		price=150
		CalorieIntake = 15
		Cooldown = 500
		FishEffect = 5
		verb
			EatMe()
				set name="Eat Shadow Fish"
				if(usr.KO)
					return
				if(Eating||usr.CooldownCheck(trueName,Cooldown,1))
					usr<<"You cannot eat another [trueName] just yet."
					return
				Eating = 1
				usr.FishEat(src)
				amount--
				Checkamount()
				usr.UpdateInventory()
				if(amount <1)
					del src
				else
					sleep(Cooldown)
					Eating = 0

	Angel
		name="Angel Fish"
		trueName="Angel Fish"
		icon_state="AngelFish"
		price=500
		CalorieIntake = 25
		Cooldown = 800
		FishEffect = 6
		verb
			EatMe()
				set name="Eat Angel Fish"
				if(usr.KO)
					return
				if(Eating||usr.CooldownCheck(trueName,Cooldown,1))
					usr<<"You cannot eat another [trueName] just yet."
					return
				Eating = 1
				usr.FishEat(src)
				amount--
				Checkamount()
				usr.UpdateInventory()
				if(amount <1)
					del src
				else
					sleep(Cooldown)
					Eating = 0

	Rainbow
		name="Rainbow Fish"
		trueName="Rainbow Fish"
		icon_state="RainbowFish"
		price=1000
		CalorieIntake = 65
		Cooldown = 1500
		FishEffect = 7
		verb
			EatMe()
				set name="Eat Rainbow Fish"
				if(usr.KO)
					return
				if(Eating||usr.CooldownCheck(trueName,Cooldown,1))
					usr<<"You cannot eat another [trueName] just yet."
					return
				Eating = 1
				usr.FishEat(src)
				amount--
				Checkamount()
				usr.UpdateInventory()
				if(amount <1)
					del src
				else
					sleep(Cooldown)
					Eating = 0
