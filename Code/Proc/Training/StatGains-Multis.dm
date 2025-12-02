mob/proc
	StamUpTree()
		if(!(istype(src,/mob/Clones)))
			if(src.StaminaXP>=src.StaminaMXP)
				var
					g=pick(8,9,10)
					stamXPgain=0.2
				g *= Multipliers["Stamina"]
				if(src.StaminaTrue>=src.Cap_Stamina) {g*=0.1; stamXPgain*=0.1}
				src.StaminaMax += g; src.StaminaTrue += g
				src<<"Your Stamina increased"; src.RefreshStamina()
				src.StaminaXP-=src.StaminaMXP; src.StaminaMXP+=stamXPgain

	ChakraUp()
		if(src.ChakraXP>=src.ChakraMXP)
			var
				g=pick(6,7,8)
			g *= Multipliers["Chakra"]
			src.ChakraTrue+=g; src.ChakraMax+=g
			src.ChakraXP-=src.ChakraMXP; src.ChakraMXP+=10
			src.RefreshChakra(); src<<"<font color=#337de2>Your Chakra has increased.</font>"
			spawn(5) src.ChakraUp()

	CCGain(C)
		if(src.ChakraControl<100)
			if(!C) C=rand(C*0.1,C*0.4)
			src.ChakraControlXP+=C
			if(src.ChakraControlXP>=src.ChakraControlMXP)
				src.ChakraControl++; src.ChakraControl++
				src.ChakraControlXP-=src.ChakraControlMXP; src.ChakraControlMXP+=8
				src.StatUpdate_chakracontrol(); src<<"<font color=#185ebd>Your Chakra Control improved.</font>"

	Taiup()
		if(src.TaijutsuXP>=src.TaijutsuMXP&&!istype(src,/mob/Clones))
			var
				ExpGain=2
				Gain=pick(5,6,7,8,9,10)
			Gain=src.SpecialtyBoost(Gain,"Taijutsu")
			Gain *= Multipliers["Taijutsu"]
			if(src.TaijutsuTrue>=src.Cap_Taijutsu) {Gain*=0.25; ExpGain*=0.10}
			src.TaijutsuMax+=Gain; src.Taijutsu+=Gain; src.TaijutsuTrue+=Gain
			src.TaijutsuXP-=src.TaijutsuMXP; src.TaijutsuMXP+=ExpGain
			if(src.TaijutsuXP>=src.TaijutsuMXP)
				spawn(1) src.Taiup()
			else {src<<"Your Taijutsu increases."; src.StatUpdate_taijutsu()}

	TaiupStatic()
		if(src.TaijutsuXP>=src.TaijutsuMXP&&!istype(src,/mob/Clones))
			var
				ExpGain=2
				Gain=5
			Gain=src.SpecialtyBoost(Gain,"Taijutsu")
			Gain*=Multipliers["Taijutsu"]
			if(src.TaijutsuTrue>=src.Cap_Taijutsu) {Gain*=0.25; ExpGain*=0.10}
			src.TaijutsuMax+=Gain; src.Taijutsu+=Gain; src.TaijutsuTrue+=Gain
			src.TaijutsuXP-=src.TaijutsuMXP; src.TaijutsuMXP+=ExpGain
			if(src.TaijutsuXP>=src.TaijutsuMXP)
				spawn(1) src.TaiupStatic()
			else {src<<"Your Taijutsu increases."; src.StatUpdate_taijutsu()}

	Ninup()
		if(!(istype(src,/mob/Clones)))
			if(src.NinjutsuXP>=src.NinjutsuMXP)
				var
					ExpGain=1
					Gain=pick(8,10,12,14,16,18,20)
				Gain=src.SpecialtyBoost(Gain,"Ninjutsu")
				Gain*=Multipliers["Ninjutsu"]
				if(src.NinjutsuTrue>=src.Cap_Ninjutsu) {Gain*=0.25; src.NinjutsuMXP+=(ExpGain*0.10)}
				src.NinjutsuMax+=Gain; src.Ninjutsu+=Gain; src.NinjutsuTrue+=Gain
				src.NinjutsuXP-=src.NinjutsuMXP; src.NinjutsuMXP+=ExpGain
				if(src.NinjutsuXP>=src.NinjutsuMXP)
					spawn(1) src.Ninup()
				else {src<<"Your Ninjutsu increases."; src.StatUpdate_ninjutsu()}

	Genup()
		if(!(istype(src,/mob/Clones)))
			if(src.GenjutsuXP>=src.GenjutsuMXP)
				var
					ExpGain=1
					Gain=rand(14,20)
				Gain=src.SpecialtyBoost(Gain,"Genjutsu")
				Gain *= Multipliers["Genjutsu"]
				if(src.GenjutsuTrue>=src.Cap_Genjutsu) {Gain*=0.25; src.GenjutsuMXP+=(ExpGain*0.10)}
				src.GenjutsuMax+=Gain; src.Genjutsu+=Gain; src.GenjutsuTrue+=Gain
				src.GenjutsuXP-=src.GenjutsuMXP; src.GenjutsuMXP+=ExpGain
				if(src.GenjutsuXP>=src.GenjutsuMXP)
					spawn(1) src.Genup()
				else {src<<"Your Genjutsu increases."; src.StatUpdate_genjutsu()}

	ReflexUp()
		if(!(istype(src,/mob/Clones)))
			if(src.ReflexExp>=src.ReflexMXP)
				if(src.TrueReflex<200)
					src.Reflex++; src.TrueReflex++
					src<<"<b>Your reflexes improved!</b>"
					src.ReflexExp-=src.ReflexMXP
					if(src.TrueReflex<180)
						src.ReflexMXP=(src.TrueReflex*60)+500
					else
						src.ReflexMXP=(src.TrueReflex*80)+600
					src.StatUpdate_reflexes()

	WindElementalup(gain)
		var
			x=0.5
			boost=0
		if(gain=="low")x=0.28
		if(src.PE=="Wind")
			boost+=src.BoostModifier("primary")
			spawn(2) src.StatUpdate_primaryelement()
		else if(src.SE=="Wind")
			boost+=src.BoostModifier("secondary")
			spawn(2) src.StatUpdate_secondaryelement()
		x*=(1+(boost))
		src.WindElemental+=x

	WaterElementalup(gain)
		var
			x=0.5
			boost=0
		if(gain=="low")x=0.28
		if(src.PE=="Water")
			boost+=src.BoostModifier("primary")
			spawn(2) src.StatUpdate_primaryelement()
		else if(src.SE=="Water")
			boost+=src.BoostModifier("secondary")
			spawn(2) src.StatUpdate_secondaryelement()
		x*=(1+(boost))
		src.WaterElemental+=x

	EarthElementalup()
		var
			x=0.5
			boost=0
		if(src.PE=="Earth")
			boost+=src.BoostModifier("primary")
			spawn(2) src.StatUpdate_primaryelement()
		else if(src.SE=="Earth")
			boost+=src.BoostModifier("secondary")
			spawn(2) src.StatUpdate_secondaryelement()
		x*=(1+(boost))
		src.EarthElemental+=x

	LightningElementalup(gain)
		var
			x=0.5
			boost=0
		if(gain=="low")x=0.28
		if(src.PE=="Lightning")
			boost+=src.BoostModifier("primary")
			spawn(2) src.StatUpdate_primaryelement()
		else if(src.SE=="Lightning")
			boost+=src.BoostModifier("secondary")
			spawn(2) src.StatUpdate_secondaryelement()
		x*=(1+(boost))
		src.LightningElemental+=x

	FireElementalup()
		var
			x=0.5
			boost=0
		if(src.PE=="Fire")
			boost+=src.BoostModifier("primary")
			spawn(2) src.StatUpdate_primaryelement()
		else if(src.SE=="Fire")
			boost+=src.BoostModifier("secondary")
			spawn(2) src.StatUpdate_secondaryelement()
		x*=(1+(boost))
		src.FireElemental+=x

	Knifeup()
		if(src.KnifeSkillXP>=src.KnifeSkillMXP&&src.Stamina>15&&!(istype(src,/mob/Clones)))
			var
				x=1
			src.KnifeSkill+=x; src.TrueKnifeSkill+=x
			src.KnifeSkillXP-=src.KnifeSkillMXP; src.KnifeSkillMXP+=0.5
			if(src.KnifeSkillXP>=src.KnifeSkillMXP&&src.Stamina>15)
				spawn() src.Knifeup()
			else
				src<<"Your Knife Skill increases"; src.StatUpdate_Kunai()

	Swordup()
		if(src.SwordSkillXP>=src.SwordSkillMXP&&src.Stamina>15&&!(istype(src,/mob/Clones)))
			var
				x=1
			src.SwordSkill+=x; src.TrueSwordSkill+=x;
			src.SwordSkillXP-=src.SwordSkillMXP; src.SwordSkillMXP+=0.5
			if(src.SwordSkillXP>=src.SwordSkillMXP&&src.Stamina>15)
				spawn() src.Swordup()
			else
				src<<"Your Sword Skill increases"; src.StatUpdate_Sword()

	H2Hup()
		if(src.H2HSkillXP>=src.H2HSkillMXP&&src.Stamina>15&&!(istype(src,/mob/Clones)))
			var
				x=1
			src.H2HSkill+=x; src.TrueH2HSkill+=x
			src.H2HSkillXP-=src.H2HSkillMXP; src.H2HSkillMXP+=0.5
			if(src.H2HSkillXP>=src.H2HSkillMXP&&src.Stamina>15)
				spawn() src.H2Hup()
			else
				src<<"Your Hand-to-Hand Skill increases"; src.StatUpdate_Unarmed()

	Throwingup()
		if(src.ThrowingSkillXP>=src.ThrowingSkillMXP)
			var
				x=1
			src.ThrowingSkill+=x; src.TrueThrowingSkill+=x
			src.ThrowingSkillXP-=src.ThrowingSkillMXP; src.ThrowingSkillMXP+=0.3
			if(src.ThrowingSkillXP>=src.ThrowingSkillMXP)
				spawn() src.Throwingup()
			else
				src<<"Your Throwing Skill increases"; src.StatUpdate_Throwing()