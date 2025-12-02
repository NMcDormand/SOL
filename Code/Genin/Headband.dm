#define BANDSTYLES list("Normal","Rock Lee","Temari","Kakashi","Bandana","Neji","Long Tie","Blindfold","Shikamaru")

obj/Clothing
	Head
		Headband
			name="Headband"
			icon='Headband.dmi'
			tradeable=0
			layer=HAT_LAYER
			verb
				ChangeStyle()
					set name="Change Headband Style"
					switch(input("What kind of headband style would you like?","Change Headband Style") as null|anything in BANDSTYLES)
						if("Normal")
							if(worn) usr.overlays-=icon
							if(usr.CurrentHair == "Minato")
								icon='Headband-Minato.dmi'
							else
								icon='Headband.dmi'
							if(worn) usr.overlays+=icon
						if("Rock Lee")
							if(worn) usr.overlays-=icon
							icon='LeeHB.dmi'
							if(worn) usr.overlays+=icon
						if("Temari")
							if(worn) usr.overlays-=icon
							icon='TemariHB.dmi'
							if(worn) usr.overlays+=icon
						if("Kakashi")
							switch(input("Left or Right Style?","Change Headband Style") as null|anything in list("Left","Right"))
								if("Left")
									if(worn) usr.overlays-=icon
									icon='KakashiHBL.dmi'
									if(worn) usr.overlays+=icon
								if("Right")
									if(worn) usr.overlays-=icon
									icon='KakashiHBR.dmi'
									if(worn) usr.overlays+=icon
						if("Bandana")
							if(worn) usr.overlays-=icon
							icon='BandanaHB.dmi'
							if(worn) usr.overlays+=icon
						if("Blindfold")
							if(worn) usr.overlays-=icon
							icon='OverEyesHB.dmi'
							if(worn) usr.overlays+=icon
						if("Long Tie")
							if(worn) usr.overlays-=icon
							icon='LongTieHB.dmi'
							if(worn) usr.overlays+=icon
						if("Neji")
							if(worn) usr.overlays-=icon
							icon='NejiHB.dmi'
							if(worn) usr.overlays+=icon
						if("Shikamaru")
							switch(input("Left or Right Style?","Change Headband Style") as null|anything in list("Left","Right"))
								if("Left")
									if(worn) usr.overlays-=icon
									icon='ShikamaruHBL.dmi'
									if(worn) usr.overlays+=icon
								if("Right")
									if(worn) usr.overlays-=icon
									icon='ShikamaruHBR.dmi'
									if(worn) usr.overlays+=icon