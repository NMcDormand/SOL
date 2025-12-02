mob/var/isSub=0 //For now, we will use this to allow everyone to have it
obj
	Item
		Icon_Scroll
			icon = 'scrolls.dmi'
			icon_state = "Icon_Scroll"
			trueName = "Icon Scroll"
			Stackable = 1
			var/Locked = 0
			rare = 0
			Drop()
				set src in usr.contents
				if(Locked)
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
mob/NPC/Shopkeepers
	SubscriberShop
		name = "Icon Uploader"
		//icon = 'Base_Pale.dmi'
		icon = 'Naruto Bases.dmi'
		icon_state = "shopkeeper"
		CantHenge=1
		protect=1
		//New()
			//new/obj/Clothing/Shirt/LongSleeveShirt(src)
			//new/obj/Clothing/Pants/Pants(src)
			//new/obj/Clothing/Feet/Sandals(src)
			//new/obj/Clothing/Over/Akatsuki_Cloak(src)
			//for(var/obj/c in src) WearClothes(c)
		Action(mob/user)
			if(get_dist(user,src)>2) return
			if(!Sub_Shop_Available) return
			//return //Temporary Return
			if(user.isSub) return //Reverse this logic later so that only subs can use this!
			switch(alert("What would you like to do?","What do?","Buy Icon","Test Icon","Cancel"))
				if("Test Icon")
					switch(alert("Uploaded icons will be saved to the server by agreeing you hereby grant permission for developers of Shinobi of Myth to use the icon. you also agree to relinquish your right to have it removed","Upload Icon","I Agree","Nevermind"))
						if("I Agree")
							var/upload = input(user,"*ATTENTION* \nPlease ensure you are using the correct file type. \n32x32 icons only. Nothing considered rude or offensive!","Icon") as file
							//Check to see if it is the correct file type
							var/filename = "[upload]"
							if(filename=="") {user<<"This icon might be corrupt. Please try saving it under a new name!"; return;}
							var/file_ext = lowertext(copytext(filename, max(length(filename)-3,1)))
							if(file_ext != ".dmi")
								user<<"Invalid file extension. File must be a DMI."
								return

							var/icon/newIcon = new(upload)

							//Check the width/height of the icon file
							if(newIcon.Width()==0||newIcon.Height()==0) {user<<"This icon might be corrupt. Please try saving it under a new name!"; return;}
							else if(newIcon.Width()!=32 && newIcon.Height()!=32)
								user<<"Please ensure your icon is 32x32. \nYour icon currently has a width of [newIcon.Width()] and a height of [newIcon.Height()]."
								return

							//Upload a copy to the server
							uploadFileToServer(upload, user.ckey)
							//Set src to icon
							var/obj/final = new/obj/Clothing/Custom/TestOutfit(user,user);
							var/A = input("What would you like to name this icon?","Icon Name") as text
							if(!A || A == "")
								final.name = "Uploaded Icon"
								//final.trueName = "Uploaded Icon"
							else
								final.name = A
								//final.trueName = A
							final.icon = newIcon
							user<<"Icon Approved, please check your inventory."
							//icon = newIcon
				if("Buy Icon")
					var/obj/Item/Icon_Scroll/I = locate() in user
					if(I)
						I.Locked=1
						switch(alert("Would you like to trade 1 Icon Scroll for an icon?","Upload Icon","Yes","No"))
							if("Yes")
								switch(alert("Uploaded icons will be saved to the server by agreeing you hereby grant permission for developers of Shinobi of Myth to use the icon. you also agree to relinquish your right to have it removed","Upload Icon","I Agree","Nevermind"))
									if("I Agree")
										if(I && I.loc == user)
											var/upload = input(user,"*ATTENTION* \nPlease ensure you are using the correct file type. \n32x32 icons only. Nothing considered rude or offensive!","Icon") as file
											//Check to see if it is the correct file type
											var/filename = "[upload]"
											if(filename=="") {user<<"This icon might be corrupt. Please try saving it under a new name!"; return;}
											var/file_ext = lowertext(copytext(filename, max(length(filename)-3,1)))
											if(file_ext != ".dmi")
												user<<"Invalid file extension. File must be a DMI."
												I.Locked=0
												return


											var/icon/newIcon = new(upload)

											//Check the width/height of the icon file
											if(newIcon.Width()==0||newIcon.Height()==0) {user<<"This icon might be corrupt. Please try saving it under a new name!";I.Locked=0; return;}
											else if(newIcon.Width()!=32 && newIcon.Height()!=32) {user<<"Please ensure your icon is 32x32. \nYour icon currently has a width of [newIcon.Width()] and a height of [newIcon.Height()].";I.Locked=0; return;}

											//Upload a copy to the server
											uploadFileToServer(upload, user.ckey)
											//Set src to icon
											var/obj/final = new/obj/Clothing/Custom/UploadedOutfit(user);
											var/A = input("What would you like to name this icon?","Icon Name") as text
											if(!A || A == "")
												final.name = "Uploaded Icon"
												//final.trueName = "Uploaded Icon"
											else
												final.name = A
												//final.trueName = A
											final.icon = newIcon
											user<<"Icon Approved, please check your inventory."
											usr<<"I will be taking that scroll now, thank you"
											if(I.amount >1)
												I.amount--
											else
												del I
											//icon = newIcon
										else
											user << "I dont know what you are playing at but your Scroll Vanished"
											return
					else
						user << "You dont seem to have any Icon Scrolls to trade"
						return

proc/uploadFileToServer(var/upload, var/userCkey)
	var/attempts=0
	var/filename = "[upload]"
	var/origName = copytext(filename, 1,-4)

	var/file_ext = lowertext(copytext(filename, max(length(filename)-3,1)))
	var/file_size = length(upload)

	if(file_size > 10485760) //If above 10MB, don't bother saving...
		return

	TryAgain
	//If the name is already taken, add a number and try again
	if(attempts) filename="[origName]([attempts])[file_ext]"

	//Check if the file name already exists
	if(fexists("UploadedIcons/[userCkey]/[filename]"))
		attempts++; goto TryAgain;

	//Save icon to server
	fcopy(upload,"UploadedIcons/[userCkey]/[filename]")