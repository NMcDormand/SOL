#if DEBUGGING
mob/verb
	SelfLearnJirai()
		var/obj/SkillCards/Clan/Clay/KibakuJirai/J = locate() in contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Kibaku Jirai no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Clan/Clay/KibakuJirai(src)
#endif

obj/SkillCards/Clan/Clay/KibakuJirai
	icon_state="card_Jirai"
	cmdstring="KibakuJiraiSet"
	var/ClickSet = 1
	var/MotionSet = 0
	CCost=300
	Seals=2
	ECost = 5
	Cooldown = 800

	Description= list(
		"about"="Creates a Clay mine that explodes when someone gets close to it or when user chooses"
		,"title"="Kibaku Jirai"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="Lightning"
		,"rank"="B"
		,"Tutorial" = "Place or throw a clay mine that will explode based on how the user set it, these can be set as traps or as projectiles.<br>\"Kibaku Setting Click\" will change whether a clay bomb is thrown or placed on the ground when the verb is used.<br>\"Kibaku Setting Motion\" will change whether a bomb should automatically trigger based on enemies being in range."
		//,"pic"='Bunshin.png'
	)

	UpgradeChoices = list("Lower Cost","Lower Cooldown")

	verb/Kibaku_Setting_Click()
		set category="TECHNIQUES"
		set src in usr.contents
		if(ClickSet)
			ClickSet = 0
			usr << "You will now throw a mine when you click the card"
		else
			ClickSet = 1
			usr << "You will now place a mine when you click the card"

	verb/Kibaku_Setting_Motion()
		set category="TECHNIQUES"
		set src in usr.contents
		if(MotionSet)
			MotionSet = 0
			usr << "Your clay mines will no longer detect motion"
		else
			MotionSet = 1
			usr << "Your clay mines will now detect motion"

	verb/Kibaku_Jirai_Place()
		set category="TECHNIQUES"
		set src in usr.contents
		if(usr.ClayInfused<ECost)
			usr<<"You don't have enough Clay Infused - You have [usr.ClayInfused] (Need: [ECost])!"
			return
		if(GENERICATTACKCHECK(usr)) return
		var
			c=CCost; mx=c; s=usr.SS*Seals
		if(usr.Chakra<=c) {usr<<"Not enough Chakra."; return}
		if(usr.CooldownCheck("KibakuJirai",(CooldownCur*usr.cooldownmultiplier)+s,1)) return
		if(ChakraUseCheck()) c *= 4
		usr.icon_state="seals"
		usr.firing=1
		spawn(s)
			spawn(1)usr.icon_state=null
			spawn(3)usr.firing=0
			if(prob(usr.ChakraControl))
				usr.JutsuMessage(Description["title"])
				usr.JutsuSeals(s); usr.JutsuNin(c);
				usr.MoveUses[name]++
				usr.JutsuUseChakra(c);
				usr.ElementalUp("Earth")
				if(usr.PracticeMode || ControlCheck(usr))
					usr.ClayInfused -= ECost
					return ..()
				usr.kibakujiraiset(MotionSet,ECost)
			else {c-=rand(1,mx/2); usr.Chakra-=c; usr<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()


	verb/Kibaku_Jirai_Throw()
		set category="TECHNIQUES"
		set src in usr.contents
		if(usr.ClayInfused<ECost)
			usr<<"You don't have enough Clay Infused - You have [usr.ClayInfused] (Need: [ECost])!"
			return
		if(GENERICATTACKCHECK(usr)) return
		var
			c=CCost; mx=c; s=usr.SS*Seals
		if(usr.Chakra<=c) {usr<<"Not enough Chakra."; return}
		if(usr.CooldownCheck("KibakuJirai",(CooldownCur*usr.cooldownmultiplier)+s,1)) return
		if(ChakraUseCheck()) c *= 4
		usr.icon_state="seals"
		usr.firing=1
		spawn(s)
			spawn(1)usr.icon_state=null
			spawn(3)usr.firing=0
			if(prob(usr.ChakraControl))
				usr.JutsuMessage(Description["title"])
				usr.JutsuSeals(s); usr.JutsuNin(c);
				usr.MoveUses[name]++
				usr.JutsuUseChakra(c);
				usr.ElementalUp("Earth")
				if(usr.PracticeMode || ControlCheck(usr))
					usr.ClayInfused -= ECost
					return ..()
				usr.kibakujiraithrow(MotionSet,ECost)
			else {c-=rand(1,mx/2); usr.Chakra-=c; usr<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

	Activate(mob/U)
		if(U.ClayInfused<ECost)
			U<<"You don't have enough Clay Infused - You have [U.ClayInfused] (Need: [ECost])!"
			return
		if(GENERICATTACKCHECK(U)) return
		var
			c=CCost; mx=c; s=U.SS*Seals
		if(U.Chakra<=c) {U<<"Not enough Chakra."; return}
		if(U.CooldownCheck("KibakuJirai",(CooldownCur*U.cooldownmultiplier)+s,1)) return
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
				U.ElementalUp("Earth")
				if(U.PracticeMode || ControlCheck(U))
					U.ClayInfused -= ECost
					return ..()
				if(ClickSet)
					U.kibakujiraiset(MotionSet,ECost)
				else
					U.kibakujiraithrow(MotionSet,ECost)
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

mob
	proc
		kibakujiraiset(MotionSet=0,ECost = 5)
			if(!src)return
			ClayInfused-=ECost
			var/Claytile = 0
			for(var/obj/Clay/Mine/C in loc)
				if(C.OwnerName == trueName)
					C.Total++
					Claytile = 1
					break
			if(!Claytile)
				var/obj/Clay/Mine/I=new/obj/Clay/Mine(loc)
				if(MotionSet)
					I.MotionSet = 1
				I.Owner=src

				ClayBombs += I

		kibakujiraithrow(MotionSet=0,ECost = 5)
			if(!src)return
			ClayInfused-=ECost
			var/obj/Clay/Mine/I=new/obj/Clay/Mine(loc)
			if(MotionSet)
				I.MotionSet = 1
			I.Owner=src
			ClayBombs += I
			I.ClayThrow=1
			I.density = 1
			walk(I,dir)