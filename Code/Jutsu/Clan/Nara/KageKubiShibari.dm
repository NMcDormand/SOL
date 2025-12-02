obj/SkillCards/Clan/Nara/KageKubiShibari
	icon_state="card_KageKubiShibari"
	cmdstring="KageKubiShibari"
	DM = 3
	CCost= 300
	Seals = 3
	Cooldown = 2500

	Description = list(
		"about"="Strangle any enemy held by your shadow manipulation."
		,"title"="Kage Kubi Shibari"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='KageKubiShibari.png'
		)

	UpgradeChoices = list("Increase Damage")

	Activate(mob/U)
		if(!U.ShadowList.len)
			U << "There are no targets bound by your shadow"
			return
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.CooldownCheck("neckbind",(CooldownCur*U.cooldownmultiplier)+s,1)) return
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(40)U.firing=0
			if(U.PracticeMode || ControlCheck(U))
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s); U.JutsuUseChakra(c); U.JutsuNin(c)
				U.MoveUses[name]++
				return ..()
			if(U.ShadowList.len>1)
				var/mob/bind=input("Use on who?","Kage Kubi Shibari no Jutsu") as null|anything in list("All")+U.ShadowList
				if(bind)
					if(bind == "All")
						if(prob(U.ChakraControl))
							U.JutsuMessage(Description["title"])
							U.JutsuSeals(s); U.JutsuUseChakra(c); U.JutsuNin(c)
							U.MoveUses[name]++
							for(var/mob/T in U.ShadowList)
								spawn()
									U<<"You extend your shadow around [T]'s neck..."
									T<<"A shadow creeps round your neck..."
									T.overlays+='Neck-Bind.dmi'
									NeckBind(U,T,DM)
						else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()
					else
						if(prob(U.ChakraControl))
							U.JutsuMessage(Description["title"])
							U.JutsuSeals(s); U.JutsuUseChakra(c); U.JutsuNin(c)
							U.MoveUses[name]++
							U<<"You extend your shadow around [bind]'s neck..."
							bind<<"A shadow creeps round your neck..."
							bind.overlays+='Neck-Bind.dmi'
							NeckBind(U,bind,DM)
						else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()
				else
					U.Cooldowns -= "neckbind"
					return
			else
				for(var/mob/bind in U.ShadowList)
					if(prob(U.ChakraControl))
						U.JutsuMessage(Description["title"])
						U.JutsuSeals(s); U.JutsuUseChakra(c); U.JutsuNin(c)
						U.MoveUses[name]++
						U<<"You extend your shadow around [bind]'s neck..."
						bind<<"A shadow creeps round your neck..."
						bind.overlays+='Neck-Bind.dmi'
						NeckBind(U,bind)
					else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

proc
	NeckBind(mob/U,mob/M,DM=3)
		set waitfor = 0
		while(U && !U.KO && M && !M.KO && (M in U.ShadowList))
			if(U.Chakra<40)
				break
			U.Chakra-=40
			U.RefreshChakra()

			var/dmg=round((U.Ninjutsu*DM)-((M.Ninjutsu*0.1)+(M.Taijutsu*1.5)))
			if(dmg<1)
				dmg=1
			if(dmg<50)
				U <<"Your Neck Bind massages [M] with [dmg] damage.";
				M<<"[U]'s Neck Bind gives you a nice massage worth [dmg] damage"
			else
				U <<"Your Neck Bind does [dmg] damage to [M]";
				M<<"[U]'s Neck Bind does [dmg] damage to you."
			M.DamageMe(U,dmg,"neck bind",1)
			sleep(20)

		if(U.Chakra<0)
			U.Chakra = 0
			U.RefreshChakra()
		if(M)
			M.ReleaseKagemane(M)