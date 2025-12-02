obj/SkillCards/Clan/Yuki/MakyouHyoushouKogeki
	icon_state="card_MakyouHyoushou"
	cmdstring="MakyouHyoushouKogeki"
	Range=6
	CCost=3000
	Seals=10
	Cooldown = 2000
	DM = 10

	Description = list(
		"about"="Attack your opponent through a barrage of available mirrors"
		,"title"="Hyouton: Kori Kogeki"
		,"type"="Ninjutsu"
		,"Element"="Ice"
		,"weak"="Fire"
		,"rank"="B"
//		,"pic"='MakyouHyoushou.png'
		)

	UpgradeChoices = list("Lower Cooldown","Lower Cost","Increase Damage")

	Activate(mob/U)
		if(U.choosingHoming)
			return
		if(GENERICATTACKCHECK(U)||U.Gokusamaisou||U.mirroring||U.InMirrors)
			return
		var/list/MAList
		if(U.MirrorDome)
			MAList = U.MirrorDome
		else
			MAList = U.AllMirrors

		if(!MAList || !MAList.len)
			return
		var/mob/M
		if(ismob(U.Targeting) && get_dist(U.Targeting,U) <= Range)
			M = U.Targeting
		else
			M = U.TargetSelect(Range)
		if(M)
			if(GENERICATTACKCHECK(U)||U.Gokusamaisou||U.mirroring||M.mirroring||U.InMirrors||InvisibilityCheck(U,M))
				return
			var
				c=CCost; mx=c; s=U.SS*Seals

			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck(cmdstring,(CooldownCur*U.cooldownmultiplier)+s)) return
			/*if(U.MirrorCreationMode)
				U.MirrorCreationMode = 0
				U <<"Mirror creation disabled"*/
			U.firing=1
			U.icon_state="seals"
			if(ChakraUseCheck()) c *= 4
			spawn(s)
				spawn(12) U.firing=0
				U.icon_state=null
				if(prob(U.ChakraControl))
					U.JutsuMessage(Description["title"])
					U.JutsuSeals(s); U.JutsuNin(c); U.ElementalUp("Ice",5);
					U.MoveUses[name]++
					U.JutsuUseChakra(c);

					if(U.PracticeMode || ControlCheck(U) || !MAList.len) return ..()
					U.mirroring = 1
					var/mob/Hittable/Unresponsive/Inanimate/randomMirror = pick(MAList)
					U.loc = randomMirror.loc
					if(!U.InAMirror)
						U.InAMirror=1
						U.invisibility += 2
					U.EnteredOBJ = randomMirror
					randomMirror.Containing=U

					for(var/mob/M2 in range(U))
						if(M2.Targeting == U)
							M2.DeleteTarget()

					U.MirrorTarget=U.Targeting

					var/Failed = 0
					for(var/Counter = 1 to DM)
						Failed = 0
						tryagain
						if(U.KO || U.dead || !U.MirrorTarget || U.MirrorTarget.dead || !MAList.len)
							break
						randomMirror = pick(MAList)
						if(!randomMirror)
							MAList -= randomMirror
							goto tryagain
						if(MAList.len)
							if(randomMirror.loc == U.loc)
								Failed++
								if(Failed >=5)
									break
								else
									goto tryagain
						// Until we find a mirror that is on the (same x or same y) and is more then two tiles away from the user and isn't our current mirror, pick a new mirror
					/*	while((randomMirror.loc.x != U.MirrorTarget.loc.x && randomMirror.loc.y != U.MirrorTarget.loc.y) || (get_dist(randomMirror.loc, U.MirrorTarget.loc) < 2) || (randomMirror == currentMirror))
							randomMirror = pick(MAList)//Need to make this more efficient
							*/
						U.loc = randomMirror.loc
						U.dir = get_dir(U,U.MirrorTarget)
						U.MirrorsSensatsu()
						sleep(3)

					U.mirroring = 0
					U<<"Your Ice Mirrors are beginning to melt"
					spawn(100)
						U.EndMirrors()
					return
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

mob
	var
		MirrorMax = 10
		tmp
			MirrorCreationMode = 0
			InMirrors = 0
			InAMirror = 0
			usingMirrors = 0
			MirrorDist = 2
			MirrorCurrent = 0

			mob/MirrorTarget
			turf/MirrorsCentre = 0
			list/AllMirrors = 0
			list/MirrorMist = list()
			list/MirrorDome = 0
	proc
		MirrorsSensatsu()
			set waitfor = 0
			var/obj/Yuki/Sensatsu/S=new/obj/Yuki/Sensatsu
			var/obj/Yuki/Sensatsu/S2=new/obj/Yuki/Sensatsu
			var/obj/Yuki/Sensatsu/S3=new/obj/Yuki/Sensatsu
			S.Power=3
			CreateProjectile(src,S,"Ice",loc,dir,1,7,0.9,1.9)
			CreateProjectile(src,S2,"Ice",get_step(src,turn(dir,90)),dir,1,7,0.9,1.6)
			CreateProjectile(src,S3,"Ice",get_step(src,turn(dir,-90)),dir,1,7,0.9,1.6)
			spawn(2)
				if(src)
					S=new/obj/Yuki/Sensatsu
					S2=new/obj/Yuki/Sensatsu
					S3=new/obj/Yuki/Sensatsu
					CreateProjectile(src,S,"Ice",loc,dir,1,7,0.9,1.9)
					CreateProjectile(src,S2,"Ice",get_step(src,turn(dir,90)),dir,1,7,0.9,1.6)
					CreateProjectile(src,S3,"Ice",get_step(src,turn(dir,-90)),dir,1,7,0.9,1.6)

		Mirrors(var/mob/M,Dur=300)
			MirrorsCentre = M.loc
			MirrorDome = list()
			var/list/TheseMirrors = list()
			for(var/turf/T in view(MirrorDist,MirrorsCentre))
				if(T.density)
					continue
				if(get_dist(MirrorsCentre,T) == MirrorDist)
					var/DIR = 0
					if(T.y >= MirrorsCentre.y + MirrorDist)
						if(T.x == MirrorsCentre.x + MirrorDist)
							DIR =SOUTHWEST
						else if(T.x == MirrorsCentre.x - MirrorDist)
							DIR =SOUTHEAST
						else
							DIR =SOUTH
					else if(T.y == MirrorsCentre.y - MirrorDist)
						if(T.x == MirrorsCentre.x + MirrorDist)
							DIR =NORTHWEST
						else if(T.x == MirrorsCentre.x - MirrorDist)
							DIR =NORTHEAST
						else
							DIR =NORTH
					else
						if(T.x < MirrorsCentre.x)
							DIR = EAST
						else
							DIR = WEST
					var/mob/Hittable/Unresponsive/Inanimate/Break/DemonMirror/DM = new(T,src,DIR)
					DM.InDome = 1
					MirrorDome += DM
					TheseMirrors+= DM
			usingMirrors = 1
			spawn(Dur)
				if(MirrorTarget)
					MirrorTarget.InMirrors = 0
				MirrorTarget = 0
				mirroring = 0
				usingMirrors = 0

				for(var/Mirror in TheseMirrors)
					del(Mirror)
				for(var/Mirror in AllMirrors)
					del(Mirror)

		EndMirrors()
			if(MirrorTarget)
				MirrorTarget.InMirrors = 0
			MirrorTarget = 0
			mirroring = 0
			usingMirrors = 0

			for(var/Mirror in MirrorDome)
				del(Mirror)
			for(var/Mirror in AllMirrors)
				del(Mirror)