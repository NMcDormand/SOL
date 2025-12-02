/mob/logging
	proc
		UpdateChar()
			var/obj/I=new/obj
			I.icon=icon
			I.dir=dir
			I.overlays=overlays
			src<<output(I,"CreationBody.grid2:1,1")

	verb
		FinishBodyCreation()
			if(!usr.basename)
				alert(usr,"Please select a body before beginning")
				return
			if(!usr.IrisColour)
				alert(usr,"Please select what colour you would like for your Eyes")
				return
			winshow(usr,"CreationBody",0)
			usr<<output(usr,"Creation.SelfImage")

		SelectHair(CHair as text)
			if(CHair)
				overlays -= HairIcon
				CurrentHair = CHair
				if(CHair != "Bald")
					var/icon/HC = icon(GetHair(CHair))
					if(HairColour)
						HC += HairColour
					switch(CHair)
						if("Temari.dmi")
							HC.Blend(icon('Hair_Temari-Band.dmi'),ICON_OVERLAY)
						if("Shikamaru.dmi" )
							HC.Blend(icon('Hair_Shikamaru-Band.dmi'),ICON_OVERLAY)
						if("Deidara.dmi" )
							HC.Blend(icon('Hair_Deidara-Band.dmi'),ICON_OVERLAY)
						if("Kimimaro.dmi")
							HC.Blend(icon('Hair_Kimimaro-Beads.dmi'),ICON_OVERLAY)

					HairIcon = new/Overlay_Obj(HC,HAIR_LAYER)
					overlays += HairIcon

		HairColor(A as color)
			HairColour = A
			SelectHair(CurrentHair)

		EyeColor(A as color)
			set hidden=1
			usr.overlays -= usr.EyeIcon
			usr.EyeIcon = 0
			var/icon/E=icon('Eyes_White.dmi')
			var/icon/iris=icon('Eyes_Base.dmi')
			if(A)
				usr.IrisColour=A
				iris += IrisColour
			E.Blend(iris,ICON_OVERLAY)
			usr.EyeIcon = new/Overlay_Obj(E,EYE_LAYER)
			usr.overlays += usr.EyeIcon

		.ChangeDir(N as num)
			set hidden=1
			if(N==1)
				dir=NORTH
			else if(N==2)
				dir=SOUTH
			else if(N==3)
				dir=EAST
			else if(N==4)
				dir=WEST

		.SetBody(N as text,G as text)
			set hidden = 1
			basename=N
			switch(basename)
				if("Very Dark") {icon = 'Base_Black.dmi'}
				if("Blue") {icon = 'Base_Blue.dmi'}
				if("Dark") {icon = 'Base_Dark.dmi'}
				if("Green") {icon = 'Base_Green.dmi'}
				if("Lilac") {icon = 'Base_Lilac.dmi'}
				if("Medium") {icon = 'Base_Medium.dmi'}
				if("Pale") {icon = 'Base_Pale.dmi'}
				if("Pallid") {icon = 'Base_Pallid.dmi'}
				if("Pink") {icon = 'Base_Pink.dmi'}
				if("Red") {icon = 'Base_Red.dmi'}
				if("Tan") {icon = 'Base_Tan.dmi'}
				if("Very Pale") {icon = 'Base_White.dmi'}
				if("Yellow") {icon = 'Base_Yellow.dmi'}
				if("Zetsu") {icon = 'Base_Zetsu.dmi';isZetsu=1}
			if(gender=="male")
				overlays-='Boxers.dmi'
			else
				overlays-='Bra.dmi'
				overlays-='Panties.dmi'
			gender=G
			if(gender=="male")
				overlays+='Boxers.dmi'
			else
				overlays+='Bra.dmi'
				overlays+='Panties.dmi'

proc
	GetHair(M)
		var/icon/A
		switch(M)
			if("Afro")
				A='Hair_Afro.dmi'
			if("Deidara")
				A='Hair_Deidara.dmi'
			if("Gaara")
				A='Hair_Gaara.dmi'
			if("Hashirama")
				A='Hair_Hashirama.dmi'
			if("Ino")
				A='Hair_Ino.dmi'
			if("ItachiHair")
				A='Hair_Itachi.dmi'
			if("Jiroubou")
				A='Hair_Jiroubou.dmi'
			if("Kakashi")
				A='Hair_Kakashi.dmi'
			if("Kimimaro")
				A='Hair_Kimimaro.dmi'
			if("Long")
				A='Hair_Long.dmi'
			if("LongCelebrity")
				A='Hair_LongCelebrity.dmi'
			if("LongStraight")
				A='Hair_LongStraight.dmi'
			if("Madara")
				A='Hair_Madara.dmi'
			if("Minato")
				A='Hair_Minato.dmi'
			if("Mohawk")
				A='Hair_Mohawk.dmi'
			if("Naruto")
				A='Hair_Naruto.dmi'
			if("Neji")
				A='Hair_Neji.dmi'
			if("Orochimaru")
				A='Hair_Orochimaru.dmi'
			if("RockLee")
				A='Hair_RockLee.dmi'
			if("Sakura")
				A='Hair_Sakura.dmi'
			if("Sasuke")
				A='Hair_Sasuke.dmi'
			if("Shikamaru")
				A='Hair_Shikamaru.dmi'
			if("Short")
				A='Hair_Short.dmi'
			if("ShortCombed")
				A='Hair_ShortCombed.dmi'
			if("Spiky")
				A='Hair_Spiky.dmi'
			if("Tayuya")
				A='Hair_Tayuya.dmi'
			if("TenTen")
				A='Hair_TenTen.dmi'
			if("Tsunade")
				A='Hair_Tsunade.dmi'
			if("Jiraiya")
				A='Hair_Jiraiya.dmi'
			if("Konan")
				A='Hair_Konan.dmi'
			if("Hidan")
				A='Hair_Hidan.dmi'
			if("Kisame")
				A='Hair_Spike.dmi'
			if("Viole")
				A='Hair_Viole.dmi'
			if("Myst")
				A='Hair_Myst.dmi'
			if("Temari")
				A='Hair_Temari.dmi'
		return A

	GetBody(M)
		var/icon/A
		switch(M)
			if("Base_Black.dmi")
				A='Base_Black.dmi'
			if("Base_Blue.dmi")
				A='Base_Blue.dmi'
			if("Base_Dark.dmi")
				A='Base_Dark.dmi'
			if("Base_Green.dmi")
				A='Base_Green.dmi'
			if("Base_Lilac.dmi")
				A='Base_Lilac.dmi'
			if("Base_Medium.dmi")
				A='Base_Medium.dmi'
			if("Base_Pale.dmi")
				A='Base_Pale.dmi'
			if("Base_Pallid.dmi")
				A='Base_Pallid.dmi'
			if("Base_Pink.dmi")
				A='Base_Pink.dmi'
			if("Base_Red.dmi")
				A='Base_Red.dmi'
			if("Base_Tan.dmi")
				A='Base_Tan.dmi'
			if("Base_White.dmi")
				A='Base_White.dmi'
			if("Base_Yellow.dmi")
				A='Base_Yellow.dmi'
		return A