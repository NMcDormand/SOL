obj/SkillCards/Clan/Lee/Hachimon
	icon_state="card_Hachimon"
	cmdstring="Hachimon"
	Cooldown=1000
	Duration = 300
	var/tmp/Activating = 0

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"Cooldown.text='[(CooldownCur*usr.cooldownmultiplier)*0.1] per Gate';DamageAmount.text='Duration: [Duration*0.1] seconds")

	Description = list(
		"about"="Forcefully open the 8 inner gates and break the bodies natural limits"
		,"title"="Hachimon"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='Kaiten.png'
		)

	UpgradeChoices = list("Lower Cooldown","Increase Duration")

	Activate(mob/U)
		if(U.Drunk)
			U << "In your current state you cant seem to focus your body enough to open the Gates"
			return
		if(GENERICATTACKCHECK(U)||Activating) return
		var/MaxGate = U.JutsuList["Hachimon"]
		var/NextGate = U.Gate+1
		if(U.Gate >= MaxGate)
			return
		if(U.CooldownCheck("Gate[NextGate]",CooldownCur*NextGate*U.cooldownmultiplier)) return
		if(U.PracticeMode || ControlCheck(U)) return ..()
		U.firing=1
		var/TG = U.TaijutsuTrue
		var/SG = U.StaminaMax
		var/AD = 110-Level
		spawn(AD+5)
			if(U)
				U.firing=0
		switch(U.Gate)
			if(0)
				U.MoveUses[name]++
				U.overlays+='GatesNew.dmi'
				U<<"A rush of adrenaline flows through you as you start opening your Initial Gate."
				Activating = 1
				spawn(AD)
					Activating = 0
					if(U.KO||U.dead)
						U.overlays-='GatesNew.dmi'
						return
					U.Reflex+=2;
					TG *= 0.1
					U.GateRFX += 2
					U.GateTai += TG
					U.Taijutsu += TG
					U.overlays-='GatesNew.dmi'
					hearers(6,U)<<"[U] has opened the Initial Gate!"

					U.RefreshPlayerStats()
					U.RefreshStats()
					U.showGateStats()
					U.Gate=1
					U.GateTime=Duration
					spawn(25)
						if(U)
							if(U.client)U.SetTimer(U.GateTime*0.1,name)
							U.GateDrain(U.Gate)
			if(1)
				if(MaxGate>1)
					//U.Cooldowns["Gates"]=world.time+(CooldownCur*U.cooldownmultiplier);
					U.overlays+='GatesNew.dmi'
					U<<"You feel your heart rate dramatically increase as you start opening your Rest Gate."
					Activating = 1
					U.GateTime+=AD
					spawn(AD)
						Activating = 0
						if(U.KO||U.dead)
							U.overlays-='GatesNew.dmi'
							return
						SG *= 0.1
						U.GateRFX += 4
						U.GateStam +=SG

						U.Reflex+=4;
						U.Stamina+=SG
						U.Chakra=U.ChakraMax
						U.overlays-='GatesNew.dmi'
						hearers(6,U)<<"[U] has opened the Rest Gate!"

						U.RefreshPlayerStats()
						U.RefreshStats()
						U.showGateStats()
						U.Gate=2
						if(U.GateTime<=Duration*0.5)
							U.GateTime+=Duration*0.5
							if(U.client)U.SetTimer(U.GateTime*0.1,name)
			if(2)
				if(MaxGate>2)
					//U.Cooldowns["Gates"]=world.time+(CooldownCur*U.cooldownmultiplier);
					U.overlays+='GatesNew.dmi'
					U<<"Your Life Gate begins opening; intense pain runs through your nerves."
					Activating = 1
					U.GateTime+=AD
					spawn(AD)
						Activating = 0
						if(U.KO||U.dead)
							U.overlays-='GatesNew.dmi'
							return
						U.Reflex+=6;
						U.GateRFX += 6
						U.movespeed-= 0.5
						U.GateSpeed+= 0.5
						U.overlays-='GatesNew.dmi'
						U.overlays+='3rd-Gate.dmi'
						hearers(6,U)<<"[U] has opened the Life Gate!"

						U.RefreshPlayerStats()
						U.RefreshStats()
						U.showGateStats()
						U.Gate=3
						U.showGateStats()
						if(U.GateTime<=Duration*0.5)
							U.GateTime+=round(Duration*0.5)
							if(U.client)U.SetTimer(U.GateTime*0.1,name)
			if(3)
				if(MaxGate>3)
					//U.Cooldowns["Gates"]=world.time+(CooldownCur*U.cooldownmultiplier);
					U.overlays-='3rd-Gate.dmi'
					U.overlays+='GatesNew.dmi.'
					U<<"Searing pain strikes all over as you open the Wound Gate."
					Activating = 1
					U.GateTime+=AD
					spawn(AD)
						Activating = 0
						if(U.KO||U.dead)
							U.overlays-='GatesNew.dmi'
							return
						TG *= 0.2
						SG *= 0.2
						U.GateRFX += 5
						U.GateTai += TG
						U.GateStam += SG
						U.Reflex+=5;
						U.Stamina += SG
						U.Taijutsu += TG
						U.overlays-='GatesNew.dmi'
						U.overlays+='4th-Gate.dmi'
						range(6,U)<<"[U] has opened the Wound Gate!"

						U.RefreshPlayerStats()
						U.RefreshStats()
						U.showGateStats()
						U.Gate=4
						if(U.GateTime<=Duration*0.5)
							U.GateTime+=round(Duration*0.5)
							if(U.client)U.SetTimer(U.GateTime*0.1,name)
			if(4)
				if(MaxGate>4)
					//U.Cooldowns["Gates"]=world.time+(CooldownCur*U.cooldownmultiplier);
					U.overlays-='4th-Gate.dmi'
					U.overlays+='GatesNew.dmi.'
					U<<"The Limit Gate opens and the pain in your body seemingly subsides."
					Activating = 1
					U.GateTime+=AD
					spawn(AD)
						Activating = 0
						if(U.KO||U.dead)
							U.overlays-='GatesNew.dmi'
							return
						U.overlays-='GatesNew.dmi.'
						U.overlays+='5th-Gate.dmi'
						SG *= 0.2
						U.GateRFX += 8
						U.GateTai += TG
						U.GateStam += SG
						U.Taijutsu += TG
						U.Stamina += SG
						U.Reflex+=8;
						range(6,U)<<"[U] has opened the Limit Gate!"

						U.RefreshPlayerStats()
						U.RefreshStats()
						U.showGateStats()
						U.Gate=5
						if(U.GateTime<=Duration*0.5)
							U.GateTime+=round(Duration*0.5)
							if(U.client)U.SetTimer(U.GateTime*0.1,name)
			if(5)
				if(MaxGate>5)
					//U.Cooldowns["Gates"]=world.time+(CooldownCur*U.cooldownmultiplier);
					U.overlays-='5th-Gate.dmi'
					U.overlays+='GatesNew.dmi'
					U<<"You feel an intense power overwhelm you as you open the View Gate."
					Activating = 1
					U.GateTime+=AD
					spawn(AD)
						Activating = 0
						if(U.KO||U.dead)
							return
						TG *= 0.5
						SG *= 0.5
						U.GateRFX += 10
						U.GateTai += TG
						U.GateStam += SG
						U.Stamina += SG
						U.Taijutsu += TG
						U.Reflex+=10;
						U.movespeed-= 0.5
						U.GateSpeed+= 0.5
						U.overlays-='GatesNew.dmi.'
						U.overlays+='6th-Gate.dmi'
						range(6,U)<<"[U] has opened the View Gate!"

						U.RefreshPlayerStats()
						U.RefreshStats()
						U.showGateStats()
						U.Gate=6
						if(U.GateTime<=Duration*0.5)
							U.GateTime+=round(Duration*0.5)
							if(U.client)U.SetTimer(U.GateTime*0.1,name)
			if(6)
				if(MaxGate>6)
					//U.Cooldowns["Gates"]=world.time+(CooldownCur*U.cooldownmultiplier);
					U.overlays-='6th-Gate.dmi'
					U.overlays+='GatesNew.dmi'
					U<<"Your body can barely take the intensity but you begin opening the Wonder Gate."
					Activating = 1
					U.GateTime+=AD
					spawn(AD)
						Activating = 0
						if(U.KO||U.dead)
							U.overlays-='GatesNew.dmi'
							return ..()
						TG *= 0.6
						SG *= 0.6
						U.GateRFX += 16
						U.GateTai += TG
						U.GateStam += SG
						U.Stamina += SG
						U.Taijutsu += TG
						U.Reflex+=16
						if(U.sliced) U.sliced=null
						if(U.Nerves) U.Nerves=null
						if(U.Blasted) U.Blasted=null
						if(U.Poisoned) U.Poisoned=null
						if(U.HasKonchuu)
							U.HasKonchuu=list()
							for(var/mob/P in U.BuggedList)
								RemoveBug(P,U)
						U.overlays-='GatesNew.dmi'
						U.overlays+='7th-Gate.dmi'
						range(6,U)<<"[U] has opened the Wonder Gate!"

						U.RefreshPlayerStats()
						U.RefreshStats()
						U.showGateStats()
						U.Gate=7
						if(U.GateTime<=Duration*0.5)
							U.GateTime=round(Duration*0.5)
							if(U.client)U.SetTimer(U.GateTime*0.1,name)
			if(7)
				if(MaxGate>7)
					//U.Cooldowns["Gates"]+=world.time+(CooldownCur*U.cooldownmultiplier)
					U.overlays+='GatesNew.dmi'
					U.overlays-='7th-Gate.dmi'
					U<<"You feel several internal ruptures as you open the Death Gate. You don't have much time left!"
					Activating = 1
					U.GateTime+=AD*3
					spawn(AD*3)
						Activating = 0
						if(U.KO||U.dead)
							U.overlays-='GatesNew.dmi'
							return ..()
						TG *= 1.5
						SG *= 2.7
						U.GateRFX += 140
						U.GateTai += TG
						U.GateStam += SG
						U.Stamina += SG
						U.Taijutsu += TG
						U.Reflex+=140;
						U.Wounds=1
						U.overlays-='GatesNew.dmi.'
						U.overlays+='8th-Gate.dmi'
						range(4,U)<<"<b>[U] has opened the Death Gate!</b>"

						U.RefreshPlayerStats()
						U.RefreshStats()
						U.showGateStats()
						U.Gate=8
						if(U.GateTime<=Duration)
							U.GateTime=Duration
							if(U.client)U.SetTimer(U.GateTime*0.1,name)
		..()

