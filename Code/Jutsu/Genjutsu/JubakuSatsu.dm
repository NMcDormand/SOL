obj/SkillCards/Genjutsu/JubakuSatsu
	icon_state="card_JubakuSatsu"
	cmdstring="JubakuSatsu"
	Range=6
	CCost = 1000
	Cooldown = 4000
	Seals = 5
	Duration = 50

	Description = list(
		"about"="Bind your enemies in an illusion; and attack them while bound."
		,"title"="Jubaku Satsu no Jutsu"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="B"
//		,"pic"='JubakuSatsu.png'
		)

	UpgradeChoices = list("Lower Cost","Lower Cooldown")

	Activate(mob/U)
		if(U.JubakuBound)
			U.endjubaku=1
		else
			var/mob/M
			if(ismob(U.Targeting)&&!U.Targeting.TreeStump&&get_dist(U.Targeting,U)<= Range)
				M = U.Targeting
			else
				M = U.TargetSelect(Range)
			if(M)
				if(GENERICATTACKCHECK(U)) return
				var
					c=CCost; mx=c; s=U.SS*Seals;
				if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
				if(U.CooldownCheck("Jubaku",(CooldownCur*U.cooldownmultiplier)+s)) return
				if(ChakraUseCheck()) c *= 4
				U.icon_state="seals"
				U.firing=1
				spawn(s)
					spawn(1)U.icon_state=null
					spawn(20)U.firing=0

					if(!M)return
					//for(var/turf/T in orange(M,6)) if(T.density) T.opacity=1
					//for(var/turf/t in orange(M,6)) if(t.density) t.opacity=initial(t.opacity)
					if(prob(U.ChakraControl))
						U.JutsuSeals(s); U.JutsuGen(c);
						U.MoveUses[name]++
						U.JutsuUseChakra(c);
						if(U.PracticeMode || ControlCheck(U))
							U.JutsuMessage(Description["title"])
							return ..()
						if(istype(M,/mob/Hittable/Responsive)&&!(U in M.HitList)) M.HitList+=U
						if(M.Genjutsu>U.Genjutsu*1.2)
							U<<"Their Genjutsu is too strong!"
							M<<"Your Genjutsu is too powerful for [U] to trap you"
							return
						var/turf/LOC = Get_Rand_DirStep(M)
						if(LOC)
							var/area/Q = U.loc.loc
							if(Q)
								Q.Exited(U)
							U.loc=LOC; U.dir=get_dir(U,M); M.dir=U.dir
							var/obj/j1=new/obj/Genjutsu/JubakuTree/Main;
							var/obj/j2=new/obj/Genjutsu/JubakuTree/Side;
							var/obj/j3=new/obj/Genjutsu/JubakuTree/Top
							j1.loc=U.loc; j2.loc=get_step(U,U.dir); j3.loc=locate(U.x,U.y+1,U.z)
							j2.dir=U.dir;
							Q = U.loc.loc
							if(Q)
								Q.Entered(U)
							spawn()
								JubakuBind(U,M,list(j1,j2,j3),Duration)
					else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
					..()

proc
	JubakuBind(mob/U,mob/M,list/JB,DUR)
		set waitfor = 0
		U.JubakuBound=2
		M.JubakuBound=1
		spawn(10)
			hearers(4,U)<<"[M] is caught in [U]'s Jubaku Satsu!"
		spawn(DUR)
			if(M)
				if(M.JubakuBound == 1)
					M.JubakuBound = 0
		while(M && M.JubakuBound)
			if(M.ReverseGenjutsu)
				if(M.Genjutsu > (U.Genjutsu*0.75))
					hearers(4,src)<<"[M] has reversed [U]'s Jubaku Satsu!"
					var/a=M.loc; var/b=U.loc
					M.loc=b; U.loc=a
					JubakuBind(M,U,JB)
					return
				else
					M<<"Their Genjutsu is too strong";
					U<<"[M] tried to reverse the attack, but your Genjutsu is too strong for \him."
					M.ReverseGenjutsu=0
			if(M.Dispel)
				if(M.Genjutsu > (U.Genjutsu*0.70) || M.Clan=="Aburame" && M.Genjutsu>(U.Genjutsu*0.40))
					view(4,src)<<"[M] is free from [src]'s Jubaku Satsu."
					break
			if(U.endjubaku)
				hearers(4,src)<<"[M] is free from [src]'s Jubaku Satsu."
				break
			sleep(5)

		if(U && U.JubakuBound)
			U.JubakuBound=0
		if(M&&M.JubakuBound)
			hearers(4,M)<<"[M] is free from [U]'s Jubaku Satsu."; M.JubakuBound=0

		for(var/obj/O in JB)
			del O
