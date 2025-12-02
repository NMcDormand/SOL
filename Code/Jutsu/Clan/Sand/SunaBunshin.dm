obj/SkillCards/Clan/Sand/SunaBunshin
	icon_state="card_SunaBunshin"
	cmdstring="SunaBunshin"
	CCost=4000
	Seals=2
	DM = 35
	ECost = 30
	IsBunshin = 1

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[min(CCost,usr.ChakraMax*0.25)]'; DamageAmount.text='[DM]% Bunshin Strength'")

	Description = list(
		"about"="Creates an exact copy of the user out of sand.  These clones will have a portion of the user's HP and chakra and can attack others. Drains chakra."
		,"title"="Suna Bunshin no Jutsu"
		,"type"="Ninjutsu"
		,"Element"="Sand"
		,"weak"="N/A"
		,"rank"="C"
//		,"pic"='MizuBunshin.png'
		)

	UpgradeChoices = list("Lower Cost","Increase Strength")

	Activate(mob/U)
		if(U.KageBunshinAttackCheck()||!U.icon) return
		if(U.SandCollected<ECost&&!U.onsand) {U<<"There is not enough sand."; return}
		if(length(U.MasterBunshinList)>=U.BunshinLimit)
			for(var/mob/Hittable/Command/Clones/B in U.MasterBunshinList)
				if(B) del(B)
				break
		var
			c=min(CCost,U.ChakraMax*0.25); mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(ChakraUseCheck()) c *= 4
		U.icon_state="seals"
		U.firing=1
		spawn(s)
			U.icon_state=null
			spawn(20)U.firing=0
			if(!U.onsand) SandCollected-=ECost
			if(prob(U.ChakraControl))
				U.JutsuSeals(s); U.JutsuNin(c*0.02);
				U.MoveUses[name]++
				U.JutsuUseChakra(c,0.05)
				U.JutsuMessage(Description["title"])
				if(U.PracticeMode || ControlCheck(U)) return ..()
				var/mob/Hittable/Command/Clones/SunaBunshin/B=new(U.loc)
				U.BunshinCreate(B,DM*0.01,c)
				//B.icon='SunaBunshinMob.dmi'
				flick('Smoke.dmi',B)
				for(var/area/A in view(0,B)) A.Entered(B)
			else {c=rand(50,99); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()