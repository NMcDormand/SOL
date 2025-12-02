obj/var/tmp/AcquiredTarget
obj/Jutsu/Nara/Trail
	notblowable=1
	icon='Kagemane.dmi'
	density=0
	layer=MOB_LAYER-1
	KagemaneTrail
		icon_state="Trail"
	KagemaneC1
		icon_state="Corner1"
	KagemaneC2
		icon_state="Corner2"
	KagemaneC3
		icon_state="Corner3"
	KagemaneC4
		icon_state="Corner4"

obj/Jutsu/Nara
	notblowable=1
	icon='Kagemane.dmi'
	density=0
	layer=MOB_LAYER-1
	KagemaneSource
		icon_state="Source"
	KagemaneCaptured
		icon_state="Captured"
	KagemaneSemiTrail
		icon_state="SemiTrail"
	KagemaneHead
		icon_state="Head"

//-------------------- [ Kagemane Move ] -----------------------------
		Move()
			var/d=dir
			var/l=loc
			.=..()
			for(var/mob/M in loc)
				if(target!=M) loc=M.loc
				else if(M.protect||M.kaiten) del(src)
				else {ShadowTrail(d,l); AcquiredTarget=1; ShadowCaptured(M); return}
			ShadowTrail(d,l)


//-------------------- [ Procs ] -----------------------------
	proc
		ShadowTrail(var/d,var/l)
			var/mob/o=Owner
			if(dir==d)
				var/obj/Jutsu/Nara/Trail/KagemaneTrail/T = new(l)
				T.dir = dir; T.target=target; T.AcquiredTarget=AcquiredTarget
				T.Owner=Owner; o.TrailList+=T
			else
				if(d==NORTH)
					if(dir==SOUTH)
						var/obj/Jutsu/Nara/Trail/KagemaneTrail/T = new(l)
						T.dir = dir; o.TrailList+=T
						T.target=target; T.AcquiredTarget=AcquiredTarget; T.Owner=Owner
					if(dir==EAST)
						var/obj/Jutsu/Nara/Trail/KagemaneC1/T = new(l)
						T.dir = dir; o.TrailList+=T
						T.target=target; T.AcquiredTarget=AcquiredTarget; T.Owner=Owner
					if(dir==WEST)
						var/obj/Jutsu/Nara/Trail/KagemaneC2/T = new(l)
						T.dir = dir; o.TrailList+=T
						T.target=target; T.AcquiredTarget=AcquiredTarget; T.Owner=Owner
				if(d==SOUTH)
					if(dir==NORTH)
						var/obj/Jutsu/Nara/Trail/KagemaneTrail/T = new(l)
						T.dir = dir; o.TrailList+=src
						T.target=target; T.AcquiredTarget=AcquiredTarget; T.Owner=Owner
					if(dir==EAST)
						var/obj/Jutsu/Nara/Trail/KagemaneC3/T = new(l)
						T.dir = dir; o.TrailList+=T
						T.target=target; T.AcquiredTarget=AcquiredTarget; T.Owner=Owner
					if(dir==WEST)
						var/obj/Jutsu/Nara/Trail/KagemaneC4/T = new(l)
						T.dir = dir; o.TrailList+=T
						T.target=target; T.AcquiredTarget=AcquiredTarget; T.Owner=Owner
				if(d==EAST)
					if(dir==WEST)
						var/obj/Jutsu/Nara/Trail/KagemaneTrail/T = new(l)
						T.dir = dir; o.TrailList+=T
						T.target=target; T.AcquiredTarget=AcquiredTarget; T.Owner=Owner
					if(dir==NORTH)
						var/obj/Jutsu/Nara/Trail/KagemaneC4/T = new(l)
						T.dir = dir; o.TrailList+=T
						T.target=target; T.AcquiredTarget=AcquiredTarget; T.Owner=Owner
					if(dir==SOUTH)
						var/obj/Jutsu/Nara/Trail/KagemaneC2/T = new(l)
						T.dir = dir; o.TrailList+=T
						T.target=target; T.AcquiredTarget=AcquiredTarget; T.Owner=Owner
				if(d==WEST)
					if(dir==EAST)
						var/obj/Jutsu/Nara/Trail/KagemaneTrail/T = new(l)
						T.dir = dir; o.TrailList+=T
						T.target=target; T.AcquiredTarget=AcquiredTarget; T.Owner=Owner
					if(dir==NORTH)
						var/obj/Jutsu/Nara/Trail/KagemaneC3/T = new(l)
						T.dir = dir; o.TrailList+=T
						T.target=target; T.AcquiredTarget=AcquiredTarget; T.Owner=Owner
					if(dir==SOUTH)
						var/obj/Jutsu/Nara/Trail/KagemaneC1/T = new(l)
						T.dir = dir; o.TrailList+=T
						T.target=target; T.AcquiredTarget=AcquiredTarget; T.Owner=Owner

		Kagemane_CloseIn(mob/M,SL=3,C=200)
			var/mob/S=Owner
			while(M && !M.dead && S)
				if(S.Chakra<=C)
					S.Chakra=1
					S.EndAllKagemane()
					return
				else
					if(CardinalStep(M))
						S.Chakra-=C
					if(AcquiredTarget && M.loc!=loc)
						break
					sleep(SL)
			S.Shadows--
			if(S.Shadows <0)
				S.Shadows = 0
			del src


