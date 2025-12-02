#if DEBUGGING
mob/verb
	SelfLearnMangekyouSharingan()
		var/obj/SkillCards/Clan/Uchiha/MangekyouSharingan/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Mangekyou Sharingan</i>!</b></font>"
			if(!SharType)
				SharType = pick(prob(100);1,prob(100);2,prob(100);3)//,prob(100);4,prob(0.1);5)
			if(!SharinganLevel)
				SharinganLevel = 3
				new/obj/SkillCards/Clan/Uchiha/Sharingan(src)
			new/obj/SkillCards/Clan/Uchiha/MangekyouSharingan(src)
#endif

obj/SkillCards/Clan/Uchiha/MangekyouSharingan
	icon_state="card_MS1"
	cmdstring="MangekyouSharingan"
	CCost = 200

	Description = list(
		"about"="Technically classified as Doujutsu (eye technique).  Using Mangekyou Sharingan will allow the user to see beyond what the regular Sharingan can.  Drains chakra with use."
		,"title"="Mangekyou Sharingan"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
//		,"pic"='MangekyouSharingan.png'
		)

	UpgradeChoices = list("Lower Cooldown","Remove Cost")

	New()
		..()
		if(ismob(loc))
			var/mob/M = loc
			M.HasMangekyou = 1
			icon_state="card_MS[M.SharType]"
			new/obj/SkillCards/Clan/Uchiha/MS/EyeSwap(M)

	Activate(mob/U)
		if(U.InMangekyou)
			U<<"You revert to the standard Sharingan."
			U.InMangekyou=0;
			U.InSharingan=3;
			U.Cooldowns["Mangekyou"]=world.time+(U.MangekyouCooldown*U.cooldownmultiplier)
			if(U.SharinganLevel==1)
				U.Reflex-=30
			else if(U.SharinganLevel==2)
				U.Reflex-=20
			else if(U.SharinganLevel>=3)
				U.Reflex-=10
			spawn(5) U.StatUpdate_reflexes()
			U.SharinganDrain()
			if(!U.Projection)
				U.see_invisible -= 1
		else
			if(U.KO||U.Sleeping||U.protect||U.jailed||U.GMfrozen)
				return
			if(U.CooldownCheck("Mangekyou",U.MangekyouCooldown**U.cooldownmultiplier))
				return
			hearers(2,U)<<"<b>[U] says: Mangekyou Sharingan!</b>"
			var/I = "MS[U.SharType]"
			//if(U.EternalSharingan)
			//IS = "EMS[U.SharType]"
			new/obj/SharEye(U,I)
			//if(U.HasDimensionalRift) add the verb
			if(CCost)
				U.MangekyouDrain(CCost)
			if(U.InSharingan)
				U.Reflex += 10
			else
				U.Reflex += 40 + U.SharinganReflexes
			spawn(5) U.StatUpdate_reflexes()
			if(!U.Projection)
				if(U.InSharingan)
					U.see_invisible += 1
				else
					U.see_invisible += 4
			if(U.InSharingan)
				U.InSharingan+=1
			else
				U.InSharingan=4
				U.DouEyes = new/Overlay_Obj('SharinganEyes.dmi',EYE_LAYER)
				U.overlays += U.DouEyes
			U.InMangekyou=1
			..()

mob/proc
	MangekyouDrain(C)
		set waitfor = 0
		while(InMangekyou)
			Chakra-=C;
			RefreshChakra()
			/*for(var/mob/B in view(16,src))
				if(B==src||IDCHECK(B,src)||istype(B,/mob/Hittable/Responsive/Animal))
					continue
				if(!B.trueName)
					B.trueName = B.name
				if(!CamoList[B.trueName] && !CamoList["[B.trueName][CamoList.len]"])
					var/image/i
					if(istype(B,/mob/Hittable/Command/Clones)||istype(B,/mob/Hittable/Command/EdoClone))
						i = image('BunshinMarker.dmi',B)
						i.layer=50
						if(i)
							CamoList["[B.trueName][CamoList.len]"] = i
							src<<i
					else
						if(istype(B,/mob/Hittable/Responsive))
							i = image('PlayerMarker.dmi',B)
							i.layer=50
							if(i)
								CamoList["[B.trueName][CamoList.len]"] = i
								src<<i
						else if(istype(B,/mob/player))
							i = image('PlayerMarker.dmi',B)
							i.layer=50
							if(i)
								CamoList[B.trueName] = i
								src<<i*/
			if(Chakra<C)
				if(Chakra<0)
					Chakra = 0
				src<<"<i>You no longer have enough chakra to sustain your Mangekyou Sharingan.</i>"
				InMangekyou=0;
				Reflex=ReflexTrue
				Cooldowns["Mangekyou"]=world.time+(MangekyouCooldown*cooldownmultiplier)
				StatUpdate_reflexes()
			sleep(15)
		/*for(var/A in CamoList)
			var/atom/i = CamoList[A]
			CamoList -= A
			del i*/