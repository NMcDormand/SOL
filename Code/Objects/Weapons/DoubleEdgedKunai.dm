obj/Weapon/Thrown
	DoubleEdgedKunai
		name="Double-Edged Kunai"
		trueName="Double-Edged Kunai"
		amount=1
		icon='DoubleEdgedKunai.dmi'
		price=5
		NotSellable=1
		Stackable = 1
		New() Checkamount()
		Click()
			..()
			if(src in usr.contents)
				if(OnSpeedRail) ThrowDoubleEdgedKunai()
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

			ThrowDoubleEdgedKunai()
				set category="Taijutsu"
				set name="Throw Double-Edged Kunai"
				if(usr.ThrowAttackCheck(src)) return
				usr.throwing=1; spawn(6)usr.throwing=0
				amount--
				spawn(6)
					if(amount<1) spawn(2)del(src)
					else Checkamount()
				usr<<"<i>You threw a Double-Edged Kunai</i>"
				var/obj/Weapon/Thrown/ThrownDoubleEdgedKunai/S = new(usr.loc)
				S.Taijutsu=usr.Taijutsu; S.ThrowingSkill=usr.ThrowingSkill
				S.dir=usr.dir; S.Owner=usr; walk(S,usr.dir)
				spawn(9)del(S)
				usr.UpdateInventory(); usr.ApplyEXP(15,"throwing")

	ThrownDoubleEdgedKunai
		name="Double-Edged Kunai"
		icon='DoubleEdgedKunai.dmi'; icon_state="Thrown"
		density=1
		NotSellable = 1
		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A))
				var/mob/M = A
				var/mob/O=Owner
				if(M.kaiten||M.MushiKabe||M.protect) del(src)
				var/damage = Taijutsu*0.12
				var/knifedmg=round((damage+1)+(ThrowingSkill*9))
				//DamageMessage(M,knifedmg,name)
				M.DamageMe(O,knifedmg,src); del(src)
			if(istype(A,/turf/))
				var/turf/T=A
				if(T.density) {spawn(2)del(src)}
			if(istype(A,/obj/)) del(src)