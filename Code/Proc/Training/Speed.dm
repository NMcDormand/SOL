mob/proc/SpeedCheck()
	if(setspeed==3)
		var
			S=100000; T=5500
		//if(Village=="Cloud") {S*=0.8; T*=0.8}
		if(StaminaTrue>=S&&TaijutsuTrue>=T)
			setspeed=2; movespeed=2
			src<<"<i>Your walk/run speed has increased to <u>Level 2</u>!</i>"

	else if(setspeed==2)

		var
			S=500000; T=28000
		//if(Village=="Cloud") {S*=0.8; T*=0.8}
		if(StaminaTrue>=S&&TaijutsuTrue>=T)
			setspeed=1; movespeed=1
			src<<"<i>Your walk/run speed has increased to <u>Level 3</u>!</i>"
/*	else if(setspeed==1)
		var
			S=1000000; T=38000
		/*if(Village=="Cloud" && StaminaTrue>=S && TaijutsuTrue>=T)
			setspeed=0.4; movespeed=0.4;*/
			*/
	StatUpdate_movespeed()