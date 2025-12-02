obj/SkillCards/Clan/Aburame
	icon='AburameCards.dmi'
	JutsuType = "Clan-Jutsu"
mob/var
	Konchuuamount=0
	KonchuuLimit=50
	tmp/list/HasKonchuu = list()
	tmp/list/BugExplodeList = list()
	tmp
		BugArmour
		MushiKabe
		Tracking
		TrackingCooldown
mob/proc
	LearnMushiYose()
		if(NinjutsuTrue>=500&&NinjaRank!="Academy Student")
			src<<"<b><font size=2>You've just learned  <i>Mushi Yose no Jutsu</i>!</b></font>"
			KonchuuLimit+=50
			new/obj/SkillCards/Clan/Aburame/MushiYose(src)

//------------------------------------------------------------------------------------------------------------
	LearnPlaceSpyBug()
		if(NinjutsuTrue>=220&&NinjaRank!="Academy Student")
			src<<"<b><font size=2>You've just learned how to <i>Place a Bug</i>!</b></font>"
			new/obj/SkillCards/Clan/Aburame/PlaceBug(src)
//------------------------------------------------------------------------------------------------------------
	LearnLocateBug()
		if(NinjutsuTrue>=500&&NinjaRank!="Academy Student")
			var/obj/SkillCards/Clan/Aburame/LocateBug/J=locate(/obj/SkillCards/Clan/Aburame/LocateBug) in contents
			if(!(J in contents))
				src<<"<b><font size=2>You've just learned how to <i>Track a Bug</i>!</b></font>"
				new/obj/SkillCards/Clan/Aburame/LocateBug(src)
//-----------------------------------------------------------------------------------------------------------
	LearnMushiBunshin()
		if(NinjutsuTrue>=2000 && NinjaRank!="Academy Student" && NinjaRank!="Genin" && MoveUses["Bunshin"]>=500)
			src<<"<b><font size=2>You've just learned <i>Mushi Bunshin no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Aburame/MushiBunshin(src)
//-----------------------------------------------------------------------------------------------------------

	LearnMushiSwarm()
		if(NinjutsuTrue>=3500&&TaijutsuTrue>=2000&&NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&MoveUses["MushiYose"]>=50)
			src<<"<b><font size=2>You've just learned <i>Mushi Swarm</i>!</b></font>"
			new/obj/SkillCards/Clan/Aburame/MushiSwarm(src)

//-----------------------------------------------------------------------------------------------------------
	LearnMushiKabe()
		if(NinjutsuTrue>=4000&&TaijutsuTrue>=4000&&NinjaRank!="Academy Student"&&NinjaRank!="Genin")
			if(MoveUses["MushiBunshin"]>=100&&MoveUses["MushiSwarm"]>=80)
				src<<"<b><font size=2>You've just learned <i>Mushi Kabe no Jutsu</i>!</b></font>"
				new/obj/SkillCards/Clan/Aburame/MushiKabe(src)

//-----------------------------------------------------------------------------------------------------------
	LearnMushinoYoroi()
		if(NinjutsuTrue>=9000&&TaijutsuTrue>=6000&&NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&NinjaRank!="Chuunin")
			if(MoveUses["MushiSwarm"]>=200&&MoveUses["MushiKabe"]>=50)
				src<<"<b><font size=2>You've just learned <i>Mushi no Yoroi</i>!</b></font>"
				new/obj/SkillCards/Clan/Aburame/MushiNoYoroi(src)

//-----------------------------------------------------------------------------------------------------------
	LearnBugExplode()
		if(NinjutsuTrue>=35000&&TaijutsuTrue>=20000&&NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&MoveUses["MushiSwarm"]>=700)
			src<<"<b><font size=2>You've just learned <i>Bakuhatsu Mushikui</i>!</b></font>"
			new/obj/SkillCards/Clan/Aburame/BakuhatsuMushikui(src)


//------------------------------------------------------------------------------------------------------------
obj/Jutsu/Aburame
	Swarm
		name="swarm of bugs"
		icon = 'BugSwarm.dmi'
		density = 1
		notblowable=1
		Power=1
		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A)||(isobj(A)&&istype(A,/obj/Destructable)))
				var/damage
				var/mob/O=Owner
				if(ismob(A))
					var/mob/M=A
					if(M.kaiten||M.InMeatTank||M.protect||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
					if(M==O) {loc=M.loc; return}
					if(O.HitCheck(M))
						damage=JutsuDamage(Ninjutsu,M.Ninjutsu,0,0,Power)
						if(M != O.Familiar && M.Creator != O)
							if(!M.HasKonchuu[O.ckey])
								M.HasKonchuu[O.ckey] = 0
							M.HasKonchuu[O.ckey] += rand(1,10)
							if(!O.BugExplodeList)
								O.BugExplodeList = list()
							if(!(M in O.BugExplodeList))
								O.BugExplodeList +=M
							if(!O.KonchuuList)
								O.KonchuuList=list()
							if(!(M in O.KonchuuList))
								O.KonchuuList+=M
							if(!M.BuggedList)
								M.BuggedList = list()
							if(!(O in M.BuggedList))
								M.BuggedList+=O
						M.Chakra= round(M.Chakra*0.95)//drain 5% of the victims chakra
						if(M.Chakra<1) M.Chakra=1
						M.DamageMe(O,damage,src)
					else {O<<"[M] dodged your attack"; M<<"You dodged [O]'s attack"}
					del(src)
				else
					var/obj/M=A
					damage=JutsuDamage(Ninjutsu,M.Ninjutsu,0,0,Power)
					M.Destroy(damage,O); del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)
			if(istype(A,/obj/))
				if(isobj(A))
					var/obj/o = A
					if(istype(o,/obj/Weapon/Wield)) del(o)
					else del(src)