obj/SkillCards/Ninjutsu/Special/Snake/Seneitajashu
	icon_state="card_Seneitajashu"
	cmdstring="Seneitajashu"
	Range=4
	CCost=1200
	Cooldown = 1200
	VerbIt=1
	DM = 15
	Duration = 15
	Shots = 1

	Description = list(
		"about"="Summon a snake to be thrown at the target potentially constraining them."
		,"title"="Seneitajashu"
		,"type"="Kinjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="A"
		//,"pic"='Chidori.png'
	)

	UpgradeChoices = list("More Shots","Upgrade Bind")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U))
			return
		var
			c=CCost; mx=c;
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Seneitajashu",(CooldownCur*U.cooldownmultiplier))) return
		if(ChakraUseCheck()) c *= 4
		U.firing=1
		spawn(2)U.firing=0
		if(prob(U.ChakraControl))
			U.JutsuMessage(Description["title"])
			U.JutsuNin(c);
			U.MoveUses[name]++
			U.JutsuUseChakra(c);
			flick("punch",src);
			if(U.PracticeMode || ControlCheck(U)) return ..()
			var/N = round(Shots * 0.5)
			for(var/i=1 to Shots)
				var/obj/Jutsu/SnakesHand/A = new(U.loc)
				A.Ninjutsu=U.Ninjutsu
				A.Owner=U
				A.BindDuration = Duration
				A.BindChance = DM
				A.dir=dir
				IDCOPY(A,U)
				if(Shots>1)
					if(U.dir==NORTH||U.dir==SOUTH)
						A.loc=locate(U.x+N,U.y,U.z)
					else if(U.dir==EAST||U.dir==WEST)
						A.loc=locate(U.x,U.y+N,U.z)
					else if(U.dir==NORTHEAST||U.dir==SOUTHWEST)
						A.loc=locate(U.x-N,U.y+N,U.z)
					else if(U.dir==SOUTHEAST||U.dir==NORTHWEST)
						A.loc=locate(U.x+N,U.y+N,U.z)
					N-=1
				walk(A,U.dir)
				spawn(16)
					if(A)
						del A
		else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

mob
	proc
		SnakeBind(BD = 30)
			src<<"<b>You are bound by the snake</b>"
			CantWalk++
			SnakeBound++
			overlays += 'Authority Snakes.dmi'
			spawn(BD)
				if(SnakeBound)
					overlays -= 'Authority Snakes.dmi'
					SnakeBound--
				if(CantWalk)
					CantWalk--

obj
	Jutsu
		SnakesHand
			name="Snakes"
			icon='SnakeHands.dmi'
			density=1
			movespeed=0
			var/BindDuration = 15
			var/BindChance = 15
			Del()
				if(AcquiredTarget)
					sleep(18)
				..()
			Bump(A)
				if(ismob(A))
					var/mob/M = A
					var/mob/O=Owner
					if(istype(M,/mob/NPC)) del(src)
					if(M.kaiten||M.protect||M.InGatsuuga||M.InMeatTank||M.InTsuuga||M.InGarouga) del(src)
					var/D=Ninjutsu*1.5-(M.Ninjutsu*0.20)
					if(D<=Ninjutsu*0.22) D=Ninjutsu*0.22
					AcquiredTarget=1
	//				if(prob(20))
	//					if(!M.Poisoned) {M.Poisoned=1; M.Poison(); M<<"<b>You have been poisoned by the snakes</b>"}
					if(prob(BindChance) && !M.SnakeBound)
						M.SnakeBind(BindDuration)
					M.DamageMe(O,D,src)
					loc=locate(0,0,0)

				if(istype(A,/turf/))
					var/turf/T = A
					if(T.density) del(src)