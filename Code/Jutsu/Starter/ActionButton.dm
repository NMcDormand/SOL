obj/SkillCards/ActionButton
	icon_state="card_Action"
	JutsuType = "Other"
	cmdstring="Action"
	name = "Action"
	VerbIt=1
	CanLevel=0

	Description = list(
		"about"="Interact with the world; this includes but not limited to talking with the various NPCs, interacting with specific objects, and opening specific doors"
		,"title"="Action"
		,"type"="Action"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='Action.png'
	)

	Activate(mob/U)
		var/list/L=list()
		for(var/atom/movable/M in view(2))
			if(istype(M,/mob/Hittable)||istype(M,/mob/NPC)||istype(M,/mob/Hittable/Unresponsive/NPC)||istype(M,/obj/Passage))
				L += M
		if(L.len>1)
			var/mob/who=input("Speak with which person?","Action") as null|anything in L
			if(who)
				who.Action(U)
		else if(L.len==1)
			for(var/atom/P in L)
				P.Action(U)

atom/proc/Action(mob/user)
	return