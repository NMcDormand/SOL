mob/proc
	AIOukashou(mob/M)
		var/c=150
		if(!(TAICHECKBOTH(src,M))&&Chakra>c)
			var/dmg = round(Taijutsu*1.8-(M.Taijutsu*0.2))
			if(dmg<=round(Taijutsu*0.1)) dmg=Taijutsu*0.1
			hearers(4,src)<< "<b>[src]</b>: Oukashou!"
			attacking=1
			spawn(5)
				spawn(20)attacking=0
				flick("punch",src); Chakra-=c
				if(M&&HitCheck(M)&&M in get_step(src,dir))
					if(!M.KnockBack) M.KnockBack=1
					spawn(5)M.KnockBack=0
					Knockback(M)
					M.DamageMe(src,dmg,"strikes")
				else M<<"You dodged [src]'s attack"

	AITsuutenKyaku(mob/M)
		var/c=350
		if(!(TAICHECKBOTH(src,M))&&!Gokusamaisou&&Chakra>c)
			var/dmg = round(Taijutsu*2.3-(M.Taijutsu*0.2))
			if(dmg<=round(Taijutsu*0.25)) dmg=Taijutsu*0.25
			hearers(4,src)<< "<b>[src]</b>:  Tsuuten Kyaku!"
			attacking=1
			spawn(10)
				spawn(30)attacking=0
				flick("kick",src); Chakra-=c
				if(M&&HitCheck(M)&&M in get_step(src,dir)) M.DamageMe(src,dmg,"kick")
				else M<<"You dodged [src]'s attack"