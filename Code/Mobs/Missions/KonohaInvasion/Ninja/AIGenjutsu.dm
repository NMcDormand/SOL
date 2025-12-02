mob/proc
	AI_Kokuangyou(mob/M)
		var
			c=280; s=SS*17
		if(Chakra>c&&!(GENERICATTACKCHECK(src)))
			icon_state="seals"
			firing=1
			spawn(s)
				spawn(1)icon_state=null
				spawn(20)firing=0
				Chakra-=c
				hearers(4,src)<<"<b>[src]: Kokuangyou no Jutsu!</b>"
				var/BlindTime=0
				if(M && src)
					var/diff=((M.Genjutsu/Genjutsu)*100)
					if(M.Clan=="Aburame") diff*=2
					if(diff < 56) BlindTime=330
					else if(diff in 56 to 75) BlindTime=230
					else if(diff in 76 to 95) BlindTime=170
					else if(diff in 96 to 120) BlindTime=110
					else if(diff > 120) BlindTime=0
					if(BlindTime)
						if(M.Class["Sensory-Nin"]) M.sight |= (BLIND|SEE_MOBS)
						else M.sight |= (BLIND|SEE_SELF)
						M.IsBlinded=1; M.Darkness=1
						SightReversalCheck(src,M,BlindTime)
					else
						M<<"[src]'s genjutsu is not strong enough to blind you!"
					sleep(10)

	AI_NehanShoujanoJutsu()
		var
			c=150; s=SS*5
		if(!(GENERICATTACKCHECK(src))&&Chakra>c)
			icon_state="seals"
			firing=1
			spawn(s)
				spawn(1)icon_state=null
				spawn(20)firing=0
				Chakra-=c
				hearers(2,src)<<"<b>[src]: Nehan Shouja no Jutsu!</b>"
				for(var/mob/m in range(9,src))
					if(!istype(m,/mob/NPC))
						if(src!=m&&!m.Sleeping&&!m.sleepy&&!((m.Dispel)&&(Genjutsu>m.Genjutsu/5)))
							m << "<b><i>You start feeling very sleepy...</i></b>"
							m.sleepy=1; m.overlays+='Nehan.dmi'
							if(m)
								m.NehanProcedure(src)
				sleep(10)