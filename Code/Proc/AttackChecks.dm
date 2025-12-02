/*
---Generic---
firing
icon
climbing
protect
resting
jailed
frozen
GMfrozen
InSoutourou
swimming
kaiten
ShadowCaptured
Tsukuyomi
waterprisoned
---Taijutsu---
attacking
protect*
resting*
jailed*
frozen*
GMfrozen*
swimming*
kaiten*
ShadowCaptured*
Tsukuyomi*
reset
KO
Webbed
EventLock
DeathSee
*/
mob/var/
	Tier1Downtime; Tier2Downtime; Tier3Downtime
	cooldownmultiplier=1.6
mob/var/tmp
	Webbed
	SkipList=list()
	DeathSee

mob/proc
	HitCheck(mob/D)//d for defender
		if(D.InKageArashi||D.Kanashibari||D.Gokusamaisou||D.IceBlasted||D.ShadowCaptured||D.JubakuBound||D.waterprisoned||D.SunaNoMayu||D.InFakeView||D.UsingWaterPrison||D.frozen||D.Tsukuyomi)
			return 1
		if(!Reflex) Reflex=1
		if(!D.Reflex) D.Reflex=1
		if(Reflex<1) Reflex=1
		if(D.Reflex<1) D.Reflex=1
		var/h = (((D.Reflex - Reflex) / ((D.Reflex + Reflex)/2))*100) // Grab % difference between numbers
		h = 100 - h // Change to hit chance from miss chance
		if(h<40) h=40
		if(D.Nerves||D.sliced||D.Blasted||D.TooMuchWeight) h+=10
		if(Nerves||sliced||Blasted) h-=10
		if((D.InMirrors&&mirroring)) h+=40
		if(MoveCheck(D)) h=100
		if(istype(D,/mob/Hittable/Responsive)&&!(src in D.HitList)) D.HitList+=src
		if(prob(h)) return TRUE
		else return FALSE

	EscapeCheck()
		if(BlockedTenketsu||Gokusamaisou||InMist||dead||InNarakumi||MushiKabe||KO||mirroring||UsingWaterPrison||InMesu||!icon||DeathSee||fishing||healingself||Sleeping||protect||frozen||GMfrozen||Tsukuyomi||swimming||kaiten||InSoutourou) return TRUE
		else {RefreshStats(); return FALSE}

	FishingAttackCheck()
		if(Drugged||Dispelling||AFK||JubakuBound||InNarakumi||dead||MushiKabe||mirroring||UsingWaterPrison||InMesu||InCloak||Coffin||DeathSee||EventLock||Webbed||fishing||healingself||KO||Blocking||throwing||Sleeping||protect||waterprisoned||IceBlasted||ShadowCaptured||jailed||frozen||GMfrozen||Tsukuyomi||swimming||kaiten||climbing||InSoutourou) return TRUE
		else {RefreshStats(); return FALSE}

	MushiKabeAttackCheck()
		if(BlockedTenketsu||Drugged||Dispelling||AFK||JubakuBound||Kanashibari||InNarakumi||dead||MushiKabe||mirroring||UsingWaterPrison||InMesu||InCloak||Coffin||DeathSee||EventLock||Webbed||fishing||healingself||firing||KO||throwing||Sleeping||protect||waterprisoned||IceBlasted||resting||jailed||frozen||GMfrozen||Tsukuyomi||swimming||kaiten||climbing||InSoutourou) return TRUE
		else {RefreshStats(); return FALSE}

	HotBarDelayCheck()
		if(hbDelay) return TRUE
		else return FALSE

	GenericAttackCheckAFK()
		if(BlockedTenketsu||Drugged||Dispelling||JubakuBound||Kanashibari||InNarakumi||dead||MushiKabe||mirroring||UsingWaterPrison||InMesu||InCloak||Coffin||DeathSee||EventLock||Webbed||fishing||healingself||firing||KO||Blocking||throwing||Sleeping||protect||waterprisoned||IceBlasted||resting||ShadowCaptured||jailed||frozen||GMfrozen||InTsukuyomi||Tsukuyomi||swimming||kaiten||climbing||InSoutourou) return TRUE
		else return FALSE

	KageBunshinAttackCheck()
		if(ReverseFlow||ShadowCaptured||InKageArashi||BlockedTenketsu||InCamo||firing||Drugged||Dispelling||AFK||JubakuBound||Kanashibari||InNarakumi||dead||MushiKabe||mirroring||UsingWaterPrison||InMesu||InCloak||Coffin||DeathSee||EventLock||Webbed||fishing||healingself||KO||Blocking||throwing||Sleeping||protect||waterprisoned||IceBlasted||resting||ShadowCaptured||jailed||frozen||GMfrozen||Tsukuyomi||swimming||kaiten||climbing||InSoutourou) return TRUE
		else return FALSE


	GarougaAttackCheck()
		if(DeathSee||Coffin||dead||Webbed||EventLock||InNarakumi||fishing||healingself||ShadowCaptured||firing||KO||Blocking||throwing||Sleeping||JubakuBound||protect||waterprisoned||IceBlasted||resting||ShadowCaptured||jailed||frozen||GMfrozen||Tsukuyomi||swimming||climbing) return TRUE
		else {RefreshStats(); return FALSE}

	TaiAttackAnywayCheck(mob/M)
		if(DeathSee||MushiKabe||JubakuBound||icon_state=="seals"||Kanashibari||InNarakumi||Sleeping||dead||ShadowCaptured||frozen||EventLock||Blocking||KO||reset||throwing||GMfrozen||Tsukuyomi||jailed||swimming||resting||ShadowCaptured||kaiten||IceBlasted||waterprisoned||Coffin) return TRUE
		else if(M&&(M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga||M.GMfrozen)) SkipList+=M
		else return FALSE

	ThrowAttackCheck(obj/T)
		if(MushiKabe||DeathSee||icon_state=="seals"||Kanashibari||InNarakumi||Sleeping||dead||ShadowCaptured||Webbed||EventLock||frozen||throwing||KO||Blocking||GMfrozen||Tsukuyomi||jailed||attacking||swimming||protect||resting||ShadowCaptured||kaiten||IceBlasted||waterprisoned||Coffin||(T&&T.amount<1)) return TRUE
		else return FALSE
	ThrowHomingAttackCheck(mob/M,obj/T)
		if(MushiKabe||DeathSee||icon_state=="seals"||Kanashibari||InNarakumi||Sleeping||dead||ShadowCaptured||frozen||EventLock||Webbed||throwing||GMfrozen||KO||Blocking||Tsukuyomi||jailed||attacking||swimming||protect||resting||ShadowCaptured||kaiten||waterprisoned||IceBlasted||Coffin||M.protect||M.InGatsuuga||M.InTsuuga||M.InMeatTank||M.InGarouga||M.GMfrozen||T.amount<1) return TRUE
		else return FALSE

	AI_GenericAttackCheck()
		if(ReverseFlow||MushiKabe||Coffin||dead||InCloak||fishing||Kanashibari||InNarakumi||Webbed||healingself||ShadowCaptured||firing||KO||IceBlasted||Blocking||throwing||Sleeping||JubakuBound||protect||waterprisoned||resting||ShadowCaptured||jailed||frozen||GMfrozen||Tsukuyomi||swimming||kaiten||climbing||InSoutourou) return TRUE
		else return FALSE
	AI_TaijutsuAttackCheck(mob/M)
		if(ReverseFlow||InFakeView||MushiKabe||(InMist&&!InByakugan&&!Underground)||Kanashibari||InNarakumi||Sleeping||Gokusamaisou||ShadowCaptured||dead||frozen||Blocking||Webbed||KO||reset||throwing||GMfrozen||Tsukuyomi||jailed||attacking||swimming||resting||ShadowCaptured||kaiten||waterprisoned||IceBlasted||Coffin) return TRUE
		else if(M&&(M.protect||M.InGatsuuga||M.InTsuuga||M.InMeatTank||M.InGarouga||M.GMfrozen)) return TRUE
		else return FALSE

	OverWorldKillMe()
		if(Arena||(src in EventParticipants)||(src in GuildWarList)||(src in BattleList)||(src in ChuuninList)) return 0
		else return 1

	FriendlyFireCheck(mob/target)
		if(!FriendlyFire)
			FriendlyFire=list()
		for(var/v in FriendlyFire)
			if(target.PlayerID == v)
				return 1
			if(FriendlyFire[v])
				if(v=="village" && target.Village==Village)
					return 1
				if(v=="guild"&&target.Guild==Guild&&Guild)
					return 1

	SendIntoBattle(battle)
		if(VillageJailTime>0||dead||Arena||NinjaRank=="Academy Student"||src in KI_Participants||src in ForestList||src in BattleList||src in GuildWarList||src in SoundMissionaries||usr.TakingExam||usr.TakingChuuninExam) return FALSE
		switch(battle)
			if("Arena Challenge")
				if(ArenaOff) return FALSE
				else return TRUE
			else return TRUE

mob/var/Cooldowns[]
var/tmp/GlobalCooldown=list()

mob/proc/CooldownCheck(Name,Cooldown,HIDEMSG)
	if(!Cooldowns) Cooldowns=list()
#if DEBUGGING
	if(Name!="Fishing")
		return 0
#endif
	if(!(ckey in GlobalCooldown)) {GlobalCooldown+=ckey; Cooldowns=list()}

	if(Cooldowns[Name]>world.time)
		if(!HIDEMSG) {
			var/timeLeft = round((Cooldowns[Name]-world.time)/10)

			if(timeLeft >= 60 ) { //Is above 60 seconds...
				var timeLeftSeconds = timeLeft % 60
				var timeLeftMinutes = round(timeLeft / 60)
				src<<"You cannot use this technique for another [timeLeftMinutes] minutes and [timeLeftSeconds] seconds."
			} else {
				src<<"You cannot use this technique for another [timeLeft] seconds."
			}
		}
		//if(!HIDEMSG)src<<"You cannot use this technique for another [round((Cooldowns[Name]-world.time)/10)] seconds."
		return 1

	Cooldowns[Name]=world.time+Cooldown
	return 0