mob/NPC/Roaming
	NinjaRank="Chuunin"
	icon='Base_Medium.dmi'
	taitraining=20
	movespeed=3
	protect=0
	SS=8
	Taijutsu=2400; MTaijutsu=2400
	Ninjutsu=3000; MNinjutsu=3000
	Genjutsu=3000; MGenjutsu=3000
	stamina=10000; mstamina=10000
	ThrowingSkill=50
	KnifeSkill=50
	SwordSkill=50
	layer=4
	WanderingNin

		name="Wandering-Nin"
		InVillage="Roaming"
		New()
			..()
			var/icon/i=pick(AI_IconList)
			var/icon/E = new(i)
			E.Blend('BrownEyes.dmi',ICON_OVERLAY)
			src.icon = E
			new/obj/Clothing/Layer3/Pants(src)
			new/obj/Clothing/Layer3/LongSleeveShirt(src)
			new/obj/Clothing/Layer3/ChuuninVest(src)
			new/obj/Clothing/Layer4/Headband(src)
			for(var/obj/c in src)
				src.WearClothes(c)
			switch(pick(prob(30); 1,prob(20); 2,prob(5); 3,prob(1); 4))
				if(1)
					NinjaRank="ANBU"
					src.MTaijutsu+=rand(15000,20000);src.Taijutsu=src.MTaijutsu
					src.MNinjutsu+=rand(15000,20000);src.Ninjutsu=src.MNinjutsu
					src.MGenjutsu+=rand(15000,20000);src.Genjutsu=src.MGenjutsu
					src.mstamina+=rand(500000,1500000); src.stamina=src.mstamina
					src.ThrowingSkill+=rand(400,600)
					src.movespeed=2
					src.Reflex=50;src.TrueReflex=50
					src.SwordSkill+=rand(100,200)
					src.H2HSkill+=rand(100,200)
					src.KnifeSkill+=rand(100,200)
					src.Chakra=30000; src.mChakra=30000
				if(2)
					NinjaRank="Jounin"
					src.MTaijutsu+=rand(30000,70000);src.Taijutsu=src.MTaijutsu
					src.MNinjutsu+=rand(30000,70000);src.Ninjutsu=src.MNinjutsu
					src.MGenjutsu+=rand(30000,70000);src.Genjutsu=src.MGenjutsu
					src.mstamina+=rand(750000,1600000); src.stamina=src.mstamina
					src.ThrowingSkill+=rand(500,600)
					src.movespeed=1
					src.Reflex=75;src.TrueReflex=75
					src.SwordSkill+=rand(200,250)
					src.H2HSkill+=rand(200,250)
					src.KnifeSkill+=rand(200,250)
					src.Chakra=60000; src.mChakra=60000
				if(3)
					NinjaRank="Kage Level"
					src.MTaijutsu+=rand(80000,150000);src.Taijutsu=src.MTaijutsu
					src.MNinjutsu+=rand(80000,150000);src.Ninjutsu=src.MNinjutsu
					src.MGenjutsu+=rand(80000,150000);src.Genjutsu=src.MGenjutsu
					src.mstamina+=rand(3000000,7000000); src.stamina=src.mstamina
					src.ThrowingSkill+=rand(650,700)
					src.movespeed=1
					src.Reflex=100;src.TrueReflex=100
					src.SwordSkill+=rand(300,400)
					src.H2HSkill+=rand(300,400)
					src.KnifeSkill+=rand(300,400)
					src.Chakra=120000; src.mChakra=120000
				if(4)
					NinjaRank="Retired Village Kage"
					src.MTaijutsu+=rand(100000,300000);src.Taijutsu=src.MTaijutsu
					src.MNinjutsu+=rand(100000,300000);src.Ninjutsu=src.MNinjutsu
					src.MGenjutsu+=rand(100000,300000);src.Genjutsu=src.MGenjutsu
					src.mstamina+=rand(10000000,20000000); src.stamina=src.mstamina
					src.ThrowingSkill+=rand(700,1200)
					src.movespeed=0
					src.Reflex=150;src.TrueReflex=150
					src.SwordSkill+=rand(500,1000)
					src.KnifeSkill+=rand(500,1000)
					src.Chakra=360000; src.mChakra=360000
			switch(pick(1,2,3,4))
				if(1) {src.Speciality="Taijutsu"; src.Taijutsu+=rand(5000,10000)}
				if(2) {src.Speciality="Ninjutsu"; src.Ninjutsu+=rand(5000,10000)}
				if(3) {src.Speciality="Genjutsu"; src.Genjutsu+=rand(5000,10000)}
				if(4) {src.Speciality="All Round"; src.Genjutsu+=rand(3000,6000); src.Ninjutsu+=rand(3000,6000); src.Taijutsu+=rand(3000,6000)}
			switch(pick(1,2))
				if(1) {src.Profession="Sword-Nin"; src.SwordSkill+=rand(500,750)}
				if(2) {src.Profession="Assassin-Nin"; src.KnifeSkill+=rand(500,750)}
			if(src.Profession=="Sword-Nin")
				switch(pick(1,2))
					if(1) {src.overlays+='BroadSword.dmi'; src.wielding="Broadsword"}
					if(2) {src.overlays+='Katana.dmi'; src.wielding="Katana"}
			if(src.Profession=="Assassin-Nin")
				src.overlays+='Kunai.dmi'; src.wielding="Kunai"
			switch(pick(1,2,3,4,5,6,7,8,9))
				if(1)
					Village="Leaf"
					src.FireElemental+=4000
					src.PE="Fire"
					LeafNinList+=src
					if(NinjaRank=="Kage Level")
						src.FireElemental+=6000
					if(NinjaRank=="Retired Village Kage")
						src.FireElemental+=10000
				if(2)
					Village="Mist"
					src.WaterElemental+=4000
					src.PE="Water"
					MistNinList+=src
					if(NinjaRank=="Kage Level")
						src.WaterElemental+=6000
					if(NinjaRank=="Retired Village Kage")
						src.WaterElemental+=10000
				if(3)
					Village="Sound"
					src.FireElemental+=4000
					src.WindElemental+=4000
					src.PE="Fire"
					src.SE="Wind"
					SoundNinList+=src
					if(NinjaRank=="Kage Level")
						src.FireElemental+=6000
						src.WindElemental+=6000
					if(NinjaRank=="Retired Village Kage")
						src.FireElemental+=10000
						src.WindElemental+=10000
				if(4)
					Village="Waterfall"
					src.WaterElemental+=4000
					src.EarthElemental+=4000
					src.PE="Water"
					src.SE="Earth"
					WaterfallNinList+=src
					if(NinjaRank=="Kage Level")
						src.WaterElemental+=6000
						src.EarthElemental+=6000
					if(NinjaRank=="Retired Village Kage")
						src.WaterElemental+=10000
						src.EarthElemental+=10000
				if(5)
					Village="Rock"
					src.EarthElemental+=4000
					src.PE="Earth"
					RockNinList+=src
					if(NinjaRank=="Kage Level")
						src.EarthElemental+=6000
					if(NinjaRank=="Retired Village Kage")
						src.EarthElemental+=10000
				if(6)
					Village="Rain"
					src.WaterElemental+=4000
					src.WindElemental+=4000
					src.PE="Water"
					src.SE="Wind"
					RainNinList+=src
					if(NinjaRank=="Kage Level")
						src.WaterElemental+=6000
						src.WindElemental+=6000
					if(NinjaRank=="Retired Village Kage")
						src.WaterElemental+=10000
						src.WindElemental+=10000
				if(7)
					Village="Grass"
					src.EarthElemental+=4000
					src.FireElemental+=4000
					src.PE="Earth"
					src.SE="Fire"
					GrassNinList+=src
					if(NinjaRank=="Kage Level")
						src.EarthElemental+=6000
						src.FireElemental+=6000
					if(NinjaRank=="Retired Village Kage")
						src.EarthElemental+=10000
						src.FireElemental+=10000
				if(8)
					Village="Sand"
					src.WindElemental+=4000
					src.PE="Wind"
					SandNinList+=src
					if(NinjaRank=="Kage Level")
						src.WindElemental+=6000
					if(NinjaRank=="Retired Village Kage")
						src.WindElemental+=10000
				if(9)
					Village="Cloud"
					src.FireElemental+=4000
					src.WindElemental+=4000
					src.PE="Fire"
					src.SE="Wind"
					CloudNinList+=src
					if(NinjaRank=="Kage Level")
						src.FireElemental+=6000
						src.WindElemental+=6000
					if(NinjaRank=="Retired Village Kage")
						src.FireElemental+=10000
						src.WindElemental+=10000
/*				if(src.wielding=="ElementalBroadsword"||src.wielding=="ElementalKunai"||src.wielding=="ElementalKatana")
				src.infused="[src.PE]"
				if(src.wielding=="ElementalBroadsword")
					src.wielding="Broadsword"
				if(src.wielding=="ElementalKunai")
					src.wielding="Kunai"
				if(src.wielding=="ElemenatalKatana")
					src.wielding="Katana"
*/
			src.SS-=rand(0,7)
			if(!src.respawn) src.respawn=src.loc
			spawn(250) Wander_Sentry()
			src.AssignRandomHair(pick(0,50,150),pick(0,50,150),pick(0,100,150))
			var/obj/Hair/h = locate() in src; if(h&&h.worn) src.overlays+=h.icon