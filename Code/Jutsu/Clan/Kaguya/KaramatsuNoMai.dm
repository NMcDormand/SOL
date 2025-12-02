obj/SkillCards/Clan/Kaguya/KaramatsuNoMai
	icon_state="card_KaramatsuNoMai"
	cmdstring="KaramatsuNoMai"
	CCost = 2000
	SCost = 2000
	Seals=3
	Cooldown = 1200

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[CCost*usr.KGCModifier]';StaminaCost.text='[SCost] per 3 seconds'")

	UpgradeChoices = list("Lower Cost","Lower Cooldown")

	Description = list(
		"about"="Extend bones from your body to provide a defence and hurt opponents who attack yiou physically."
		,"title"="Karamatsu No Mai"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="A"
//		,"pic"='KaramatsuNoMai.png'
		)

	Activate(mob/U)
		if(U.InKaramatsu)
			U.InKaramatsu=0
			U<<"Your rib bones retract into your torso"
			U.CooldownCheck("KaramatsuNoMai",(CooldownCur*U.cooldownmultiplier))
			//U.overlays-='karamatsu.dmi'
		else
			if(GENERICATTACKCHECK(U)) return
			var
				c=(CCost*U.KGCModifier); mx=c; s=U.SS*Seals
				ST = SCost
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.Stamina<=ST) {U<<"Not enough Stamina."; return}
			//if(U.SandArmour) {U<<"Release your Sand Armour first."; return}
			if(U.CooldownCheck("KaramatsuNoMai",(CooldownCur*U.cooldownmultiplier)+s)) return
			if(ChakraUseCheck()) c *= 4
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				spawn(1)U.icon_state=null
				spawn(10)U.firing=0
				if(prob(U.ChakraControl))
					U.JutsuUseChakra(c)
					U.JutsuUseStamina(ST)
					U.JutsuMessage(Description["title"])
					U.JutsuSeals(s); U.JutsuTai(U.Taijutsu*0.02)
					U.MoveUses[name]++
					if(U.PracticeMode || ControlCheck(U)) return ..()
					spawn(2)
						U.InKaramatsu=1
						U<<"Your rib bones painfully extend through your torso."
						U.Wounds+=10; U.Damaged(U.Wounds); U.RefreshWounds()
						U.KaramatsuDrain(ST)
						//U.overlays+='karamatsu.dmi'
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
				..()

mob/proc/KaramatsuDrain(S)
	set waitfor = 0
	while(InKaramatsu)
		Stamina-=S;
		if(Stamina<S)
			src<<"You can no longer sustain your bone armour."
			if(Stamina<1) Stamina=0
			InKaramatsu=0
		RefreshStamina()
		sleep(30)
	RefreshStamina()
	InKaramatsu=0
	//overlays-='karamatsu.dmi'
	src<<"Your rib bones retract into your torso."