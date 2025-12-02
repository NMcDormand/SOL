#if DEBUGGING
mob/verb
	SelfLearnYagura()
		var/obj/SkillCards/Clan/Sarutobi/HiuchiYagura/J=locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Hiuchi Yagura no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Sarutobi/HiuchiYagura(src)
#endif

obj/SkillCards/Clan/Sarutobi/HiuchiYagura
	icon_state="card_HiuchiYagura"
	cmdstring="HiuchiYagura"
	Range=14
	CCost=1500
	Seals=8
	DM = 1
	Shots = 1
	Cooldown = 1000

	Description = list(
		"about"="Unleash pillars of fire that grow in size to attack your enemies"
		,"title"="Katon: Hiuchi Yagura"
		,"type"="Ninjutsu"
		,"Element"="Fire"
		,"weak"="Water"
		,"rank"="B"
//		,"pic"='Housenka.png'
		)

	UpgradeChoices = list("Increase Damage","More Shots")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("HiuchiYagura",(CooldownCur*U.cooldownmultiplier)+s,1)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(4)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s);
				U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.ElementalUp("Fire")
				if(U.PracticeMode || ControlCheck(U))
					return ..()

				if(Shots>1)
					var/N = round(Shots * 0.5)
					for(var/i=1 to Shots)
						var/turf/A
						if(U.dir==NORTH||U.dir==SOUTH)
							A=locate(U.x+N,U.y,U.z)
						else if(U.dir==EAST||U.dir==WEST)
							A=locate(U.x,U.y+N,U.z)
						else if(U.dir==NORTHEAST||U.dir==SOUTHWEST)
							A=locate(U.x-N,U.y+N,U.z)
						else if(U.dir==SOUTHEAST||U.dir==NORTHWEST)
							A=locate(U.x+N,U.y+N,U.z)
						N-=1
						NewProjectile(U,new/obj/Jutsu/Katon/HiuchiYagura(A),src,1,DM,A)
				else
					NewProjectile(U,new/obj/Jutsu/Katon/HiuchiYagura(U.loc),src,1,DM)
			else {c-=rand(1,mx/2); usr.Chakra-=c; usr<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

obj/Jutsu/Katon/HiuchiYagura
	icon='Firenado.dmi'
	density=1
	Power=0
	layer = MOB_LAYER+1
	var/StepsTaken = 0
	bound_height=32

	New()
		..()
		spawn(1)
			animate(src, transform = matrix()*3, pixel_y = 32*2, time = 16)
	Move()
		.=..()
		if(!.)
			walk(src,0)
	Bump(A)
		if(!Owner)
			del src
			return
		if(ismob(A)||istype(A,/obj/Destructable))
			var/damage
			var/mob/O=Owner
			if(ismob(A))
				if(O)
					var/mob/M=A
					if(M.kaiten||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga||M.MushiKabe) del(src)
					if(M==O) {loc=M.loc; return}
					if(O.HitCheck(M))
						damage=JutsuDamage(Ninjutsu,M.Ninjutsu,FireElemental,M.WaterElemental,Power)
						M.DamageMe(O,damage,src)
						if(M && M.loc)
							for(var/obj/Jutsu/Katon/HiuchiYagura/K in range(10,src))
								if(!K.Targeting && M && M.loc)
									K.Targeting = M
									K.BetterHoming(M,M.loc)
					else {O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."}
			else
				var/obj/M=A
				var/SE=0
				if(M.IceElemental||(M.WindElemental&&!M.WaterElemental)) SE=1
				damage=JutsuDamage(Ninjutsu,M.Ninjutsu,FireElemental,M.WaterElemental,Power,SE)
				M.Destroy(damage,O); del(src)
		/*if(istype(A,/turf/))
			var/turf/T = A
			//if(T.density) del(src)
			*/
		if(istype(A,/obj/))
			if(isobj(A))
				var/obj/o = A
				if(istype(o,/obj/Jutsu))
					if(istype(o,type) && o.Owner == Owner)
						return
					else
						JutsuClash_Fire(src,o)
				else if(istype(o,/obj/Weapon/Wield)) del(o)