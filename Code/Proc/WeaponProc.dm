mob/proc/infusedweapon(mob/m)
	switch(infused)
		if("Fire") return ((FireElemental-(m.WaterElemental*0.5))*3.5)
		if("Water") return ((WaterElemental-(m.LightningElemental*0.5))*3.5)
		if("Wind") return ((WindElemental-(m.FireElemental*0.5))*3.5)
		if("Earth") return ((EarthElemental-(m.WindElemental*0.5))*3.5)
		if("Lightning") return ((LightningElemental-(m.EarthElemental*0.5))*3.5)

mob/var
	AttackMethod="punch"
mob/proc/Weapons(mob/target)
	if(!target)
		return 0
	var
		dmg=0
		i
	switch(wielding)
		if("Kunai")
			AttackMethod="stabs"
			if(!istype(src,/mob/Hittable/Command/Clones))
				dmg=KnifeSkill*5.5
				if(infused)
					i=infusedweapon(target)
					if(i>0) dmg+=i
				ApplyEXP(2,"knife")

		if("Katana")
			AttackMethod="slices"
			if(!istype(src,/mob/Hittable/Command/Clones))
				if(Class["Sword-Nin"]) dmg=SwordSkill*8.5
				else dmg=SwordSkill*7
				if(infused)
					i=infusedweapon(target)
					if(i>0) dmg+=i
				ApplyEXP(2,"sword")

		if("Jashin Scythe","Scythe")
			AttackMethod="slices"
			if(!istype(src,/mob/Hittable/Command/Clones))
				if(Class["Jashin"]) dmg=ScytheSkill*12.5
				else dmg=ScytheSkill*7
				if(infused)
					i=infusedweapon(target)
					if(i>0) dmg+=i
				ApplyEXP(2,"scythe")

		if("Axe")
			AttackMethod="swings at"
			if(!istype(src,/mob/Hittable/Command/Clones))
				if(Class["Hand2Hand-Nin"])
					dmg=AxeSkill*12.5
				else
					dmg=AxeSkill*7
				if(infused)
					i=infusedweapon(target)
					if(i>0) dmg+=i
				ApplyEXP(2,"axe")

		if("Staff")
			AttackMethod="swings at"
			if(!istype(src,/mob/Hittable/Command/Clones))
				if(Class["Hand2Hand-Nin"]) dmg=StaffSkill*12.5
				else dmg=StaffSkill*7
				if(infused)
					i=infusedweapon(target)
					if(i>0) dmg+=i
				ApplyEXP(2,"staff")

		if("Broad Sword")
			AttackMethod="hacks at"
			if(!istype(src,/mob/Hittable/Command/Clones))
				if(Class["Sword-Nin"]) dmg=SwordSkill*10.5
				else dmg=SwordSkill*9.3
				if(infused)
					i=infusedweapon(target)
					if(i>0) dmg+=i
				ApplyEXP(3,"sword")

		if("Dual Bone Kunais")
			AttackMethod="slashes"
			if(!istype(src,/mob/Hittable/Command/Clones))
				dmg=KnifeSkill*5.8
				ApplyEXP(2,"knife")

		if("Bone Sword")
			AttackMethod="slices"
			if(!istype(src,/mob/Hittable/Command/Clones)	)
				if(Class["Sword-Nin"]) dmg=SwordSkill*11.5
				else dmg=SwordSkill*10
				ApplyEXP(2,"sword")

		if("Spine Whip")
			AttackMethod="whips"
			if(!istype(src,/mob/Hittable/Command/Clones))
				dmg=SwordSkill*14
				ApplyEXP(2,"sword")

		if("Fan")
			AttackMethod="strikes"
			if(!istype(src,/mob/Hittable/Command/Clones))
				if(Class["Fan-Nin"])
					dmg=FanSkill*20
				else
					dmg=FanSkill*5
				ApplyEXP(2,"fan")

		if("Gunbai")
			AttackMethod="strikes"
			if(!istype(src,/mob/Hittable/Command/Clones))
				dmg=FanSkill*20
				ApplyEXP(2,"fan")

		if("Samehada")
			AttackMethod="slashes"
			if(!istype(src,/mob/Hittable/Command/Clones))
				if(Class["Sword-Nin"])
					dmg=SwordSkill*15
					var/ch=target.ChakraMax*0.1
					target.Chakra-=ch;
					target.StatUpdate_chakra()
					Chakra+=(ch)
					StatUpdate_chakra()
					if(Chakra>SetMaxChakra()) Chakra=SetMaxChakra()
					target.Wounds++
				else
					dmg=SwordSkill*5
				ApplyEXP(4,"sword")

		if("Samehada(Unwrapped)")
			AttackMethod="slashes"
			if(!istype(src,/mob/Hittable/Command/Clones))
				if(Class["Sword-Nin"])
					dmg=SwordSkill*25
					var/ch=target.ChakraMax*0.3
					target.Chakra-=ch;
					target.StatUpdate_chakra()
					Chakra+=(ch)
					StatUpdate_chakra()
					if(Chakra>SetMaxChakra())
						Chakra=ChakraMax
					target.Wounds++
				else
					dmg=SwordSkill*10
				ApplyEXP(4,"sword")

		if("Executioner Blade")
			AttackMethod="swings at"
			if(!istype(src,/mob/Hittable/Command/Clones))
				if(Class["Sword-Nin"])
					dmg=SwordSkill*50
					if(target)
						target.Wounds++
						spawn(5)
							if(target)
								target.Wounds+=6
				else
					dmg=SwordSkill*10
				ApplyEXP(4,"sword")

		if("Shibuki")
			AttackMethod="swings at"
			if(!istype(src,/mob/Hittable/Command/Clones))
				if(Class["Sword-Nin"])
					var/DM = SwordSkill*20
					dmg = DM
					target.Wounds++
					spawn(10)
						target.DamageMe(src,DM,"Shibuki")
				else
					dmg=SwordSkill*5
				ApplyEXP(4,"sword")

		if("Nuibari")
			AttackMethod="pierced"
			if(!istype(src,/mob/Hittable/Command/Clones))
				if(Class["Sword-Nin"])
					dmg= SwordSkill*20
					target.Wounds+=6
				else
					dmg=SwordSkill*5
				ApplyEXP(4,"sword")

		else //if(!wielding)
			AttackMethod="strikes"
			if(!istype(src,/mob/Hittable/Command/Clones))
				if(Class["Hand2Hand-Nin"]) dmg=H2HSkill*6
				else dmg=H2HSkill*3
				ApplyEXP(2,"unarmed")
	return round(dmg + (dmg * TMulti))

