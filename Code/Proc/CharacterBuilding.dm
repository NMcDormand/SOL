#define HAIRLIST list("Afro","Bald","Deidara","Gaara","Hashirama","Hidan","Ino","Itachi","Jiraiya","Jiroubou","Kakashi","Kimimaro","Kisame","Konan","Long","LongCelebrity","LongStraight","Madara","Minato","Mohawk","Myst","Naruto","Neji","Orochimaru","RockLee","Sakura","Sasuke","Shikamaru","Short","ShortCombed","Spiky","Tayuya","Temari","TenTen","Tsunade","Viole")
mob/proc
	AssignRandomHair(r=0,g=0,b=0)
		CurrentHair = pick(HAIRLIST)
		if(CurrentHair != "Bald")
			var/icon/HC = icon(GetHair(CurrentHair))
			HairColour = rgb(pick(20,40,60,80,100),pick(20,40,60,80,100),pick(20,40,60,80,100))
			HC += HairColour
			HairIcon = new/Overlay_Obj(HC,HAIR_LAYER)

			overlays += HairIcon

	CreationHair()
		if(choosing)
			return
		choosing=1
		var/CHair = input("Pick a hairstyle.","Hairstyle",text) as null|anything in HAIRLIST
		if(CHair)
			overlays -= HairIcon
			CurrentHair = CHair
			if(CHair != "Bald")
				var/icon/HC = icon(GetHair(CurrentHair))
				HairColour=input("What colour would you like your hair to be?","Hair Colour") as color
				if(HairColour)
					HC += HairColour
				switch(CHair)
					if("Temari")
						HC.Blend(icon('Hair_Temari-Band.dmi'),ICON_OVERLAY)
					if("Shikamaru" )
						HC.Blend(icon('Hair_Shikamaru-Band.dmi'),ICON_OVERLAY)
					if("Deidara" )
						HC.Blend(icon('Hair_Deidara-Band.dmi'),ICON_OVERLAY)
					if("Kimimaro")
						HC.Blend(icon('Hair_Kimimaro-Beads.dmi'),ICON_OVERLAY)

				HairIcon = new/Overlay_Obj(HC,HAIR_LAYER)
				overlays += HairIcon

		choosing=0

	ChangeBaseName()
		var/baseList=list("Pale","Medium","Tan","Dark","Blue","Red","Lilac","Green","Yellow","Pink","Pallid")
		if(client)
			if(client.IsByondMember()) baseList += list("Very Pale", "Very Dark", "Zetsu")

		var/BN = input(src,"Pick a skin tone.","Skin Tone") in baseList
		if(BN != basename)
			basename = BN
			CreationSkin()
			return 1
		else
			return 0

	CreationSkin(OL = 0)
		if(!OriginalIcon)
			if(!basename||!loggedin)
				isZetsu=0;
				var/baseList=list("Pale","Medium","Tan","Dark","Blue","Red","Lilac","Green","Yellow","Pink","Pallid")
				if(client)
					if(client.IsByondMember()) baseList += list("Very Pale", "Very Dark", "Zetsu")
				basename = input(src,"Pick a skin tone.","Skin Tone") in baseList

			var/icon/I
			switch(basename)
				if("Very Dark") {I = 'Base_Black.dmi'}
				if("Blue") {I = 'Base_Blue.dmi'}
				if("Dark") {I = 'Base_Dark.dmi'}
				if("Green") {I = 'Base_Green.dmi'}
				if("Lilac") {I = 'Base_Lilac.dmi'}
				if("Medium") {I = 'Base_Medium.dmi'}
				if("Pale") {I = 'Base_Pale.dmi'}
				if("Pallid") {I = 'Base_Pallid.dmi'}
				if("Pink") {I = 'Base_Pink.dmi'}
				if("Red") {I = 'Base_Red.dmi'}
				if("Tan") {I = 'Base_Tan.dmi'}
				if("Very Pale") {I = 'Base_White.dmi'}
				if("Yellow") {I = 'Base_Yellow.dmi'}
				if("Zetsu") {I = 'Base_Zetsu.dmi';isZetsu=1}
			icon = I
			vis_contents = null
			/*if(!CMarker)
				CMarker = new/Overlay_Obj(icon('BunshinMarker.dmi'),MOB_LAYER+9)
				CMarker.name = "Marker"
				CMarker.invisibility = 9
			if(!CPaths)
				CPaths = new/Overlay_Obj(icon('PlayerMarker.dmi'),MOB_LAYER+10)
				CPaths.name = "Paths"
				CPaths.invisibility = 10
			vis_contents += CMarker
			vis_contents += CPaths*/
			if(OL)
				overlays = null
				if(!HairIcon)
					if(CurrentHair && CurrentHair != "Bald")
						var/icon/HC = icon(GetHair(CurrentHair))
						if(HairColour)
							HC += HairColour
						switch(CurrentHair)
							if("Temari")
								HC.Blend(icon('Hair_Temari-Band.dmi'),ICON_OVERLAY)
							if("Shikamaru" )
								HC.Blend(icon('Hair_Shikamaru-Band.dmi'),ICON_OVERLAY)
							if("Deidara" )
								HC.Blend(icon('Hair_Deidara-Band.dmi'),ICON_OVERLAY)
							if("Kimimaro")
								HC.Blend(icon('Hair_Kimimaro-Beads.dmi'),ICON_OVERLAY)

						HairIcon = new/Overlay_Obj(HC,HAIR_LAYER)
						//overlays += HairIcon
				if(!EyeIcon)
					var/icon/E = icon('Eyes_White.dmi')
					var/icon/iris = icon('Eyes_Base.dmi')
					if(IrisColour)
						iris += IrisColour
					E.Blend(iris,ICON_OVERLAY)
					EyeIcon = new/Overlay_Obj(E,EYE_LAYER)

				/*switch(gender)
					if("male")
						I=icon('Boxers.dmi');I.Blend("[rgb(pick(20,40,60,80,100),pick(20,40,60,80,100),pick(20,40,60,80,100))]")
						overlays+=I
					else//if("female")
						var/B=rgb(pick(20,40,60,80,100),pick(20,40,60,80,100),pick(20,40,60,80,100))
						I=icon('Panties.dmi');I.Blend("[B]")
						overlays+=I
						I=icon('Bra.dmi');I.Blend("[B]")
						overlays+=I*/

				for(var/obj/C in contents)
					if(C.worn)
						C.Overlay = new/Overlay_Obj(C.icon,C.layer)
						overlays += C.Overlay//.icon

				if(CurrentHair && CurrentHair != "Bald")
					overlays += HairIcon

				overlays += EyeIcon
		else
			icon = OriginalIcon