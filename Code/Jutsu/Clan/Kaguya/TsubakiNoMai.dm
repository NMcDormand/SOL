obj/SkillCards/Clan/Kaguya/TsubakiNoMai
	icon_state="card_TsubakiNoMai"
	cmdstring="TsubakiNoMai"
	Range=2
	CCost=1100
	CanLevel = 0
	Cooldown = 40

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[CCost*usr.KGCModifier]'")

	Description = list(
		"about"="Attack all opponents around you."
		,"title"="Tsubaki no Mai"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="B"
//		,"pic"='TsubakiNoMai.png'
		)

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		if(U.wielding!="Bone Sword" && U.wielding!="Sword") {U<<"Equip a Sword first"; return}
		var
			c=(CCost*U.KGCModifier); mx=c
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Tsubaki",(CooldownCur*U.cooldownmultiplier))) return
		if(MoveCheck(U)) return
		if(ChakraUseCheck()) c *= 4
		U.attacking=1;spawn(U.atkspeed)U.attacking=0
		//swordspin icon state needed
		//flick("SwordSpin",U)
		if(prob(U.ChakraControl))
			U.JutsuMessage(Description["title"])
			U.JutsuUseChakra(c)
			U.JutsuTai(c); U.MoveUses[name]++
			if(U.PracticeMode) return ..()
			var/hit=0
			for(var/mob/M in orange(1))
				if(hit>=8) break
				hit++
				if(get_dist(U,M)>1) continue
				if(TAICHECKBOTH(U,M))
					continue
				var/dmg=round(U.Taijutsu*0.65-(M.Taijutsu*0.20))
				dmg+=U.Weapons()
				if(dmg<round(U.Taijutsu*0.13)) dmg=round(U.Taijutsu*0.13)
				if(M.TreeStump)
					spawn(U.atkspeed+3) U.attacking=0
					if(U.Stamina<=15&&U.reset) return
					if(U.Stamina<=15&&!U.reset)
						U<<"Not enough Stamina"
						U.reset=1; spawn(20)U.reset=0
						return
				if(U.HitCheck(M))
					for(var/obj/Weapon/Wield/W in U.contents)
						if(W.worn) W.DamagetoWeapon(rand(1,5),U)
					spawn()
						M.DamageMe(U,dmg,"slashes")
					var/taiup=rand(2,15)
					U.ApplyEXP(taiup+M.taitraining,"taijutsu")
					U.ApplyEXP(1,"Stamina")
					spawn(U.atkspeed+3) U.attacking=0
				else
					spawn(U.atkspeed+11) U.attacking=0
					U<<"[M] dodged the attack!"; M<<"You dodged [U]'s attack"
				sleep()
			if(!hit) spawn(U.atkspeed+5) U.attacking=0
		else
			c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"
			spawn(U.atkspeed+11) U.attacking=0
			return