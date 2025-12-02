mob/NPC/Shopkeepers
	Barber
		CantHenge=1
		name = "Barber"
		icon = 'Naruto Bases.dmi'
		icon_state = "barber"
		protect=1
		Action(mob/user)
			if(get_dist(user,src)>2) return
			switch(input("What can I do for you?","Barber")in list("Hair Cut(500)","Skin Tone(1k)","Nothing"))
				if("Hair Cut(500)")
					if(user.gold<500) user<<"[name] says: Hair cuts are 500 gold."
					else {user.gold-=500; user.CreationHair()}
				if("Skin Tone(1k)")
					if(user.gold<1000) user<<"[name] says: Skin tone changes are 1000 gold."
					else
						if(user.ChangeBaseName())
							user.gold-=1000;
							user << "[name] says: I hope you enjoy the new look"
						else
							user << "[name] says: So you changed your mind?"
			user.StatUpdate_gold()

mob/proc
	SpecialHair()
		for(var/obj/Hair/h in src) overlays-=h.icon
		switch(input("Pick a hairstyle.","Special Hairstyle",text)as null|anything in list ("Madara","Minato","Never mind"))
			if("Madara")
				var/clr=input("What colour would you like your hair to be?","Hair Colour") as color
				if(clr)
					var/icon/hairover='Hair_Madara.dmi'
					hairover += clr
					overlays += hairover
					for(var/obj/Hair/h in src) del(h)
					var/obj/Hair/Madara/H=new(src)
					H.icon=hairover; H.worn=1
			if("Minato")
				var/clr=input("What colour would you like your hair to be?","Hair Colour") as color
				if(clr)
					var/icon/hairover='Hair_Minato.dmi'
					hairover += clr
					overlays += hairover
					for(var/obj/Hair/h in src) del(h)
					var/obj/Hair/Minato/H=new(src)
					H.icon=hairover; H.worn=1