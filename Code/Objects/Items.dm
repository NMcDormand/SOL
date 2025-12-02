obj
	var
		NotCreatable
		Stackable = 0
		Creator
		tmp
			//collected
			cantCollect
			Active = 0
			Dropped = 1

	Del()
		loc=null
		..()

	proc
		Checkamount()
			set waitfor = 0
			name= "[trueName] ([amount])"

		Check_Durability(mob/M)
			if(!M.client) return
			if(Durability<=0)
				Durability = 0
				if(worn)
					M.overlays-=icon
					M.wielding=null
					M.atkspeed=3
				M<<"Your [name] shattered!"
				if(bones)
					loc=null
					M.UpdateInventory()
					del(src)
				else
					if(istype(src,/obj/Weapon))
						M.EquipRemove_Weapon(src,icon)
					icon_state="broken"
					M.UpdateInventory()

		Destroy(DAMAGE,mob/M)
			if(DAMAGE>0&&Owner!=M)
				HEALTH-=DAMAGE
				if(HEALTH<=0) del(src)
				Checkamount()
				name= "[trueName] ([amount])"

	gold
		invisibility = 5
		name="gold Bag"
		icon='goldbag.dmi'
		verb
			Get()
				set src in oview(1)
				if(gold<1)
					usr<<"That was bugged gold. Luckily, a mystical force deleted it."
				else
					usr<<"You get <b>[gold]</b> gold."
					usr.gold += gold
					usr.StatUpdate_gold()
				del src

