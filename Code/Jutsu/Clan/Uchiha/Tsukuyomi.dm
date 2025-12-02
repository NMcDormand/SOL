obj/SkillCards/Clan/Uchiha/MS/Tsukuyomi
	icon_state="card_Tsukuyomi"
	cmdstring="Tsukuyomi"
	Range=1
	CCost = 9000
	Cooldown = 3000
	Seals=1
	AOE = 0
	Duration = 2

	Description = list(
		"about"="Look your opponent in the face and trap them in an illusion where you control time and space, at their peril"
		,"title"="Tsukuyomi"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
//		,"pic"='Tsukuyomi.png'
	)

	UpgradeChoices = list("Increase Duration","Create Area Effect")

	Activate(mob/U)
		if(!U.InMangekyou) {U<<"You must activate Mangekyou Sharingan first"; return}
		if(GENERICATTACKCHECK(U)) return

		//var/turf/T = U.loc
		var/list/Victims = list()
		if(AOE)
			for(var/mob/M in view(Range,U))
				if(IDCHECK(U,M)||istype(M,/mob/Hittable/Unresponsive/Training)||istype(M,/mob/Hittable/Unresponsive/Inanimate)||istype(M,/mob/Hittable/Responsive/Boss/Madara))
					continue
				else if(M.InIllusion)
					continue
				else if(M.Blind||M.IsBlinded)
					continue
				else
					if(M.x < U.x && (M.dir == EAST||M.dir == NORTHEAST||M.dir == SOUTHEAST))
						Victims += M
					else if(M.x > U.x && (M.dir == WEST||M.dir == NORTHWEST||M.dir == SOUTHWEST))
						Victims += M
					else if(M.y < U.y && (M.dir == NORTH||M.dir == NORTHWEST||M.dir == NORTHEAST))
						Victims += M
					else if(M.y > U.y && (M.dir == SOUTH||M.dir == SOUTHWEST||M.dir == SOUTHEAST))
						Victims += M
		else
			for(var/mob/M in get_step(U,U.dir))
				if(IDCHECK(U,M)||istype(M,/mob/Hittable/Unresponsive/Training)||istype(M,/mob/Hittable/Unresponsive/Inanimate)||istype(M,/mob/Hittable/Responsive/Boss/Madara))
					continue
				else if(M.InIllusion)
					U << "[M] is already under the influence of a mind altering genjutsu"
					return
				else if(M.Blind||M.IsBlinded)
					U << "[M] was unable to see the genjutsu and remains unaffected"
					return
				else
					if(M.dir==get_dir(M,U))
						Victims += M
		if(Victims.len)
			var
				c=CCost; mx=c
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("Tsukuyomi",Cooldown*U.cooldownmultiplier)) return
			if(ChakraUseCheck()) c *= 4
			if(prob(U.ChakraControl))
				U.JutsuUseChakra(c)
				U.JutsuMessage(Description["title"])
				U.JutsuGen(c/2)
				U.MoveUses[name]++

				if(U.PracticeMode || ControlCheck(U)) return ..()
				U.attacking=1
				U.InTsukuyomi=1
				spawn(5)
					if(U.InTsukuyomi)
						U.InTsukuyomi = 0
				//---Land Visuals---
				var/list/TsuVis = list()
				for(var/turf/A in view(13,U))
					if(get_dist(A,U)<10)
						var/image/C=image(/obj/Jutsu/Uchiha/Tsukuyomi/T1,A,MOB_LAYER-2)
						TsuVis += C
					else
						var/image/C=image(/obj/Jutsu/Uchiha/Tsukuyomi/T2,A,MOB_LAYER-2)
						TsuVis += C

				for(var/mob/M in Victims)
					var/image/C=image(/obj/Jutsu/Uchiha/Tsukuyomi/Totem,M,MOB_LAYER-1)
					TsuVis += C
					C=image(M,M,MOB_LAYER,dir=2)
					TsuVis += C

				for(var/mob/M in Victims)
					spawn(-1)
						if(M.kaiten||M.protect||M.frozen||istype(M,/mob/Hittable/Responsive/Boss/Viole)||istype(M,/mob/Hittable/Responsive/Boss/Madara))
							continue
						var/freezetime = U.Genjutsu-M.Genjutsu
						freezetime*=(Duration*0.01)

						if(M.InMangekyou||M.InSharingan)
							if(M.InMangekyou)
								freezetime*=0.6
							else if(M.InSharingan)
								var/x=1-(U.SharinganLevel * 0.1)
								freezetime*=x

						if(freezetime<20) freezetime=20
						if(freezetime>350) freezetime=350

						if(istype(M,/mob/Hittable/Responsive)&&!(U in M.HitList))
							M.HitList+=U

						var/FT=freezetime*0.1
						M.frozen=1
						M.Tsukuyomi=1
						M.InIllusion=1
						if(M.client)
							for(var/image/I in TsuVis)
								M<<I
								M.TsukuImages += I
						M.TsukuyomiHurt(U,FT,Range)

				if(!U.EternalSharingan && prob(105-Level))
					U.BlindMe("Tsukuyomi")
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

mob
	var
		tmp/list/TsukuImages = list()
		tmp/list/TsuSelf = list()
	proc
		TsukuyomiHurt(mob/U,FT,R)
			set waitfor = 0
			while(FT && U && src)
				if(!KO)
					if(get_dist(U,src) <= R && frozen)
						FT--
						DamageMe(U,U.Genjutsu*1.3,"tsukuyomi")
						sleep(5)
					else
						U<<"<b>[src] is free from your Tsukuyomi!</b>"
						src<<"<b>You break out of [U]'s Tsukuyomi.</b>"
						break
				else
					break

			InIllusion=0
			frozen=0
			Tsukuyomi=0
			if(client)
				for(var/image/I in TsukuImages)
					TsukuImages -= I
					del I
			if(U)
				U.attacking=0
				U.InTsukuyomi=0

		RemoveT(image/I)
			while(Tsukuyomi)
				sleep(10)
			del(I)
		RemoveS(image/I)
			while(frozen)
				sleep(10)
			del(I)
		RemoveCamo(image/i,mob/P)
			while(P)
				sleep(5)
			if(P&&P.icon)
				del i
