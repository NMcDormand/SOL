
mob
	proc
		RYoroiDrain()
			if(!RaitonYoroi)return
			chakra-=20
			if(chakra<=0)
				chakra=0
				RaitonYoroi=0
				movespeed=savespeed
				savespeed=null
				Reflex=mReflex
				loadoverlays()
				tai=mtai
				src<<"You stop using Raiton no Yoroi!"
			spawn(15)
				RYoroiDrain()
		nagashi()
			nagashi=1
			loadoverlays()
			spawn(100)
				if(nagashi)
					nagashi=0
					loadoverlays()
			while(nagashi)
				chakra-=100
				if(chakra<=0)
					nagashi=0
					loadoverlays()
					break
					return
				for(var/mob/I in range(src,1))
					if(I!=src&&I.owner!=src)
						if(I.nagashi)continue
						if(I.dead)continue
						view(src)<<"[I] was hit by [src] Chidori Nagashi!"
				sleep(5)
				continue
		raitonyoroi()
			RaitonYoroi=1
			loadoverlays()
			tai=round(mtai*1.3)
			savespeed=movespeed
			movespeed=1
			Reflex+=40
			RYoroiDrain()
			spawn(300)
				if(RaitonYoroi)
					RaitonYoroi=0
					Reflex=mReflex
					movespeed=savespeed
					savespeed=null
					tai=mtai
					loadoverlays()
					src<<"You stop using Raiton no Yoroi!"