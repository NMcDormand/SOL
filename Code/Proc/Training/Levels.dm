#define BIAS(X,Y) ((X)**(log(Y)/log(0.5)))
/*
var
	MostExp=333333
mob/var/tmp
	NewMaxExp=50
	NewLevel=1
mob/verb/GiveExp(var/n as num)
	if(!n) n=50
	usr.Exp+=n
	usr<<"+[n]XP! ([usr.Exp])"
	if(usr.Exp>=usr.NewMaxExp) usr.NewLevels()
mob/verb/Level()
	usr.NewLevels()
mob/proc/NewLevels()
	NewLevel++
	var/x=NewMaxExp
	NewMaxExp = round(BIAS(0.3, (NewLevel+1)/400)*MostExp)
	var/y=NewMaxExp
	world<<"Now @ Level [usr.NewLevel]"
//	world<<"Exp for next level ([usr.NewLevel+1]) = [usr.NewMaxExp]"
//	world<<"<i>Difference = [usr.NewMaxExp-usr.Exp]</i>"
	world<<"[y-x]"
//	if(y&&x)
//		world<<"[NewLevel] - [(y/x)*100]%"
*/
mob/var
	StatPoints=0
	LevelBonus=10
	BonusCap = list("Stamina" = 0,"Chakra"=0,"Taijutsu"=0,"Ninjutsu"=0,"Genjutsu"=0)
	tmp/Leveling = 0

mob/proc
	LevelUpCheck()	//checks to see if your XP is enough
		..()
	ExperienceCheck()
		..()
	UpdateEXPBar()
		..()
mob/player
	UpdateEXPBar()
		winset(src,"Stats.ExpBar","value=[(Exp/MXP)*100]")
	LevelUpCheck()
		if(Level>=600||!client||Leveling)
			return
		var/T = 0
		var/SPA = 0
		var/Levels = 0
		Leveling = 1
		while(Exp>=MXP && Level<600)
			Levels++
			Exp-=MXP;  Exp=round(Exp)
			PlaySound("levelup")
			LevelUp_notification("level",client)
			T += 65
			//if(MeditationComplete) {T+=10; StatPoints+=4}
			//if(Level==round(Level,10)) MeditationComplete=0
			//if(client.IsByondMember()) StatPoints++
			var/SPSA = 8
			if(ckey in ContributorTier1) SPSA+=6
			if(ckey in ContributorTier2) SPSA+=4
			if(ckey in ContributorTier3) SPSA+=2
			SPA+=SPSA
			MXP*=1.018;
		if(Levels>0)
			Level += Levels
			if(Levels > 1)
				src<<"<b><font color=silver>You went up [Levels] and are now level [Level]!</font></b>"
			else
				src<<"<b><font color=silver>You are now level [Level]!</font></b>"
			switch(Speciality)
				if("Taijutsu")
					Taijutsu+=T; TaijutsuMax+=T; TaijutsuTrue+=T; Cap_Taijutsu+=T
					src<<"+[T] to Taijutsu"
					BonusCap["Taijutsu"]+=T
					StatUpdate_taijutsu()
				if("Genjutsu")
					Genjutsu+=T; GenjutsuMax+=T; GenjutsuTrue+=T; Cap_Genjutsu+=T
					src<<"+[T] to Genjutsu"
					BonusCap["Genjutsu"]+=T
					StatUpdate_genjutsu()
				if("Ninjutsu")
					Ninjutsu+=T; NinjutsuMax+=T; NinjutsuTrue+=T; Cap_Ninjutsu+=T
					src<<"+[T] to Ninjutsu"
					BonusCap["Ninjutsu"]+=T
					StatUpdate_ninjutsu()
				else
					T=round(T*0.33)
					Taijutsu+=T; TaijutsuMax+=T; TaijutsuTrue+=T; Cap_Taijutsu+=T
					Ninjutsu+=T; NinjutsuMax+=T; NinjutsuTrue+=T; Cap_Ninjutsu+=T
					Genjutsu+=T; GenjutsuMax+=T; GenjutsuTrue+=T; Cap_Genjutsu+=T
					src<<"+[T] to Taijutsu"; src<<"+[T] to Ninjutsu"; src<<"+[T] to Genjutsu"
					BonusCap["Taijutsu"]+=T
					BonusCap["Ninjutsu"]+=T
					BonusCap["Genjutsu"]+=T
					StatUpdate_taijutsu()
					StatUpdate_ninjutsu()
					StatUpdate_genjutsu()

			src<<"<b><font color=silver>+[SPA] Stat Points</font></b>"
			StatPoints += SPA
			Skills()
			//src << output(Level, "mainwindow.Level")
			//src << output(StatPoints, "mainwindow.StatPoints")
			StatUpdate_level();
			StatUpdate_statpoints()
		Leveling = 0
		UpdateEXPBar()

	ExperienceCheck(D,mob/v)
		if(src !=v && !(v in MasterBunshinList))//src is the attacker.  v is the victim.
			if(Level>=MaxGain()) return
			if((client && v.client) && (client.address == v.client.address)) return
			if((FriendlyFireCheck(v))||(KI_InMission&&(src in KI_Participants))) return
			var/k=(TaijutsuMax+NinjutsuMax+GenjutsuMax)*0.35	//25% of the Average score of Tai+Nin+Gen
			var/a=(v.TaijutsuMax+v.NinjutsuMax+v.GenjutsuMax)*0.35//25% of the Average score of Tai+Nin+Gen (for the other guy)
			var/P=(k/a)*100// What Killers avg stats are Compared to Victims's. as a percent
			if(istype(v,/mob/Hittable/Responsive/VillageNinjas)) P*=1.4
			else if(istype(v,/mob/Hittable/Responsive/Boss/Minato)||istype(v,/mob/Hittable/Responsive/Boss/Viole)) P*=3.7
			else if(istype(v,/mob/Hittable)) P*=1.7
			else if(istype(v,/mob/player)) P*=5
			if(D>100) D=100
			if(a<10) a=10
			var/XPlimit=MXP*3.05
			switch(P)
				if(180 to 200) Exp+=a*0.01
				if(150 to 179) Exp+=a*0.015
				if(125 to 149) Exp+=(a*0.02)
				if(110 to 124) Exp+=(a*0.03)+D
				if(91 to 109) Exp+=((a*0.04)+(D*3))
				if(75 to 90) Exp+=((a*0.023)+(D*3))
				if(50 to 74) Exp+=((a*0.012)+(D*2.5))
				if(20 to 49) Exp+=((a*0.01)+(D*2))
				else Exp+=a*0.01
			if(v.KO&&Finishing) {Exp+=a*0.05; Finishing=0}
			if(Exp>XPlimit) Exp=XPlimit
			if(client)
				winset(src,"ExpBar","value=[round((Exp/MXP)*100)]")
			LevelUpCheck()

mob/proc/MaxGain()
	var/Max=((1.55)*((NinjutsuTrue+TaijutsuTrue+GenjutsuTrue)/1000))
	Max+=LevelBonus
	return round(Max)

obj/meter
	icon = 'ExpMeter.dmi'
	icon_state = "0"

	var/num = 0
	var/width = 30

	proc/Update()
		if(num < 0)
			num = 0
		else if(num > width)
			num = width
		icon_state = "[round(num)]"