mob/proc/ChuuninCaps()
	src.Cap_Stamina=150000; src.Cap_Chakra=5000
	src.Cap_Genjutsu=8000; src.Cap_Ninjutsu=8000; src.Cap_Taijutsu=8000
	if(src.Speciality=="Genjutsu") src.Cap_Genjutsu=11000
	else if(src.Speciality=="Ninjutsu") src.Cap_Ninjutsu=11000
	else if(src.Speciality=="Taijutsu") src.Cap_Taijutsu=11000
	else if(src.Speciality=="All round") {src.Cap_Taijutsu=9500; src.Cap_Genjutsu=9500; src.Cap_Ninjutsu=9500}
	src.protect=null; src.ChuuninExit()
	world<<"<font size=2>[src] has just become a Chuunin ranked ninja!</font>"
	src.LevelBonus+=15