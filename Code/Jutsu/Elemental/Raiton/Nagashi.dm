#if DEBUGGING
mob/verb
	learnChidoriNagashi()
		var/obj/SkillCards/Ninjutsu/Raiton/ChidoriNagashi/J = locate() in src.contents
		if(!J)
			src<<"<b><font size=2>You've just learned <i>Chidori Nagashi no Jutsu</i>!</b></font>"
			new/obj/SkillCards/Ninjutsu/Raiton/ChidoriNagashi(src)
#endif

obj/SkillCards/Ninjutsu/Raiton/ChidoriNagashi
	cmdstring="ChidoriNagashi"
	name="Chidori Nagashi"
	icon_state="card_bunshin"
	Click(x,y)
		if((src in usr)&&(findtext("[y]","HotBar")))
			ChidoriNagashi()
		else ..()
	New()
		if(!Description)Description=new()
		Description["about"]="By releasing the Chidori in every direction, an electrical discharge flows from the user's entire body allowing him to affect multiple enemies."
		Description["title"]="Chidori Nagashi"
		Description["range"]="N/A"
		Description["type"]="Ninjutsu"
		Description["cost"]=50
		Description["seals"]=4
		Description["strong"]="N/A"
		Description["weak"]="N/A"
		Description["rank"]="A"
		Description["pic"]='Bunshin.png'
		Description["category"]="ninjutsu"

	verb/ChidoriNagashi()
		set category="TECHNIQUES"
		set src in usr.contents
		if(usr.Nagashi)
			usr.Nagashi = 0
			return
		if(usr.GenericAttackCheck()||usr.Gokusamaisou||usr.mirroring||usr.InMirrors)
			return
		var
			c=800; mx=c; s=usr.SS*4
		if(usr.Chakra<=c) {usr<<"Not enough Chakra."; return}
		if(usr.CooldownCheck("ChidoriNagashi",(800*usr.cooldownmultiplier)+s,1)) return
		usr.icon_state="seals"
		usr.firing=1
		spawn(s)
			spawn(1)usr.icon_state=null
			spawn(3)usr.firing=0
			if(prob(usr.ChakraControl))
				if(usr.ChakraControl<100) {c+=rand(0,mx/2); usr.CCGain(c)}
				usr.JutsuSeals(s); usr.JutsuChakra(c); usr.JutsuNin(c); usr.LightningElementalup(); usr.MoveUses[src.cmdstring]++
				usr.Chakra-=c; usr<< "<i>[c]/[mx] converted.</i>"; usr.RefreshChakra()
				hearers(4,usr)<<"<b>[usr]: Raiton: Chidori Nagashi!</b>"
				if(usr.PracticingCheck()) return
				usr.ChidoriNagashi()
			else {c-=rand(1,mx/2); usr.Chakra-=c; usr<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"; return}

mob
	var
		Nagashi = 0
	proc
		ChidoriNagashi()
			Nagashi = 1
			spawn(100)
				if(Nagashi)
					Nagashi=0
			while(Nagashi)
				Chakra-=100
				if(Chakra<=0)
					Nagashi=0
					return
				var/L = LightningElemental
				for(var/mob/I in range(src,1))
					if(I!=src&&I.Creator!=src)
						if(I.Nagashi)
							continue
						if(I.dead)
							continue
						view(src)<<"[I] was hit by [src] Chidori Nagashi!"
						I.DamageMe(src,L,"Nagashi")
						I.RaitonStun()
				sleep(5)
				continue


