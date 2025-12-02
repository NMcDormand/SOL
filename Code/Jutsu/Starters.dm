mob/proc/LearnStarters()
	var/obj/SkillCards/Starter/Spar/SPAR=locate() in contents
	if(!SPAR)
		new/obj/SkillCards/Starter/Spar(src)

	var/obj/SkillCards/Starter/Craft/CRAFT=locate() in contents
	if(!CRAFT)
		new/obj/SkillCards/Starter/Craft(src)

	//rest
	//med
	//punch
	//kick
	//action
	//treeclimb
	//bunshins
	//kawarimi
	//henge
	//yield
	//craft