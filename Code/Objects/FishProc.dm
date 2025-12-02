var/frenzyyActive
mob/proc
	CatchNothing()
		src<<"There were no bites"
		FishingSkillXP+=rand(1,2)
		if(FishingSkillXP>=FishingSkill) Fishingup()
		overlays-='Rod.dmi'
		sleep(10)
		fishing=0

	CatchEscape()
		src<<"You got a bite!"
		FishingSkillXP+=rand(2,3)
		if(FishingSkillXP>=FishingSkill) Fishingup()
		sleep(10)

		src<<"It got away..."
		overlays-='Rod.dmi'
		sleep(10)
		fishing=0

	CatchSmall()
		src<<"You got a bite!"
		FishCaught++
		FishingSkillXP+=rand(1,3)
		if(FishingSkillXP>=FishingSkill) Fishingup()
		sleep(10)

		src<<"You caught a Small Fish."
		overlays-='Rod.dmi'
		sleep(10)
		fishing=0

		spawn(-1)
			var/obj/Fish/Small/F = locate() in contents
			if(!F)
				F=new(src)
			else
				F.amount++
			UpdateInventory()

	CatchMedium()
		src<<"You got a bite!"; FishCaught++
		FishingSkillXP+=rand(2,4)
		if(FishingSkillXP>=FishingSkill) Fishingup()
		sleep(10)

		src<<"You caught a Medium Fish"
		overlays-='Rod.dmi'
		sleep(10)
		fishing=0

		spawn(-1)
			var/obj/Fish/Medium/F = locate() in contents
			if(!F)
				F=new(src)
			else
				F.amount++
			UpdateInventory()

	CatchLarge()
		src<<"You got a bite!"
		FishCaught++
		FishingSkillXP+=rand(3,6)
		if(FishingSkillXP>=FishingSkill) Fishingup()
		sleep(10)

		src<<"You caught a Large Fish"
		overlays-='Rod.dmi'
		sleep(10)
		fishing=0

		spawn(-1)
			var/obj/Fish/Large/F = locate() in contents
			if(!F)
				F=new(src)
			else
				F.amount++
			UpdateInventory()

	CatchLava()
		src<<"You got a bite!"; FishCaught++
		FishingSkillXP+=rand(4,10)
		if(FishingSkillXP>=FishingSkill) Fishingup()
		sleep(10)

		src<<"You caught a Lava Fish!"
		overlays-='Rod.dmi'
		sleep(10)
		fishing=0

		spawn(-1)
			var/obj/Fish/Lava/F = locate() in contents
			if(!F)
				F=new(src)
			else
				F.amount++
			UpdateInventory()

	CatchShadow()
		src<<"You got a bite!"; FishCaught++
		FishingSkillXP+=rand(5,15)
		if(FishingSkillXP>=FishingSkill) Fishingup()
		sleep(10)

		src<<"You caught a Shadow Fish!"
		overlays-='Rod.dmi'
		sleep(10)
		fishing=0

		spawn(-1)
			var/obj/Fish/Shadow/F = locate() in contents
			if(!F)
				F=new(src)
			else
				F.amount++
			UpdateInventory()

	CatchAngel()
		src<<"You got a bite!"; FishCaught++
		FishingSkillXP+=rand(10,30)
		if(FishingSkillXP>=FishingSkill) Fishingup()
		sleep(10)

		src<<"You caught an Angel Fish!"
		overlays-='Rod.dmi';
		sleep(10)
		fishing=0

		spawn(-1)
			var/obj/Fish/Angel/F = locate() in contents
			if(!F)
				F=new(src)
			else
				F.amount++
			UpdateInventory()

	CatchRainbow()
		src<<"You got a bite!"; FishCaught++
		FishingSkillXP+=rand(20,45)
		if(FishingSkillXP>=FishingSkill) Fishingup()
		sleep(10)

		src<<"You caught a Rainbow Fish!"
		overlays-='Rod.dmi'
		sleep(10)
		fishing=0

		spawn(-1)
			var/obj/Fish/Rainbow/F = locate() in contents
			if(!F)
				F=new(src)
			else
				F.amount++
			UpdateInventory()

	CollectFishProcedure(obj/B)
		var/alert=0
		var/list/FL = B.FishyList
		var/msg = ""
		for(var/A in FL)
			var/FC = FL[A]
			if(FC)
				if(!alert)
					alert = 1
				msg += "You collected [FC] [A] Fish.<br>"
				var/FT = text2path("/obj/Fish/[A]")
				var/obj/Fish/F = locate(FT) in src
				if(!F)
					F = new FT(src)
				else
					F.amount += FC
				FL -= A
		if(alert)
			src << msg
			if(B.Placed != trueName)
				for(var/mob/player/p in MasterPlayerList)
					if(B.Placed==p.trueName) p<<"<b><i>[src] stole fish from your Fishing Box!</b></i>"
			UpdateInventory()
		else
			usr << "There were no Fish caught in the Fishing Box"

		/*if(B.FishyList["Medium"])
			if(B.Placed!=name) alert=1
			usr<<"You collected [B.FishyList["Medium"]] Medium Fish."
			var/counter=0
			for(var/obj/Fish/Medium/F in contents) counter++
			if(counter<=0)
				var/obj/Fish/Medium/F=new(src)
				F.amount=B.FishyList["Medium"]
				F.Checkamount()
			else
				for(var/obj/Fish/Medium/F in contents)
					F.amount+=B.FishyList["Medium"]; F.Checkamount()
			B.FishyList["Medium"]=0

		if(B.FishyList["Large"])
			if(B.Placed!=name) alert=1
			usr<<"You collected [B.FishyList["Large"]] Large Fish."
			var/counter=0
			for(var/obj/Fish/Large/F in contents) counter++
			if(counter<=0)
				var/obj/Fish/Large/F=new(src)
				F.amount=B.FishyList["Large"]
				F.Checkamount()
			else
				for(var/obj/Fish/Large/F in contents)
					F.amount+=B.FishyList["Large"]; F.Checkamount()
			B.FishyList["Large"]=0

		if(B.FishyList["Lava"])
			if(B.Placed!=name) alert=1
			usr<<"You collected [B.FishyList["Lava"]] Lava Fish."
			var/counter=0
			for(var/obj/Fish/Lava/F in contents) counter++
			if(counter<=0)
				var/obj/Fish/Lava/F=new(src)
				F.amount=B.FishyList["Lava"]
				F.Checkamount()
			else
				for(var/obj/Fish/Lava/F in contents)
					F.amount+=B.FishyList["Lava"]; F.Checkamount()
			B.FishyList["Lava"]=0

		if(B.FishyList["Shadow"])
			if(B.Placed!=name) alert=1
			usr<<"You collected [B.FishyList["Shadow"]] Shadow Fish."
			var/counter=0
			for(var/obj/Fish/Shadow/F in contents) counter++
			if(counter<=0)
				var/obj/Fish/Shadow/F=new(src)
				F.amount=B.FishyList["Shadow"]
				F.Checkamount()
			else
				for(var/obj/Fish/Shadow/F in contents)
					F.amount+=B.FishyList["Shadow"]; F.Checkamount()
			B.FishyList["Shadow"]=0

		if(B.FishyList["Rainbow"])
			if(B.Placed!=name) alert=1
			usr<<"You collected [B.FishyList["Rainbow"]] Rainbow Fish."
			var/counter=0
			for(var/obj/Fish/Rainbow/F in contents) counter++
			if(counter<=0)
				var/obj/Fish/Rainbow/F=new(src)
				F.amount=B.FishyList["Rainbow"]
				F.Checkamount()
			else
				for(var/obj/Fish/Rainbow/F in contents)
					F.amount+=B.FishyList["Rainbow"]; F.Checkamount()
			B.FishyList["Rainbow"]=0
		UpdateInventory()*/

obj/proc
	FishingBoxProcedure(mob/M)
		set waitfor = 0, background = 1
		while(Placed&&M)
			switch(pick(1,prob(25); 2,prob(15); 3,prob(5); 4,prob(2); 5,prob(1); 6))
				if(2) FishyList["Medium"]++
				if(3) FishyList["Large"]++
				if(4) FishyList["Lava"]++
				if(5) FishyList["Shadow"]++
				if(6) FishyList["Rainbow"]++
		#if DEBUGGING
			sleep(10)
		#else
			sleep(150)
		#endif
		if(!M) del(src)

obj/var/list
	tmp/Placed
	FishyList[]

mob/VerbHolder/Admin/Creator/verb
	FishFrenzy()
		if(!frenzyyActive)
			frenzyyActive = 1
			world<<"<font color=red><b>[usr] has tossed some bait and caused a Fish Frenzy!</b></font>"
			spawn(4000)
				if(frenzyyActive)
					world<<"<font color=red>The fish swim off...</b></font>"
					frenzyyActive = 0

		else
			frenzyyActive = 0
			world<<"<font color=red><b>The fish swim off...</b></font>"
			feathers = 1