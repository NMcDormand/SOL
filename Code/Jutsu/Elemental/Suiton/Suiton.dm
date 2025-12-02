/***********************************************************************************
*********************************[ Suitons ]****************************************
************************************************************************************/
var/SuitonOnEarthCheck = 4000
mob/var/tmp/DaibaSmother
obj/var/CanBeShocked
obj/Jutsu/Suiton
	Daibakufu
		name="Daibakfu"
		notblowable=1
		Move()
			var/l=loc
			.=..()
			if(.)
				//var/mob/o=Owner
				new/obj/Jutsu/Suiton/Daibakufu/Tail(l)
		Tail
			icon='Daibakufu_SOL.dmi'
			icon_state="tail"
			density=0
			New()
				..()
				spawn(11)
					flick("tail_del",src)
					sleep(10)
					loc = null
					//del src
			Del()
				..()
		Daibakufu1
			icon='Daibakufu_SOL.dmi'
			icon_state="h2"
			density=1
			CanBeShocked=1
			Power=1

			Bump(A)
				if(!Owner)
					del src
					return
				if(ismob(A)||(isobj(A)&&istype(A,/obj/Destructable)))
					var/damage
					var/mob/O=Owner
					if(ismob(A))
						var/mob/M=A
						new/obj/Jutsu/Suiton/Daibakufu/Tail(loc)
						loc=M.loc
						if(M.kaiten||M.MushiKabe||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga)
							walk(src,0)
							return
						damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WaterElemental,M.LightningElemental,Power)
						if((damage>(M.StaminaMax*0.18)&&prob(25))||(damage>(M.StaminaMax*0.25)&&prob(80))||M.ChakraControl<100) M.DaibaSmother=1
						//DamageMessage(M,damage,name)
						M.DamageMe(O,damage,src)
						Ninjutsu*=0.3; WaterElemental*=0.4
					else
						var/obj/M=A
						var/SE=0
						if(M.FireElemental&&!M.LightningElemental) SE=1
						damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WaterElemental,M.LightningElemental,Power,SE)
						M.Destroy(damage,O);
						walk(src,0)
						//del(src)
				else if(istype(A,/turf/))
					walk(src,0)
					/*var/turf/T = A
					if(T.density)
						del(src)*/
				else if(istype(A,/obj/))
					if(isobj(A))
						var/obj/o = A
						if(istype(o,/obj/Jutsu)) JutsuClash_Water(src,o)
						else if(istype(o,/obj/Weapon/Wield)) del(o)
						else
							walk(src,0)
							//del(src)
//---------------------------------------------------------------------------------------
	Suiryuudan
		name="Suiryuudan"
		icon='Suitons.dmi'
		icon_state="Suiryuudan"
		density = 1
		Power=2
		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A)||(isobj(A)&&istype(A,/obj/Destructable)))
				var/damage
				var/mob/O=Owner
				if(ismob(A))
					var/mob/M=A
					if(M.kaiten||M.MushiKabe||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
					if(O==M) {loc=M.loc; return}
					if(O.HitCheck(M))
						damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WaterElemental,M.LightningElemental,Power)
						//DamageMessage(M,damage,name)
						M.DamageMe(O,damage,src)
					else
						O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."
					del(src)
				else
					var/obj/M=A
					var/SE=0
					if(M.FireElemental&&!M.LightningElemental) SE=1
					damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WaterElemental,M.LightningElemental,Power,SE)
					M.Destroy(damage,O); del(src)

			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)
			if(istype(A,/obj/))
				if(isobj(A))
					var/obj/o = A
					if(istype(o,/obj/Jutsu)) JutsuClash_Water(src,o)
					else if(istype(o,/obj/Weapon/Wield)) del(o)
					else del(src)
//---------------------------------------------------------------------------------------
	Suikoudan
		name="Suikoudan"
		icon='Suitons.dmi'
		icon_state="Suiryuudan"
		density = 1
		Power=4
		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A)||(isobj(A)&&istype(A,/obj/Destructable)))
				var/damage
				var/mob/O=Owner
				if(ismob(A))
					var/mob/M=A
					if(M.kaiten||M.MushiKabe||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
					if(O==M) {loc=M.loc; return}
					if(O.HitCheck(M))
						damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WaterElemental,M.LightningElemental,Power)
						//DamageMessage(M,damage,name)
						M.DamageMe(O,damage,src)
					else {O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."}
					del(src)
				else
					var/obj/M=A
					var/SE=0
					if(M.FireElemental&&!M.LightningElemental) SE=1
					damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WaterElemental,M.LightningElemental,Power,SE)
					M.Destroy(damage,O); del(src)
			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)
			if(istype(A,/obj/))
				if(isobj(A))
					var/obj/o = A
					if(istype(o,/obj/Jutsu)) JutsuClash_Water(src,o)
					else if(istype(o,/obj/Weapon/Wield)) del(o)
					else del(src)


	Goshokuzame
		name="Goshokuzame"
		icon='Suitons.dmi'
		icon_state="Goshokuzame"
		density = 1
		movespeed=2
		Power=2
		Bump(A)
			if(!Owner)
				del src
				return
			if(ismob(A))
				var/damage
				var/mob
					M = A; O=Owner
				if(target!=M) {loc=M.loc; return}
				//if(!M.swimming) del src
				if(M.dead||M.kaiten||M.MushiKabe||M.protect||M.InMeatTank||M.InGatsuuga||M.InTsuuga||M.InGarouga) del(src)
				if(O.HitCheck(M))
					damage=JutsuDamage(Ninjutsu,M.Ninjutsu,WaterElemental,M.LightningElemental,Power)
					//DamageMessage(M,damage,name)
					M.DamageMe(O,damage,src)
				else
					O<<"[M] dodged your attack."; M<<"You dodged [O]'s attack."
				del(src)


			if(istype(A,/turf/))
				var/turf/T = A
				if(T.density) del(src)
			if(istype(A,/obj/))
				if(isobj(A))
					var/obj/o = A
					if(istype(o,/obj/Jutsu/Suiton/Goshokuzame))
						if(Owner!=o.Owner) JutsuClash_Water(src,o)
						else if(istype(o,/obj/Weapon/Wield)) del(o)
					else loc=o.loc