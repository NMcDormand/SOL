mob/proc/GeninCaps()
	src.Cap_Stamina=50000; src.Cap_Chakra=2000
	src.Cap_Genjutsu=2000; src.Cap_Ninjutsu=2000; src.Cap_Taijutsu=2000
	if(src.Speciality=="Genjutsu") src.Cap_Genjutsu=5000
	else if(src.Speciality=="Ninjutsu") src.Cap_Ninjutsu=5000
	else if(src.Speciality=="Taijutsu") src.Cap_Taijutsu=5000
	else if(src.Speciality=="All round") {src.Cap_Taijutsu=3200; src.Cap_Genjutsu=3200; src.Cap_Ninjutsu=3200}
	if(src.Clan=="None") {src.Cap_Stamina=(src.Cap_Stamina/3); src.Cap_Chakra=(src.Cap_Chakra/2.5); src.Cap_Genjutsu=(src.Cap_Genjutsu/2.5); src.Cap_Ninjutsu=(src.Cap_Ninjutsu/2.5); src.Cap_Taijutsu=(src.Cap_Taijutsu/2.5);}
	else if (src.rebirthAmount) {
		var/total = src.rebirthAmount*geninCapRebirth
		src.Cap_Stamina-=(total*5); if(src.Cap_Stamina < 30000) src.Cap_Stamina = 30000;
		src.Cap_Genjutsu-=total; if(src.Cap_Genjutsu < 1800) src.Cap_Genjutsu = 1800;
		src.Cap_Ninjutsu-=total; if(src.Cap_Ninjutsu < 1800) src.Cap_Ninjutsu = 1800;
		src.Cap_Taijutsu-=total; if(src.Cap_Taijutsu < 1800) src.Cap_Taijutsu = 1800;
	}
	src.LevelBonus+=5