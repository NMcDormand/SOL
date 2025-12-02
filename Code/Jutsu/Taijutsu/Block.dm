mob/var/tmp/Blocking
obj/SkillCards/Taijutsu/Starter/Block
	icon_state="card_block"
	JutsuType = "Taijutsu"
	cmdstring="block"
	VerbIt=1
	CanLevel=0

	Description = list(
		"about"="Blocking will reduce damage but slow you down as you move. Useful if dodging the attack is not an option or if you need to buy a moment of time."
		,"title"="Block"
		,"type"="Taijutsu"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="E"
		,"pic"='Block.png'
		)

	Activate(mob/U)
		if(U.Blocking) {U<<"You stop blocking"; U.Blocking=0; U.icon_state=""; return}
		else
			if(GENERICATTACKCHECK(U)) return
			U.Blocking=1; U.icon_state="block"; U<<"You start blocking"