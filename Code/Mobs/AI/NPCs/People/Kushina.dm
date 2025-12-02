mob/Hittable/Responsive/Boss/Kushina
	name="Kushina Uzumaki"
	icon='Base_Pale.dmi'
	Village="Event"
	NinjaRank="Red Hot-Blooded Habanero"
	WW = 1
	Level = 8000
	Taijutsu=905000
	Ninjutsu=405000
	Genjutsu=605000
	TaijutsuMax=905000
	NinjutsuMax=405000
	GenjutsuMax=605000
	Stamina=950000000
	StaminaMax=950000000
	ChakraMax=8000000
	WindElemental=100000
	FireElemental=1000000
	LightningElemental=100000
	WaterElemental=100000
	EarthElemental=100000
	VillageColour = "#e92106"
	Reflex=180
	ReflexTrue=180
	gender="female"
	movespeed=1
	atkspeed=4
	protect=0
	HasHiraishin = 1
	EvadeChance = 10
	BunshinLimit = 16

	Action(mob/user)
		if(get_dist(user,src)>2) return
		var/msg = ""
		switch(pick(1,2,3,4,5,6))
			if(1)
				msg += "Anybody who called me tomato...well, I just turned them into smashed tomatoes. That's how I got my other nickname - The Red-Hot Habanero!"
			if(2)
				msg += "I won, I won! Score one for Lady Kushina!"
			if(3)
				msg += "At that moment, Minato was a great ninja in my eyes. He was the man of my dreams. He changed me. This red hair that I used to hate brought me the man of my destiny. And it became the 'red thread of fate.' After that I learned to love my red hair. And... I fell in love with Minato."
			if(4)
				msg += "I used to really hate my red hair, but since that incident, I liked it. Thanks to Minato."
			if(5)
				msg += "If only my hair looked like that girl's from the tower... what was her name?"
			if(6)
				msg += "Yen... something what was his name?"

		hearers(src, 6)<<output("<b><font face=verdana color=\"[VillageColour]\">[src]</font> says:</b> [msg]", "Chat")

	New()
		//del src
		//return
		overlays += icon('Headband.dmi')
		var/icon/A = icon('Hair_Kushina.dmi')
		overlays += A
		A = icon('Eyes_Base.dmi')
		A += rgb(0,0,75)
		overlays += A
		overlays += icon('Shoes.dmi')
		overlays += icon('Pants.dmi')
		A = icon('LShirt.dmi')
		A += rgb(160,160,120)
		overlays += A
		overlays += icon('Jounin_Leaf.dmi')
		respawn=loc
		if(!SpecialMobs["Kushina"])
			SpecialMobs["Kushina"] = src