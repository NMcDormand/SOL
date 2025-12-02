#if DEBUGGING
mob/verb
	SelfLearnThorn()
		var/obj/SkillCards/Ninjutsu/Special/Tower/Thorn/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just obtained the <i>Thorn</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Special/Tower/Thorn(src)
#endif
mob
	var
		tmp
			Thorn = 0
			ThornNinBoost = 0
			ThornChakraBoost = 0
			ThornCost = 0
		ThornMax = 1

obj/SkillCards/Ninjutsu/Special/Tower/Thorn
	cmdstring="Thorn"
	name="Thorn"
	icon_state="card_FirstThorn"
	CCost=2000
	Seals=1
	VerbIt=1
	CanLevel=0
	Description= list(
		"about"="The ultimate needle to take down anything in your path, granting increased Ninjutsu, Speed, and Chakra"
		,"title"="Thorn"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="A"
		//,"pic"='Bunshin.png'
		)

	verb/Thorn_Deactivate()
		set category="TECHNIQUES"
		set src in usr.contents
		if(usr.Thorn)
			usr.ThornDeactivate()
			usr<<"You sealed the power of the thorn"

	Activate(mob/U)
		if(U.Thorn >= U.ThornMax)
			U.ThornDeactivate()
			U<<"You sealed the power of the thorn"
		else
			if(GENERICATTACKCHECK(U)) return
			if(!MultiBuffs && U.InBoost)
				U << "You are already using a boost of some kind"
				return
			var
				c=2000; mx=c; s=U.SS*2
			if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
			spawn(s)
				if(prob(U.ChakraControl))
					if(U.ChakraControl<100) {c+=rand(0,mx/2); U.CCGain(c)}
					U.JutsuSeals(s); ; U.JutsuNin(c); U.MoveUses[name]++
					U.JutsuUseChakra(c)
					if(U.PracticeMode) return ..()
					U.ThornActivate()
					U.MoveUses["Thorn"]++
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

mob
	proc
		ShinsuForce()
			for(var/i=1 to 3)
				new/Effect/Visual/KuchuNejire(loc)
				for(var/mob/M in range(3,src))
					if(M==src || M.Creator == src)
						continue
					if(NINIGNORELIST(M))
						continue
					spawn()
						step(M,get_dir(src,M))
						M.dir = get_dir(M,src)
						if(ismob(M))
							var/mob/A = M
							A.DamageMe(src,Ninjutsu,"ShinsuForce",0)
				sleep(i)

		ThornDeactivate()
			overlays -= icon('FirstThorn.dmi')
			overlays -= icon('FirstThornActivated.dmi')
			Thorn = 0
			InBoost = 0

			Ninjutsu -= ThornNinBoost
			ThornNinBoost = 0
			Chakra -= ThornChakraBoost
			ChakraMax -= ThornChakraBoost
			ThornChakraBoost = 0

			if(Thorn>1)
				movespeed += 0.7

			var/Underlay_Obj/AP = new('AirPulse1.dmi',FLOAT_LAYER-50,-32,-32)
			underlays -= AP
			AP.icon = icon('AirPulse.dmi')
			underlays -= AP
			AP.icon = icon('AirPulse2.dmi')
			underlays -= AP
			if(client)
				StatUpdate_chakra()
				StatUpdate_ninjutsu()
				Cooldowns["Thorn"]=world.time+(2000*cooldownmultiplier)

		ThornActivate()
			//set waitfor = 0
			Thorn++
			if(Thorn==1)
				src << "<b><i>You scratched the surface of the thorn</i></b>"
				overlays += icon('FirstThorn.dmi')
				Thorn = 1
				ThornCost = 3000
				ThornDrain()
				ThornNinBoost = NinjutsuTrue * 0.2
				Ninjutsu += ThornNinBoost
				ThornChakraBoost += ChakraTrue * 0.3
				ChakraMax += ThornChakraBoost
				Chakra += ThornChakraBoost
				RefreshStats()

				var/Underlay_Obj/AP = new('AirPulse1.dmi',FLOAT_LAYER-50,-32,-32)
				underlays += AP
				if(client)
					StatUpdate_chakra()
					StatUpdate_ninjutsu()

			else if(Thorn==2)
				Thorn++
				src << "<b><i>You unleash the full power of the thorn</i></b>"
				var/Underlay_Obj/AP = new('AirPulse1.dmi',FLOAT_LAYER-50,-32,-32)
				underlays -= AP
				AP.icon = icon('AirPulse.dmi')
				underlays += AP
				ShinsuForce()
				overlays -= icon('FirstThorn.dmi')
				overlays += icon('FirstThornActivated.dmi')
				underlays -= AP
				AP.icon = icon('AirPulse2.dmi')
				underlays += AP

				ThornCost = 6000
				var/C = ChakraTrue * 0.3
				var/N = NinjutsuTrue * 0.2
				ThornNinBoost += N
				Ninjutsu += N
				ThornChakraBoost += C
				ChakraMax += C
				Chakra += C
				movespeed -= 0.7
				if(client)
					StatUpdate_chakra()
					StatUpdate_ninjutsu()
				else
					atkspeed = 0.5
			else
				ThornDeactivate()

		ThornDrain()
			set waitfor = 0
			while(Thorn)
				if(Chakra >= ThornCost)
					Chakra -= ThornCost
					JutsuChakra(50);
					StatUpdate_chakra()
				else
					Thorn = 0
				sleep(20)

			if(Chakra<0)
				Chakra = 0
			if(ThornNinBoost)
				ThornDeactivate()