obj/Item
	invisibility = 5
	New()
		if(!trueName)
			trueName = name
		..()
	verb
		Get()
			set src in oview(1)
			Active++
			if(Active == 1 && loc)
				if(Stackable)
					var/obj/Item/F = locate(type) in usr
					if(!F)
						loc=usr
					else
						F.amount += amount
						amount = 0
						loc = null
				else
					loc=usr
				if(!amount)
					usr << "You pick up \an [trueName]"
				else
					usr << "You pick up [amount] [trueName]"
				usr.UpdateInventory()
				Active = 0

		Drop()
			set src in usr.contents
			if(BlockDrop)
				return
			Active++
			if(Active == 1)
				if(worn)
					usr << "You're using it!"
					Active = 0
				else if(Stackable)
					usr.DropStackedItems(src)
					Active = 0
				else
					usr.DropItems(src)
					Active = 0

	CatCollar
		name="Cat Collar"
		icon='MissionItems.dmi'
		icon_state="CatCollar"
		Click()
			..()
			if(src in usr.contents)
				if(OnSpeedRail)
					Use()
				else
					usr.ItemStats(src)
			else
				if(usr.clicked_item)
					return
				usr.clicked_item = 1
				spawn(10)
					usr.clicked_item = 0
				Get()
		verb
			Use()
				set name="Locate Cat"
				set desc="Display the cat's location on your minimap."
				if(usr.Tracking) return
				if(usr.loc && usr.loc.loc)
					var/area/AR = usr.loc.loc
					if(AR)
						if(istype(AR,/area/Outdoor))
							usr.Tracking=1; spawn(100) usr.Tracking=0
							var/DC = 0
							var/obj/Item/Cat/G
							var/turf/VL = loc
							for(var/obj/Item/CA in CatsSpawned)
								if(!DC)
									DC = get_dist(CA,VL)
									G = CA
								else
									if(get_dist(CA,VL) < DC )
										G = CA
							if(G)
								usr.TrackCat(G)

	Sake
		name="Sake"
		trueName="Sake"
		icon='Sake.dmi'
		amount=1
		Stackable = 0
		Click()
			..()
			if(src in usr.contents)
				if(OnSpeedRail) Use()
				else usr.ItemStats(src)
			else
				if(usr.clicked_item) return
				usr.clicked_item = 1
				spawn(10) usr.clicked_item = 0
				Get()
		verb
			Use()
				set name="Drink Sake"
				set desc="Drink from the bottle of Sake"
				usr<<"You take a violent swig of Sake."
				if(usr.CooldownCheck("Sake",9000*usr.cooldownmultiplier)) return
				if(usr.Gate)
					usr << "With your new found strength you accidentally shatter the bottle"
				else if(!usr.Drunk)
					usr.Drunk=1
					spawn(250)
						if(usr.Drunk)
							usr.Drunk=0;
							usr<<"You sober up..."
				loc=null; usr.UpdateInventory(); del(src)
	Bandages
		name="Bandages"
		trueName="Bandages"
		icon='Bandages.dmi'
		icon_state="inventory"
		amount=1
		Stackable = 1
		Click()
			..()
			if(src in usr.contents)
				if(OnSpeedRail) Use()
				else usr.ItemStats(src)
			else
				if(usr.clicked_item) return
				usr.clicked_item = 1
				spawn(10) usr.clicked_item = 0
				Get()
		verb
			Use()
				set src in usr.contents
				set name="Use Bandages"
				set desc="Heal the wounds of yourself or another"
				if(usr.UsingBandages) {usr<<"You're currently applying bandages."; return}
				for(var/mob/p in get_step(usr, usr.dir))
					if(p&&(istype(p,/mob/player/)||istype(p,/mob/Hittable/Responsive/Animal/Pet/)))
						if(p.Wounds<=18) {usr<<"Applying bandages to [p]'s wounds will have no effect."; return}
						if(p.BandageUses>7) {usr<<"[p] is already dressed with the maximum number of bandages."; return}
						usr.ApplyBandages(p)
						return
				if(usr.Wounds<=18) {usr<<"Applying bandages to your wounds will have no effect."; return}
				if(usr.BandageUses>7) {usr<<"You've already dressed yourself with the maximum number of bandages."; return}
				if(usr.DamagedRecently) {usr<<"You cannot use any Bandages just yet."; return}
				usr.ApplyBandages()

	parcel
		name="Parcel"
		icon='MissionItems.dmi'
		icon_state="Parcel"
		//****************************************************************************************
	GarbageNet
		name="Garbage Net"
		icon='MissionItems.dmi'
		icon_state="GarbageNet"
		tradeable=0
		verb
			CollectGarbage()
				set name="Collect Garbage"
				set desc="Collect garbage from waters as part of a D Misson"
				var/turf/M=get_step(usr,usr.dir)
				if(M)
					if(!istype(M.loc,/area/Water))
						usr<<"You must be near water to collect garbage"
						return
				if(usr.frozen||usr.swimming||usr.GMfrozen||usr.jailed||usr.fishing||usr.kaiten||usr.waterprisoned||usr.InGatsuuga||usr.InMeatTank||usr.InTsuuga||usr.InGarouga) return
				if(usr.FishingSkill<5) {usr<<"You need fishing skill of Level 5 or higher"; return}
				usr.fishing=1
				range(4,usr)<<"<font color=gray>[usr] scoops \his net through the water...</font>"
				spawn(22)
					if(prob(usr.FishingSkill*2))
						usr<<"You found some garbage!"; usr.FishingSkillXP+=0.5
						var/obj/Item/Material/Garbage/G=locate() in usr.contents
						if(!G)
							new/obj/Item/Material/Garbage(usr)
						else
							G.amount++;
							G.Checkamount();
						usr.UpdateInventory()
					else {usr<<"No garbage could be found."}
					usr.fishing=0
//----------------------------
obj
	ThrownStone
		name="stone"
		icon = 'Materials.dmi'
		icon_state="StoneOre"
		density=1
		Bump(A)
			if(!Owner)
				del src
				return
			if(istype(A,/mob/Hittable/Command/Genjutsu/FakeView))
				density = 0
				spawn(1)
					density = 1
			else if(ismob(A))
				var
					mob/M = A
					mob/O = Owner
				if(M.kaiten||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
				var/D = round(Taijutsu*0.001)+(EarthElemental*0.01)
				var/damage=D+ThrowingSkill
				if(damage<1)damage=1
				var/nk=0
				if(!M.KO) nk=1
				M.DamageMe(O,damage,src)
				if(M.KO&&nk) O.Medal_YouRock()
				del(src)
			else if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)
			else if(istype(A,/obj/)) del(src)

