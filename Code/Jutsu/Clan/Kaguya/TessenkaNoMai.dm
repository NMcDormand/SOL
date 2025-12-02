obj/SkillCards/Clan/Kaguya/TessenkanoMai
	icon_state="card_TessenkanoMai"
	cmdstring="TessenkanoMai"
	Range=2
	CCost=700
	CanLevel = 0
	Cooldown = 40

	Description = list(
		"about"="Attack  up to 2 tiles away with a Spine Whip."
		,"title"="Tessenka no Mai"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="B"
//		,"pic"='TessenkanoMai.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		if(U.wielding!="Spine Whip") {U<<"Equip Spine Whip first"; return}
		var
			c=(CCost*U.KGCModifier); mx=c
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Tessenka",(CooldownCur*U.cooldownmultiplier))) return
		if(MoveCheck(U)) return
		if(ChakraUseCheck()) c *= 4
		U.JutsuUseChakra(c)
		//U.JutsuTai(U.Taijutsu*0.01)
		U.MoveUses[name]++
		flick("punch",U)
		U.attacking=1;spawn(U.atkspeed)U.attacking=0
		if(U.PracticeMode)
			return ..()
		U.RefreshChakra()
		var/hit=0
		//var/turf/Spot
		for(var/mob/M in orange(2))
			if(get_dir(U,M)==U.dir)
				hit++
				if(TAICHECKBOTH(U,M)) continue
				if(prob(U.ChakraControl))
					var/dmg=round(U.Taijutsu*0.9-(M.Taijutsu*0.11))
					dmg+=U.Weapons()
					if(dmg<round(U.Taijutsu*0.15)) dmg=round(U.Taijutsu*0.10)
					if(M.TreeStump)
						spawn(U.atkspeed+2)U.attacking=0
						if(U.Stamina<=15&&U.reset) U.attacking=0; return
						if(U.Stamina<=15&&!U.reset)
							U<<"Not enough Stamina"
							U.reset=1; spawn(20)U.reset=0
							U.attacking=0;
							return
						if(!M.Cactus) {U.TreeStump(M,dmg);continue}
						else if(M.Cactus) {U.Cactus(M,dmg);continue}
					if(U.HitCheck(M))
						for(var/obj/Weapon/Wield/W in U.contents)
							if(W.worn) W.DamagetoWeapon(rand(1,5),U)
						M.DamageMe(U,dmg,"whips")
						var/taiup=rand(2,15)
						U.TaijutsuXP+=(taiup+M.taitraining)
						U.ApplyEXP(10,"Stamina")
						spawn(U.atkspeed+2)U.attacking=0
					else
						spawn(U.atkspeed+11)U.attacking=0
						U<<"[M] dodged the attack!"; M<<"You dodged [U]'s attack"
					break
				else
					c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"
					spawn(U.atkspeed+1)U.attacking=0
			if(!hit)
				U.attacking=1;spawn(U.atkspeed+5) U.attacking=0