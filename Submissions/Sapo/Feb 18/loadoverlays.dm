mob
	proc
		loadoverlays()
			underlays=null
			overlays=null
			if(client)icon='Base_Tan.dmi'
			else icon=originalicon
			icon_state=""
			if(onwater)overlays+='WaterWalk.dmi'
			if(swimming)icon_state="swim"
			if(resting||meditate)icon_state="rest"
			if(infusing&&!inseals)icon_state="block"
			if(shikeiseppun)
				icon+=rgb(155,1,1)
			if(KO)
				if(onwater||swimming)invisibility=9
				else icon_state="KO"
			if(inbed)
				invisibility=0
				dir=SOUTH
			if(AFK)overlays+='AFK.dmi'
			if(inseals)icon_state="seals"
			if(InMeatTank)
				icon='meattank.dmi'
				var/icon/F = icon(icon,icon_state)
				F.Scale(92,92)
				icon = F
				pixel_x=-32
			if(InMeatTankHari)
				icon='spikedmeattank.dmi'
				var/icon/F = icon(icon,icon_state)
				F.Scale(92,92)
				icon = F
				pixel_x=-32
			if(ingreen)overlays+='3rd-Gate.dmi'
			if(inyellow)overlays+='5th-Gate.dmi'
			if(inred)
				overlays+='8th-Gate.dmi'
				overlays+='aki_wings.dmi'
			if(karori)overlays+='aki_wings.dmi'
			if(RaitonYoroi)overlays+='lightningreleasearmor.dmi'
			if(nagashi)overlays+='lightning stun.dmi'
			if(Giant)
				var/icon/F = icon(icon,icon_state)
				F.Scale(92,92)
				icon = F
				pixel_x=-16
			for(var/obj/R in contents)
				if(R.worn)
					if(!Giant)
						var/icon/J=icon(R.icon,R.icon_state)
						J.Scale(32,32)
						R.icon=J
						overlays+=R.icon
					else
						var/icon/J=icon(R.icon,R.icon_state)
						J.Scale(92,92)
						R.icon=J
						overlays+=R.icon