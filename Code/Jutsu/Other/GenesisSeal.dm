mob/var
	StoredChakra=0
	tmp
		Storing
		CreationRebirth
		Creation_Immortal
obj/SkillCards/Taijutsu/CreationRebirth
	icon_state="card_CreationRebirth"
	cmdstring="CreationRebirth"
	JutsuType = "S-Rank"
	CanLevel = 0
	Description = list(
		"about"="Store your chakra over time for use in battle later in order to heal grave wounds."
		,"title"="Creation Rebirth"
		,"type"="Kinjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="S"
//		,"pic"='HeavenCursedSeal.png'
	)

	Activate(mob/U)
		if(usr.CreationRebirth)
			usr.CreationRebirth=0; usr<<"<font color=green>You are no longer releasing your stored chakra.</font>"
			return
		if(usr.GMfrozen||usr.fishing||usr.firing||usr.transing) return
		if(usr.StoredChakra<5000) {usr<<"<font color=green>You need to have stored 5000 chakra before you can use this.</font>"; return}
		if(usr.CooldownCheck("GENESIS",6000*usr.cooldownmultiplier)) return
		usr<<"<b>You release your stored chakra, and regenerate your cells.</b>"
		usr.Storing=0; usr.Rebirth_Revive()

	verb/Genesis_Seal_Store()
		set name="Creation Rebirth: Store Chakra"
		if(usr.GMfrozen||usr.fishing||usr.firing||usr.transing) return
		usr.transing=1; spawn(55) usr.transing=0
		if(usr.Storing) {usr.Storing=0; usr<<"You are no longer storing your Chakra"}
		else {usr.Storing=1; usr<<"You begin storing your Chakra"; usr.Store()}

mob/proc
	Rebirth_Revive()
		CreationRebirth=1
		overlays+='GS_Aura.dmi'
		KO=0; icon_state=null
		CantWalk--
		if(CantWalk<0)
			CantWalk = 0
		for(StoredChakra-=2000, StoredChakra>0,StoredChakra-=1000)
			Wounds-=10
			TextOverlay(src, round(10), "health");
			Stamina+=(StaminaMax/5)
			Stamina=min(Stamina,StaminaMax)
			RefreshWounds(); RefreshStamina()
			if(Wounds<=0)
				Wounds=0
				break
			sleep(2)
		if(StoredChakra<=0)
			Chakra += (StoredChakra)
			StoredChakra=0; Chakra=max(Chakra,1)
			CreationRebirth=0; overlays-='GS_Aura.dmi'
			RefreshChakra()
		else if(StoredChakra>0)
			spawn(50) Rebirth_Immortal()

	Rebirth_Immortal()
		if(Creation_Immortal) return
		Creation_Immortal=1
		while(StoredChakra>0&&CreationRebirth)
			StoredChakra-=300
			if(Wounds>0) Rebirth_Heal_Wounds()
			if(Stamina<StaminaMax) Rebirth_Heal_Stamina()
			RefreshChakra()
			sleep(50)
		if(StoredChakra<0) StoredChakra=0
		CreationRebirth=0; Creation_Immortal=0
		overlays-='GS_Aura.dmi'
		RefreshChakra()

	Rebirth_Heal_Wounds()
		for(Wounds,Wounds>0,Wounds-=15)
			StoredChakra-=800
			if(Wounds<0) Wounds=0
			RefreshChakra(); RefreshWounds()
			TextOverlay(src, round(15), "health");
			if(StoredChakra<1||!CreationRebirth) break
			sleep(10)
		if(Wounds<0) Wounds=0
		RefreshChakra(); RefreshWounds()

	Rebirth_Heal_Stamina()
		for(Stamina,Stamina<StaminaMax,Stamina+=(StaminaMax/10))
			StoredChakra-=400
			if(Stamina>StaminaMax) Stamina=StaminaMax
			RefreshChakra(); RefreshStamina()
			if(StoredChakra<1||!CreationRebirth) break
			sleep(10)
		if(Stamina>StaminaMax) Stamina=StaminaMax
		RefreshChakra(); RefreshStamina()

	Store()
		set background=1
		if(StoredChakra>=ChakraTrue) {StoredChakra=ChakraTrue; Storing=0; StatUpdate_chakra()}
		if(Storing)
			var
				delay=50; drain=5
			if(meditating) {delay=10; drain=0}
			if(Chakra<=5)
				src<<"<font color=green>You can no longer sustain Chakra Storage.</font>"; Storing=0

			if(Chakra>5)
				Chakra-=drain; StoredChakra+=5; StatUpdate_chakra()

			spawn(delay)Store()

	GenesisSealAttain()
		switch(input(src,"Would you like to learn the Genesis Seal?","")in list("Yes","No"))
			if("Yes")
				src<<"<font size=2 color=silver><b>You have mastered the Genesis Rebirth Seal!</b></font>"
				HasSeal="Genesis Seal"