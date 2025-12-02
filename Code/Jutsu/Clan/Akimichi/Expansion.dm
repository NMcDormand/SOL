obj/SkillCards/Clan/Akimichi/Baika
	//icon_state="card_Kaiten"
	cmdstring="Baika" //Expansion Jutsu

	CCost=400
	ECost=20
	Seals=2
	Cooldown=300
	CooldownCur=300
	DM = 1.5

	UpgradeChoices = list("Increase Buff", "Lower Cost")

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[ECost] per 2 seconds'; DamageAmount.text='[DM*100]% Stamina Buff'")

	Description = list(
		"about"="Expansion Technique"
		,"title"="Baika no Jutsu"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="A"
		,"Tutorial" = ""
//		,"pic"='Kaiten.png'
		)

	Tutorial()
		Description["Tutorial"] = "You will grow in size allowing you to attack multiple targets when punching, you will obtain a [DM*100]% Boost to your Stamina but will cost [ECost] Calories every 2 seconds"

	Activate(mob/U)
		if(U.Giant) //Avoid the spawn because we want to instant revert
			if(U.InMeatTank)
				U<<"You can't revert while using Nikudan Sensha!"
				return
			U.Giant=0
			U.Akimichi_Revert()
		else // Otherwise we have to wait to use seals
			if(GENERICATTACKCHECK(U)) return
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<= c) {U<<"Not enough Chakra."; return}
			if(U.Calories<=ECost) {U<<"Not enough Calories."; return}
			if(U.CooldownCheck("Baika",(CooldownCur*U.cooldownmultiplier)+s)) return
			if(ChakraUseCheck()) c *= 4
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				spawn(20) U.firing=0
				U.icon_state=null
				if(prob(U.ChakraControl))
					U.Giant=1
					U.JutsuSeals(s); U.JutsuTai(c*0.3); U.MoveUses[name]++

					U.JutsuMessage(Description["title"])
					U.JutsuUseChakra(c)
					if(U.PracticeMode || ControlCheck(U)) return ..()

					U.ExpansionStamGain = U.StaminaMax*DM
					U.Stamina+=U.ExpansionStamGain; U.StaminaMax+=U.ExpansionStamGain;
					U.ExpansionRFXGain = 20
					U.Reflex-=U.ExpansionRFXGain;
					if(U.Reflex < 1)
						U.ExpansionRFXGain = U.Reflex+1; U.Reflex=1;
					U.RefreshPlayerStats()
					U.Akimichi_Grow(3,10)
					U.Calorie_Drain(2)

				else {c-=rand(1,mx/2); U.Chakra-=c; U.icon_state=""; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
				..()

mob
	proc
		Calories(amount)
			if(Calories < CALORIEMAX)
				Calories+=amount;
				if(Calories > CALORIEMAX)
					Calories = CALORIEMAX
			StatUpdate_Calories()

		Calorie_Drain(var/previous)
			set waitfor = 0
			while(Giant)
				if(Calories<=previous)
					Akimichi_Revert()
					return;
				Calories-=previous
				if(Calories<0) Calories=0; //If we go under zero, set to 0
				StatUpdate_Calories()
				previous*=1.02
				sleep(20)

		Akimichi_Revert()
			while(InMeatTank) //Don't do anything if we are in MeatTank
				sleep(10)

			Giant=0
			if(!dead)
				StaminaMax -= ExpansionStamGain
				Stamina -= ExpansionStamGain
				if(Stamina < 10)
					Stamina = 10
				Reflex += ExpansionRFXGain
			ExpansionRFXGain = 0
			ExpansionStamGain = 0
			RefreshPlayerStats()
			Akimichi_Grow(1,10)

		Akimichi_Revert_DamageMe()
			if(InMeatTank)
				InMeatTank=0;
				firing=0
				CreationSkin(1)
				icon_state=null
				movespeed=setspeed
				overlays-=/obj/Akimichi/BALL

			Giant=0
			if(!dead)
				StaminaMax -= ExpansionStamGain
				Stamina -= ExpansionStamGain
				if(Stamina < 10)
					Stamina = 10
				Reflex += ExpansionRFXGain
			ExpansionRFXGain = 0
			ExpansionStamGain = 0
			RefreshPlayerStats()
			Akimichi_Grow(1,10)

		Akimichi_Grow(size, time)//2 or 3
			//Animate & grow in size
			if(size==1) //Restore proper bounds
				animate(src, transform = matrix()*size,pixel_y = 0, time = time)
				appearance_flags = PIXEL_SCALE
				//var/turf/Tile = get_step(loc,SOUTH)

				//bound_y = 0
				/*bound_height = 32
				if(Tile)
					if(!Tile.density) //If the tiles density = 0
						loc = locate(x,y-1,z)*/

			if(size==3)
				animate(src, transform = matrix()*size,pixel_y = 32, time = time)
				appearance_flags = PIXEL_SCALE
				//var/turf/Tile = get_step(loc,NORTH)
				//Set up bounds for new character size of 3
				//bound_y = -32 //Bounds position bottom of feet for x2
				/*bound_height = 64
				if(!Tile.density) //If the tiles density = 0
					loc = locate(x,y+1,z)*/