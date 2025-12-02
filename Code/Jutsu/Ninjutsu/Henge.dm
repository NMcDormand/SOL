obj/SkillCards/Ninjutsu/Starter/Henge
	icon_state="card_henge"
	cmdstring="HengeNoJutsu"
	CCost=40
	Seals=1
	XPLGain = 100

	Description = list(
		"about"="With this technique you can transform into other people or objects.  Perfect for posing as a friend before attacking the enemy, or blending into the landscape to avoid attack.  You can remember up to three different things.  Drains chakra while in effect."
		,"title"="Henge no Jutsu"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="D"
		,"pic"='Henge.png'
	)

	UpgradeChoices = list("Lower Cost")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)||U.choosing) return
		if(U.Giant)
			return
		var
			c=15; mx=c; s=U.SS*1
		if(U.InHenge)
			flick('Smoke.dmi',U)
			spawn(5)
				U.overlays = list(); U.InHenge=0
				U.Set_Float()
				U.CreationSkin(1)
		else
			U.choosing=1
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			var/HengeList=list()
			if(U.Slot1)
				HengeList+="Slot 1"
			if(U.Slot2)
				HengeList+="Slot 2"
			if(U.Slot3)
				HengeList+="Slot 3"
			if(!length(HengeList)) {U<<"You have not remembered anyone's appearance. use \"RememberHengeNoJutsu\" to save one"; U.choosing=0; return}
			switch(input("Which slot would you like to use?","Henge") as null|anything in HengeList)
				if("Slot 1")
					U.HengeChoice=1
				if("Slot 2")
					U.HengeChoice=2
				if("Slot 3")
					U.HengeChoice=3
				else
			U.choosing=0
			U.icon_state="seals"
			if(ChakraUseCheck()) c *= 4
			U.firing=1
			spawn(s)
				U.icon_state=null
				spawn(25) U.firing=0; U.choosing=0
				if(prob(U.ChakraControl+20))
					U.JutsuSeals(s); U.JutsuNin(c);
					U.MoveUses[name]++
					U.JutsuUseChakra(c)
					U.JutsuMessage(Description["title"])
					if(U.PracticeMode || ControlCheck(U)) return ..()
					U.InHenge=1
					flick('Smoke.dmi',U)
					if(U.HengeChoice==1)
						spawn(5)
							U.icon=U.Henge1Icon
							U.overlays=U.Henge1Clothes
							U.maptext = U.Henge1Text
					else if(U.HengeChoice==2)
						spawn(5)
							U.icon=U.Henge2Icon
							U.overlays=U.Henge2Clothes
							U.maptext = U.Henge2Text
					else if(U.HengeChoice==3)
						spawn(5)
							U.icon=U.Henge3Icon
							U.overlays=U.Henge3Clothes
							U.maptext = U.Henge3Text
					spawn(5)
						U.HengeDrain()
				else {c=rand(3,9); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
				..()

	verb/Remember_Henge_No_Jutsu()
		set category="TECHNIQUES"
		set src in usr.contents
		var/list/h=list()
		for(var/mob/M in oview(usr))
			if(M.Giant||M.Creator == usr)
				continue
			if(!M.CantHenge&&!M.noHenge&&M.icon)
				h+=M

		var/mob/H=input("","Remember") as null|anything in h
		if(H)
			switch(input("Which slot would you like to save [H]'s appearance to?","Henge Remember") as null|anything in list("Slot 1","Slot 2","Slot 3"))
				if("Slot 1")
					if(!H.icon) return
					usr.Slot1=1
					usr.Henge1Icon=H.icon
					usr.Henge1Clothes = list()
					usr.Henge1Text = H.maptext
					for(var/obj/C in H.contents)
						if(C.worn&&!C.rare) usr.Henge1Clothes+=C.icon
				if("Slot 2")
					if(!H.icon) return
					usr.Slot2=1
					usr.Henge2Icon=H.icon
					usr.Henge2Clothes = list()
					usr.Henge2Text = H.maptext
					for(var/obj/C in H.contents)
						if(C.worn&&!C.rare) usr.Henge2Clothes+=C.icon
				if("Slot 3")
					if(!H.icon) return
					usr.Slot3=1
					usr.Henge3Icon=H.icon
					usr.Henge3Clothes = list()
					usr.Henge3Text = H.maptext
					for(var/obj/C in H.contents)
						if(C.worn&&!C.rare) usr.Henge3Clothes+=C.icon

mob/proc/HengeDrain()
	while(InHenge)
		RefreshStats()
		if(prob(ChakraControl+45))
			Chakra-=10
			if(Chakra<10)
				src<<"Your transformation ceased because you are out of chakra."
				flick('Smoke.dmi',src)
				spawn(5)
					overlays.len=0; InHenge=0
					CreationSkin(1)
		else
			src<<"Your transformation fails because you didn't control your chakra well enough."
			InHenge = 0
			break
		sleep(22)

	if(InHenge)
		InHenge = 0
	flick('Smoke.dmi',src)
	spawn(5)
		overlays.len=0
		CreationSkin(1)