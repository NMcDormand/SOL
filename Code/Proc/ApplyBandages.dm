mob/proc
	ApplyBandages(mob/patient)
		if(patient)
			src<<"You apply bandages to [patient]'s wounds."; patient<<"[src] applys bandages to your wounds."
			patient.BandagesUsed++
			if(!UsingBandages) UsingBandages=1
			patient.BandageCheck(patient.BandageUses)
			var/X=(FirstAidSkill/8)
			var/T = 0
			for(var/i=0, i<8, i++)
				if(!patient)
					break
				patient.Wounds-=X
				T += X
				TextOverlay(patient, X, "health");
				if(patient.Wounds<18) {patient.Wounds=18; patient.RefreshWounds(); break}
				else patient.RefreshWounds()
				sleep(5)
			/*if(KI_InMission&&(src in KI_Participants))
				KonohaInvasionPoints+=T
				Refresh_InvasionScore()*/
		else
			src<<"You apply bandages to your wounds."; BandagesUsed++
			if(!UsingBandages) UsingBandages=1
			BandageCheck(BandageUses)
			var/X=(FirstAidSkill/8)
			for(var/i=0, i<8, i++)
				if(!src)
					return
				Wounds-=X
				TextOverlay(src, X, "health");
				if(Wounds<18) {Wounds=18; RefreshWounds(); break}
				else RefreshWounds()
				sleep(5)
		UsingBandages=0
		FirstAidSkillXP+=rand(100,200)*0.01; FirstAidup()
		for(var/obj/Item/Bandages/B in contents)
			B.amount--; B.Checkamount()
			if(B.amount<=0) del(B)
		UpdateInventory()

	BandageCheck(U)
		spawn(400)
			if(BandageUses==U&&U>0)
				BandageUses--; U--
				BandageCheck(U)