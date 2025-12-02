obj/SkillCards/Clan/Uchiha/MS/EyeSwap
	icon_state="card_EyeSwap"
	cmdstring="EyeSwap"
	CCost=0
	Seals=0
	Duration = 0
	Cooldown = 0
	CanLevel = 0
	var/Offered

	Description = list(
		"about"="Swap Eyes with another Uchiha clan member who also has the Mangekyou Sharingan, this can only be offered once per Uchiha member"
		,"title"="Swap Eyes"
		,"type"="Surgical"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="?"
//		,"pic"='Dispel.png'
	)

	Activate(mob/U)
		if(Offered)
			return
		Offered = 1
		var/list/aList = list()
		for(var/mob/player/J in view(usr,1))
			if(J == U)
				continue
			if(J.Clan=="Uchiha" && J.HasMangekyou && !J.SharType2)
				aList+=J
		var/mob/M
		if(aList.len)
			M=input("Who are you offering to swap with?","Aim") as null|anything in aList
		if(M)
			if(alert(M,"[U.name] has offered to swap eyes with you, will you accept? note you will not be able to do this again","EyeSwap","Accept","Reject") == "Reject")
				U << "[M.name] has rejected your offer"
				Offered = 0
			else
				var/IC = U.IrisColour
				var/MC = U.MangekyouCooldown
				var/SC = U.SharinganCooldown

				U.IrisColour = M.IrisColour
				U.SharType2 = U.SharType
				U.SharType = M.SharType
				U.MangekyouCooldown = M.MangekyouCooldown
				U.SharinganCooldown = M.SharinganCooldown

				var/obj/SkillCards/Clan/Uchiha/MangekyouSharingan/J1 = locate() in U.contents
				var/obj/SkillCards/Clan/Uchiha/MangekyouSharingan/J2 = locate() in M.contents

				J1.loc = M
				J2.loc = U

				U.UpdateInventory()
				M.UpdateInventory()

				M.IrisColour = IC
				M.SharType2 = M.SharType
				M.SharType = U.SharType2
				M.MangekyouCooldown = MC
				M.SharinganCooldown = SC

				M.EternalSharingan = 1
				U.EternalSharingan = 1

				M.overlays -= M.EyeIcon
				M.overlays += U.EyeIcon

				U.overlays -= U.EyeIcon
				U.overlays += M.EyeIcon

				U.EyeIcon = null
				M.EyeIcon = null


				M << "You have now swapped eyes with [U.name], and unlocked the Eternal Mangekyou Sharingan"
				U << "You have now swapped eyes with [M.name], and unlocked the Eternal Mangekyou Sharingan"

				var/obj/SkillCards/Clan/Uchiha/MS/EyeSwap/JE = locate() in M.contents
				del JE
				del src

		else
			Offered = 0