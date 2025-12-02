mob/var/tmp
	KnockBack
obj/SkillCards/Ninjutsu/Rasengan
	icon_state="card_rasengan"
	cmdstring="Rasengan"
	Range=1
	CCost=10
	Seals=4
	Cooldown = 2800
	DM = 1
	Duration = 120

	Click(x,y)
		..()
		if(usr.JutsuBrowse)
			winset(usr,null,"ChakraCost.text='[usr.RasenganUse]%'")

	Description = list(
		"about"="Once activated, a spiraling sphere of chakra forms in the users hand.  Using the punch technique will unleash the power of the Rasengan, and knock back the opponent in the process. Right-click skill to allocate chakra."
		,"title"="Rasengan"
		,"type"="Ninjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="A"
		,"pic"='Rasengan.png'
		)

	UpgradeChoices = list("Increase Damage","Increase Duration")

	Activate(mob/U)
		if(U.inrasengan)
			U.inrasengan=0; U.overlays-='Rasengan_SOL.dmi'
			U.firing=0
			U.Chakra+=(U.ActiveRasenganUse*0.8); U.Chakra=min(U.Chakra,U.ChakraMax)
			U.RefreshChakra()
			return
		else
			if(GENERICATTACKCHECK(U))
				return
			var
				c=(U.Chakra*(U.RasenganUse*0.01)); mx=c;
			if(c>U.Chakra) {U<<"<i>Not enough chakra.</i>"}
			if(U.CooldownCheck("Rasengan",(CooldownCur*U.cooldownmultiplier)))
				return
			U.firing=1
			if(prob(U.ChakraControl))
				U.JutsuNin(50);
				U.MoveUses[name]++
				U.JutsuUseChakra(c,0.01)
				U.JutsuMessage(Description["title"])
				if(U.PracticeMode || ControlCheck(U))
					U.firing=0
					return ..()
				U.inrasengan=1; U.ActiveRasenganUse=c*DM; U.overlays+='Rasengan_SOL.dmi'
				spawn(Duration)
					if(U.inrasengan)
						U.inrasengan=0
						U.overlays-='Rasengan_SOL.dmi'
			else {c-=rand(1,mx/2); U.Chakra-=c; U<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"};..()

	verb/Rasengan_Chakra_Usage()
		set category="TECHNIQUES"
		set src in usr.contents
		if(usr.inrasengan) return
		usr.choosing=1
		var/c=input("How much Chakra do you want to use for the Rasengan? (Currently [usr.RasenganUse]%)","Rasengan")as num
		if(c<=0||c>100) {usr<<"<i>Please enter a number between 1 and 100</i>"; usr.choosing=0}
		//if(c>U.ChakraMax||c<2000) {U<<"<i>Not enough chakra.</i>"; U.choosing=0}
		//else if(c>U.ChakraMax) {U<<"<i>Cannot exceed your max chakra.</i>"; U.choosing=0}
		else {usr<<"<i>Usage set to [c]%.</i>"; usr.RasenganUse=c; usr.choosing=0}

mob/proc/RasenganPunch(mob/M)
	inrasengan=0
	firing=0
	if(M)
		if(HitCheck(M))
			if(!M.TreeStump && !M.kaiten)
				if(!M.KnockBack) M.KnockBack=1
				spawn(10)
					if(M)
						M.KnockBack=0
				Knockback(M)
			var/damage=round((Taijutsu*2)+(Ninjutsu*0.7)+(ActiveRasenganUse*8))
			if(Clan=="Uzumaki"||Clan=="Namikaze")
				damage *= 1.3
			M.DamageMe(src,damage,"rasengan")
		else {src<<"[M] dodged your attack."; M<<"You dodged [src]'s attack."}
	ActiveRasenganUse=0; overlays-='Rasengan_SOL.dmi'

mob/proc/Knockback(mob/M)
	if(!istype(M,/mob/Hittable/Unresponsive/Inanimate))
		return
	while(M&&M.KnockBack)
		step(M,dir)
		sleep(pick(0.5,1,1.5,2))