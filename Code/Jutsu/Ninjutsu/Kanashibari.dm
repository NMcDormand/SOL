obj/SkillCards/Ninjutsu/Kanashibari
	icon_state="card_Kanashibari"
	cmdstring="Kanashibari"
	Range=2
	CCost=1000
	Seals=5
	Cooldown = 1500
	Duration = 10

	Description = list(
		"about"="Stun opponents for 3 seconds."
		,"title"="Kanashibari no Jutsu"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="A"
//		,"pic"='Kanashibari.png'
		)

	UpgradeChoices = list("Increase Range","Increase Duration")

	Activate(mob/U)
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("Kanashibari",(CooldownCur*U.cooldownmultiplier)+s,1)) return
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			spawn(1)U.icon_state=null
			spawn(33)U.firing=0
			if(prob(U.ChakraControl))
				U.JutsuSeals(s); U.JutsuNin(c);
				U.MoveUses[name]++
				U.JutsuUseChakra(c)
				U.JutsuMessage(Description["title"])
				if(U.PracticeMode || ControlCheck(U)) return ..()
				new/Effect/Kanashibari/Centre(U.loc)
				for(var/mob/M in range(Range,U))
					if(IDCHECK(U,M))
						continue
					if(M.KI_InMission&&(U in KI_Participants)) continue
					M.KanashiStun(Duration)
			else {c=rand(3,9); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}
			..()


mob/proc/KanashiStun(DUR)
	Kanashibari++
	spawn(DUR)
		if(Kanashibari)
			Kanashibari--

mob/var
	KanashibariUses=0
	tmp/Kanashibari

Effect/Kanashibari
	icon='Kanashibari.dmi'
	layer=MOB_LAYER-1
	Centre
		icon_state="centre"
		New()
			var/Effect/Kanashibari/Outer/a = new/Effect/Kanashibari/Outer(loc)
			var/Effect/Kanashibari/Outer/b = new/Effect/Kanashibari/Outer(loc)
			var/Effect/Kanashibari/Outer/c = new/Effect/Kanashibari/Outer(loc)
			var/Effect/Kanashibari/Outer/d = new/Effect/Kanashibari/Outer(loc)
			var/Effect/Kanashibari/Outer/e = new/Effect/Kanashibari/Outer(loc)
			var/Effect/Kanashibari/Outer/f = new/Effect/Kanashibari/Outer(loc)
			var/Effect/Kanashibari/Outer/g = new/Effect/Kanashibari/Outer(loc)
			var/Effect/Kanashibari/Outer/h = new/Effect/Kanashibari/Outer(loc)
			sleep(1)
			step(a,NORTH); step(b,NORTHEAST); step(c,EAST); step(d,SOUTHEAST)
			step(e,SOUTH); step(f,SOUTHWEST); step(g,WEST);step(h,NORTHWEST)
			spawn(5)
				if(a)del(a)
				if(b)del(b)
				if(c)del(c)
				if(d)del(d)
				if(e)del(e)
				if(f)del(f)
				if(g)del(g)
				if(h)del(h)
				del(src)
	Outer
		icon_state="outer"