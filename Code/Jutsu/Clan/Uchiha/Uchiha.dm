obj/SkillCards/Clan/Uchiha
	icon='UchihaCards.dmi'
	JutsuType = "Clan-Jutsu"


obj/SharEye
	density = 0
	icon = 'UchihaCards.dmi'
	invisibility = 0
	layer = 4
	New(mob/M,S,T = 20)
		if(M)
			icon_state = S
			Overlay = new/Underlay_Obj('UchihaCards.dmi',0,0,24,S)
			M.overlays += Overlay
			spawn(T)
				if(M)
					M.overlays -= Overlay
				del src
		else
			spawn(100)
				del src

mob/var
	SharinganLevel
	SharinganReflexes = 0
	EternalSharingan = 0
	HasMangekyou = 0
	CanLearnSharingan
	CanLearnMangekyouSharingan
	SharinganCooldown = 900
	MangekyouCooldown = 3000
	BlindTime = 10
	tmp
		Illuminated
		ReverseGenjutsu
		Blind
		InMangekyou
		InSharingan
		InTsukuyomi
		Tsukuyomi

mob/proc
	BlindMe(var/A)
		if(!Blind)
			if(InMangekyou)
				see_invisible -= 6
			else if(InSharingan)
				see_invisible -= 5
			else
				see_invisible -= 2
		Blind++
		src << "Your vision was affected by this [A]! You need to find a solution!"
		spawn(BlindTime)
			if(Blind)
				Blind--
			if(!Blind)
				if(InMangekyou)
					see_invisible += 6
				else if(InSharingan)
					see_invisible += 5
				else
					see_invisible += 2
		BlindTime += 10

	LearnSharingan()
		if(NinjaRank!="Academy Student"&&!SharinganLevel)
			if(NinjutsuTrue>=900&&GenjutsuTrue>=1200&&TaijutsuTrue>=600&&ChakraControl>=80)
				src<<"<b><font size=2>You've just learned <i>Sharingan</i>!</b></font>"
				new/obj/SkillCards/Clan/Uchiha/Sharingan(src)
				SharinganLevel=1
		/*if(!CanLearnSharingan&&SharinganLevel==1&&NinjaRank!="Academy Student"&&NinjutsuTrue>=5500&&GenjutsuTrue>=4000&&TaijutsuTrue>=3000)
			CanLearnSharingan=2; src<<"<b><font size=2>You can now unlock a higher Sharingan level!</b></font>"
		if(CanLearnSharingan==2&&SharinganLevel==2&&NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&NinjaRank!="Chuunin"&&NinjutsuTrue>=1100&&GenjutsuTrue>=8000&&TaijutsuTrue>=5500)
			CanLearnSharingan=3; src<<"<b><font size=2>You can now unlock a higher Sharingan level!</b></font>"*/
//-------------------------------------------------------------------------------------------------------------
	LearnHigherSharingan()
		if(!CanLearnMangekyouSharingan && SharinganLevel==3 && NinjutsuTrue>=22000 && GenjutsuTrue>=22000 && TaijutsuTrue>=8000)
			src<<"<b><font size=2><i>Mangekyou Sharingan</i> is within your grasp!</b></font>"
			CanLearnMangekyouSharingan=1
//------------------------------------------------------------------------------------------------------------- //Uchiha_Kyouten
	LearnKyoutenChiten()
		if(!JutsuList["KyoutenChiten"])
			if(SharinganLevel==3&&NinjaRank!="Academy Student"&&NinjaRank!="Genin"&&NinjaRank!="Chuunin")
				if(NinjutsuTrue>=7000&&GenjutsuTrue>=10000&&TaijutsuTrue>=5000)
					src<<"<b><font size=2>You've just learned <i>Kyouten Chiten</i>!</b></font>"
					new/obj/SkillCards/Clan/Uchiha/KyoutenChiten(src)
//------------------------------------------------------------------------------------------------------------
	LearnTsukuyomi()
		if(NinjutsuTrue>=19000 && GenjutsuTrue>=30000)
			src<<"<b><font size=2>You've just learned <i>Tsukuyomi</i>!</b></font>"
			new/obj/SkillCards/Clan/Uchiha/MS/Tsukuyomi(src)
//-------------------------------------------------------------------------------------------------------------
	LearnAmaterasu()
		if(NinjutsuTrue>=22000 && FireElemental>=4000)
			src<<"<b><font size=2>You've just learned <i>Amaterasu</i>!</b></font>"
			new/obj/SkillCards/Clan/Uchiha/MS/Amaterasu(src)
//-------------------------------------------------------------------------------------------------------------
	LearnKamuiToggle()
		if(NinjutsuTrue>=38000)
			src<<"<b><font size=2>You've just learned <i>Kamui</i>!</b></font>"
			new/obj/SkillCards/Clan/Uchiha/MS/KamuiToggle(src)
//-------------------------------------------------------------------------------------------------------------
	LearnIzanami()
		if(NinjutsuTrue>=18000 && GenjutsuTrue>=28000)
			src<<"<b><font size=2>You've just learned <i>Izanami</i>!</b></font>"
			new/obj/SkillCards/Clan/Uchiha/MS/Izanami(src)
//-------------------------------------------------------------------------------------------------------------
	LearnIzanagi()
		if(GenjutsuTrue>=38000)
			src<<"<b><font size=2>You've just learned <i>Izanagi</i>!</b></font>"
			new/obj/SkillCards/Clan/Uchiha/MS/Izanagi(src)