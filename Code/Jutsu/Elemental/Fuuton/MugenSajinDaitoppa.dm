obj/SkillCards/Ninjutsu/Fuuton/MugenSajinDaitoppa
	icon_state="card_MugenSajinDaitoppa"
	cmdstring="MugenSajinDaitoppa"
	Range=15
	CCost=300
	Seals=4
	Cooldown = 700
	Shots = 1

	Description = list(
		"about"="Send damaging gusts of wind at your opponents."
		,"title"="Fuuton: Mugen Sajin Daitoppa"
		,"type"="Ninjutsu"
		,"Element"="Wind"
		,"weak"="Fire"
		,"rank"="TBC"
//		,"pic"='MugenSajinDaitoppa.png'
		)

	UpgradeChoices = list("Track Target","More Shots")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U))
			return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Mugen",(CooldownCur*U.cooldownmultiplier)+s,1)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(3)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuMessage(Description["title"])
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c);
				U.ElementalUp("Wind")
				if(U.PracticeMode || ControlCheck(U)) return ..()
				for(var/i = 1 to Shots)
					var/obj/Jutsu/Fuuton/MugenSajin/F1=new/obj/Jutsu/Fuuton/MugenSajin(U.loc,U)
					var/obj/Jutsu/Fuuton/MugenSajin/F2=new/obj/Jutsu/Fuuton/MugenSajin
					var/obj/Jutsu/Fuuton/MugenSajin/F3=new/obj/Jutsu/Fuuton/MugenSajin

					NewProjectile(U,F1,src,1,1.1)
					NewProjectile(U,F2,src,1,1.1,get_step(U,turn(U.dir,90)))
					NewProjectile(U,F3,src,1,1.1,get_step(U,turn(U.dir,-90)))
					sleep(2)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()


obj/Jutsu/Fuuton
	MugenSajin
		name="Mugen Sajin"
		icon = 'MugenSajin.dmi'
		density=1
		Power=2
		New(LOC,mob/O)
			Owner = O
			loc = LOC
			..()
		Bump(A)
			if(!Owner)
				del src
				return
			if(A==Owner)
				return
			if(ismob(A)||(isobj(A)&&istype(A,/obj/Destructable)))
				var/damage
				var/mob/O=Owner
				if(ismob(A))
					var/mob/M=A
					loc=M.loc
					if(M==O) return
					if(M.kaiten||M.protect||M.InGatsuuga||M.InMeatTank||M.InTsuuga||M.InGarouga) del(src)
					if(O.HitCheck(M))
						damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WindElemental,M.FireElemental,Power)
						//DamageMessage(M,damage,name)
						M.DamageMe(O,damage,src)
						Ninjutsu*=0.5; WindElemental*=0.6
					else
						O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."
				else
					var/obj/M=A
					var/SE=0
					if(M.EarthElemental&&!M.FireElemental) SE=1
					damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WindElemental,M.FireElemental,Power,SE)
					M.Destroy(damage,O); del(src)

			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)
			if(istype(A,/obj/))
				if(isobj(A))
					var/obj/o = A
					if(istype(o,/obj/Jutsu))
						if(istype(o,type) && o.Owner == Owner)
							return
						else
							JutsuClash_Wind(src,o)
					else if(istype(o,/obj/Weapon/Wield)) del(o)
					else del(src)
			if(src)
				if(Targeting == A)
					del src