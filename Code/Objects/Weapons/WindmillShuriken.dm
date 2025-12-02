obj/Weapon/Thrown
	WindmillShuriken
		name="Windmill Shuriken"; trueName="Windmill Shuriken"
		amount=1
		Stackable = 1
		icon='WindmillShuriken.dmi'
		price=50
		ItemType="Weapon"
		New() Checkamount()
		Click()
			..()
			if(src in usr.contents)
				if(OnSpeedRail)
					ThrowWindmillShuriken()
				else usr.ItemStats(src)
			else
				if(usr.clicked_item) return
				usr.clicked_item = 1
				spawn(10) usr.clicked_item = 0
				Get()
		verb
			Drop()
				set src in usr.contents
				var/dropno = input("Drop how many [trueName]?","Drop") as num
				if(dropno<=0) return
				if(dropno>amount)
					usr<<"You don't have that many [trueName]."; return
				else
					var/obj/O = new type(usr.loc)
					O.amount = dropno
					O.collected = 0
					O.icon = icon
					O.price = price
					O.trueName = trueName
					O.Creator = Creator
					O.Multiplier = Multiplier
					O.Material = Material
					O.desc = desc
					amount -= dropno
					usr<<"You drop [dropno] [trueName]."
					Checkamount()
					O.Checkamount()
					if(amount<=0) del src
					usr.UpdateInventory()

			ThrowWindmillShuriken()
				set category="Taijutsu"
				set name="Throw Windmill Shuriken"
				var/dist=5;
				var/mob/M

				if(ismob(usr.Targeting)&&get_dist(usr.Targeting,usr)<= dist)
					M = usr.Targeting
				else
					M = usr.TargetSelect(dist)
				if(M)
					if(usr.ThrowHomingAttackCheck(M,src)||!(M)) return
					amount--; usr.throwing=1; spawn(20)usr.throwing=0
					spawn(6)
						if(amount<1)
							spawn(2) loc=null
							spawn(21) del(src)
						else Checkamount()
					usr.MoveUses["WindmillShurikenThrows"]++
					usr<<"<i>You throw the Windmill Shuriken</i>"
					var/obj/Weapon/Thrown/ThrownWindmillShuriken/S=new/obj/Weapon/Thrown/ThrownWindmillShuriken
					S.loc=usr.loc
					S.Taijutsu=usr.Taijutsu; S.ThrowingSkill=usr.ThrowingSkill; S.Multiplier = Multiplier
					S.dir=usr.dir; S.name="[usr]"; S.Owner=usr
					step(S,usr.dir)
					sleep(2)
					step(S,usr.dir)
					S.BetterHoming(M,M.loc)
					usr.UpdateInventory()
					spawn(28)del(S)
					usr.ApplyEXP(20,"throwing")

	ThrownWindmillShuriken
		name="Windmill Shuriken"; icon='WindmillShuriken.dmi'
		density=1; movespeed=2
		NotSellable = 1
		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A))
				var/mob/M=A
				var/mob/O=Owner
				if(M.kaiten||M.MushiKabe||M.protect) del(src)
				var/damage = (Taijutsu*0.14)
				damage += (damage*Multiplier)
				var/Shurikendmg=round((damage+5)+((ThrowingSkill*12)+5))
				//DamageMessage(M,Shurikendmg,name)
				M.DamageMe(O,Shurikendmg,src); del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) {spawn(2)del(src)}
			if(istype(A,/obj/)) del(src)