obj/var/Unbreakable
obj/proc/DamagetoWeapon(var/d,mob/o)
	if(!Unbreakable)
		Durability-=d
		o.UpdateDurabilityMeter()
		Check_Durability(o)
//------------------------

mob/proc/BunshinWeapons(mob/target, BunshinExp=0.2)
	var
		dmg=0
	switch(wielding)
		if("Kunai")
			AttackMethod="stabs"
			dmg=KnifeSkill*1.4
			ApplyEXP(2*BunshinExp,"knife")

		if("Katana")
			AttackMethod="slices"
			if(Class["Sword-Nin"]) dmg=SwordSkill*2.1
			else dmg=SwordSkill*1.7
			ApplyEXP(2*BunshinExp,"sword")

		if("Broad Sword")
			AttackMethod="hacks at"
			if(Class["Sword-Nin"]) dmg=SwordSkill*2.4
			else dmg=SwordSkill*2.1
			ApplyEXP(3*BunshinExp,"sword")

		if("Dual Bone Kunais")
			AttackMethod="slashes"
			dmg=KnifeSkill*1.7
			ApplyEXP(2*BunshinExp,"knife")

		if("Bone Sword")
			AttackMethod="slices"
			if(Class["Sword-Nin"]) dmg=SwordSkill*3.1
			else dmg=SwordSkill*2.5
			ApplyEXP(2*BunshinExp,"sword")

		if("Spine Whip")
			AttackMethod="whips"
			ApplyEXP(2*BunshinExp,"sword")
			dmg=SwordSkill*3.25

		if("Jashin Scythe","Scythe")
			AttackMethod="slices"
			if(Class["Jashin"])
				dmg=ScytheSkill*3.2
			else
				dmg=ScytheSkill*1.2
			ApplyEXP(2*BunshinExp,"scythe")

		if("Axe")
			AttackMethod="swings at"
			if(Class["Hand2Hand-Nin"])
				dmg=AxeSkill*3.2
			else
				dmg=AxeSkill*1.2
			ApplyEXP(2*BunshinExp,"axe")

		if("Staff")
			AttackMethod="swings at"
			if(Class["Hand2Hand-Nin"])
				dmg=StaffSkill*2.7
			else
				dmg=StaffSkill*2
			ApplyEXP(2*BunshinExp,"staff")

		if("Fan")
			AttackMethod="strikes"
			if(Class["Fan-Nin"])
				dmg=FanSkill*3.5
			else
				dmg=FanSkill*2
			ApplyEXP(2*BunshinExp,"fan")

		if("Gunbai")
			AttackMethod="strikes"
			dmg=FanSkill*4
			ApplyEXP(2*BunshinExp,"fan")

		if("Samehada","Samehada(Unwrapped)")
			AttackMethod="slashes"
			if(Class["Sword-Nin"]) dmg=SwordSkill*2.75
			else dmg=SwordSkill*2
			ApplyEXP(4*BunshinExp,"sword")

		if("Executioner Blade", "Shibuki")
			AttackMethod="swings at"
			if(Class["Sword-Nin"]) dmg=SwordSkill*5.75
			else dmg=3.75
			ApplyEXP(4*BunshinExp,"sword")

		if("Nuibari")
			AttackMethod="pierced"
			if(Class["Sword-Nin"])
				dmg = SwordSkill*2.2
			else
				dmg=SwordSkill*1.5
			ApplyEXP(4*BunshinExp,"sword")

		else //if(wielding==null)
			AttackMethod="strikes"
			if(Class["Hand2Hand-Nin"]) dmg=H2HSkill*1.5
			else dmg=H2HSkill*0.9
			ApplyEXP(2*BunshinExp,"unarmed")

	return round(dmg)