obj/SkillCards/Clan/Lee/HachimonClose
	icon_state="card_HachimonClose"
	cmdstring="HachimonClose"
	CanLevel = 0
	Description = list(
		"about"="Close all Gates"
		,"title"="Hachimon Close"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='Kaiten.png'
		)

	Activate(mob/U)
		if(U.Gate && U.Gate<9)
			if(U.Gate>7) {U<<"It is too late, the Death Gate is already opened and you will soon die..."; return}
			U.GateTime=0

mob/var
	GateTai = 0
	GateStam = 0
	GateRFX = 0
	GateSpeed = 0
	DeathSaved = 0

mob/proc
	showGateStats()
		StatUpdate_reflexes()
		StatUpdate_taijutsu()
		StatUpdate_stamina()
		StatUpdate_chakra()

	removeGateImage()
		overlays-='3rd-Gate.dmi'
		overlays-='4th-Gate.dmi'
		overlays-='5th-Gate.dmi'
		overlays-='6th-Gate.dmi'
		overlays-='7th-Gate.dmi'
		overlays-='8th-Gate.dmi'

	GateDrain()
		while(GateTime>0)
			if(!Gate)
				return
			GateTime-=20
			var/SR = StaminaMax*0.005
			if(Gate)
				Stamina -= SR
				Wounds+=1
			if(Gate>3)
				Stamina -= SR
				Wounds+=1
			if(Gate>5)
				Stamina -= SR
				Wounds+=1
			if(Gate>7)
				Wounds+=1
			if(Stamina<0)Stamina=0
			RefreshStats()
			sleep(20)

		if(client)SetTimer(0,"Hachimon")

		if(Gate)
			src<<"Pain pulses through your veins and agony charges along your nerves. Your gates are closing."
			if(!dead)
				Reflex-=GateRFX;
				Stamina -= GateStam
				if(Stamina>StaminaMax) Stamina = StaminaMax
				if(Chakra>ChakraMax) Chakra=ChakraMax
				Taijutsu -= GateTai
				movespeed += GateSpeed
			StatUpdate_taijutsu()
			StatUpdate_reflexes()
			StatUpdate_movespeed()
			StatUpdate_stamina()
			StatUpdate_wounds()
			GateTai = 0
			GateStam = 0
			GateRFX = 0
			GateSpeed = 0
			switch(Gate)
				if(3)
					overlays-='3rd-Gate.dmi'
				if(4)
					overlays-='4th-Gate.dmi'
				if(5)
					overlays-='5th-Gate.dmi'
				if(6)
					overlays-='6th-Gate.dmi'
				if(7)
					overlays-='7th-Gate.dmi'
				if(8)
					overlays-='8th-Gate.dmi'
					if(!dead)
						Gate = 9
						src << "You feel your heart beat slowly fade as the Death Gate Closes"
						var/WT = 120
						while(WT)
							sleep(10)
							if(dead)
								return
							if(DeathSaved)
								DeathSaved = 0
								return
							WT -= 10
						if(!DeathSaved)
							KillMe(src)
						else
							DeathSaved = 0
			Gate=0