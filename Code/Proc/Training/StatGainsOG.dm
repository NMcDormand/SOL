var
	MultiGainChance = 0.001

mob/proc
	StamUp()
		set waitfor = 0
		if(istype(src,/mob/Hittable/Responsive/Animal/Pet/Dog))
			var/mob/player/O = Master
			if(O)
				O.DogStaminaMax=StaminaMax; O.DogTaijutsu=Taijutsu
				O.DogTaijutsuXP=TaijutsuXP; O.DogStaminaExp=StaminaXP; O.DogStaminaMXP=StaminaMXP
		else
			if(StaminaMXP <= 0)
				StaminaMXP = StaminaXP
				src << "Your Stamina XP has been repaired"
			var/Up = 0
			while(StaminaXP>=StaminaMXP)
				var
					stamXP=1
					Gain=pick(45,50,55)
				if(prob(5)) Gain*=2

				var/CB = 1
				switch(Clan)
					if("Inuzuka","Hyuuga")
						CB += 0.35
					if("Yuki","Uchiha")
						CB += 0.3
					if("Kaguya","Aburame")
						CB += 0.4
					//if("Taijutsu Specialist") CB += 0.5
					if("Uzumaki")
						CB += 0.45
					else
						CB += 0.5
				Gain *= CB
				if(prob(MultiGainChance))
					Multipliers["Stamina"]+=0.01
				if(StaminaTrue>=Cap_Stamina) {Gain*=0.1; stamXP*=0.1}
				StaminaMax += Gain; StaminaTrue += Gain
				StaminaXP-=StaminaMXP; StaminaMXP+=stamXP
				RefreshStamina()
				Up = 1

			if(Up)
				src<<"<i><font size=1 color=#99FF99>Your Stamina increased!</i></font>";

	StamUpTree()
		set waitfor = 0
		if(istype(src,/mob/Hittable/Command/Clones))
			return
		if(StaminaMXP <= 0)
			StaminaMXP = StaminaXP
			src << "Your Stamina XP has been repaired"
		var/Up = 0
		while(StaminaXP>=StaminaMXP)
			var
				Gain=pick(8,9,10)
				stamXPgain=0.2

			var/CB = 1
			switch(Clan)
				if("Inuzuka","Hyuuga")
					CB += 0.35
				if("Yuki","Uchiha")
					CB += 0.3
				if("Kaguya","Aburame")
					CB += 0.4
				//if("Taijutsu Specialist") CB += 0.5
				if("Uzumaki")
					CB += 0.45
				else
					CB += 0.5
			Gain *= CB
			if(prob(MultiGainChance))
				Multipliers["Stamina"]+=0.01
			if(StaminaTrue>=Cap_Stamina) {Gain*=0.1; stamXPgain*=0.1}
			StaminaMax += Gain; StaminaTrue += Gain
			StaminaXP-=StaminaMXP; StaminaMXP+=stamXPgain
			Up = 1

		if(Up)
			src<<"<i><font size=1 color=#99FF99>Your Stamina increased!</i></font>";
			RefreshStamina()

	ChakraUp()
		set waitfor = 0
		if(istype(src,/mob/Hittable/Command/Clones))
			return
		if(ChakraMXP <= 0)
			ChakraMXP = ChakraXP
			src << "Your Chakra XP has been repaired"
		var/Up = 0
		while(ChakraXP>=ChakraMXP)
			var
				Gain=pick(6,7,8)

			var/CB = 1
			switch(Clan)
				if("Aburame","Kaguya")
					CB += 0.25
				if("Aburame")
					CB += 0.35
				if("Nara")
					CB += 0.4
				if("Yuki","Uchiha")
					CB += 0.5
				if("Uzumaki")
					CB += 0.45
				else
					CB += 0
			Gain *= CB

			if(prob(MultiGainChance))
				Multipliers["Chakra"]+=0.01

			ChakraTrue+=Gain; ChakraMax+=Gain
			ChakraXP-=ChakraMXP; ChakraMXP+=10
			Up = 1
		if(Up)
			src<<"<i><font size=1 color=#9999FF>Your Chakra increased!</i></font>";
			RefreshChakra()

	CCGain(C)
		if(ChakraControlTrue<100)
			if(!C) C=rand(C*0.1,C*0.4)
			var/CB = 1
			switch(Clan)
				if("Hyuuga","Yuki","Nara")
					CB += 0.3
				if("Taijutsu Specialist","Uzumaki")
					CB += -0.1
				else
					CB += 0.1
			C *= CB

			ChakraControlXP+=C
			if(ChakraControlMXP <= 0)
				ChakraControlMXP = ChakraControlXP
				src << "Your Chakra Control XP has been repaired"
			if(ChakraControlXP>=ChakraControlMXP)
				ChakraControlTrue++; ChakraControl++
				ChakraControlXP-=ChakraControlMXP; ChakraControlMXP+=8
				StatUpdate_chakracontrol();
				src<<"<i><font size=1 color=#5555BB>Your Chakra Control improved!</i></font>";

	Taiup()
		set waitfor = 0
		if(istype(src,/mob/Hittable/Command/Clones))
			return
		if(TaijutsuMXP <= 0)
			TaijutsuMXP = TaijutsuXP
			src << "Your Taijutsu XP has been repaired"
		var/Up = 0
		while(TaijutsuXP>=TaijutsuMXP)
			var
				ExpGain=2
				Gain=pick(8,10,12,14,16,18,20)
			Gain=SpecialtyBoost(Gain,"Taijutsu")
			var/CB = 1
			switch(Clan)
				if("Taijutsu Specialist")
					CB += 0.8
				if("Hyuuga","Kaguya","Akimichi")
					CB += 0.6
				if("Uchiha")
					CB += 0.3
				if("Inuzuka")
					CB += 0.2
				if("Aburame","Nara","Yuki")
					CB += 0
				else
					CB += 0.2

			Gain *= CB
			if(prob(MultiGainChance))
				Multipliers["Taijutsu"]+=0.01
			if(TaijutsuTrue>=Cap_Taijutsu)
				Gain*=0.15; ExpGain*=0.10
			TaijutsuMax+=Gain; Taijutsu+=Gain; TaijutsuTrue+=Gain
			TaijutsuXP-=TaijutsuMXP; TaijutsuMXP+=ExpGain
			Up = 1
		if(Up)
			src<<"<i><font size=1 color=#20CC20>Your Taijutsu increased!</i></font>";
			StatUpdate_taijutsu()

	TaiupStatic()
		set waitfor = 0
		if(istype(src,/mob/Hittable/Command/Clones))
			return
		if(TaijutsuMXP <= 0)
			TaijutsuMXP = TaijutsuXP
			src << "Your Taijutsu XP has been repaired"
		var/Up = 0
		while(TaijutsuXP>=TaijutsuMXP)
			var
				ExpGain=2
				Gain=5
			Gain=SpecialtyBoost(Gain,"Taijutsu")
			var/CB = 1
			switch(Clan)
				if("Taijutsu Specialist")
					CB += 0.8
				if("Hyuuga","Kaguya","Akimichi")
					CB += 0.6
				if("Uchiha")
					CB += 0.3
				if("Inuzuka")
					CB += 0.2
				if("Aburame","Nara","Yuki")
					CB += 0
				else
					CB += 0.2

			Gain *= CB
			if(prob(MultiGainChance))
				Multipliers["Taijutsu"]+=0.01
			if(TaijutsuTrue>=Cap_Taijutsu) {Gain*=0.15; ExpGain*=0.10}
			TaijutsuMax+=Gain; Taijutsu+=Gain; TaijutsuTrue+=Gain
			TaijutsuXP-=TaijutsuMXP; TaijutsuMXP+=ExpGain
			Up = 1
		if(Up)
			src<<"<i><font size=1 color=#20CC20>Your Taijutsu increased!</i></font>";
			StatUpdate_taijutsu()

	Ninup()
		set waitfor = 0
		if(istype(src,/mob/Hittable/Command/Clones))
			return
		if(NinjutsuMXP <= 0)
			NinjutsuMXP = NinjutsuXP
			src << "Your Ninjutsu XP has been repaired"
		var/Up = 0
		while(NinjutsuXP>=NinjutsuMXP)
			var
				ExpGain=1
				Gain=pick(8,10,12,14,16,18,20)
			Gain=SpecialtyBoost(Gain,"Ninjutsu")
			var/CB = 1
			switch(Clan)
				if("Uchiha")
					CB += 0.5
				if("Nara")
					CB += 0.4
				if("Aburame")
					CB += 0.6
				if("Yuki")
					CB += 0.75
				if("Taijutsu Specialist")
					CB += 0
				else
					CB += 0.1
			Gain *= CB
			if(prob(MultiGainChance))
				Multipliers["Ninjutsu"]+=0.01
			if(NinjutsuTrue>=Cap_Ninjutsu) {Gain*=0.25; NinjutsuMXP+=(ExpGain*0.10)}
			NinjutsuMax+=Gain; Ninjutsu+=Gain; NinjutsuTrue+=Gain
			NinjutsuXP-=NinjutsuMXP; NinjutsuMXP+=ExpGain
			Up = 1
		if(Up)
			src<<"<i><font size=1 color=#CC2020>Your Ninjutsu increased!</i></font>";
			StatUpdate_ninjutsu()

	Genup()
		set waitfor = 0
		if(istype(src,/mob/Hittable/Command/Clones))
			return
		if(GenjutsuMXP <= 0)
			GenjutsuMXP = GenjutsuXP
			src << "Your Genjutsu XP has been repaired"
		var/Up = 0
		while(GenjutsuXP>=GenjutsuMXP)
			var
				ExpGain=1
				Gain=rand(14,20)
			Gain=SpecialtyBoost(Gain,"Genjutsu")
			var/CB = 1
			switch(Clan)
				if("Uchiha")
					CB += 1.5
				if("Aburame","Nara")
					CB += 0.4
				if("Inuzuka")
					CB += 0.2
				if("Taijutsu Specialist","Kaguya")
					CB += 0.1
				else
					CB += 0.1
			Gain *= CB
			if(prob(MultiGainChance))
				Multipliers["Genjutsu"]+=0.01
			if(GenjutsuTrue>=Cap_Genjutsu) {Gain*=0.25; GenjutsuMXP+=(ExpGain*0.10)}
			GenjutsuMax+=Gain; Genjutsu+=Gain; GenjutsuTrue+=Gain
			GenjutsuXP-=GenjutsuMXP; GenjutsuMXP+=ExpGain
			Up = 1
		if(Up)
			src<<"<i><font size=1 color=#C8A2C8>Your Genjutsu increased!</i></font>";
			StatUpdate_genjutsu()

	ReflexUp()
		if(!(istype(src,/mob/Hittable/Command/Clones)))
			if(ReflexMXP <= 0)
				ReflexMXP = ReflexExp
				src << "Your Reflex XP has been repaired"
			if(ReflexExp>=ReflexMXP)
				if(ReflexTrue>=RFXMax)return
				Reflex++; ReflexTrue++
				src<<"<i><font size=1 color=silver>Your Reflexes improved!</i></font>";
				ReflexExp-=ReflexMXP
				if(ReflexTrue<450)
					ReflexMXP=(ReflexTrue*60)+500
				else
					ReflexMXP=(ReflexTrue*80)+600
				StatUpdate_reflexes()

	ElementalUp(Type, Gain = 1) //CHANGEME on Stat Skin Update
		if(Type)
			var
				boost=0
			if(PE==Type)
				boost += BoostModifier("primary")
			else if(SE==Type)
				boost += BoostModifier("secondary")
			Gain *= 1+boost
			vars["[Type]Elemental"] += Gain
			StatUpdate_primaryelement()
			StatUpdate_secondaryelement()

	Knifeup()
		set waitfor = 0
		if(istype(src,/mob/Hittable/Command/Clones))
			return
		if(KnifeSkillMXP <= 0)
			KnifeSkillMXP = KnifeSkillXP
			src << "Your Knife Skill XP has been repaired"
		var/Up = 0
		while(KnifeSkillXP>=KnifeSkillMXP)
			var
				x=1
			KnifeSkill+=x; KnifeSkillTrue+=x
			KnifeSkillXP-=KnifeSkillMXP; KnifeSkillMXP+=0.5
			Up = 1
		if(Up)
			src<<"<i><font size=1 color=silver>Your Knife Skill increased!</i></font>";
			StatUpdate_Kunai()

	Swordup()
		set waitfor = 0
		if(istype(src,/mob/Hittable/Command/Clones))
			return
		if(SwordSkillMXP <= 0)
			SwordSkillMXP = SwordSkillXP
			src << "Your Sword Skill XP has been repaired"
		var/Up = 0
		while(SwordSkillXP>=SwordSkillMXP)
			var
				x=1
			SwordSkill+=x; SwordSkillTrue+=x;
			SwordSkillXP-=SwordSkillMXP; SwordSkillMXP+=0.5
			Up = 1
		if(Up)
			src<<"<i><font size=1 color=silver>Your Sword Skill increased!</i></font>";
			StatUpdate_Sword()

	Fanup()
		set waitfor = 0
		if(istype(src,/mob/Hittable/Command/Clones))
			return
		if(FanSkillMXP <= 0)
			FanSkillMXP = FanSkillXP
			src << "Your Fan Skill XP has been repaired"
		var/Up = 0
		while(FanSkillXP>=FanSkillMXP)
			var
				x=1
			FanSkill+=x; FanSkillTrue+=x;
			FanSkillXP-=FanSkillMXP; FanSkillMXP+=0.5
			Up = 1
		if(Up)
			src<<"<i><font size=1 color=silver>Your Fan Skill increased!</i></font>";
			//StatUpdate_Sword()

	Axeup()
		set waitfor = 0
		if(istype(src,/mob/Hittable/Command/Clones))
			return
		if(AxeSkillMXP <= 0)
			AxeSkillMXP = AxeSkillXP
			src << "Your Axe Skill XP has been repaired"
		var/Up = 0
		while(AxeSkillXP>=AxeSkillMXP)
			var
				x=1
			AxeSkill+=x; AxeSkillTrue+=x;
			AxeSkillXP-=AxeSkillMXP; AxeSkillMXP+=0.5
			Up = 1
		if(Up)
			src<<"<i><font size=1 color=silver>Your Axe Skill increased!</i></font>";
			//StatUpdate_Sword()

	Staffup()
		set waitfor = 0
		if(istype(src,/mob/Hittable/Command/Clones))
			return
		if(StaffSkillMXP <= 0)
			StaffSkillMXP = StaffSkillXP
			src << "Your Staff Skill XP has been repaired"
		var/Up = 0
		while(StaffSkillXP>=StaffSkillMXP)
			var
				x=1
			StaffSkill+=x; StaffSkillTrue+=x;
			StaffSkillXP-=StaffSkillMXP; StaffSkillMXP+=0.5
			Up = 1
		if(Up)
			src<<"<i><font size=1 color=silver>Your Staff Skill increased!</i></font>";
			//StatUpdate_Sword()

	Scytheup()
		set waitfor = 0
		if(istype(src,/mob/Hittable/Command/Clones))
			return
		if(ScytheSkillMXP <= 0)
			ScytheSkillMXP = ScytheSkillXP
			src << "Your Scythe Skill XP has been repaired"
		var/Up = 0
		while(ScytheSkillXP>=ScytheSkillMXP)
			var
				x=1
			ScytheSkill+=x; ScytheSkillTrue+=x;
			ScytheSkillXP-=ScytheSkillMXP; ScytheSkillMXP+=0.5
			Up = 1
		if(Up)
			src<<"<i><font size=1 color=silver>Your Scythe Skill increased!</i></font>";
			//StatUpdate_Sword()

	H2Hup()
		set waitfor = 0
		if(istype(src,/mob/Hittable/Command/Clones))
			return
		var/Up = 0
		if(H2HSkillMXP <= 0)
			H2HSkillMXP = H2HSkillXP
			src << "Your Hand-to-Hand Skill XP has been repaired"
		while(H2HSkillXP>=H2HSkillMXP)
			var
				x=1
			H2HSkill+=x; H2HSkillTrue+=x
			H2HSkillXP-=H2HSkillMXP; H2HSkillMXP+=0.5
			Up = 1
		if(Up)
			src<<"<i><font size=1 color=silver>Your Hand-to-Hand Skill increased!</i></font>";
			StatUpdate_Unarmed()

	Throwingup()
		set waitfor = 0
		if(istype(src,/mob/Hittable/Command/Clones))
			return
		var/Up = 0
		if(ThrowingSkillMXP <= 0)
			ThrowingSkillMXP = ThrowingSkillXP
			src << "Your Throwing Skill XP has been repaired"
		while(ThrowingSkillXP>=ThrowingSkillMXP)
			var
				x=1
			ThrowingSkill+=x; ThrowingSkillTrue+=x
			ThrowingSkillXP-=ThrowingSkillMXP; ThrowingSkillMXP+=0.3
			Up = 1
		if(Up)
			src<<"<i><font size=1 color=silver>Your Throwing Skill increased!</i></font>";
			StatUpdate_Throwing()
/*
	up()
		if(SkillXP>=SkillMXP&&Stamina>15&&!(istype(src,/mob/Hittable/Command/Clones)))
			var
				x=1
			Skill+=x; SkillTrue+=x;
			SkillXP-=SkillMXP; SkillMXP+=0.5
			if(SkillXP>=SkillMXP&&Stamina>15)
				spawn() up()
			else
				src<<"Your  Skill increases"; //StatUpdate_Sword()
*/