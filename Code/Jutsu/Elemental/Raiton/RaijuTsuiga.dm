#if DEBUGGING
mob/verb
	SelfLearnRaijuTsuiga()
		var/obj/SkillCards/Ninjutsu/Raiton/RaijuTsuiga/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Raiton Raiju Tsuiga no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Raiton/RaijuTsuiga(src)
#endif

obj/SkillCards/Ninjutsu/Raiton/RaijuTsuiga
	icon_state="card_Raiju"
	cmdstring="RaijuTsuiga"
	CCost=300
	Seals=2
	Cooldown = 1250
	Range = 8
	DM = 0.5

	Description= list(
		"about"="Creates Lightning in the form of a wolf that moves extremely fast"
		,"title"="Raiton Raiju Tsuiga"
		,"type"="Ninjutsu"
		,"Element"="Lightning"
		,"weak"="Earth"
		,"rank"="B"
		,"pic"='Bunshin.png'
		)

	UpgradeChoices = list("Increase Damage","Lower Cooldown")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)||U.choosingHoming)
			return
		var/mob/M
		if(ismob(U.Targeting)&&get_dist(U.Targeting,U)<= Range)
			M = U.Targeting
		else
			M = U.TargetSelect(Range)
		spawn(10)if(U)U.choosingHoming=0
		if(U)
			var
				c=CCost; mx=c; s=U.SS*Seals
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			if(U.CooldownCheck("RaijuTsuiga",(CooldownCur*U.cooldownmultiplier)+s,1)) return
			if(U.CooldownCheck("Homing",(100*U.cooldownmultiplier)+s,1)) return
			if(ChakraUseCheck()) c *= 4
			U.icon_state="seals"
			U.firing=1
			spawn(s)
				spawn(2)U.firing=0
				U.icon_state=null
				if(prob(U.ChakraControl))
					U.JutsuMessage(Description["title"])
					U.JutsuSeals(s); U.JutsuNin(c);
					U.MoveUses[name]++
					U.JutsuUseChakra(c);
					U.ElementalUp("Lightning")
					if(U.PracticeMode || ControlCheck(U)) return ..()
					if(M)
						new/obj/Jutsu/Raiton/Tsuiga(U,M,DM)
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

obj/Jutsu/Raiton
	Tsuiga
		var/list/parts = list()

		icon='Raitons.dmi'
		icon_state="wolf"
		layer=MOB_LAYER+1||OBJ_LAYER+1
		density = 1
		New(mob/O,mob/M,DM)
			Owner = O
			loc = O.loc
			dir = O.dir
			Ninjutsu = round(O.Ninjutsu*DM)
			LightningElemental = O.LightningElemental * (DM*2)
			..()
			if(!M)
				walk(src,dir)
			else
				target = M
				walk_to(src,M)
			spawn(25)
				if(src)
					del(src)
		Move()
			//var/LOC = loc
			.=..()
			if(.)
				if(Owner)
					/*var/obj/Jutsu/Raiton/TsuigaTrail/Y = new/obj/Jutsu/Raiton/TsuigaTrail(LOC,Owner)
					Y.dir = dir
					parts += Y*/
					if(!target)
						walk(src,dir)
					else
						if(get_dist(target,src)<=1)
							walk_towards(src,target)
				else
					del src
			else
				del src
		Del()
			for(var/obj/T in parts)
				del T
			..()

		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A))
				var/damage
				var/mob/O=Owner
				var/mob/M=A
				if(A == O)
					loc=M.loc
					return
				if(target && target!=M) {loc=M.loc; return}
				if(M.kaiten||M.MushiKabe||M.InMeatTank||M.protect||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
				if(O.HitCheck(M))
					damage=JutsuDamage(Ninjutsu,M.Ninjutsu,LightningElemental,M.EarthElemental,Power)
					M.DamageMe(O,damage,src)
					if(M)
						M.RaitonStun()
				else {O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."}
				del src
			else if(istype(A,/obj/Destructable))
				var/damage
				var/mob/O=Owner
				var/obj/M=A
				var/SE=0
				if(M.WaterElemental&&!M.EarthElemental) SE=1
				damage=JutsuDamage(Ninjutsu,M.Ninjutsu,LightningElemental,M.EarthElemental,Power,SE)
				M.Destroy(damage,O); del(src)
			else if(istype(A,/obj/))
				if(isobj(A))
					var/obj/o = A
					if(istype(o,/obj/Jutsu))
						if(istype(o,type) && o.Owner == Owner)
							return
						else
							JutsuClash_Lightning(src,o)
					else if(istype(o,/obj/Weapon/Wield)) del(o)
					else del(src)
			else if(istype(A,/turf/))
				del(src)
	TsuigaTrail
		icon='Raitons.dmi'
		icon_state="wtrail"
		layer=MOB_LAYER+1