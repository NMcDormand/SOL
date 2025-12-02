obj/SkillCards/Clan/Yuki/OniKagami
	icon_state="card_MakyouHyoushou"
	cmdstring="OniKagami"
	Range=6
	CCost = 500
	Cooldown = 400
	Duration = 200

	Description = list(
		"about"="Attack your opponent through barrage of available mirrors"
		,"title"="Hyouton: Oni kagami"
		,"type"="Ninjutsu"
		,"Element"="Ice"
		,"weak"="Fire"
		,"rank"="D"
//		,"pic"='MakyouHyoushou.png'
		)

	Activate(mob/U)
		if(U.MirrorCreationMode == 1)
			U.MirrorCreationMode = 0
			U <<"Mirror creation disabled"
		else
			if(U.Cooldowns["OniKagami"]>world.time)
				var/timeLeft = round((U.Cooldowns["OniKagami"]-world.time)/10)

				if(timeLeft >= 60 ) { //Is above 60 seconds...
					var timeLeftSeconds = timeLeft % 60
					var timeLeftMinutes = round(timeLeft / 60)
					U<<"You cannot use this technique for another [timeLeftMinutes] minutes and [timeLeftSeconds] seconds."
				} else {
					U<<"You cannot use this technique for another [timeLeft] seconds."
				}
			if(U.protect)
				U << "You cant create mirrors indoors"
				return
			else
				U.MirrorCreationMode = 1
				U << "You can now create mirrors by clicking where you would like to create it"

	UpgradeChoices = list("Lower Cooldown","Lower Cost","Increase Duration")

turf
	Click()
		..()
		var/mob/player/U = usr
		if(U.MirrorCreationMode)
			if(GENERICATTACKCHECK(U)||U.mirroring||U.Gokusamaisou||U.mirroring)
				return
			if(U.protect)
				U << "You cant create mirrors indoors"
				return
			if(density)
				return
			var/obj/SkillCards/Clan/Yuki/OniKagami/OK = U.OniKagamiCard
			if(!OK)
				OK = locate() in U
				if(!OK)
					U.MirrorCreationMode = 0
					return
			var
				c=OK.CCost; mx=c; s=U.SS*OK.Seals

			if(U.Chakra<=c)
				U << "Not enough Chakra."
				U.MirrorCreationMode = 1
				return

			U.MirrorCreationMode++
			if(U.MirrorCreationMode == 2 && !U.InAMirror)
				var/mob/Hittable/Unresponsive/Inanimate/Break/DemonMirror/DELOLDMIR = 0
				for(var/atom/movable/M in contents)
					if(istype(M,/mob/Hittable/Unresponsive/Inanimate/Break/DemonMirror))
						var/mob/Hittable/Unresponsive/Inanimate/Break/DemonMirror/DM = M
						if(DM.Owner == U)
							if(M in U.AllMirrors)
								U.AllMirrors -= M
								U.MirrorCurrent--
							del M
							U.MirrorCreationMode = 1
							return
						else if(DM.Health > U.StaminaMax * ((U.IceElemental * 0.5) * 0.00025))
							//DM.Owner << "A Mirror was just destroyed by an opponents ice technique"
							DELOLDMIR = DM
						else
							spawn(OK.CooldownCur)
								U.MirrorCreationMode = 1
							return
					else if(M.density)
						spawn(OK.CooldownCur)
							U.MirrorCreationMode = 1
						return
				if(U.MirrorCurrent >= U.MirrorMax)
					U << "Creating more Mirrors are beyond your current ability"
					spawn(OK.CooldownCur)
						U.MirrorCreationMode = 1
					return
				if(U.CooldownCheck("OniKagami",(OK.CooldownCur*U.cooldownmultiplier)+s)) return
				spawn(OK.CooldownCur)
					if(U && U.MirrorCreationMode)
						U.MirrorCreationMode = 1
				U.firing=1
				U.icon_state="seals"
				spawn(s)
					if(U)
						U.firing=0
						U.icon_state=null
						if(OK.ChakraUseCheck()) c *= 2
						if(prob(U.ChakraControl))
							U.JutsuUseChakra(c);
							c *= 0.01
							U.JutsuSeals(s); U.JutsuNin(c); U.ElementalUp("Ice",0.1)
							if(DELOLDMIR)
								del DELOLDMIR

							U.MoveUses["OniKagami"]++
							if(!(U.PracticeMode || OK.ControlCheck(U)))
								var/mob/Hittable/Unresponsive/Inanimate/Break/DemonMirror/DM = new(src,U,0,1,OK.Duration)
								DM.CCost -= round(OK.CCost*0.4)
								if(DM.CCost < 20)
									DM.CCost = 20
								if(!U.AllMirrors)
									U.AllMirrors = list()
								U.AllMirrors += DM
								U.MirrorCurrent++
							if(OK.Level < OK.LevelMax)
								var/XPL = OK.XPLGain * OK.XPMulti
								if(U.DamagedRecently)
									XPL *= 3
								OK.EXP(XPL)
						else
							c-=rand(1,mx/2)
							U.Chakra-=c
							U.RefreshChakra()
							U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"
