obj/SkillCards/Ninjutsu/Chidori
	icon_state="card_chidori"
	cmdstring="Chidori"
	JutsuType = "Primary-Element"
	Range=1
	CCost=10
	Seals=16
	Cooldown = 2100
	DM = 1
	Duration = 150

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[usr.ChidoriUse]%'")

	Description = list(
		"about"="Once activated, simply use the punch command and you will be able to unleash a series of powerful lightning attaks on your opponent(s). Right-Click to allocate chakra usage."
		,"title"="Chidori"
		,"type"="Ninjutsu"
		,"Element"="Lightning"
		,"weak"="N/A"
		,"rank"="A"
		,"pic"='Chidori.png'
	)

	UpgradeChoices = list("Increase Damage","Increase Duration")

	Activate(mob/U)
		if(U.inchidori)
			U.inchidori=0; U.overlays-='Chidori.dmi'
			U.firing = 0
			U.Chakra+=(U.ActiveChidoriUse*0.8); U.Chakra=min(U.Chakra,U.ChakraMax)
			U.RefreshChakra()
			return
		else
			if(GENERICATTACKCHECK(U)) return
			var
				c=(U.Chakra*(U.ChidoriUse*0.01)); mx=c; s=U.SS*Seals
			if(c>U.Chakra) {U<<"<i>Not enough chakra.</i>"}
			if(U.CooldownCheck("Chidori",(CooldownCur * U.cooldownmultiplier)+s)) return
			U.icon_state="seals"; U.firing=1
			spawn(s)
				U.icon_state=null
				if(prob(U.ChakraControl))
					U.JutsuSeals(s*2); U.JutsuNin(c*0.01); U.ElementalUp("Lightning");
					U.MoveUses[name]++
					U.JutsuUseChakra(c,0.01)
					U.JutsuMessage(Description["title"])
					if(U.PracticeMode || ControlCheck(U))
						U.firing=0
						return ..()
					U.inchidori=1; U.ActiveChidoriUse=c*DM; U.overlays+='Chidori.dmi'
					spawn(Duration)
						if(U.inchidori)
							U.inchidori=0;
							U.firing = 0
							U.overlays-='Chidori.dmi'
				else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

	verb/Chidori_Chakra_Usage()
		set category="TECHNIQUES"
		set src in usr.contents
		usr.choosing=1
		var/c=input("How much Chakra do you want to use for the Chidori? (Currently [usr.ChidoriUse]%)","Chidori")as num
		if(c<=0||c>100) {usr<<"<i>Please enter a number between 1 and 100</i>";}
		//else if(c>U.ChakraMax||c>2500) {U<<"<i>Cannot exceed 2500.</i>"; U.choosing=0}
		else {usr<<"<i>Usage set to [c]%.</i>"; usr.ChidoriUse=c;}
		usr.choosing=0

mob/proc/ChidoriPunch(mob/M)
	if(HitCheck(M))
		var/dmg=round((Ninjutsu*1.8)+(Taijutsu*0.4)+(ActiveChidoriUse*1.5)+(LightningElemental*5))
		if(InSharingan||InByakugan) dmg*=1.3
		if(ActiveChidoriUse>=40) {M.DamageMe(src,dmg,"chidori"); ActiveChidoriUse*=0.4}
		else {inchidori=0; firing=0; ActiveChidoriUse=0; overlays-='Chidori.dmi'}
	else
		if(ActiveChidoriUse >= 30)
			ActiveChidoriUse*=0.7
		else
			inchidori=0; ActiveChidoriUse=0; firing=0; overlays-='Chidori.dmi'
		src<<"[M] dodged your attack."; M<<"You dodged [src]'s attack."
