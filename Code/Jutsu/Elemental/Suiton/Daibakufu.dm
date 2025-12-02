obj/SkillCards/Ninjutsu/Suiton/Daibakufu
	icon_state="card_daibakufu"
	cmdstring="Daibakufu"
	Range=8
	CCost=120
	Seals=7
	Cooldown = 610
	Size = 1

	Description = list(
		"about"="Send a giant wave at opponents."
		,"title"="Suiton: Daibakufu"
		,"type"="Ninjutsu"
		,"Element"="Fire"
		,"weak"="Lightning"
		,"rank"="B"
//		,"pic"='Daibakufu.png'
	)

	UpgradeChoices = list("Lower Cost","Lower Cooldown","Increase Size")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		if(!U.onwater && U.WaterElemental < SuitonOnEarthCheck && usr.Clan!="Yuki") {U<<"<b>You need to be on water to execute this jutsu</b>."; return}
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Daibakufu",(CooldownCur*U.cooldownmultiplier)+s)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(2)U.firing=0
			U.icon_state=null
			//if(U.dir==NORTHWEST||U.dir==SOUTHWEST||U.dir==NORTHEAST||U.dir==SOUTHEAST) return
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.ElementalUp("Water")
				if(U.PracticeMode || ControlCheck(U)) return ..()
				var/DC = 90
				if(U.dir==NORTHWEST||U.dir==SOUTHWEST||U.dir==NORTHEAST||U.dir==SOUTHEAST)
					DC = 135
				var
					DIR1 = turn(U.dir,DC)
					DIR2 = turn(U.dir,-DC)
					turf/A = U.loc
					turf/B = U.loc
					AStop = 0
					BStop = 0

				var/obj/Jutsu/Suiton/Daibakufu/Daibakufu1/D1=new(U.loc)
				NewProjectile(U,D1,src,1,2.9,D1.loc)
				for(var/i=1 to Size)
					if(AStop && BStop)
						break
					if(!AStop)
						var/turf/A2 = get_step(A,DIR1)
						if(A2 && !A2.density)
							var/obj/Jutsu/Suiton/Daibakufu/Daibakufu1/D2=new(A2)
							NewProjectile(U,D2,src,1,2.9,A2)
							if(i == Size)
								D2.icon_state = "h1"
							else
								A = A2
						else
							AStop = 1
					if(!BStop)
						var/turf/B2 = get_step(B,DIR2)
						if(B2 && !B2.density)
							var/obj/Jutsu/Suiton/Daibakufu/Daibakufu1/D3=new(B2)
							NewProjectile(U,D3,src,1,2.9,B2)
							if(i == Size)
								D3.icon_state = "h3"
							else
								B = B2
						else
							BStop = 1

				/*if(Size>1)
					var/obj/Jutsu/Suiton/Daibakufu/Daibakufu1/D4=new(get_step(D2,turn(U.dir,DC)))
					var/obj/Jutsu/Suiton/Daibakufu/Daibakufu1/D5=new(get_step(D3,turn(U.dir,-DC)))
					NewProjectile(U,D4,src,1,2.9,D4.loc)
					NewProjectile(U,D5,src,1,2.9,D5.loc)
					if(Size>2)
						var/obj/Jutsu/Suiton/Daibakufu/Daibakufu1/D6=new(get_step(D4,turn(U.dir,DC)))
						var/obj/Jutsu/Suiton/Daibakufu/Daibakufu1/D7=new(get_step(D5,turn(U.dir,-DC)))
						NewProjectile(U,D6,src,1,2.9,D6.loc)
						NewProjectile(U,D7,src,1,2.9,D7.loc)
						if(Size>3)
							var/obj/Jutsu/Suiton/Daibakufu/Daibakufu1/D8=new(get_step(D6,turn(U.dir,DC)))
							var/obj/Jutsu/Suiton/Daibakufu/Daibakufu1/D9=new(get_step(D7,turn(U.dir,-DC)))
							NewProjectile(U,D8,src,1,2.9,D8.loc)
							NewProjectile(U,D9,src,1,2.9,D9.loc)*/
				/*spawn(11)
					for(var/obj/Jutsu/Suiton/Daibakufu/T in U.TailList)
						if(T)
							del(T)*/
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()