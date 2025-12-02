mob/proc

	JutsuChakra(var/c)
		ApplyEXP(c*0.4,"chakra")

	JutsuSeals(var/s)
		if(SS>1)
			SSXP+=s
			if(Clan=="Kaguya"||Clan=="Yuki"||Clan=="Uchiha")
				SSXP+=(s*0.4)
			if(SSXP>=SSMXP)
				SSXP-=SSMXP; SSMXP+=750; SS--; src<<"<b>Your Seal Speed is a little faster!</b>"
				StatUpdate_sealspeed()

	JutsuNin(var/c)
		c=rand(c,c*2)
		ApplyEXP(c,"ninjutsu")
	JutsuGen(var/c)
		c=rand(c,c*2)
		ApplyEXP(c,"genjutsu")
	JutsuTai(var/c)
		c=rand(c,c*1.8)
		ApplyEXP(c,"taijutsu")

//-------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------------

//-------------------------------------------------------------------------------------------------------
	Fishingup()
		if(FishingSkillXP>=FishingSkill)//&&FishingSkill<100)
			FishingSkillXP-=FishingSkill
			FishingSkill++; FishingSkillTrue++
			if(FishingSkill<100) {FishingSkill++}
			else {FishingSkill = (FishingSkill * 1.025)}
			src<<"Your Fishing Skill increases"
			StatUpdate_Fishing()
			if(FishingSkill==100) Medal_FishingGuru()

	Miningup()
		if(MiningSkillXP>=MiningSkill&&MiningSkill<100)
			MiningSkillXP-=MiningSkill
			MiningSkill++; MiningSkillTrue++
			if(MiningSkill<100)
				MiningSkill++
			src<<"Your Mining Skill increases"
			//StatUpdate_Mining()
		//if(MiningSkill==100) Medal_MiningGuru()

	FirstAidup()
		if(FirstAidSkillXP>=FirstAidSkill&&FirstAidSkill<100)
			FirstAidSkillXP-=FirstAidSkill
			if(Class["Medical-Nin"]&&prob(50)) {FirstAidSkill++; FirstAidSkillTrue++}
			FirstAidSkill++; FirstAidSkillTrue++
			FirstAidSkill++
			src<<"Your First Aid Skill increases"
			StatUpdate_FirstAid()