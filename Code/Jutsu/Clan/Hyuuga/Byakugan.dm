obj/SkillCards/Clan/Hyuuga/Byakugan
	icon_state="card_Byakugan"
	cmdstring="Byakugan"
	Range=32
	CCost=100
	Cooldown=1200
	CooldownCur=1200

	UpgradeChoices = list("Remove Cost", "Lower Cooldown", "Purify")

	Description = list(
		"about"="Activate the innate ability in Hyuugas to see the chakra flow of opponents as well as a wide field of vision."
		,"title"="Byakugan"
		,"type"="Doujutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='Byakugan.png'
		)

	Activate(mob/U)
		if(U.InByakugan)
			U.InByakugan=0
		else
			if(U.KO||U.Sleeping||U.protect||U.jailed||U.GMfrozen) return
			var/c=CCost
			if(U.Chakra < c) {U<<"You need more chakra to activate your Byakugan."; return}
			if(U.CooldownCheck("Byakugan",CooldownCur*U.cooldownmultiplier)) return
			if(ChakraUseCheck()) c *= 4
			U.JutsuMessage(Description["title"])
			U.JutsuUseChakra(c)
			if(ControlCheck(U)) return ..()

			U.InByakugan = U.ByakuganLevel
			if(!U.Projection)
				U.see_invisible += U.InByakugan

			switch(U.ByakuganLevel)
				if(1) {U.Reflex+=20;}// U.client.view=11;}
				if(2) {U.Reflex+=40;}// U.client.view=12;} //Palms
				if(3) {U.Reflex+=60;}// U.client.view=13;} //Palms

			U.StatUpdate_reflexes()
			U.ByakuganDrain(c*0.1,CooldownCur)
			..()

mob/proc/ByakuganDrain(C,CD)
	set waitfor = 0
	DouEyes = new/Overlay_Obj('ByakuganEyes.dmi',EYE_LAYER)
	overlays += DouEyes
	if(ByakuganLevel>2) //If they have maxed byakugan level
		for(var/mob/player/P in MasterPlayerList)
			if(P==src)
				continue
			if(P.invisibility <= see_invisible)
				var/image/i = image('PlayerMarker.dmi',P)
				i.layer=50
				CamoList[P.trueName] = i
				src<< i

	var/IB = InByakugan
	while(InByakugan && !KO && !dead)
		if(C)
			if(Chakra<C)
				break
			Chakra-=C
			RefreshChakra()
			ApplyEXP(C,"Chakra")

		if(ByakuganLevel>2)
			for(var/mob/B in view(16,src))
				if(B==src)
					continue
				if(IDCHECK(B,src))
					continue
				if(!B.trueName)
					B.trueName = B.name
				if(!CamoList[B.trueName])
					var/image/i
					if(istype(B,/mob/Hittable/Responsive) && !istype(B,/mob/Hittable/Responsive/Animal))
						i = image('PlayerMarker.dmi',B)
						i.layer=50
						if(i)
							CamoList["[B.trueName][CamoList.len]"] = i
							src<<i
					else
						if(istype(B,/mob/player))
							i = image('PlayerMarker.dmi',B)
							i.layer=50
							if(i)
								CamoList[B.trueName] = i
								src<<i
						else if(istype(B,/mob/Hittable/Command/Clones) && !istype(B,/mob/Hittable/Command/Clones/LimboClone)||istype(B,/mob/Hittable/Command/EdoClone))
							i = image('BunshinMarker.dmi',B)
							i.layer=50
							if(i)
								CamoList["[B.trueName][CamoList.len]"] = i
								src<<i
		sleep(4)

	if(src)
		overlays -= DouEyes
		if(!Projection)
			see_invisible -= IB
		if(Chakra < 0)
			Chakra = 0
		src<<"<b>You release your Byakugan.</b>"

		/*if(Settings["Screen"]) client.view=Settings["Screen"];
		else client.view=9;*/
		Reflex -= IB*20;
		InByakugan=0
		if(!Cooldowns)
			Cooldowns = list()
		Cooldowns["Byakugan"]=world.time+(CD*cooldownmultiplier)
		for(var/A in CamoList)
			var/atom/i = CamoList[A]
			if(i)
				del i
			CamoList -= A

		RefreshChakra()
		StatUpdate_reflexes()