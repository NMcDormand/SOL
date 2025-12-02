obj/SkillCards/Clan/Nara/Kagearashi
	icon_state="card_Kagearashi"
	cmdstring="kagearashi"
	Duration = 40
	Cooldown = 3000
	Power = 7
	Range=1
	CCost=20000
	Seals=5

	Description = list(
		"about"="Manipulate your shadow to an enlarged area and assault enemies within."
		,"title"="Kage Arashi no Jutsu"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='Kagemane.png'
		)

	UpgradeChoices = list("Increase Range","Increase Duration")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost;s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("KageArashi",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 2
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			U.icon_state=null
			spawn(15)U.firing=0
			U.JutsuUseChakra(CCost,0.1)
			U.JutsuMessage(Description["title"])
			U.JutsuSeals(s); U.JutsuNin(c*0.1);U.MoveUses[name]++
			if(U.PracticeMode || ControlCheck(U)) return ..()
			U.UsedArashi = 1
			var/Effect/Visual/KageArashi/Pool/KA
			switch(Range)
				if(1)
					KA=new/Effect/Visual/KageArashi/Pool/One(U.loc)
				if(2)
					KA=new/Effect/Visual/KageArashi/Pool/Two(U.loc)
				if(3)
					KA=new/Effect/Visual/KageArashi/Pool/Three(U.loc)
			spawn(-1)
				KA.Owner=U
				var/C
				KA.Duration = Duration
				for(var/mob/M in range(Range,U))
					if(IDCHECK(U,M))
						continue
					else
						var/icon/SS = icon('ShadowStorm.dmi',pick("Spikes1","Spikes2","Spikes3"))
						M.overlays+=SS

						C=JutsuDamage(U.Ninjutsu,M.Ninjutsu,0,0,Power)
						M.DamageMe(U,C,src)

						if(M)
							M.InKageArashi=1
							KA.CaughtList += M
							spawn(Duration)
								if(M)
									M.overlays-=icon('ShadowStorm.dmi',"Spikes1")
									M.overlays-=icon('ShadowStorm.dmi',"Spikes2")
									M.overlays-=icon('ShadowStorm.dmi',"Spikes3")
									M.InKageArashi = 0
				spawn(Duration)
					del KA
					U.UsedArashi = 0
			..()