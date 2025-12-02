obj/SkillCards/Clan/Sand/SunaYoroi
	icon_state="card_SunaYoroi"
	cmdstring="SunaYoroi"
	CCost=300
	Seals=2
	Cooldown = 1100
	DM = 1
	ECost = 30

	Description = list(
		"about"="The user covers their body in dense chakra infused sand to protect from damage"
		,"title"="Suna no Yoroi"
		,"type"="Ninjutsu"
		,"Element"="Sand"
		,"weak"="N/A"
		,"rank"="B"
		//,"pic"='Chidori.png'
	)

	UpgradeChoices = list("Lower Cooldown","Lower Cost")

	Activate(mob/U)
		if(U.SandArmour)
			U.SandArmour=0;
			//U.overlays-='SandArmour.dmi'; U.overlays-='SandArmour.dmi';
			return
		else
			if(GENERICATTACKCHECK(U)) return
			if(U.SandCollected<ECost && !U.onsand)
				U<<"You do not have enough sand in your gourd."
				return
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("SunaYoroi",(CooldownCur*U.cooldownmultiplier)+s)) return
			if(ChakraUseCheck()) c *= 4
			//if(U.BugArmour) {U<<"Release your Bug Armour first."; return}
			//if(U.InKaramatsu) {U<<"Release your Bone Armour first."; return}
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				U.icon_state=null
				spawn(20)U.firing=null
				if(prob(U.ChakraControl))
					if(!U.onsand)
						U.SandCollected-=ECost
					U.JutsuMessage(Description["title"])
					U.JutsuSeals(s); U.JutsuNin(c);
					U.MoveUses[name]++
					U.JutsuUseChakra(c);
					//U.ElementalUp("Sand")
					if(U.PracticeMode || ControlCheck(U)) return ..()
					//U.overlays+='SandArmour.dmi'
					U.SandArmourDrain(c,CooldownCur*U.cooldownmultiplier)
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
				..()

mob
	proc
		SandArmourDrain(A = 200,CD)
			SandArmour=1;
			while(SandArmour)
				if(Chakra<A)
					Chakra = 0
					src<<"Your Suna no Yoroi breaks away as you run out of chakra..."
				else
					Chakra-=A
					A+=10
				StatUpdate_chakra()
				sleep(20)
			SandArmour=0;
			//overlays-='SandArmour.dmi'
			src << "Your Suna no Yoroi is no longer in effect."
			Cooldowns["SunaYoroi"] = world.time+CD