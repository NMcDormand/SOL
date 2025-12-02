#if DEBUGGING
mob/verb
	SelfLearnShiFo()
		var/obj/SkillCards/Clan/Clay/ShiFo/J = locate(/obj/SkillCards/Clan/Clay/ShiFo) in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Shi Fo no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Clay/ShiFo(src)
#endif

obj/SkillCards/Clan/Clay/ShiFo
	icon_state="card_ShiFo"
	cmdstring="ShiFo"
	CCost=1600
	ECost = 40
	Seals=8
	Cooldown = 1800

	Description= list(
		"about"="Creates a Huge Doll of Clay clone that explodes, using the skill while a Shi Fo clone already exists will cause it to explode instantly"
		,"title"="Bakuton: Shi Fo"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="Lightning"
		,"rank"="B"
		,"Tutorial" = "After creating a Clone made of explosive clay, it slowly expands in size and if you had a target will move towards this target. <br>Once it has grown to an appropriate size use the skill again to make it explode causing erosion damage over time to anyone nearby.<br>Warning: This clone can be triggered to explode by enemies attacking it before it is ready."
		//,"pic"='Bunshin.png'
		)

	UpgradeChoices = list("Lower Cooldown","Lower Cost")

	Activate(mob/U)
		if(U.ShiFoClone)
			var/mob/Hittable/Command/Clay/Shifo/A = U.ShiFoClone
			if(A.Exploding)
				U << "Shi Fo has already detonated"
			else
				A.goexplode()
			return
		if(U.ClayInfused<ECost)
			U<<"You don't have enough Clay Infused - You have [U.ClayInfused] (Need: [ECost])!"
			return

		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("ShiFo",(CooldownCur*U.cooldownmultiplier)+s,1)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(3)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.ElementalUp("Earth")
				if(U.PracticeMode || ControlCheck(U))
					U.ClayInfused -= ECost
					return ..()
				U.Shifo(ECost)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
			..()

mob
	var
		ClayDet = 0
	proc
		Shifo(C = 20)
			if(!src)
				return
			ClayInfused -= C
			var/mob/Hittable/Command/Clay/Shifo/Y = new/mob/Hittable/Command/Clay/Shifo(get_step(src,dir))
			Y.Creator=src
			Y.dir=SOUTH
			var/icon/IC = icon(icon)
			for(var/A in overlays)
				IC.Blend(icon(A:icon),ICON_OVERLAY)
			Y.ShifoICon=IC
			Y.icon = IC
			ShiFoClone = Y
			if(Targeting)
				walk_to(Y,Targeting,1,4)

		ClayDeteriorate(var/mob/M)
			if(ClayDet)
				return
			var/RD = (Ninjutsu + EarthElemental)*0.2
			ClayDet = 1
			src << "You feel your flesh begin to tear away"
			while(ClayInfection>0)
				if(!M)
					break
				var/ND = M.Ninjutsu/ClayInfection
				if(KO)
					var/CR = rand(1,ClayInfection)
					Wounds += round(CR*0.5)
					ClayInfection -= CR
					sleep(5)
				else if(!M||dead||RaitonArmour||RaitonCurrent)
					ClayInfection = 0
					break
				else if(M)
					var/CR = rand(1,ClayInfection)
					var/CD = (CR * (rand(M.EarthElemental*2,M.EarthElemental*4) + ND)) - RD
					if(CD < 10000)
						CD = rand(10000,15000)
					DamageMe(M,CD,"ClayDeteriorate",0)
					if(prob(30))
						Wounds += CR
					ClayInfection -= CR
					sleep(5)
				else
					break
			ClayDet = 0

	Hittable/Command/Clay
		CantHenge = 1
		Shifo
			density=1
			Grown=32
			var/Exploding=0
			var/HitMe = 10
			New()
				..()
				spawn(4)
					grow()
			DamageMe()
				HitMe--
				if(Grown >= 96)
					goexplode()
				else if(Grown >= 64)
					if(HitMe < 6)
						goexplode()
				else
					if(HitMe <= 0)
						goexplode()
			proc
				goexplode()
					if(!Exploding)
						Exploding = 1
						if(Creator)
							icon = null
							underlays = null
							overlays += icon('AirBurst.dmi')
							icon_state = "C4"
							pixel_x = -64
							pixel_y = -64
							sleep(4)
							invisibility = 100
							density = 0
							var/AddRange = (round(Grown/32)+2)
							var/mob/player/M = Creator
							for(var/i = 1 to 30)
								if(M)
									for(var/mob/A in range(AddRange,src))
										if(A.NinjaRank == "Academy Student")
											continue
										if(istype(A,/mob/Hittable/Responsive/Boss))
											continue
										if(!A.density||A.Intangible||A.RaitonArmour||A.RaitonCurrent||A==Creator)
											continue
										A.ClayInfection += 20
										if(!A.ClayDet)
											A.ClayDeteriorate(M)
									sleep(3)
								else
									break
						spawn(5)
							if(Creator)
								Creator.ShiFoClone = 0
							del src

				grow()
					set waitfor = 0
					if(!src)
						del src
						return
					if(Exploding)
						return
					if(Grown<96)
						Grown+=8
						if(Grown>96)
							Grown=96
						pixel_x-=4
						var/icon/F = icon(ShifoICon,icon_state)
						F.Scale(Grown,Grown)
						icon = F
					sleep(2)
					grow()