//-------------------------------------------------------------------------------------------------------------
obj/Scrolls
	Parchment
		name="Parchment"
		icon='Parchment.dmi'
		price=10
		//ItemType="Food"
		Click()
			..()
			if(src in usr.contents)
				if(OnSpeedRail) WriteOn()
				else usr.ItemStats(src)
		verb
			WriteOn()
				set name="Write"
				if(usr.choosing)
					return
				usr.choosing=1
				var/list/Choices = list("Kage Shuriken", "Mei Mei", "Kage Bunshin", "Bunshin Daibakuha","Shuriken Kage Bunshin")
				var/write=input("What will you write on the parchment?","Parchment") as null|anything in Choices
				if(write)
					switch(write)
						if("Mei Mei")
							new/obj/Scrolls/MeiMeiScroll(usr)
							usr<<"You created a Mei Mei no Jutsu Scroll from the Parchment!"
						if("Kage Shuriken")
							new/obj/Scrolls/KageShurikenScroll(usr)
							usr<<"You created a Kage Shuriken no Jutsu Scroll from the Parchment!"
						if("Shuriken Kage Bunshin")
							new/obj/Scrolls/KageShurikenScroll(usr)
							usr<<"You created a Kage Shuriken no Jutsu Scroll from the Parchment!"
						if("Kage Bunshin")
							new/obj/Scrolls/KageBunshinScroll(usr)
							usr<<"You created a Kage Bunshin no Jutsu Scroll from the Parchment!"
						if("Bunshin Daibakuha")
							new/obj/Scrolls/BunshinExplodeScroll(usr)
							usr<<"You created a Bunshin Daibakuha scroll from the Parchment!"
					usr.choosing=0
					spawn(2)
						if(usr)
							usr.UpdateInventory()
					del src
				usr.choosing=0

//-------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------
/***********************************************************************************
***********************************[ Food ]*****************************************
************************************************************************************/
obj/Item
	RamenDisplay
		name="Ramen"
		trueName = "Ramen"
		icon='ramen.dmi'
		icon_state="show"

	Ramen
		name="Ramen"
		icon='ramen.dmi'
		price=3
		Stackable = 1
		ItemType="Food"
		var
			tmp/Eating = 0
			Cooldown = 1
			CalorieIntake = 120
		Click()
			..()
			if(src in usr.contents)
				if(OnSpeedRail) Eat()
				else usr.ItemStats(src)
			else
				if(usr.clicked_item) return
				usr.clicked_item = 1
				spawn(10) usr.clicked_item = 0
				Get()
		verb
			Eat()
				set name="Eat Ramen"
				if(Eating)
					return
				if(usr.KO||usr.dead)
					return
				if(usr.CooldownCheck(trueName,Cooldown,1))
					usr<<"You cannot eat another [trueName] just yet."
					return
				Eating = 1
				usr.Stamina+=500; usr.Stamina+=(usr.StaminaMax*0.05); usr.Calories(CalorieIntake)
				if(usr.Stamina>=usr.StaminaMax) {usr.Stamina=usr.StaminaMax;usr.rockLuck=1;usr.OutofLuck();} // Also add double find find chance
				usr<<"You ate some [name]"

				amount--
				Checkamount()
				usr.UpdateInventory()
				if(amount <1)
					del src
				else
					sleep(Cooldown)
					Eating = 0


mob/proc
	OutofLuck()
		spawn(6000)
			usr.rockLuck=0 // Double rock find chance removed

	DropItems(obj/O)
		src<<"You drop the [O.name]"; O.loc=loc
		if(O.OnSpeedRail)
			O.OnSpeedRail=null; SpeedRailSlotsUsed[O.ItemSlot]=0
		UpdateInventory()

	DropStackedItems(obj/O)
		var/D = round(input("Drop how many [O.name]?","Drop",) as num)
		if(D<=0)
			return
		else if(D>O.amount)
			if(alert("You don't have that many [O.trueName], Would you like to drop them all?([O.amount] in total)","Drop","Yes","No")=="Yes")
				D = O.amount
			else
				return
		if(D >= O.amount)
			src<<"You drop the [O.trueName]"
			if(O.OnSpeedRail)
				O.OnSpeedRail = null
				SpeedRailSlotsUsed[O.ItemSlot]=0
			O.loc=loc
		else
			src<<"You drop [D] [O.trueName]"
			O.amount-=D
			var/obj/o = new O.type(loc)
			o.amount=D
		UpdateInventory()

	GetItems(obj/O)
		src<<"You pick up the [O.name]"; O.loc=src; UpdateInventory()