//-------------------------------------------------------------------------------------------------------------
		CardinalStep(mob/M)
			switch(get_dir(src,M.loc))
				if(NORTHEAST)
					if(step(src,pick(NORTH,EAST)))
						return 1
				if(NORTHWEST)
					if(step(src,pick(NORTH,WEST)))
						return 1
				if(SOUTHEAST)
					if(step(src,pick(SOUTH,EAST)))
						return 1
				if(SOUTHWEST)
					if(step(src,pick(SOUTH,WEST)))
						return 1
				else
					if(step_towards(src,M.loc))
						return 1
			return

//------------------------------------------------------------------------------------------------------------

Effect/Visual/KageArashi/Pool
	var/Duration
	var/list/CaughtList = list()
	layer=MOB_LAYER-1
	New()
		..()
		name="Shadow"

	Del()
		Owner.UsedArashi = 0
		for(var/mob/M in CaughtList)
			M.overlays-=icon('ShadowStorm.dmi',"Spikes1")
			M.overlays-=icon('ShadowStorm.dmi',"Spikes2")
			M.overlays-=icon('ShadowStorm.dmi',"Spikes3")
			M.InKageArashi = 0
		..()

	Crossed(mob/M)
		..()
		if(ismob(M) && M != Owner)
			M<<"You were caught in [Owner]'s shadow!"
			Owner<<"[M] was caught in your shadow!"
			M.InKageArashi=1

			var/icon/SS = icon('ShadowStorm.dmi',pick("Spikes1","Spikes2","Spikes3"))
			M.overlays+=SS
			CaughtList += M

			var/C=JutsuDamage(Owner.Ninjutsu,M.Ninjutsu,0,0,7)
			range(M,10) << "[M] was damaged by [Owner]'s shadows for [C]"
			M.DamageMe(Owner,C,src)

			spawn(Duration)
				if(M)
					M.overlays-=icon('ShadowStorm.dmi',"Spikes1")
					M.overlays-=icon('ShadowStorm.dmi',"Spikes2")
					M.overlays-=icon('ShadowStorm.dmi',"Spikes3")
					M.InKageArashi = 0

	Uncrossed(mob/M)
		if(M==Owner)
			del src

	One
		icon='KageArashi96.dmi'
		bounds="96,96"
		New()
			..()
			x-=1
			y-=1
	Two
		icon='KageArashi160.dmi'
		bounds="160,160"
		New()
			..()
			x-=2
			y-=2
	Three
		icon='KageArashi224.dmi'
		bounds="224,224"
		New()
			..()
			x-=3
			y-=3