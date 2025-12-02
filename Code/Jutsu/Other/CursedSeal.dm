mob/var/tmp/choosingCS=0;
obj/SkillCards/CS/CS_Basic
	icon_state="card_CursedSeal"
	cmdstring="BasicCursedSeal"
	JutsuType = "S-Rank"
	CanLevel = 0

	Description = list(
		"about"="The CS has been imprinted on you. What path will you follow?"
		,"title"="Cursed Seal Selection"
		,"type"="Kinjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
//		,"pic"='HeavenCursedSeal.png'
	)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		if(U.choosingCS) return
		U.choosingCS=1
		switch(input(U,"Choose your curse, what path will you take?","Cursed Seal") as null|anything in list("Heaven", "Earth", "Remove"))
			if("Heaven")
				U.HasSeal="Heaven"
				U<<"<i>You have chosen the Cursed Seal of Heaven!</i>"
				var/obj/SkillCards/Taijutsu/CursedSeal_Earth/J=locate() in U.contents
				var/obj/SkillCards/Ninjutsu/CursedSeal_Heaven/K=locate() in U.contents
				if(!J && !K)
					new/obj/SkillCards/Ninjutsu/CursedSeal_Heaven(U)
					del(src)

			if("Earth")
				U.HasSeal="Earth"
				U<<"<i>You have chosen the Cursed Seal of Earth!</i>"
				var/obj/SkillCards/Taijutsu/CursedSeal_Earth/J=locate() in U.contents
				var/obj/SkillCards/Ninjutsu/CursedSeal_Heaven/K=locate() in U.contents
				if(!J && !K)
					new/obj/SkillCards/Taijutsu/CursedSeal_Earth(U)
					del(src)

			if("Remove")
				if(alert("Are you sure you want to remove the Cursed Mark?","Cursed Seal","Yes", "No") == "Yes")
					U<<"You have removed the seal, but you are still able to get one in the future..."
					U.HasBeenBitten=0
					U.choosing=0
					U.HasSeal=0
					U.choosingCS=0
					del(src)

		U.choosingCS=0;
		return


obj/SkillCards/Ninjutsu/CursedSeal_Heaven
	icon_state="card_CursedSeal"
	cmdstring="HeavenCursedSeal"
	JutsuType = "S-Rank"
	CanLevel = 0

	Description = list(
		"about"="Transform using the Cursed Seal to multiply your Ninjutsu, Genjutsu, and Chakra."
		,"title"="Heaven Cursed Seal"
		,"type"="Kinjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
//		,"pic"='HeavenCursedSeal.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)||U.transing||U.choosing) return
		if(!MultiBuffs && U.InBoost)
			U << "You already using a boost of some kind"
			return
		if(U.CS<1&&U.CooldownCheck("CS",3500*U.cooldownmultiplier)) return
		if(U.CSLevel==1)
			if(U.CS==1)
				U.transing=1;spawn(30) U.transing=0
				U.CS=0; U.Revert(); U<<"<b>You deactivate your Cursed Seal</b>"
			else if(!U.CS)
				U.transing=1; spawn(50)U.transing=0
				U.CS=1; U.CS_1_Heaven(); //U.overlays-='CursedSeal.dmi'
				U<<"<b>You activate your Level One Cursed Seal</b>"

		if(U.CSLevel==2)
			if(U.CS==2)
				U.transing=1; spawn(30) U.transing=null
				U.CS=0; U.Revert(); U<<"<b>You deactivate your Cursed Seal</b>"
			else if(U.CS==1)
				U.choosing=1
				switch(input("","Cursed Seal")in list("Level Two","Deactivate","Cancel"))
					if("Level Two")
						U.choosing=0
						U.transing=1; spawn(50)U.transing=0
						U.CS=2; U.CS_2_Heaven()
						U<<"<b>You activate your Level Two Cursed Seal</b>"
					if("Deactivate")
						U.choosing=0
						U.transing=1; spawn(30)U.transing=0
						U.CS=0; U.Revert(); U<<"<b>You deactivate your Cursed Seal</b>"
					else U.choosing=0
			else if(!U.CS)
				U.transing=1; spawn(50)U.transing=0
				U.CS=1; U.CS_1_Heaven()
				U<<"<b>You activate your Level One Cursed Seal</b>"

obj/SkillCards/Taijutsu/CursedSeal_Earth
	icon_state="card_CursedSeal"
	cmdstring="EarthCursedSeal"
	JutsuType = "S-Rank"
	CanLevel = 0

	Description = list(
		"about"="Transform using the Cursed Seal to multiply your Taijutsu, and Stamina."
		,"title"="Earth Cursed Seal"
		,"type"="Kinjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
//		,"pic"='EarthCursedSeal.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)||U.transing||U.choosing) return
		if(!MultiBuffs && U.InBoost)
			U << "You already using a boost of some kind"
			return
		if(U.CS<1&&U.CooldownCheck("CS",3500*U.cooldownmultiplier)) return
		if(U.CSLevel==1)
			if(U.CS==1)
				U.transing=1;spawn(30) U.transing=0
				U.CS=0; U.Revert(); U<<"<b>You deactivate your Cursed Seal</b>"
			else if(!U.CS)
				U.transing=1; spawn(50)U.transing=0
				U.CS=1; U.CS_1_Earth()
				U<<"<b>You activate your Level One Cursed Seal</b>"

		if(U.CSLevel==2)
			if(U.CS==2)
				U.transing=1; spawn(30) U.transing=null
				U.CS=0; U.Revert(); U<<"<b>You deactivate your Cursed Seal</b>"
			else if(U.CS==1)
				U.choosing=1
				switch(input("","Cursed Seal")in list("Level Two","Deactivate","Cancel"))
					if("Level Two")
						U.choosing=0
						U.transing=1; spawn(50)U.transing=0
						U.CS=2; U.CS_2_Earth()
						U<<"<b>You activate your Level Two Cursed Seal</b>"
					if("Deactivate")
						U.choosing=0
						U.transing=1; spawn(30)U.transing=0
						U.CS=0; U.Revert(); U<<"<b>You deactivate your Cursed Seal</b>"
					else U.choosing=0
			else if(!U.CS)
				U.transing=1; spawn(50)U.transing=0
				U.CS=1; U.CS_1_Earth()
				U<<"<b>You activate your Level One Cursed Seal</b>"