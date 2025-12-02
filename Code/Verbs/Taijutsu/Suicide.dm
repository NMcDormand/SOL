mob/Suicide/verb/Suicide()
	set name="Commit Suicide"
	set category="suicide"
	set desc="Forego the chance for rescue and commit suicide"
	if(!usr.KO) usr.verbs-=/mob/Suicide/verb/Suicide
	switch(input("Are you sure you want to die?","Suicide")in list("Yes","No"))
		if("Yes")
			if(usr.KO)
				if(usr.KOfrom) usr.KillMe(usr.KOfrom)
				else usr.KillMe(usr)
			else usr<<"You can't; you're concious!"