obj/SkillCards/Class/Medical/Shousen
	icon_state="card_Shousen"
	cmdstring="Shousen"
	JutsuType = "Class"
	Cooldown = 800
	DM = 8
	CCost = 20
	Seals = 4

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[usr.ChakraMax * (CCost * 0.01)] per second'; DamageAmount.text='[DM]% Bunshin Strength'")

	Description=list(
		"about" = "Heal someone in close proximity",
		,"title" = "Shousen",
		,"type" ="Ninjutsu",
		,"strong"="N/A",
		,"weak"="N/A",
		,"rank"="B",
		//,"pic"='Bunshin.png',
	)

	UpgradeChoices = list("Increase Skill","Lower Cost")

	Activate(mob/U)
		if(U.healing)
			U.healing=0;
			spawn(15)
				U.firing=0;
			return
		if(!U.Class["Medical-Nin"])
			U << "This technique is disabled as you are not currently an Medic-Nin"
			return
		if(GENERICATTACKCHECK(U)) return
		var/list/Choices = list()
		for(var/mob/player/A in view(U,1))
			//if(A.healing)
			//	continue
			Choices += A

		var/mob/M
		if(Choices.len == 1)
			M=U
		else
			M = input("Who would you like to heal?") as null|anything in Choices

		if(M)
			var
				c=CCost * 0.01; mx=c; s=U.SS*Seals
			if(U.Chakra <= (U.ChakraMax * c)) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("Shousen",(CooldownCur*U.cooldownmultiplier)+s)) return
			if(ChakraUseCheck()) c *= 4
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				spawn(1)U.icon_state=null
				if(prob(U.ChakraControl))
					if(M.Wounds<=15 && M != src)
						U<<"You cannot heal them any further."
						U.firing=0
						return
					else
						U.JutsuUseChakra(c)
						U.JutsuMessage(Description["title"])
						U.JutsuSeals(s);
						U.JutsuNin(c)
						U.MoveUses[name]++
						if(U.PracticeMode || ControlCheck(U))
							U.firing=0
							return ..()
						U.ShousenProc(M, c, DM)
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
				..()

mob
	proc
		SelfShousenProc()
			if(healingself)
				var
					c=ChakraMax*0.12; heal=c*0.007
				Chakra-=round(c); Wounds-=heal
				TextOverlay(src, heal, "health");
				BandageUses--; if(BandageUses<0) BandageUses=0
				if(Chakra<=1) {Chakra=1; healingself=0}
				if(Wounds<=25) {healingself=0; Wounds=25}
				RefreshWounds(); RefreshChakra()
				spawn(15)SelfShousenProc()
			else
				healingself=0; spawn(15)firing=0
				src<<"You are no longer healing yourself."

		ShousenProc(mob/W, C, DM)
			set waitfor = 0
			/*if(istype(W,/mob/Hittable/Responsive/NPC/Mission/Sound5/Orochimaru)) {
				W.Wounds=0
				W.Stamina=(W.StaminaMax*10)
				W.Taijutsu=W.TaijutsuMax*3.8; W.Ninjutsu=W.NinjutsuMax*3.8; W.Genjutsu=W.GenjutsuMax*4
				healing=0; firing=0
				view(W)<<"<b>[W] says:</b> Well aren't you.. intriguing... Kehehe"
				return
			}*/
			healing=1
			C = round(ChakraMax * C)
			//DM = round(C * DM)
			if(W == src)
				src<<"You begin healing yourself.";
				while(healing)
					if(Chakra<C)
						healing = 0
						break
					else
						Chakra -= C
						Wounds -= DM
						TextOverlay(src, DM, "health");
						if(KI_InMission&&(src in KI_Participants))
							KonohaInvasionPoints+=min(13,(DM*0.15))
							Refresh_InvasionScore()
						if(BandageUses>0)
							BandageUses--
						if(sliced)
							src<<"You reattached your tendons!"
							sliced=null
						if(Nerves)
							src<<"You ed your nerves!"
							Nerves=null
						if(Blasted)
							src<<"You repaired your inner ear!"
							Blasted=null
						if(Poisoned)
							src<<"You cured yourself of the poison!"
							Poisoned=null
						if(HasKonchuu.len)
							src<<"You rid yourself of Konchuu!";
							HasKonchuu=list()
							for(var/mob/player/P in MasterPlayerList)
								RemoveBug(P,src)
						RefreshWounds()
						RefreshChakra()
						sleep(10)
				src<<"You are no longer healing yourself."
			else
				src<<"You begin healing [W].";
				W<<"[src] is using their chakra to heal your wounds."
				while(healing && W && get_dist(src,W)<=1)
					if(Chakra<C)
						healing = 0
						break
					else
						Chakra -= C
						W.Wounds -= DM;
						TextOverlay(W, DM, "health");
						if(KI_InMission&&(src in KI_Participants))
							KonohaInvasionPoints+=min(13,(DM*0.15))
							Refresh_InvasionScore()
						if(W.BandageUses>0)
							W.BandageUses--
						if(W.sliced)
							W<<"[src] has reattached your tendons!"
							W.sliced=null
						if(W.Nerves)
							W<<"[src] has repaired your nerves!"
							W.Nerves=null
						if(W.Blasted)
							W<<"[src] has repaired your inner ear!"
							W.Blasted=null
						if(W.Poisoned)
							W<<"[src] has cured you!"
							W.Poisoned=null
						if(W.HasKonchuu.len)
							W<<"[src] has rid you of Konchuu!";
							W.HasKonchuu=list()
							for(var/mob/player/P in MasterPlayerList)
								RemoveBug(P,W)
						if(!W.Gate == 9)
							DeathSaved = 1
							W << "[src] has saved you from the Gate of Death's fate"
							src << "[W] has been saved by you from the Gate of Death's fate"

						W.RefreshWounds()
						RefreshChakra()
						if(W.Wounds<15)
							W.Wounds=15
							healing=0
							break
						sleep(10)
				src<<"You are no longer healing [W]."
				W<<"[src] is no longer healing you."
			firing=0