mob/proc/NPCWeapons(mob/target, BunshinExp=0.2)
	var
		dmg=0
	switch(wielding)
		if("Kunai")
			AttackMethod="stabs"
			dmg=KnifeSkill*1.4

		if("Katana")
			AttackMethod="slices"
			if(Class["Sword-Nin"]) dmg=SwordSkill*2.1
			else dmg=SwordSkill*1.7

		if("Broad Sword")
			AttackMethod="hacks at"
			if(Class["Sword-Nin"]) dmg=SwordSkill*2.4
			else dmg=SwordSkill*2.1

		if("Dual Bone Kunais")
			AttackMethod="slashes"
			dmg=KnifeSkill*1.7

		if("Bone Sword")
			AttackMethod="slices"
			if(Class["Sword-Nin"]) dmg=SwordSkill*3.1
			else dmg=SwordSkill*2.5

		if("Spine Whip")
			AttackMethod="whips"
			dmg=SwordSkill*3.25

		if("Jashin Scythe","Scythe")
			AttackMethod="slices"
			if(Class["Jashin"])
				dmg=ScytheSkill*3.2
			else
				dmg=ScytheSkill*1.2

		if("Axe")
			AttackMethod="swings at"
			if(Class["Hand2Hand-Nin"])
				dmg=AxeSkill*3.2
			else
				dmg=AxeSkill*1.2

		if("Staff")
			AttackMethod="swings at"
			if(Class["Hand2Hand-Nin"])
				dmg=StaffSkill*2.7
			else
				dmg=StaffSkill*2

		if("Fan")
			AttackMethod="strikes"
			if(Class["Fan-Nin"])
				dmg=FanSkill*3.5
			else
				dmg=FanSkill*2

		if("Gunbai")
			AttackMethod="strikes"
			dmg=FanSkill*4

		if("Samehada","Samehada(Unwrapped)")
			AttackMethod="slashes"
			if(Class["Sword-Nin"]) dmg=SwordSkill*2.75
			else dmg=SwordSkill*2

		if("Executioner Blade", "Shibuki")
			AttackMethod="swings at"
			if(Class["Sword-Nin"]) dmg=SwordSkill*5.75
			else dmg=3.75

		if("Nuibari")
			AttackMethod="pierced"
			if(Class["Sword-Nin"])
				dmg = SwordSkill*2.2
			else
				dmg=SwordSkill*1.5

		else //if(wielding==null)
			AttackMethod="strikes"
			if(Class["Hand2Hand-Nin"]) dmg=H2HSkill*1.5
			else dmg=H2HSkill*0.9

	return round(dmg)