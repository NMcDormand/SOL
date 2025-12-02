//--------------------------------------------------------------------------------------------------------
obj/SkillCards/Ninjutsu/BunshinDaibakuha
	icon_state="card_Bunshin Daibakuha"
	cmdstring="BunshinDaibakuha"
	CCost=5000
	Seals=4
	Cooldown = 1000
	DM=1

	Description = list(
		"about"="Causes all currently created bunshin to explode and cause damage to any nearby targets, Note this will damage squad members"
		,"title"="Bunshin Daibakuha"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="B"
		//,"pic"='KageBunshin.png'
		)

	UpgradeChoices = list("Increase Damage","Lower Cost")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals; Bcount=0
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		for(var/mob/Hittable/Command/Clones/K in U.MasterBunshinList)
			if(istype(K,/mob/Hittable/Command/Clones/Bunshin))
				continue
			else
				Bcount++

		if(U.CooldownCheck("BunshinDaibakuha",(CooldownCur*U.cooldownmultiplier)+s,1)) return
		if(!Bcount)
			U<<"You dont currently have any Bunshins created that can explode"
			return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(80)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				if(U.PracticeMode || ControlCheck(U)) return ..()

				orange(4,U)<<"You hear a great Explosion!"
				for(var/mob/Hittable/Command/Clones/K in U.MasterBunshinList)
					if(istype(K,/mob/Hittable/Command/Clones/Bunshin))
						continue
					else
						for(var/mob/M in range(4,K))
							if(M.Creator == U||M.dead)
								continue
							switch(get_dist(K,M))
								if(4)
									M << "The bunshin explosion missed you by the skin of your pants"
								if(3)
									M.DamageMe(U,(U.Ninjutsu*0.2)*DM,"BunshinExplosion",1)
								if(2)
									M.DamageMe(U,(U.Ninjutsu*0.6)*DM,"BunshinExplosion",1)
								if(1)
									M.DamageMe(U,(U.Ninjutsu*1.2,)*DM,"BunshinExplosion",1)
						flick('Explode.dmi',K)
						spawn(2)
							if(K)
								del(K)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()