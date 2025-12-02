obj/SkillCards/Clan/Uchiha/Sharingan
	icon_state="card_S1"
	cmdstring="Sharingan"
	CCost = 50

	Description = list(
		"about"="Technically classified as Doujutsu (eye technique).  Using Sharingan will allow the user to see the unseeable.  You will also be better-ab;e to anticipate the enemies attacks.  Drains chakra with use."
		,"title"="Sharingan"
		,"type"="Ninjutsu"
		,"type"="C"
		,"weak"="N/A"
		,"rank"="N/A"
		,"pic"='Sharingan.png'
	)

	UpgradeChoices = list("Remove Cost","Add Tomoe")

	Activate(mob/U)
		if(U.InSharingan||U.InMangekyou)
			U<<"You release your Sharingan."
			if(U.InSharingan)
				if(!U.Cooldowns)
					U.Cooldowns = list()
				U.Cooldowns["Sharingan"]=world.time+(U.SharinganCooldown*U.cooldownmultiplier)
			if(U.InMangekyou)
				U.InMangekyou=0;
				U.Cooldowns["Mangekyou"]=world.time+(U.MangekyouCooldown*U.cooldownmultiplier)
			U.overlays -= U.DouEyes
			U.DouEyes = null
			if(!U.Projection)
				U.see_invisible -= U.InSharingan
			U.Reflex -= ((U.InSharingan*10) + U.SharinganReflexes)
			U.InSharingan=0
			spawn(5) U.StatUpdate_reflexes()
		else
			if(U.KO||U.Sleeping||U.protect||U.jailed||U.GMfrozen) return
			if(U.CooldownCheck("Sharingan",U.SharinganCooldown*U.cooldownmultiplier)) return
			var/sharLevel=U.SharinganLevel;
			if(sharLevel > 3) sharLevel = 3;
			/*if(U.InMangekyou)
				U<<"You revert to the standard Sharingan."
				U.InMangekyou=0;
				U.overlays-= U.DouEyes
				U.Cooldowns["Mangekyou"]=world.time+(U.MangekyouCooldown*U.cooldownmultiplier)
				if(U.SharinganLevel==1)
					U.Reflex-=30
				else if(U.SharinganLevel==2)
					U.Reflex-=20
				else if(U.SharinganLevel>=3)
					U.Reflex-=10
			else*/
			hearers(2,U)<<"<b>[U] says: Sharingan! ([sharLevel] tomoe)</b>"

			//if(!U.InMangekyou)
			U.DouEyes = new/Overlay_Obj('SharinganEyes.dmi',EYE_LAYER)
			U.overlays+=U.DouEyes
			U.InSharingan=sharLevel;

			new/obj/SharEye(U,"S[U.SharinganLevel]")

			if(U.SharinganLevel==1)
				U.Reflex+=(10+U.SharinganReflexes)
			else if(U.SharinganLevel==2)
				U.Reflex+=(20+U.SharinganReflexes)
			else if(U.SharinganLevel>=3)
				U.Reflex+=(30+U.SharinganReflexes)

			spawn(5) U.StatUpdate_reflexes()
			if(!U.Projection)
				U.see_invisible += U.InSharingan
			U.SharinganDrain(CCost)
			..()

mob/proc
	SharinganDrain(C)
		set waitfor = 0
		while(InSharingan)
			Chakra-=C; RefreshChakra()

			ApplyEXP(C,"Chakra")
			/*switch(SharinganLevel)
				if(1)
					for(var/mob/Hittable/Command/Clones/B in view(16,src))
						if(B==src)
							continue
						if(IDCHECK(B,src))
							continue
						if(!B.trueName)
							B.trueName = B.name
						if(!CamoList["[B.trueName][CamoList.len]"])
							var/image/i = image('BunshinMarker.dmi',B)
							if(i)
								CamoList["[B.trueName][CamoList.len]"] = i
								src<<i
				if(2)
					for(var/mob/Hittable/Command/B in view(16,src))
						if(B==src)
							continue
						if(IDCHECK(B,src))
							continue
						if(!B.trueName)
							B.trueName = B.name
						if(!CamoList["[B.trueName][CamoList.len]"])
							var/image/i
							if(istype(B,/mob/Hittable/Command/Clones)||istype(B,/mob/Hittable/Command/EdoClone))
								i = image('BunshinMarker.dmi',B)
							if(i)
								CamoList["[B.trueName][CamoList.len]"] = i
								src<<i
				if(3)
					for(var/mob/B in view(16,src))
						if(B==src||IDCHECK(B,src)||istype(B,/mob/Hittable/Responsive/Animal))
							continue
						if(!B.trueName)
							B.trueName = B.name
						if(!CamoList[B.trueName] && !CamoList["[B.trueName][CamoList.len]"])
							var/image/i
							if(istype(B,/mob/Hittable/Command/Clones)||istype(B,/mob/Hittable/Command/EdoClone))
								i = image('BunshinMarker.dmi',B)
								if(i)
									i.layer=50
									CamoList["[B.trueName][CamoList.len]"] = i
									src<<i
							else
								if(istype(B,/mob/Hittable/Responsive))
									i = image('PlayerMarker.dmi',B)
									if(i)
										i.layer=50
										CamoList["[B.trueName][CamoList.len]"] = i
										src<<i
								else if(istype(B,/mob/player))
									i = image('PlayerMarker.dmi',B)
									if(i)
										i.layer=50
										CamoList[B.trueName] = i
										src<<i*/
			if(Chakra<C)
				Chakra=0; src<<"<i>You no longer have enough chakra to sustain your Sharingan.</i>"
				InSharingan=0;
				overlays -= DouEyes
				DouEyes = null
				Reflex=ReflexTrue
				if(!Cooldowns)
					Cooldowns=list()
				Cooldowns["Sharingan"]=world.time+(SharinganCooldown*cooldownmultiplier)
				StatUpdate_reflexes()
			else
				sleep(10)
		/*for(var/A in CamoList)
			var/atom/i = CamoList[A]
			CamoList -= A
			del i*/