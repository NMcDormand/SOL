#if DEBUGGING
mob/verb
	Give_Profession(mob in MasterPlayerList)
		var/A = input("Which Class would you like to give them?","Class") as null|anything in list("Assassin","Fan","Hand2Hand","Jashin","Medical","Sensory","Sword")
		if(A)
			ReAssignProfession("[A]-Nin")
#endif
obj/SkillCards/Class
	JutsuType = "Class"

mob/proc
	ReAssignProfession(var/N)
		if(!Class["None"])
			if(wielding=="Fan")
				var/obj/Item/Class/Fan/FA = locate() in usr
				EquipRemove_Weapon(FA)
			if(wielding=="Hiden Scythe")
				var/obj/Item/Class/Scythe/JS = locate() in usr
				EquipRemove_Weapon(JS)
			for(var/obj/Item/Class/O in contents)
				overlays-=O.icon; overlays -= O.Overlay; O.worn=0; del(O)
			for(var/A in Class)
				if(Class[A])
					Class[A] = 0
					switch(A)
						if("Assassin-Nin")
							KnifeSkill -= 200
							KnifeSkillTrue -= 200
							src<<"<i>-00 from Skill!</i>"
						if("Clay-Nin")
							src<<"<i>-600 Earth Element!</i>"
							EarthElemental-=600
							ClayExMax = ClayMax
							ClayMax = 0
						//if("Sand-Nin")
						//	SandCollected=0
						if("Medical-Nin")
							FirstAidSkill -= 50
							FirstAidSkillTrue -= 50
							src<<"<i>-50 First Aid Skill!</i>"
						if("Sword-Nin")
							SwordSkill -= 200;
							SwordSkillTrue -= 200;
							src<<"<i>-200  Sword Skill!</i>"
							/*var/obj/Weapon/Wield/ExecutionerBlade/X=locate(/obj/Weapon/Wield/ExecutionerBlade) in src
							var/obj/Weapon/Wield/Samehada/x=locate(/obj/Weapon/Wield/Samehada) in src
							if(X) {overlays-=X.icon; del(X)}
							if(x) {overlays-=X.icon; del(X)}*/
							if(wielding=="Executioner Blade"||wielding=="Samehada") wielding=null
						if("Hand2Hand-Nin")
							H2HSkill -= 300;
							H2HSkillTrue -= 300;
							src<<"<i>-300 Hand to Hand Skill !</i>"
						if("Fan-Nin")
							WindElemental-=600
							src<<"<i>-600 Wind Element!</i>"
						//if("Sensory-Nin")
						//if("Jashin")
		Class["None"] = 0
		src<<"You are now a [N]!"
		Class[N] = 1
		Class["Total"]++
		sleep(2)
		switch(N)
			if("Assassin-Nin")
				KnifeSkill+= 200;
				KnifeSkillTrue += 200;
				src<<"<i>+200 Knife Skill!</i>"
				if(!JutsuList["Kakuremino"])
					new/obj/SkillCards/Class/Assassin/Kakuremino(src)
					src<<"<b><font size=2>You've just learned <i>Kakuremino no Jutsu</i>!</b></font>"
			if("Medical-Nin")
				if(!JutsuList["Shousen"])
					new/obj/SkillCards/Class/Medical/Shousen(src)
					src<<"<b><font size=2>You've just learned <i>Shousen</i>!</b></font>"
				FirstAidSkill += 50
				FirstAidSkillTrue += 50
				src<<"<i>+50 First Aid Skill!</i>"
			if("Sword-Nin")
				SwordSkill += 200;
				SwordSkillTrue += 200;
				src<<"<i>+200 Sword Skill!</i>"
				if(!JutsuList["Mikazuki"])
					new/obj/SkillCards/Class/Sword/Mikazuki(src)
					src<<"<b><font size=2>You've just learned <i>Mikazuki no Mai</i>!</b></font>"
			if("Sensory-Nin")
				if(!JutsuList["SenseArea"])
					new/obj/SkillCards/Class/Sensory/SenseArea(src)
					src<<"<b><font size=2>You've just learned how to sense people's chakra!</b></font>"
			if("Hand2Hand-Nin")
				H2HHits=0;
				H2HSkill += 300;
				H2HSkillTrue += 300;
				src<<"<i>+300 Unarmed Skill!</i>"
			if("Fan-Nin")
				WindElemental+=600;
				src<<"<i>+600 Wind Element!</i>"

				if(!JutsuList["Kamaitachi"])
					src<<"<b><font size=2>You've just learned <i>Fuuton: Kamaitachi no Jutsu</i>!</b></font>"
					new/obj/SkillCards/Class/Fan/Kamaitachi(src)
				var/obj/Item/Class/Fan/F = locate() in contents
				if(!F)
					new/obj/Item/Class/Fan(usr); src<<"<i>Fan added to Weapons!</i>"
			if("Jashin")
				if(!JutsuList["Shijihyouketsu"])
					new/obj/SkillCards/Class/Jashin/Shijihyouketsu(src);
					src<<"<b><font size=2>You've just learned <i>Shijihyouketsu the Jashin Ritual</i>!</b></font>"
				if(!JutsuList["DamageSelf"])
					new/obj/SkillCards/Class/Jashin/DamageSelf(src)
					src<<"<b><font size=2>You've just learned <i>Self Damage</i>!</b></font>"
				var/obj/Item/Class/Scythe/JS = locate() in usr
				if(!JS)
					JS = new(usr)
					src<<"<i>Scythe added to Weapons!</i>"