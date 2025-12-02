obj/SkillCards/ClimbTree
	icon_state="card_ClimbTree"
	cmdstring="ClimbTree"
	JutsuType = "Other"
	VerbIt=1
	CanLevel=0

	Description = list(
		"about"="Climb large trees to train your Chakra Control"
		,"title"="Climb Tree"
		,"type"="Action"
		,"strong"="N/A"
		,"weak"="N/A"
		,"rank"="N/A"
//		,"pic"='ClimbTree.png'
	)

	Activate(mob/U)
		for(var/obj/Tree/BigTree/T in orange(1,U))
			T.ClimbTree(U)

obj/proc/ClimbTree(mob/user)
	return