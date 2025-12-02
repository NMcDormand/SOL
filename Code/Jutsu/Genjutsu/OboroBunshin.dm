obj/SkillCards/Genjutsu/Starter/OboroBunshin
	name="Oboro Bunshin no Jutsu"
	icon_state="card_bunshin"
	cmdstring="OboroBunshinnoJutsu"
	CCost=10
	Seals=2
	DM=3

	Description = list(
		"about"="This technique creates a clone of the user and will drain chakra for as long as the clones are active. These clones will not be able to inflict any damage but they are tough to kill.  Useful for confusing, deceiving, or distracting your opponent."
		,"title"="Oboro Bunshin no Jutsu"
		,"type"="Genjutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="D"
		,"pic"='Bunshin.png'
		)
	verb/OboroBunshinnoJutsu()
		set category="TECHNIQUES"
		set src in usr.contents
		if(GENERICATTACKCHECK(usr)||!usr.icon) return
		if(usr.Chakra<30) {usr<<"Not enough Chakra"; return}
		if(length(usr.MasterBunshinList)>=usr.BunshinLimit)
			for(var/mob/Hittable/Command/Clones/B in usr.MasterBunshinList)
				if(B) del(B)
				break
		var
			c=30; mx=c; s=usr.SS*1
		usr.icon_state="seals"
		usr.firing=1
		spawn(s)
			usr.icon_state=null
			spawn(10)usr.firing=0
			if(prob(usr.ChakraControl))
				usr.JutsuSeals(s); usr.JutsuGen(c*2.2); ; Uses++; if(usr.Chakra<=1) usr.Chakra=1
				if(usr.ChakraControl<100) {c+=rand(0,mx/2); usr.CCGain(c)}
				usr.Chakra-=c; usr<< "<i>[c]/[mx] converted.</i>"; usr.RefreshChakra(); hearers(4,usr)<<"<b>[usr]: Bunshin!</b>"
				if(U.PracticeMode || ControlCheck(U)) return ..()
				var/mob/Hittable/Command/Clones/Bunshin/B=new(usr.loc)
				usr.BunshinCreate(B,DM*0.01,0)
			else {c=rand(5,29); usr.Chakra-=c; usr<<"<i>[c]/[mx] converted. You failed to perform the jutsu.</i>"}